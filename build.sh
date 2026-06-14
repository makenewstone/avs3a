#!/usr/bin/env bash
# ============================================================================
# AVS3 Audio Decoder — Build Script
# ============================================================================
# Usage:
#   ./build.sh                    # Release build in build/
#   ./build.sh <dir>              # Custom build directory
#   ./build.sh <dir> <type>       # Custom dir + build type (Debug/Release)
#
# Prerequisites: CMake >= 3.10, C11 compiler (gcc/clang)
# ============================================================================

set -euo pipefail

BUILD_DIR="${1:-build}"
BUILD_TYPE="${2:-Release}"

# ── Parallel job count ──────────────────────────────────────────────────────
if command -v nproc &>/dev/null; then
    NPROC=$(nproc)
elif command -v sysctl &>/dev/null; then
    NPROC=$(sysctl -n hw.ncpu)
else
    NPROC=4
fi

# ── Banner ──────────────────────────────────────────────────────────────────
echo "╔══════════════════════════════════════════╗"
echo "║       AVS3 Audio Decoder — Build        ║"
echo "╠══════════════════════════════════════════╣"
printf "║  Build dir:   %-26s ║\n" "${BUILD_DIR}"
printf "║  Build type:  %-26s ║\n" "${BUILD_TYPE}"
printf "║  Parallel:    %-2d jobs                    ║\n" "${NPROC}"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── Clean & Configure ───────────────────────────────────────────────────────
echo "Cleaning ${BUILD_DIR} ..."
rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

cmake -B "${BUILD_DIR}" \
      -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
      -S .

# ── Build ───────────────────────────────────────────────────────────────────
cmake --build "${BUILD_DIR}" -j "${NPROC}"

# ── Summary ─────────────────────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║           Build Succeeded                ║"
echo "╠══════════════════════════════════════════╣"
printf "║  Library:    %-28s ║\n" "${BUILD_DIR}/libavs3a.a"
printf "║  Executable: %-28s ║\n" "${BUILD_DIR}/avs3a_dec"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Usage:"
echo "  ${BUILD_DIR}/avs3a_dec <input.avs3> <output.wav>"
echo ""


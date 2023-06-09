HOST_DIR := src
BUILDDIR ?= bin
FIRST_PASS_BIT_LENGTH ?= 7
SECOND_PASS_BIT_LENGTH ?= 7
THIRD_PASS_BIT_LENGTH ?= 9
NUM_RADIX_BITS ?= 14

CXX := nvcc

HOST_TARGET := ${BUILDDIR}/host_code

HOST_SOURCES := $(wildcard ${HOST_DIR}/*.c)

CUDA_SOURCES := $(wildcard ${HOST_DIR}/*.cu)

COMMON_INCLUDES := ${wildcard ${HOST_DIR}/*.h}

.PHONY: all clean test

__dirs := $(shell mkdir -p ${BUILDDIR})

HOST_LIB_LINKED := -lm -lpthread -lnuma

COMMON_FLAGS := -std=c11 -Wall -Wextra -g

DATA_FLAG := -DNUM_RADIX_BITS=${NUM_RADIX_BITS}

HOST_FLAGS := -O0 -g -G  ${HOST_LIB_LINKED} ${DATA_FLAG}

all: ${HOST_TARGET}

${HOST_TARGET}: ${HOST_SOURCES} ${CUDA_SOURCES} ${COMMON_INCLUDES} ${CONF}
	$(CXX) -o $@ ${HOST_SOURCES} ${CUDA_SOURCES} ${HOST_FLAGS}

clean:
	$(RM) -r $(BUILDDIR)

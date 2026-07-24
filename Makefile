.PHONY := clean all

COMMONFLAGS := -Wall -mmcu=atmega328p -DF_CPU=1000000 -Ivariants/standard -Icores/arduino -Os -v

CXX := avr-g++
CXXFLAGS := -std=c++11 $(COMMONFLAGS)
CC := avr-gcc
CFLAGS := $(COMMONFLAGS)

CORE_DIR := cores/arduino
CORE_SOURCES := $(shell find $(CORE_DIR) -name '*.cpp' -or -name '*.c')
CORE_OBJS := $(patsubst %.cpp, %.o, $(patsubst %.c, %.o, $(CORE_SOURCES)))

$(CORE_OBJS): $(CORE_SOURCES)

libarduino.a: $(CORE_OBJS)
	avr-ar rcs $@ $^


WIRE_DIR := libraries/Wire
WIRE_SOURCES := $(shell find $(WIRE_DIR) -name '*.cpp' -or -name '*.c')
WIRE_OBJS := $(patsubst %.cpp, %.o, $(patsubst %.c, %.o, $(WIRE_SOURCES)))

$(WIRE_OBJS): $(WIRE_SOURCES)

libwire.a: $(WIRE_OBJS)
	avr-ar rcs $@ $^


SPI_DIR := libraries/SPI
SPI_SOURCES := $(shell find $(SPI_DIR) -name '*.cpp' -or -name '*.c')
SPI_OBJS := $(patsubst %.cpp, %.o, $(patsubst %.c, %.o, $(SPI_SOURCES)))

$(SPI_OBJS): $(SPI_SOURCES)

libspi.a: $(SPI_OBJS)
	avr-ar rcs $@ $^



all: libarduino.a libwire.a libspi.a

clean:
	rm -rf $(CORE_DIR)/**/*.o $(WIRE_DIR)/**/*.o $(SPI_DIR)/**/*.o *.a


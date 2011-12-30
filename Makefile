ifneq ($(KERNELRELEASE),)
EMBUNIT_DIR := embunit
EMBUNIT_SRC := $(EMBUNIT_DIR)/embUnit

EXTRA_CFLAGS += -I$(src)/$(EMBUNIT_DIR)
EXTRA_CFLAGS += -DNO_STDIO_PRINTF

obj-m += test.o

#test runner
test-y := test_runner.o

#counter module
test-y += counter/counter.o
test-y += counter/counterTest.o

#person module
test-y += person/person.o
test-y += person/personTest.o

#embunit
test-y += $(EMBUNIT_SRC)/AssertImpl.o
test-y += $(EMBUNIT_SRC)/RepeatedTest.o
test-y += $(EMBUNIT_SRC)/stdImpl.o
test-y += $(EMBUNIT_SRC)/TestCaller.o
test-y += $(EMBUNIT_SRC)/TestCase.o
test-y += $(EMBUNIT_SRC)/TestResult.o
test-y += $(EMBUNIT_SRC)/TestRunner.o
test-y += $(EMBUNIT_SRC)/TestSuite.o

#sample driver
obj-m += mycdrv.o
mycdrv-y += mycdrv/mycdrv.o



else
KDIR := /lib/modules/`uname -r`/build

all: default

default:
	$(MAKE) V=0 -C $(KDIR) M=`pwd`

clean:
	$(MAKE) V=0 -C $(KDIR) M=`pwd` clean
endif

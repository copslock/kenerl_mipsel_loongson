Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2010 19:58:17 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10793 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492432Ab0CZS6N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Mar 2010 19:58:13 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bad03cf0000>; Fri, 26 Mar 2010 11:58:23 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 26 Mar 2010 11:57:42 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 26 Mar 2010 11:57:42 -0700
Message-ID: <4BAD03A5.9070701@caviumnetworks.com>
Date:   Fri, 26 Mar 2010 11:57:41 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Peter 'p2' De Schrijver <p2@debian.org>
CC:     linux-mips@linux-mips.org
Subject: Re: movidis x16 hard lockup using 2.6.33
References: <20100326184132.GU2437@apfelkorn>
In-Reply-To: <20100326184132.GU2437@apfelkorn>
Content-Type: multipart/mixed;
 boundary="------------050903000200060705040004"
X-OriginalArrivalTime: 26 Mar 2010 18:57:42.0211 (UTC) FILETIME=[3693C930:01CACD16]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050903000200060705040004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/26/2010 11:41 AM, Peter 'p2' De Schrijver wrote:
> Hi,
>
> Thanks to Jan Rovins and David Daney we linux 2.6.33 working fine with 1 additional
> patch for the ethernet NICs. We are using this machine as a buildd. Unfortunately
> we found out that building gcc 4.5 using all available 16 cores causes the machine
> to lock up after about 6 hours of building. There is no output on the serial
> console indicating a kernel panic or some malfunction. The machine is hosted in
> some data center so physical access is difficult.
>
> Any insight welcome !
>
> Thanks,
>

What is the output of:

cat /proc/cpuinfo | grep 'system type'


Also you could try running with the attached patch.  It is not the best 
watchdog, but it will print the register state for each core when things 
get stuck.  Occasionally that is enough to see where the problem is.

David Daney

--------------050903000200060705040004
Content-Type: text/plain;
 name="0922-cavium-octeon-watchdog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0922-cavium-octeon-watchdog.patch"

MIPS: Watchdog driver for Cavium OCTEON CPU.

This is a new driver for the OCTEON's on-chip watchdog hardware.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/Kconfig        |   10 ++
 arch/mips/cavium-octeon/Makefile       |    1 +
 arch/mips/cavium-octeon/watchdog.c     |  255 ++++++++++++++++++++++++++++++++
 arch/mips/cavium-octeon/watchdog_nmi.S |   96 ++++++++++++
 4 files changed, 362 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 094c17e..3a40360 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -83,3 +83,13 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC
 	depends on CPU_CAVIUM_OCTEON
+
+config CAVIUM_OCTEON_WATCHDOG
+	tristate "Octeon watchdog driver"
+	default y
+	help
+	  This option enables a watchdog driver for all cores running Linux. It
+	  installs a NMI handler and pokes the watchdog based on an interrupt.
+	  On first expiration of the watchdog, the interrupt handler pokes it.
+	  The second expiration causes an NMI that prints a message and resets
+	  the chip. The third expiration causes a global soft reset.
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 3e98763..9da88b2 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -14,5 +14,6 @@ obj-y += dma-octeon.o flash_setup.o
 obj-y += octeon-memcpy.o
 
 obj-$(CONFIG_SMP)                     += smp.o
+obj-$(CONFIG_CAVIUM_OCTEON_WATCHDOG)  += watchdog.o watchdog_nmi.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/cavium-octeon/watchdog.c b/arch/mips/cavium-octeon/watchdog.c
new file mode 100644
index 0000000..453bdc3
--- /dev/null
+++ b/arch/mips/cavium-octeon/watchdog.c
@@ -0,0 +1,255 @@
+/*
+ *   Octeon Watchdog driver
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007, 2008, 2009 Cavium Networks
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ip.h>
+#include <linux/string.h>
+#include <linux/smp.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+
+
+#include <asm/octeon/octeon.h>
+
+extern void octeon_watchdog_nmi(void);
+
+/* A zero value is replaced with the max timeout */
+int timeout;
+module_param(timeout, int, 0444);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in milliseconds. First timeout causes a poke,\n"
+	"the second causes an NMI, and the third causes a soft reset.");
+
+/**
+ * Poke the watchdog when an interrupt is received
+ *
+ * @cpl:
+ * @dev_id:
+ *
+ * Returns
+ */
+static irqreturn_t watchdog_poke_irq(int cpl, void *dev_id)
+{
+	unsigned int core = cvmx_get_core_num();
+	/* We're alive, poke the watchdog */
+	cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
+	return IRQ_HANDLED;
+}
+
+/* From setup.c */
+extern int prom_putchar(char c);
+
+/**
+ * Write a string to the uart
+ *
+ * @str:        String to write
+ */
+static void uart_write_string(const char *str)
+{
+	/* Just loop writing one byte at a time */
+	while (*str)
+		prom_putchar(*str++);
+}
+
+/**
+ * Write a hex number out of the uart
+ *
+ * @value:      Number to display
+ * @digits:     Number of digits to print (1 to 16)
+ */
+static void uart_write_hex(uint64_t value, int digits)
+{
+	int d;
+	int v;
+	for (d = 0; d < digits; d++) {
+		v = (value >> ((digits - d - 1) * 4)) & 0xf;
+		if (v >= 10)
+			prom_putchar('a' + v - 10);
+		else
+			prom_putchar('0' + v);
+	}
+}
+
+/**
+ * NMI stage 3 handler. NMIs are handled in the following manner:
+ * 1) The first NMI handler enables CVMSEG and transfers from
+ * the bootbus region into normal memory. It is careful to not
+ * destroy any registers.
+ * 2) The second stage handler uses CVMSEG to save the registers
+ * and create a stack for C code. It then calls the third level
+ * handler with one argument, a pointer to the register values.
+ * 3) The third, and final, level handler is the following C
+ * function that prints out some useful infomration.
+ *
+ * @reg:    Pointer to register state before the NMI
+ */
+void octeon_watchdog_nmi_stage3(uint64_t reg[32])
+{
+	const char *reg_name[] =
+		{ "$0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
+		"a4", "a5", "a6", "a7", "t0", "t1", "t2", "t3",
+		"s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
+		"t8", "t9", "k0", "k1", "gp", "sp", "s8", "ra"
+	};
+	uint64_t i;
+	/*
+	 * Save status and cause early to get them before any changes
+	 * might happen.
+	 */
+	uint64_t cp0_cause = read_c0_cause();
+	uint64_t cp0_status = read_c0_status();
+	uint64_t cp0_error_epc = read_c0_errorepc();
+	/* Delay so all cores output is jumbled */
+	cvmx_wait(100000000ull * cvmx_get_core_num());
+
+	uart_write_string("\r\n*** NMI Watchdog interrupt on Core 0x");
+	uart_write_hex(cvmx_get_core_num(), 1);
+	uart_write_string(" ***\r\n");
+	for (i = 0; i < 32; i++) {
+		uart_write_string("\t");
+		uart_write_string(reg_name[i]);
+		uart_write_string("\t0x");
+		uart_write_hex(reg[i], 16);
+		if (i & 1)
+			uart_write_string("\r\n");
+	}
+	uart_write_string("\tepc\t0x");
+	uart_write_hex(cp0_error_epc, 16);
+	uart_write_string("\r\n");
+
+	uart_write_string("\tstatus\t0x");
+	uart_write_hex(cp0_status, 16);
+	uart_write_string("\tcause\t0x");
+	uart_write_hex(cp0_cause, 16);
+	uart_write_string("\r\n");
+
+	uart_write_string("\tsum0\t0x");
+	uart_write_hex(cvmx_read_csr(CVMX_CIU_INTX_SUM0
+				     (cvmx_get_core_num() * 2)), 16);
+	uart_write_string("\ten0\t0x");
+	uart_write_hex(cvmx_read_csr(CVMX_CIU_INTX_EN0
+				     (cvmx_get_core_num() * 2)), 16);
+	uart_write_string("\r\n");
+}
+
+
+static void setup_interrupt(int cpu, unsigned long threshold)
+{
+	union cvmx_ciu_wdogx ciu_wdog;
+	unsigned int core;
+	unsigned int irq;
+
+#ifdef CONFIG_SMP
+	core = cpu_logical_map(cpu);
+#else
+	core = cvmx_get_core_num();
+#endif
+
+	irq = OCTEON_IRQ_WDOG0 + core;
+
+	if (request_irq(irq, watchdog_poke_irq,
+			IRQF_SHARED, "watchdog", watchdog_poke_irq))
+		panic("watchdog couldn't obtain irq %d", irq);
+
+#ifdef CONFIG_SMP
+	/* Set the affinity to this cpu. */
+	irq_set_affinity(irq, cpumask_of(cpu));
+#endif
+
+	/* Poke the watchdog to clear out its state */
+	cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
+
+	/* Finally enable the watchdog now that all handlers are installed */
+	ciu_wdog.u64 = 0;
+	ciu_wdog.s.len = threshold;
+	ciu_wdog.s.mode = 3;	/* 3 = Interrupt + NMI + Soft-Reset */
+	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
+}
+
+static int __init wd_2_ms(unsigned count)
+{
+	return (((uint64_t)count) << 16) * 1000 / octeon_get_clock_rate();
+}
+
+/**
+ * Module/ driver initialization.
+ *
+ * Returns Zero on success
+ */
+static int __init watchdog_init(void)
+{
+	unsigned long threshold;
+	int i;
+	int cpu;
+
+	/*
+	 * Watchdog time expiration length = The 16 bits of LEN
+	 * represent the most significant bits of a 24 bit decrementer
+	 * that decrements every 256 cycles.
+	 */
+	if (timeout)
+		threshold = (timeout * octeon_get_clock_rate() / 1000) >> 16;
+	else {
+		threshold = 65535;
+		timeout = wd_2_ms((unsigned)threshold);
+	}
+	if ((threshold < 10) || (threshold >= 65536)) {
+		pr_warning("Illegal watchdog timeout.  "
+			   "Timeout must be between %d and %d.\n",
+			   wd_2_ms(10), wd_2_ms(65535));
+		return -1;
+	}
+
+	/* Install the NMI handler */
+	for (i = 0; i < 16; i++) {
+		uint64_t *ptr = (uint64_t *) octeon_watchdog_nmi;
+		cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, i * 8);
+		cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, ptr[i]);
+	}
+	cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0x81fc0000);
+
+	for_each_online_cpu(cpu)
+		setup_interrupt(cpu, threshold);
+
+	pr_info("Octeon watchdog driver loaded with a timeout of %d ms.\n",
+		timeout);
+	return 0;
+}
+
+
+/**
+ * Module / driver shutdown
+ */
+static void __exit watchdog_cleanup(void)
+{
+	int cpu;
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+#ifdef CONFIG_SMP
+		int core = cpu_logical_map(cpu);
+#else
+		int core = cvmx_get_core_num();
+#endif
+		/* Disable the watchdog */
+		cvmx_write_csr(CVMX_CIU_WDOGX(core), 0);
+		/* Free the interrupt handler */
+		free_irq(OCTEON_IRQ_WDOG0 + core, watchdog_poke_irq);
+	}
+	preempt_enable();
+
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
+MODULE_DESCRIPTION("Cavium Networks Octeon Watchdog driver.");
+module_init(watchdog_init);
+module_exit(watchdog_cleanup);
diff --git a/arch/mips/cavium-octeon/watchdog_nmi.S b/arch/mips/cavium-octeon/watchdog_nmi.S
new file mode 100644
index 0000000..7ca3eba
--- /dev/null
+++ b/arch/mips/cavium-octeon/watchdog_nmi.S
@@ -0,0 +1,96 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 Cavium Networks
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+#define CP0_CVMMEMCTL $11,7
+
+	.text
+	.set 	push
+	.set 	noreorder
+	.set 	noat
+	NESTED(octeon_watchdog_nmi, PT_SIZE, sp)
+	/* For the next few instructions running the debugger may
+	 * cause corruption of k0 in the saved registers. Since we're
+	 * about to crash, nobody probably cares. */
+	 /* Save K0 into the debug scratch register */
+	dmtc0	k0, CP0_DESAVE
+	/* Use K0 to do a read/modify/write of CVMMEMCTL */
+	dmfc0	k0, CP0_CVMMEMCTL
+	/* Clear out the size of CVMSEG	*/
+	dins	k0, $0, 0, 6
+	/* Set CVMSEG to its largest value */
+	ori	k0, 54
+	/* Store the CVMMEMCTL value */
+	dmtc0	k0, CP0_CVMMEMCTL
+	/* Load the address of the second stage handler */
+	dla	k0, octeon_watchdog_nmi_stage2
+	/* Jump to the second stage handler */
+	jr	k0
+	/* Restore K0 from DESAVE (delay slot) */
+	dmfc0	k0, CP0_DESAVE
+	.set pop
+	END(octeon_watchdog_nmi)
+
+#define SAVE_REG(r)	sd $r, -32768+6912-(32-r)*8($0)
+
+        NESTED(octeon_watchdog_nmi_stage2, PT_SIZE, sp)
+	.set 	push
+	.set 	noreorder
+	.set 	noat
+	/* Save all regosters to the top CVMSEG. This shouldn't
+	 * corrupt any state used by the kernel. Also all registers
+	 * should have the value right before the NMI. */
+	SAVE_REG(0)
+	SAVE_REG(1)
+	SAVE_REG(2)
+	SAVE_REG(3)
+	SAVE_REG(4)
+	SAVE_REG(5)
+	SAVE_REG(6)
+	SAVE_REG(7)
+	SAVE_REG(8)
+	SAVE_REG(9)
+	SAVE_REG(10)
+	SAVE_REG(11)
+	SAVE_REG(12)
+	SAVE_REG(13)
+	SAVE_REG(14)
+	SAVE_REG(15)
+	SAVE_REG(16)
+	SAVE_REG(17)
+	SAVE_REG(18)
+	SAVE_REG(19)
+	SAVE_REG(20)
+	SAVE_REG(21)
+	SAVE_REG(22)
+	SAVE_REG(23)
+	SAVE_REG(24)
+	SAVE_REG(25)
+	SAVE_REG(26)
+	SAVE_REG(27)
+	SAVE_REG(28)
+	SAVE_REG(29)
+	SAVE_REG(30)
+	SAVE_REG(31)
+	/* Set the stack to begin right below the registers */
+	li	sp, -32768+6912-32*8
+	/* Load the address of the third stage handler */
+	dla	a0, octeon_watchdog_nmi_stage3
+	/* Call the third stage handler */
+	jal	a0
+	/* a0 is the address of the saved registers */
+	 move	a0, sp
+	/* Loop forvever if we get here. */
+1:	b	1b
+	nop
+	.set pop
+	END(octeon_watchdog_nmi_stage2)

--------------050903000200060705040004--

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:15:36 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:65116 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012571AbaKDGOXQLFwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:14:23 +0100
Received: by mail-pd0-f169.google.com with SMTP id y10so13074117pdj.28
        for <multiple recipients>; Mon, 03 Nov 2014 22:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/w1+l2HT7KNELJjyGjRpe7TVJAXeFjp2GKnXG/PhkyM=;
        b=rWFcHFZnAMrNb8BMvoLBxxdw9bcRXXHAcxrjtTYrPVkl0VIvhbNyMb7ohz0ppTYKbM
         SCGWyad7zyBygAjemc+ISGvY4nh0OqKuqz0Q+StIJnpEW1BGc13KXarwc12hNmrgNEKm
         1z6l0zUtl7HvK863W76ZhpAxtsomJUb1A/J9eN8mUlyk6b57rIpFi1Dqo6jYHtCjoCK6
         XVQYDprEVVe5rprpBx6X9Fb+q2gnuKKyGZlAuiZfJ73bZ3I2sgBHXZxNS0lVjJexGPuj
         gb4PtvryBm2M8ojFDMyfSGUHpTw10IzMDe2Aya6ZczoCVMnDuPiBzQe2pKXJ68iMdBag
         nLbw==
X-Received: by 10.68.100.69 with SMTP id ew5mr48432446pbb.84.1415081656748;
        Mon, 03 Nov 2014 22:14:16 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.14.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:14:16 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 06/12] MIPS: Loongson: Improve LEFI firmware interface
Date:   Tue,  4 Nov 2014 14:13:27 +0800
Message-Id: <1415081610-25639-7-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Machtypes of Loongson-3 machines become more and more, but there are
only small differences among different machtypes. Keeping a large table
of machtypes is very ugly and hard to extend. We found that the major
machtype differences are UARTs information (number of UARTs, UART IRQs,
UART clocks, etc.), platform devices (EC, temperature sensors, fan
controllers, etc.) and some workarounds (because of some CPU bugs or
mainboard bugs).

In this patch we improve the UEFI-like (LEFI) interface to make all
Loongson-3 machines use a same machtype "generic-loongson-machine".

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/bootinfo.h                   |    5 +--
 arch/mips/include/asm/mach-loongson/boot_param.h   |   44 +++++++++++++++-
 arch/mips/include/asm/mach-loongson/loongson.h     |    2 +-
 .../include/asm/mach-loongson/loongson_hwmon.h     |   55 ++++++++++++++++++++
 arch/mips/include/asm/mach-loongson/machine.h      |    2 +-
 arch/mips/include/asm/mach-loongson/workarounds.h  |    7 +++
 arch/mips/loongson/common/early_printk.c           |    2 +-
 arch/mips/loongson/common/env.c                    |   26 +++++++++-
 arch/mips/loongson/common/machtype.c               |    5 +--
 arch/mips/loongson/common/serial.c                 |   48 ++++++++++++++---
 arch/mips/loongson/common/uart_base.c              |   30 +++++------
 arch/mips/loongson/loongson-3/Makefile             |    2 +-
 arch/mips/loongson/loongson-3/platform.c           |   43 +++++++++++++++
 arch/mips/loongson/loongson-3/smp.c                |    5 +-
 14 files changed, 234 insertions(+), 42 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/loongson_hwmon.h
 create mode 100644 arch/mips/include/asm/mach-loongson/workarounds.h
 create mode 100644 arch/mips/loongson/loongson-3/platform.c

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 1f7ca8b..8b2eaa1 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -70,10 +70,7 @@ enum loongson_machine_type {
 	MACH_DEXXON_GDIUM2F10,
 	MACH_LEMOTE_NAS,
 	MACH_LEMOTE_LL2F,
-	MACH_LEMOTE_A1004,
-	MACH_LEMOTE_A1101,
-	MACH_LEMOTE_A1201,
-	MACH_LEMOTE_A1205,
+	MACH_LOONGSON_GENERIC,
 	MACH_LOONGSON_END
 };
 
diff --git a/arch/mips/include/asm/mach-loongson/boot_param.h b/arch/mips/include/asm/mach-loongson/boot_param.h
index 11ebf4c..fa80292 100644
--- a/arch/mips/include/asm/mach-loongson/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson/boot_param.h
@@ -10,7 +10,8 @@
 #define VIDEO_ROM		7
 #define ADAPTER_ROM		8
 #define ACPI_TABLE		9
-#define MAX_MEMORY_TYPE		10
+#define SMBIOS_TABLE		10
+#define MAX_MEMORY_TYPE		11
 
 #define LOONGSON3_BOOT_MEM_MAP_MAX 128
 struct efi_memory_map_loongson {
@@ -48,10 +49,43 @@ struct efi_cpuinfo_loongson {
 	u32 nr_cpus;
 } __packed;
 
+#define MAX_UARTS 64
+struct uart_device {
+	u32 iotype; /* see include/linux/serial_core.h */
+	u32 uartclk;
+	u32 int_offset;
+	u64 uart_base;
+} __packed;
+
+#define MAX_SENSORS 64
+#define SENSOR_TEMPER  0x00000001
+#define SENSOR_VOLTAGE 0x00000002
+#define SENSOR_FAN     0x00000004
+struct sensor_device {
+	char name[32];  /* a formal name */
+	char label[64]; /* a flexible description */
+	u32 type;       /* SENSOR_* */
+	u32 id;         /* instance id of a sensor-class */
+	u32 fan_policy; /* see loongson_hwmon.h */
+	u32 fan_percent;/* only for constant speed policy */
+	u64 base_addr;  /* base address of device registers */
+} __packed;
+
 struct system_loongson {
 	u16 vers;     /* version of system_loongson */
 	u32 ccnuma_smp; /* 0: no numa; 1: has numa */
 	u32 sing_double_channel; /* 1:single; 2:double */
+	u32 nr_uarts;
+	struct uart_device uarts[MAX_UARTS];
+	u32 nr_sensors;
+	struct sensor_device sensors[MAX_SENSORS];
+	char has_ec;
+	char ec_name[32];
+	u64 ec_base_addr;
+	char has_tcm;
+	char tcm_name[32];
+	u64 tcm_base_addr;
+	u64 workarounds; /* see workarounds.h */
 } __packed;
 
 struct irq_source_routing_table {
@@ -162,9 +196,15 @@ struct loongson_system_configuration {
 	u64 suspend_addr;
 	u64 vgabios_addr;
 	u32 dma_mask_bits;
+	char ecname[32];
+	u32 nr_uarts;
+	struct uart_device uarts[MAX_UARTS];
+	u32 nr_sensors;
+	struct sensor_device sensors[MAX_SENSORS];
+	u64 workarounds;
 };
 
 extern struct efi_memory_map_loongson *loongson_memmap;
 extern struct loongson_system_configuration loongson_sysconf;
-extern int cpuhotplug_workaround;
+
 #endif
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 92bf76c..5459ac0 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -35,7 +35,7 @@ extern void __init prom_init_cmdline(void);
 extern void __init prom_init_machtype(void);
 extern void __init prom_init_env(void);
 #ifdef CONFIG_LOONGSON_UART_BASE
-extern unsigned long _loongson_uart_base, loongson_uart_base;
+extern unsigned long _loongson_uart_base[], loongson_uart_base[];
 extern void prom_init_loongson_uart_base(void);
 #endif
 
diff --git a/arch/mips/include/asm/mach-loongson/loongson_hwmon.h b/arch/mips/include/asm/mach-loongson/loongson_hwmon.h
new file mode 100644
index 0000000..4431fc5
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/loongson_hwmon.h
@@ -0,0 +1,55 @@
+#ifndef __LOONGSON_HWMON_H_
+#define __LOONGSON_HWMON_H_
+
+#include <linux/types.h>
+
+#define MIN_TEMP	0
+#define MAX_TEMP	255
+#define NOT_VALID_TEMP	999
+
+typedef int (*get_temp_fun)(int);
+extern int loongson3_cpu_temp(int);
+
+/* 0:Max speed, 1:Manual, 2:Auto */
+enum fan_control_mode {
+	FAN_FULL_MODE = 0,
+	FAN_MANUAL_MODE = 1,
+	FAN_AUTO_MODE = 2,
+	FAN_MODE_END
+};
+
+struct temp_range {
+	u8 low;
+	u8 high;
+	u8 level;
+};
+
+#define CONSTANT_SPEED_POLICY	0  /* at constent speed */
+#define STEP_SPEED_POLICY	1  /* use up/down arrays to describe policy */
+#define KERNEL_HELPER_POLICY	2  /* kernel as a helper to fan control */
+
+#define MAX_STEP_NUM	16
+#define MAX_FAN_LEVEL	255
+
+/* loongson_fan_policy works when fan work at FAN_AUTO_MODE */
+struct loongson_fan_policy {
+	u8	type;
+
+	/* percent only used when type is CONSTANT_SPEED_POLICY */
+	u8	percent;
+
+	/* period between two check. (Unit: S) */
+	u8	adjust_period;
+
+	/* fan adjust usually depend on a temprature input */
+	get_temp_fun	depend_temp;
+
+	/* up_step/down_step used when type is STEP_SPEED_POLICY */
+	u8	up_step_num;
+	u8	down_step_num;
+	struct temp_range up_step[MAX_STEP_NUM];
+	struct temp_range down_step[MAX_STEP_NUM];
+	struct delayed_work work;
+};
+
+#endif /* __LOONGSON_HWMON_H_*/
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 228e3784..cb2b602 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -26,7 +26,7 @@
 
 #ifdef CONFIG_LOONGSON_MACH3X
 
-#define LOONGSON_MACHTYPE MACH_LEMOTE_A1101
+#define LOONGSON_MACHTYPE MACH_LOONGSON_GENERIC
 
 #endif /* CONFIG_LOONGSON_MACH3X */
 
diff --git a/arch/mips/include/asm/mach-loongson/workarounds.h b/arch/mips/include/asm/mach-loongson/workarounds.h
new file mode 100644
index 0000000..e180c14
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/workarounds.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_LOONGSON_WORKAROUNDS_H_
+#define __ASM_MACH_LOONGSON_WORKAROUNDS_H_
+
+#define WORKAROUND_CPUFREQ	0x00000001
+#define WORKAROUND_CPUHOTPLUG	0x00000002
+
+#endif
diff --git a/arch/mips/loongson/common/early_printk.c b/arch/mips/loongson/common/early_printk.c
index ced461b..6ca632e 100644
--- a/arch/mips/loongson/common/early_printk.c
+++ b/arch/mips/loongson/common/early_printk.c
@@ -30,7 +30,7 @@ void prom_putchar(char c)
 	int timeout;
 	unsigned char *uart_base;
 
-	uart_base = (unsigned char *)_loongson_uart_base;
+	uart_base = (unsigned char *)_loongson_uart_base[0];
 	timeout = 1024;
 
 	while (((serial_in(uart_base, UART_LSR) & UART_LSR_THRE) == 0) &&
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index d8be539..045ea3d 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -21,6 +21,7 @@
 #include <asm/bootinfo.h>
 #include <loongson.h>
 #include <boot_param.h>
+#include <workarounds.h>
 
 u32 cpu_clock_freq;
 EXPORT_SYMBOL(cpu_clock_freq);
@@ -31,7 +32,6 @@ u64 loongson_chipcfg[MAX_PACKAGES] = {0xffffffffbfc00180};
 u64 loongson_freqctrl[MAX_PACKAGES];
 
 unsigned long long smp_group[4];
-int cpuhotplug_workaround = 0;
 
 #define parse_even_earlier(res, option, p)				\
 do {									\
@@ -67,6 +67,7 @@ void __init prom_init_env(void)
 #else
 	struct boot_params *boot_p;
 	struct loongson_params *loongson_p;
+	struct system_loongson *esys;
 	struct efi_cpuinfo_loongson *ecpu;
 	struct irq_source_routing_table *eirq_source;
 
@@ -74,6 +75,8 @@ void __init prom_init_env(void)
 	boot_p = (struct boot_params *)fw_arg2;
 	loongson_p = &(boot_p->efi.smbios.lp);
 
+	esys = (struct system_loongson *)
+		((u64)loongson_p + loongson_p->system_offset);
 	ecpu = (struct efi_cpuinfo_loongson *)
 		((u64)loongson_p + loongson_p->cpu_offset);
 	eirq_source = (struct irq_source_routing_table *)
@@ -95,6 +98,7 @@ void __init prom_init_env(void)
 		loongson_chipcfg[2] = 0x900020001fe00180;
 		loongson_chipcfg[3] = 0x900030001fe00180;
 		loongson_sysconf.ht_control_base = 0x90000EFDFB000000;
+		loongson_sysconf.workarounds = WORKAROUND_CPUFREQ;
 	} else if (ecpu->cputype == Loongson_3B) {
 		loongson_sysconf.cores_per_node = 4; /* One chip has 2 nodes */
 		loongson_sysconf.cores_per_package = 8;
@@ -111,7 +115,7 @@ void __init prom_init_env(void)
 		loongson_freqctrl[2] = 0x900040001fe001d0;
 		loongson_freqctrl[3] = 0x900060001fe001d0;
 		loongson_sysconf.ht_control_base = 0x90001EFDFB000000;
-		cpuhotplug_workaround = 1;
+		loongson_sysconf.workarounds = WORKAROUND_CPUHOTPLUG;
 	} else {
 		loongson_sysconf.cores_per_node = 1;
 		loongson_sysconf.cores_per_package = 1;
@@ -143,6 +147,24 @@ void __init prom_init_env(void)
 	pr_debug("Shutdown Addr: %llx, Restart Addr: %llx, VBIOS Addr: %llx\n",
 		loongson_sysconf.poweroff_addr, loongson_sysconf.restart_addr,
 		loongson_sysconf.vgabios_addr);
+
+	memset(loongson_sysconf.ecname, 0, 32);
+	if (esys->has_ec)
+		memcpy(loongson_sysconf.ecname, esys->ec_name, 32);
+	loongson_sysconf.workarounds |= esys->workarounds;
+
+	loongson_sysconf.nr_uarts = esys->nr_uarts;
+	if (esys->nr_uarts < 1 || esys->nr_uarts > MAX_UARTS)
+		loongson_sysconf.nr_uarts = 1;
+	memcpy(loongson_sysconf.uarts, esys->uarts,
+		sizeof(struct uart_device) * loongson_sysconf.nr_uarts);
+
+	loongson_sysconf.nr_sensors = esys->nr_sensors;
+	if (loongson_sysconf.nr_sensors > MAX_SENSORS)
+		loongson_sysconf.nr_sensors = 0;
+	if (loongson_sysconf.nr_sensors)
+		memcpy(loongson_sysconf.sensors, esys->sensors,
+			sizeof(struct sensor_device) * loongson_sysconf.nr_sensors);
 #endif
 	if (cpu_clock_freq == 0) {
 		processor_id = (&current_cpu_data)->processor_id;
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 1a47979..26629ab 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -27,10 +27,7 @@ static const char *system_types[] = {
 	[MACH_DEXXON_GDIUM2F10]		"dexxon-gdium-2f",
 	[MACH_LEMOTE_NAS]		"lemote-nas-2f",
 	[MACH_LEMOTE_LL2F]		"lemote-lynloong-2f",
-	[MACH_LEMOTE_A1004]		"lemote-3a-notebook-a1004",
-	[MACH_LEMOTE_A1101]		"lemote-3a-itx-a1101",
-	[MACH_LEMOTE_A1201]		"lemote-2gq-notebook-a1201",
-	[MACH_LEMOTE_A1205]		"lemote-2gq-aio-a1205",
+	[MACH_LOONGSON_GENERIC]		"generic-loongson-machine",
 	[MACH_LOONGSON_END]		NULL,
 };
 
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index bd2b709..d2f4817 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -38,7 +38,7 @@
 	.regshift	= 0,					\
 }
 
-static struct plat_serial8250_port uart8250_data[][2] = {
+static struct plat_serial8250_port uart8250_data[][MAX_UARTS + 1] = {
 	[MACH_LOONGSON_UNKNOWN]		{},
 	[MACH_LEMOTE_FL2E]              {PORT(4, 1843200), {} },
 	[MACH_LEMOTE_FL2F]              {PORT(3, 1843200), {} },
@@ -47,10 +47,7 @@ static struct plat_serial8250_port uart8250_data[][2] = {
 	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3, 3686400), {} },
 	[MACH_LEMOTE_NAS]               {PORT_M(3, 3686400), {} },
 	[MACH_LEMOTE_LL2F]              {PORT(3, 1843200), {} },
-	[MACH_LEMOTE_A1004]             {PORT_M(2, 33177600), {} },
-	[MACH_LEMOTE_A1101]             {PORT_M(2, 25000000), {} },
-	[MACH_LEMOTE_A1201]             {PORT_M(2, 25000000), {} },
-	[MACH_LEMOTE_A1205]             {PORT_M(2, 25000000), {} },
+	[MACH_LOONGSON_GENERIC]         {PORT_M(2, 25000000), {} },
 	[MACH_LOONGSON_END]		{},
 };
 
@@ -61,17 +58,52 @@ static struct platform_device uart8250_device = {
 
 static int __init serial_init(void)
 {
+	int i;
 	unsigned char iotype;
 
 	iotype = uart8250_data[mips_machtype][0].iotype;
 
-	if (UPIO_MEM == iotype)
+	if (UPIO_MEM == iotype) {
+		uart8250_data[mips_machtype][0].mapbase =
+			loongson_uart_base[0];
 		uart8250_data[mips_machtype][0].membase =
-			(void __iomem *)_loongson_uart_base;
+			(void __iomem *)_loongson_uart_base[0];
+	}
 	else if (UPIO_PORT == iotype)
 		uart8250_data[mips_machtype][0].iobase =
-		    loongson_uart_base - LOONGSON_PCIIO_BASE;
+			loongson_uart_base[0] - LOONGSON_PCIIO_BASE;
 
+	if (loongson_sysconf.uarts[0].uartclk)
+		uart8250_data[mips_machtype][0].uartclk =
+			loongson_sysconf.uarts[0].uartclk;
+
+	for (i = 1; i < loongson_sysconf.nr_uarts; i++) {
+		iotype = loongson_sysconf.uarts[i].iotype;
+		uart8250_data[mips_machtype][i].iotype = iotype;
+		loongson_uart_base[i] = loongson_sysconf.uarts[i].uart_base;
+
+		if (UPIO_MEM == iotype) {
+			uart8250_data[mips_machtype][i].irq =
+				MIPS_CPU_IRQ_BASE + loongson_sysconf.uarts[i].int_offset;
+			uart8250_data[mips_machtype][i].mapbase =
+				loongson_uart_base[i];
+			uart8250_data[mips_machtype][i].membase =
+				ioremap_nocache(loongson_uart_base[i], 8);
+		} else if (UPIO_PORT == iotype) {
+			uart8250_data[mips_machtype][i].irq =
+				loongson_sysconf.uarts[i].int_offset;
+			uart8250_data[mips_machtype][i].iobase =
+				loongson_uart_base[i] - LOONGSON_PCIIO_BASE;
+		}
+
+		uart8250_data[mips_machtype][i].uartclk =
+			loongson_sysconf.uarts[i].uartclk;
+		uart8250_data[mips_machtype][i].flags =
+			UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	}
+
+	memset(&uart8250_data[mips_machtype][loongson_sysconf.nr_uarts],
+			0, sizeof(struct plat_serial8250_port));
 	uart8250_device.dev.platform_data = uart8250_data[mips_machtype];
 
 	return platform_device_register(&uart8250_device);
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index 1e1eeea..9de559d 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -13,22 +13,27 @@
 
 #include <loongson.h>
 
-/* ioremapped */
-unsigned long _loongson_uart_base;
-EXPORT_SYMBOL(_loongson_uart_base);
 /* raw */
-unsigned long loongson_uart_base;
+unsigned long loongson_uart_base[MAX_UARTS] = {};
+/* ioremapped */
+unsigned long _loongson_uart_base[MAX_UARTS] = {};
+
 EXPORT_SYMBOL(loongson_uart_base);
+EXPORT_SYMBOL(_loongson_uart_base);
 
 void prom_init_loongson_uart_base(void)
 {
 	switch (mips_machtype) {
+	case MACH_LOONGSON_GENERIC:
+		/* The CPU provided serial port (CPU) */
+		loongson_uart_base[0] = LOONGSON_REG_BASE + 0x1e0;
+		break;
 	case MACH_LEMOTE_FL2E:
-		loongson_uart_base = LOONGSON_PCIIO_BASE + 0x3f8;
+		loongson_uart_base[0] = LOONGSON_PCIIO_BASE + 0x3f8;
 		break;
 	case MACH_LEMOTE_FL2F:
 	case MACH_LEMOTE_LL2F:
-		loongson_uart_base = LOONGSON_PCIIO_BASE + 0x2f8;
+		loongson_uart_base[0] = LOONGSON_PCIIO_BASE + 0x2f8;
 		break;
 	case MACH_LEMOTE_ML2F7:
 	case MACH_LEMOTE_YL2F89:
@@ -36,17 +41,10 @@ void prom_init_loongson_uart_base(void)
 	case MACH_LEMOTE_NAS:
 	default:
 		/* The CPU provided serial port (LPC) */
-		loongson_uart_base = LOONGSON_LIO1_BASE + 0x3f8;
-		break;
-	case MACH_LEMOTE_A1004:
-	case MACH_LEMOTE_A1101:
-	case MACH_LEMOTE_A1201:
-	case MACH_LEMOTE_A1205:
-		/* The CPU provided serial port (CPU) */
-		loongson_uart_base = LOONGSON_REG_BASE + 0x1e0;
+		loongson_uart_base[0] = LOONGSON_LIO1_BASE + 0x3f8;
 		break;
 	}
 
-	_loongson_uart_base =
-		(unsigned long)ioremap_nocache(loongson_uart_base, 8);
+	_loongson_uart_base[0] =
+		(unsigned long)ioremap_nocache(loongson_uart_base[0], 8);
 }
diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
index b4df775..69809a3 100644
--- a/arch/mips/loongson/loongson-3/Makefile
+++ b/arch/mips/loongson/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o cop2-ex.o
+obj-y			+= irq.o cop2-ex.o platform.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/arch/mips/loongson/loongson-3/platform.c b/arch/mips/loongson/loongson-3/platform.c
new file mode 100644
index 0000000..25a97cc
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/platform.c
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
+ *         Xiang Yu, xiangy@lemote.com
+ *         Chen Huacai, chenhc@lemote.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <asm/bootinfo.h>
+#include <boot_param.h>
+#include <loongson_hwmon.h>
+#include <workarounds.h>
+
+static int __init loongson3_platform_init(void)
+{
+	int i;
+	struct platform_device *pdev;
+
+	if (loongson_sysconf.ecname[0] != '\0')
+		platform_device_register_simple(loongson_sysconf.ecname, -1, NULL, 0);
+
+	for (i = 0; i < loongson_sysconf.nr_sensors; i++) {
+		if (loongson_sysconf.sensors[i].type > SENSOR_FAN)
+			continue;
+
+		pdev = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
+		pdev->name = loongson_sysconf.sensors[i].name;
+		pdev->id = loongson_sysconf.sensors[i].id;
+		pdev->dev.platform_data = &loongson_sysconf.sensors[i];
+		platform_device_register(pdev);
+	}
+
+	return 0;
+}
+
+arch_initcall(loongson3_platform_init);
diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
index 94ed8a5..e2eb688 100644
--- a/arch/mips/loongson/loongson-3/smp.c
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -25,6 +25,7 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <loongson.h>
+#include <workarounds.h>
 
 #include "smp.h"
 
@@ -587,7 +588,7 @@ void loongson3_disable_clock(int cpu)
 	if (loongson_sysconf.cputype == Loongson_3A) {
 		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
 	} else if (loongson_sysconf.cputype == Loongson_3B) {
-		if (!cpuhotplug_workaround)
+		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
 			LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
 	}
 }
@@ -600,7 +601,7 @@ void loongson3_enable_clock(int cpu)
 	if (loongson_sysconf.cputype == Loongson_3A) {
 		LOONGSON_CHIPCFG(package_id) |= 1 << (12 + core_id);
 	} else if (loongson_sysconf.cputype == Loongson_3B) {
-		if (!cpuhotplug_workaround)
+		if (!(loongson_sysconf.workarounds & WORKAROUND_CPUHOTPLUG))
 			LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
 	}
 }
-- 
1.7.7.3

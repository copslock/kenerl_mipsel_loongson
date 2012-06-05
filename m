Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:51:16 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43555 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903726Ab2FEVuJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:50:09 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AW-000824-Sj; Tue, 05 Jun 2012 16:20:00 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 24/35] MIPS: MSP71xx, Yosemite: Cleanup firmware support for PMC platforms.
Date:   Tue,  5 Jun 2012 16:19:28 -0500
Message-Id: <1338931179-9611-25-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |   25 ----
 arch/mips/pmc-sierra/msp71xx/msp_prom.c            |  130 +++++++-------------
 arch/mips/pmc-sierra/msp71xx/msp_serial.c          |    9 +-
 arch/mips/pmc-sierra/msp71xx/msp_setup.c           |   10 +-
 arch/mips/pmc-sierra/msp71xx/msp_time.c            |   26 ++--
 arch/mips/pmc-sierra/msp71xx/msp_usb.c             |   17 +--
 arch/mips/pmc-sierra/yosemite/prom.c               |   32 +----
 drivers/mtd/maps/pmcmsp-flash.c                    |    9 +-
 8 files changed, 73 insertions(+), 185 deletions(-)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
index 786d82d..b8c34ff 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
@@ -118,13 +118,9 @@
 #define ZSP_DUET		'D'	/* one DUET zsp engine */
 #define ZSP_TRIAD		'T'	/* two TRIAD zsp engines */
 
-extern char *prom_getenv(char *name);
-extern void prom_init_cmdline(void);
-extern void prom_meminit(void);
 extern void prom_fixup_mem_map(unsigned long start_mem,
 			       unsigned long end_mem);
 
-extern int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr);
 extern unsigned long get_deviceid(void);
 extern char identify_enet(unsigned long interface_num);
 extern char identify_enetTxD(unsigned long interface_num);
@@ -147,25 +143,4 @@ extern unsigned long identify_revision(void);
 		printk(_f, ## x); \
 	} while (0)
 
-/* Memory descriptor management. */
-#define PROM_MAX_PMEMBLOCKS    7	/* 6 used */
-
-enum yamon_memtypes {
-	yamon_dontuse,
-	yamon_prom,
-	yamon_free,
-};
-
-struct prom_pmemblock {
-	unsigned long base; /* Within KSEG0. */
-	unsigned int size;  /* In bytes. */
-	unsigned int type;  /* free or prom memory */
-};
-
-extern int prom_argc;
-extern char **prom_argv;
-extern char **prom_envp;
-extern int *prom_vec;
-extern struct prom_pmemblock *prom_getmdesc(void);
-
 #endif /* !_ASM_MSP_PROM_H */
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
index db00deb..885256f 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
@@ -43,23 +43,18 @@
 #include <linux/slab.h>
 
 #include <asm/addrspace.h>
-#include <asm/bootinfo.h>
 #include <asm-generic/sections.h>
 #include <asm/page.h>
+#include <asm/fw/fw.h>
 
 #include <msp_prom.h>
 #include <msp_regs.h>
 
-/* global PROM environment variables and pointers */
-int prom_argc;
-char **prom_argv, **prom_envp;
-int *prom_vec;
-
-/* debug flag */
-int init_debug = 1;
+/* Global PROM vector */
+int *fw_vec;
 
 /* memory blocks */
-struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
+fw_memblock_t mdesc[7];
 
 /* default feature sets */
 static char msp_default_features[] =
@@ -141,7 +136,7 @@ int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr)
 {
 	char *ethaddr_str;
 
-	ethaddr_str = prom_getenv(ethaddr_name);
+	ethaddr_str = fw_getenv(ethaddr_name);
 	if (!ethaddr_str) {
 		printk(KERN_WARNING "%s not set in boot prom\n", ethaddr_name);
 		return -1;
@@ -168,7 +163,7 @@ EXPORT_SYMBOL(get_ethernet_addr);
 
 static char *get_features(void)
 {
-	char *feature = prom_getenv(FEATURES);
+	char *feature = fw_getenv(FEATURES);
 
 	if (feature == NULL) {
 		/* default features based on MACHINE_TYPE */
@@ -193,7 +188,7 @@ static char test_feature(char c)
 
 unsigned long get_deviceid(void)
 {
-	char *deviceid = prom_getenv(DEVICEID);
+	char *deviceid = fw_getenv(DEVICEID);
 
 	if (deviceid == NULL)
 		return *DEV_ID_REG;
@@ -281,72 +276,30 @@ unsigned long identify_revision(void)
 }
 EXPORT_SYMBOL(identify_revision);
 
-/* PROM environment functions */
-char *prom_getenv(char *env_name)
-{
-	/*
-	 * Return a pointer to the given environment variable.  prom_envp
-	 * points to a null terminated array of pointers to variables.
-	 * Environment variables are stored in the form of "memsize=64"
-	 */
-
-	char **var = prom_envp;
-	int i = strlen(env_name);
-
-	while (*var) {
-		if (strncmp(env_name, *var, i) == 0) {
-			return (*var + strlen(env_name) + 1);
-		}
-		var++;
-	}
-
-	return NULL;
-}
-
-/* PROM commandline functions */
-void  __init prom_init_cmdline(void)
-{
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = &(arcs_cmdline[0]);
-	while (actr < prom_argc) {
-		strcpy(cp, prom_argv[actr]);
-		cp += strlen(prom_argv[actr]);
-		*cp++ = ' ';
-		actr++;
-	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
-}
-
 /* memory allocation functions */
-static int __init prom_memtype_classify(unsigned int type)
+static int __init fw_memtype_classify(unsigned int type)
 {
 	switch (type) {
-	case yamon_free:
+	case fw_free:
 		return BOOT_MEM_RAM;
-	case yamon_prom:
+	case fw_code:
 		return BOOT_MEM_ROM_DATA;
 	default:
 		return BOOT_MEM_RESERVED;
 	}
 }
 
-void __init prom_meminit(void)
+void __init fw_meminit(void)
 {
-	struct prom_pmemblock *p;
+	fw_memblock_t *p;
 
-	p = prom_getmdesc();
+	p = fw_getmdesc();
 
 	while (p->size) {
 		long type;
 		unsigned long base, size;
 
-		type = prom_memtype_classify(p->type);
+		type = fw_memtype_classify(p->type);
 		base = p->base;
 		size = p->size;
 
@@ -369,43 +322,43 @@ void __init prom_free_prom_memory(void)
 	 * preserve environment variables and command line from pmon/bbload
 	 * first preserve the command line
 	 */
-	for (argc = 0; argc < prom_argc; argc++) {
-		len += sizeof(char *);			/* length of pointer */
-		len += strlen(prom_argv[argc]) + 1;	/* length of string */
+	for (argc = 0; argc < fw_argc; argc++) {
+		len += sizeof(int *);			/* length of pointer */
+		len += strlen(fw_argv(argc)) + 1;	/* length of string */
 	}
 	len += sizeof(char *);		/* plus length of null pointer */
 
 	argv = kmalloc(len, GFP_KERNEL);
-	ptr = (char *) &argv[prom_argc + 1];	/* strings follow array */
+	ptr = (char *) &argv[fw_argc + 1];	/* strings follow array */
 
-	for (argc = 0; argc < prom_argc; argc++) {
+	for (argc = 0; argc < fw_argc; argc++) {
 		argv[argc] = ptr;
-		strcpy(ptr, prom_argv[argc]);
-		ptr += strlen(prom_argv[argc]) + 1;
+		strcpy(ptr, fw_argv(argc));
+		ptr += strlen(fw_argv(argc)) + 1;
 	}
-	argv[prom_argc] = NULL;		/* end array with null pointer */
-	prom_argv = argv;
+	argv[fw_argc] = NULL;		/* end array with null pointer */
+	_fw_argv = (int *)argv;
 
 	/* next preserve the environment variables */
 	len = 0;
 	i = 0;
-	for (envp = prom_envp; *envp != NULL; envp++) {
+	while (fw_envp(i) != NULL) {
+		len += sizeof(int *);		/* length of pointer */
+		len += strlen(fw_envp(i)) + 1;	/* length of string */
 		i++;		/* count number of environment variables */
-		len += sizeof(char *);		/* length of pointer */
-		len += strlen(*envp) + 1;	/* length of string */
 	}
 	len += sizeof(char *);		/* plus length of null pointer */
 
 	envp = kmalloc(len, GFP_KERNEL);
-	ptr = (char *) &envp[i+1];
+	ptr = (char *) &envp[i + 1];
 
 	for (argc = 0; argc < i; argc++) {
 		envp[argc] = ptr;
-		strcpy(ptr, prom_envp[argc]);
-		ptr += strlen(prom_envp[argc]) + 1;
+		strcpy(ptr, fw_envp(argc));
+		ptr += strlen(fw_envp(argc)) + 1;
 	}
 	envp[i] = NULL;			/* end array with null pointer */
-	prom_envp = envp;
+	_fw_envp = (int *)envp;
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
@@ -417,22 +370,23 @@ void __init prom_free_prom_memory(void)
 	}
 }
 
-struct prom_pmemblock *__init prom_getmdesc(void)
+fw_memblock_t *__init fw_getmdesc(void)
 {
 	static char	memsz_env[] __initdata = "memsize";
 	static char	heaptop_env[] __initdata = "heaptop";
 	char		*str;
 	unsigned int	memsize;
 	unsigned int	heaptop;
-	int i;
+	int i, tmp;
+	long val;
 
-	str = prom_getenv(memsz_env);
+	str = fw_getenv(memsz_env);
 	if (!str) {
-		ppfinit("memsize not set in boot prom, "
-			"set to default (32Mb)\n");
+		ppfinit("memsize not set in firmware, set to default (32Mb)\n");
 		memsize = 0x02000000;
 	} else {
-		memsize = simple_strtol(str, NULL, 0);
+		tmp = kstrtol(str, 0, &val);
+		memsize = (unsigned int)val;
 
 		if (memsize == 0) {
 			/* if memsize is a bad size, use reasonable default */
@@ -443,16 +397,18 @@ struct prom_pmemblock *__init prom_getmdesc(void)
 		memsize = CPHYSADDR(memsize);
 	}
 
-	str = prom_getenv(heaptop_env);
+	str = fw_getenv(heaptop_env);
 	if (!str) {
 		heaptop = CPHYSADDR((u32)&_text);
 		ppfinit("heaptop not set in boot prom, "
 			"set to default 0x%08x\n", heaptop);
 	} else {
-		heaptop = simple_strtol(str, NULL, 16);
+		tmp = kstrtol(str, 16, &val);
+		heaptop = (unsigned int)val;
 		if (heaptop == 0) {
 			/* heaptop conversion bad, might have 0xValue */
-			heaptop = simple_strtol(str, NULL, 0);
+			tmp = kstrtol(str, 0, &val);
+			heaptop = (unsigned int)val;
 
 			if (heaptop == 0) {
 				/* heaptop still bad, use reasonable default */
@@ -495,7 +451,7 @@ struct prom_pmemblock *__init prom_getmdesc(void)
 
 	/* Remainder of RAM -- under memsize */
 	i++;			/* 5 */
-	mdesc[i].type = yamon_free;
+	mdesc[i].type = fw_free;
 	mdesc[i].base = mdesc[i-1].base + mdesc[i-1].size;
 	mdesc[i].size = memsize - mdesc[i].base;
 
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_serial.c b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
index a1c7c7d..7080bce 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_serial.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_serial.c
@@ -29,12 +29,13 @@
 #include <linux/serial_reg.h>
 #include <linux/slab.h>
 
-#include <asm/bootinfo.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/serial.h>
 #include <linux/serial_8250.h>
 
+#include <asm/fw/fw.h>
+
 #include <msp_prom.h>
 #include <msp_int.h>
 #include <msp_regs.h>
@@ -90,16 +91,14 @@ static int msp_serial_handle_irq(struct uart_port *p)
 
 void __init msp_serial_setup(void)
 {
-	char    *s;
-	char    *endp;
 	struct uart_port up;
 	unsigned int uartclk;
 
 	memset(&up, 0, sizeof(up));
 
 	/* Check if clock was specified in environment */
-	s = prom_getenv("uartfreqhz");
-	if(!(s && *s && (uartclk = simple_strtoul(s, &endp, 10)) && *endp == 0))
+	uartclk = (unsigned int) fw_getenvl("uartfreqhz");
+	if (uartclk == 0)
 		uartclk = MSP_BASE_BAUD;
 	ppfinit("UART clock set to %d\n", uartclk);
 
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
index 7a834b2..6fa0d76 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
@@ -10,12 +10,12 @@
  * option) any later version.
  */
 
-#include <asm/bootinfo.h>
 #include <asm/cacheflush.h>
 #include <asm/r4kcache.h>
 #include <asm/reboot.h>
 #include <asm/smp-ops.h>
 #include <asm/time.h>
+#include <asm/fw/fw.h>
 
 #include <msp_prom.h>
 #include <msp_regs.h>
@@ -154,10 +154,6 @@ void __init prom_init(void)
 	unsigned long family;
 	unsigned long revision;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
-
 	/*
 	 * Someday we can use this with PMON2000 to get a
 	 * platform call prom routines for output etc. without
@@ -213,9 +209,9 @@ void __init prom_init(void)
 		break;
 	}
 
-	prom_init_cmdline();
+	fw_init_cmdline();
 
-	prom_meminit();
+	fw_meminit();
 
 	/*
 	 * Sub-system setup follows.
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index 8b42f30..d76cbdb 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -32,8 +32,8 @@
 #include <asm/cevt-r4k.h>
 #include <asm/mipsregs.h>
 #include <asm/time.h>
+#include <asm/fw/fw.h>
 
-#include <msp_prom.h>
 #include <msp_int.h>
 #include <msp_regs.h>
 
@@ -45,26 +45,16 @@ static int tim_installed;
 
 void __init plat_time_init(void)
 {
-	char    *endp, *s;
-	unsigned long cpu_rate = 0;
+	unsigned long cpu_rate;
 
-	if (cpu_rate == 0) {
-		s = prom_getenv("clkfreqhz");
-		cpu_rate = simple_strtoul(s, &endp, 10);
-		if (endp != NULL && *endp != 0) {
-			printk(KERN_ERR
-				"Clock rate in Hz parse error: %s\n", s);
-			cpu_rate = 0;
-		}
-	}
+	cpu_rate = fw_getenvl("clkfreqhz");
+	if (cpu_rate == 0)
+		printk(KERN_ERR "Clock rate in Hz parse error: %s\n", s);
 
 	if (cpu_rate == 0) {
-		s = prom_getenv("clkfreq");
-		cpu_rate = 1000 * simple_strtoul(s, &endp, 10);
-		if (endp != NULL && *endp != 0) {
-			printk(KERN_ERR
-				"Clock rate in MHz parse error: %s\n", s);
-			cpu_rate = 0;
+		cpu_rate = 1000 * fw_getenvl("clkfreq");
+		if (cpu_rate == 0)
+			printk(KERN_ERR "Clock rate in MHz parse error: %s\n", s);
 		}
 	}
 
diff --git a/arch/mips/pmc-sierra/msp71xx/msp_usb.c b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
index 9a1aef8..ee4ed9b 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_usb.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/mipsregs.h>
+#include <asm/fw/fw.h>
 
 #include <msp_regs.h>
 #include <msp_int.h>
@@ -201,26 +202,20 @@ static struct mspusb_device msp_usbdev1_device = {
 
 static int __init msp_usb_setup(void)
 {
-	char		*strp;
-	char		envstr[32];
 	struct platform_device *msp_devs[NUM_USB_DEVS];
+	char *strp;
 	unsigned int val;
 
-	/* construct environment name usbmode */
-	/* set usbmode <host/device> as pmon environment var */
+	/* set default host mode */
+	val = 1;
+
 	/*
 	 * Could this perhaps be integrated into the "features" env var?
 	 * Use the features key "U", and follow with "H" for host-mode,
 	 * "D" for device-mode.  If it works for Ethernet, why not USB...
 	 *  -- hammtrev, 2007/03/22
 	 */
-	snprintf((char *)&envstr[0], sizeof(envstr), "usbmode");
-
-	/* set default host mode */
-	val = 1;
-
-	/* get environment string */
-	strp = prom_getenv((char *)&envstr[0]);
+	strp = fw_getenv("usbmode");
 	if (strp) {
 		/* compare string */
 		if (!strcmp(strp, "device"))
diff --git a/arch/mips/pmc-sierra/yosemite/prom.c b/arch/mips/pmc-sierra/yosemite/prom.c
index 6a2754c..b4ce648 100644
--- a/arch/mips/pmc-sierra/yosemite/prom.c
+++ b/arch/mips/pmc-sierra/yosemite/prom.c
@@ -20,7 +20,7 @@
 #include <asm/processor.h>
 #include <asm/reboot.h>
 #include <asm/smp-ops.h>
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/pmon.h>
 
 #ifdef CONFIG_SMP
@@ -85,11 +85,7 @@ extern struct plat_smp_ops yos_smp_ops;
  */
 void __init prom_init(void)
 {
-	int argc = fw_arg0;
-	char **arg = (char **) fw_arg1;
-	char **env = (char **) fw_arg2;
 	struct callvectors *cv = (struct callvectors *) fw_arg3;
-	int i = 0;
 
 	/* Callbacks for halt, restart */
 	_machine_restart = (void (*)(char *)) prom_exit;
@@ -97,36 +93,16 @@ void __init prom_init(void)
 	pm_power_off = prom_halt;
 
 	debug_vectors = cv;
-	arcs_cmdline[0] = '\0';
 
-	/* Get the boot parameters */
-	for (i = 1; i < argc; i++) {
-		if (strlen(arcs_cmdline) + strlen(arg[i]) + 1 >=
-		    sizeof(arcs_cmdline))
-			break;
-
-		strcat(arcs_cmdline, arg[i]);
-		strcat(arcs_cmdline, " ");
-	}
+	fw_init_cmdline();
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	if ((strstr(arcs_cmdline, "console=ttyS")) == NULL)
 		strcat(arcs_cmdline, "console=ttyS0,115200");
 #endif
 
-	while (*env) {
-		if (strncmp("ocd_base", *env, strlen("ocd_base")) == 0)
-			yosemite_base =
-			    simple_strtol(*env + strlen("ocd_base="), NULL,
-					  16);
-
-		if (strncmp("cpuclock", *env, strlen("cpuclock")) == 0)
-			cpu_clock_freq =
-			    simple_strtol(*env + strlen("cpuclock="), NULL,
-					  10);
-
-		env++;
-	}
+	yosemite_base = fw_getenvl("ocd_base");
+	cpu_clock_freq = fw_getenvl("cpuclock");
 
 	prom_grab_secondary();
 
diff --git a/drivers/mtd/maps/pmcmsp-flash.c b/drivers/mtd/maps/pmcmsp-flash.c
index 744ca5c..c19d9e4 100644
--- a/drivers/mtd/maps/pmcmsp-flash.c
+++ b/drivers/mtd/maps/pmcmsp-flash.c
@@ -37,6 +37,7 @@
 #include <linux/mtd/partitions.h>
 
 #include <asm/io.h>
+#include <asm/fw/fw.h>
 
 #include <msp_prom.h>
 #include <msp_regs.h>
@@ -67,7 +68,7 @@ static int __init init_msp_flash(void)
 	}
 
 	/* examine the prom environment for flash devices */
-	for (fcnt = 0; (env = prom_getenv(flash_name)); fcnt++)
+	for (fcnt = 0; (env = fw_getenv(flash_name)); fcnt++)
 		flash_name[5] = '0' + fcnt + 1;
 
 	if (fcnt < 1)
@@ -92,7 +93,7 @@ static int __init init_msp_flash(void)
 		/* examine the prom environment for flash partititions */
 		part_name[5] = '0' + i;
 		part_name[7] = '0';
-		for (pcnt = 0; (env = prom_getenv(part_name)); pcnt++)
+		for (pcnt = 0; (env = fw_getenv(part_name)); pcnt++)
 			part_name[7] = '0' + pcnt + 1;
 
 		if (pcnt == 0) {
@@ -108,7 +109,7 @@ static int __init init_msp_flash(void)
 
 		/* now initialize the devices proper */
 		flash_name[5] = '0' + i;
-		env = prom_getenv(flash_name);
+		env = fw_getenv(flash_name);
 
 		if (sscanf(env, "%x:%x", &addr, &size) < 2) {
 			ret = -ENXIO;
@@ -152,7 +153,7 @@ static int __init init_msp_flash(void)
 			part_name[5] = '0' + i;
 			part_name[7] = '0' + j;
 
-			env = prom_getenv(part_name);
+			env = fw_getenv(part_name);
 
 			if (sscanf(env, "%x:%x:%n", &offset, &size,
 						&coff) < 2) {
-- 
1.7.10.3

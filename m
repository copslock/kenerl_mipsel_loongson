Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 12:33:06 +0000 (GMT)
Received: from erebor.lep.brno.cas.cz ([IPv6:::ffff:195.178.65.162]:42252 "EHLO
	erebor.lep.brno.cas.cz") by linux-mips.org with ESMTP
	id <S8226009AbTAHMdF>; Wed, 8 Jan 2003 12:33:05 +0000
Received: from ladis by erebor.lep.brno.cas.cz with local (Exim 3.12 #1 (Debian))
	id 18WFWd-0004rG-00; Wed, 08 Jan 2003 13:41:39 +0100
Date: Wed, 8 Jan 2003 13:41:38 +0100
To: linux-mips <linux-mips@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>
Subject: [PATCH] proper bus error handling for IP22
Message-ID: <20030108134138.B17162@erebor.psi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Ladislav Michl <ladis@psi.cz>
Return-Path: <ladis@psi.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@psi.cz
Precedence: bulk
X-list: linux-mips

This patch makes get_dbe/put_dbe useable. Additionaly prints some useful
informations on bus error. Depends on GIO interface removing patch.

	ladis

Index: arch/mips/sgi-ip22/ip22-berr.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-berr.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 ip22-berr.c
--- arch/mips/sgi-ip22/ip22-berr.c	5 Aug 2002 23:53:35 -0000	1.1.2.2
+++ arch/mips/sgi-ip22/ip22-berr.c	8 Jan 2003 12:22:32 -0000
@@ -15,12 +15,11 @@
 #include <asm/sgi/sgimc.h>
 #include <asm/sgi/sgihpc.h>
 
-unsigned int cpu_err_stat;	/* Status reg for CPU */
-unsigned int gio_err_stat;	/* Status reg for GIO */
-unsigned int cpu_err_addr;	/* Error address reg for CPU */
-unsigned int gio_err_addr;	/* Error address reg for GIO */
 
-volatile int nofault;
+static unsigned int cpu_err_stat;	/* Status reg for CPU */
+static unsigned int gio_err_stat;	/* Status reg for GIO */
+static unsigned int cpu_err_addr;	/* Error address reg for CPU */
+static unsigned int gio_err_addr;	/* Error address reg for GIO */
 
 static void save_and_clear_buserr(void)
 {
@@ -33,6 +32,35 @@
 	mcmisc_regs->cstat = mcmisc_regs->gstat = 0;
 }
 
+#define GIO_ERRMASK	0xff00
+#define CPU_ERRMASK	0x3f00
+
+static void print_buserr(void)
+{
+	if (cpu_err_stat & CPU_ERRMASK)
+		printk(KERN_ALERT "CPU Error/Addr 0x%x<%s%s%s%s%s%s> 0x%08x\n",
+			cpu_err_stat,
+			cpu_err_stat & SGIMC_CSTAT_RD ? "RD " : "",
+			cpu_err_stat & SGIMC_CSTAT_PAR ? "PAR " : "",
+			cpu_err_stat & SGIMC_CSTAT_ADDR ? "ADDR " : "",
+			cpu_err_stat & SGIMC_CSTAT_SYSAD_PAR ? "SYSAD " : "",
+			cpu_err_stat & SGIMC_CSTAT_SYSCMD_PAR ? "SYSCMD " : "",
+			cpu_err_stat & SGIMC_CSTAT_BAD_DATA ? "BAD_DATA " : "",
+			cpu_err_addr);
+	if (gio_err_stat & GIO_ERRMASK)
+		printk(KERN_ALERT "GIO Error/Addr 0x%x:<%s%s%s%s%s%s%s%s> 0x08%x\n",
+			gio_err_stat,
+			gio_err_stat & SGIMC_GSTAT_RD ? "RD " : "",
+			gio_err_stat & SGIMC_GSTAT_WR ? "WR " : "",
+			gio_err_stat & SGIMC_GSTAT_TIME ? "TIME " : "",
+			gio_err_stat & SGIMC_GSTAT_PROM ? "PROM " : "",
+			gio_err_stat & SGIMC_GSTAT_ADDR ? "ADDR " : "",
+			gio_err_stat & SGIMC_GSTAT_BC ? "BC " : "",
+			gio_err_stat & SGIMC_GSTAT_PIO_RD ? "PIO_RD " : "",
+			gio_err_stat & SGIMC_GSTAT_PIO_WR ? "PIO_WR " : "",
+			gio_err_addr);
+}
+
 /*
  * MC sends an interrupt whenever bus or parity errors occur. In addition,
  * if the error happened during a CPU read, it also asserts the bus error
@@ -43,33 +71,18 @@
 void be_ip22_interrupt(int irq, struct pt_regs *regs)
 {
 	save_and_clear_buserr();
-	printk(KERN_ALERT "Bus error, epc == %08lx, ra == %08lx\n",
-	       regs->cp0_epc, regs->regs[31]);
-	die_if_kernel("Oops", regs);
-	force_sig(SIGBUS, current);
+	print_buserr();
+	panic("Bus error, epc == %08lx, ra == %08lx\n",
+	      regs->cp0_epc, regs->regs[31]);
 }
 
 int be_ip22_handler(struct pt_regs *regs, int is_fixup)
 {
 	save_and_clear_buserr();
-	if (nofault) {
-		nofault = 0;
-		compute_return_epc(regs);
-		return MIPS_BE_DISCARD;
-	}
-	return MIPS_BE_FIXUP;
-}
-
-int ip22_baddr(unsigned int *val, unsigned long addr)
-{
-	nofault = 1;
-	*val = *(volatile unsigned int *) addr;
-	__asm__ __volatile__("nop;nop;nop;nop");
-	if (nofault) {
-		nofault = 0;
-		return 0;
-	}
-	return -EFAULT;
+	if (is_fixup)
+		return MIPS_BE_FIXUP;
+	print_buserr();
+	return MIPS_BE_FATAL;
 }
 
 void __init bus_error_init(void)
Index: include/asm-mips/sgi/sgimc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/sgi/sgimc.h,v
retrieving revision 1.5
diff -u -r1.5 sgimc.h
--- include/asm-mips/sgi/sgimc.h	6 Sep 2001 13:12:03 -0000	1.5
+++ include/asm-mips/sgi/sgimc.h	8 Jan 2003 12:22:33 -0000
@@ -15,144 +15,159 @@
 
 struct sgimc_misc_ctrl {
 	u32 _unused1;
-	volatile u32 cpuctrl0;     /* CPU control register 0, readwrite */
-#define SGIMC_CCTRL0_REFS         0x0000000f /* REFS mask */
-#define SGIMC_CCTRL0_EREFRESH     0x00000010 /* Memory refresh enable */
-#define SGIMC_CCTRL0_EPERRGIO     0x00000020 /* GIO parity error enable */
-#define SGIMC_CCTRL0_EPERRMEM     0x00000040 /* Main mem parity error enable */
-#define SGIMC_CCTRL0_EPERRCPU     0x00000080 /* CPU bus parity error enable */
-#define SGIMC_CCTRL0_WDOG         0x00000100 /* Watchdog timer enable */
-#define SGIMC_CCTRL0_SYSINIT      0x00000200 /* System init bit */
-#define SGIMC_CCTRL0_GFXRESET     0x00000400 /* Graphics interface reset */
-#define SGIMC_CCTRL0_EISALOCK     0x00000800 /* Lock CPU from memory for EISA */
-#define SGIMC_CCTRL0_EPERRSCMD    0x00001000 /* SysCMD bus parity error enable */
-#define SGIMC_CCTRL0_IENAB        0x00002000 /* Allow interrupts from MC */
-#define SGIMC_CCTRL0_ESNOOP       0x00004000 /* Snooping I/O enable */
-#define SGIMC_CCTRL0_EPROMWR      0x00008000 /* Prom writes from cpu enable */
-#define SGIMC_CCTRL0_WRESETPMEM   0x00010000 /* Perform warm reset, preserves mem */
-#define SGIMC_CCTRL0_LENDIAN      0x00020000 /* Put MC in little-endian mode */
-#define SGIMC_CCTRL0_WRESETDMEM   0x00040000 /* Warm reset, destroys mem contents */
-#define SGIMC_CCTRL0_CMEMBADPAR   0x02000000 /* Generate bad perr from cpu to mem */
-#define SGIMC_CCTRL0_R4KNOCHKPARR 0x04000000 /* Don't chk parity on mem data reads */
-#define SGIMC_CCTRL0_GIOBTOB      0x08000000 /* Allow GIO back to back writes */
+	volatile u32 cpuctrl0;	/* CPU control register 0, readwrite */
+#define SGIMC_CCTRL0_REFS	0x0000000f /* REFS mask */
+#define SGIMC_CCTRL0_EREFRESH	0x00000010 /* Memory refresh enable */
+#define SGIMC_CCTRL0_EPERRGIO	0x00000020 /* GIO parity error enable */
+#define SGIMC_CCTRL0_EPERRMEM	0x00000040 /* Main mem parity error enable */
+#define SGIMC_CCTRL0_EPERRCPU	0x00000080 /* CPU bus parity error enable */
+#define SGIMC_CCTRL0_WDOG	0x00000100 /* Watchdog timer enable */
+#define SGIMC_CCTRL0_SYSINIT	0x00000200 /* System init bit */
+#define SGIMC_CCTRL0_GFXRESET	0x00000400 /* Graphics interface reset */
+#define SGIMC_CCTRL0_EISALOCK	0x00000800 /* Lock CPU from memory for EISA */
+#define SGIMC_CCTRL0_EPERRSCMD	0x00001000 /* SysCMD bus parity error enable */
+#define SGIMC_CCTRL0_IENAB	0x00002000 /* Allow interrupts from MC */
+#define SGIMC_CCTRL0_ESNOOP	0x00004000 /* Snooping I/O enable */
+#define SGIMC_CCTRL0_EPROMWR	0x00008000 /* Prom writes from cpu enable */
+#define SGIMC_CCTRL0_WRESETPMEM	0x00010000 /* Perform warm reset, preserves mem */
+#define SGIMC_CCTRL0_LENDIAN	0x00020000 /* Put MC in little-endian mode */
+#define SGIMC_CCTRL0_WRESETDMEM	0x00040000 /* Warm reset, destroys mem contents */
+#define SGIMC_CCTRL0_CMEMBADPAR	0x02000000 /* Generate bad perr from cpu to mem */
+#define SGIMC_CCTRL0_R4KNOPAR	0x04000000 /* Don't chk parity on mem data reads */
+#define SGIMC_CCTRL0_GIOBTOB	0x08000000 /* Allow GIO back to back writes */
 
 	u32 _unused2;
-	volatile u32 cpuctrl1;     /* CPU control register 1, readwrite */
-#define SGIMC_CCTRL1_EGIOTIMEO    0x00000010 /* GIO bus timeout enable */
-#define SGIMC_CCTRL1_FIXEDEHPC    0x00001000 /* Fixed HPC endianness */
-#define SGIMC_CCTRL1_LITTLEHPC    0x00002000 /* Little endian HPC */
-#define SGIMC_CCTRL1_FIXEDEEXP0   0x00004000 /* Fixed EXP0 endianness */
-#define SGIMC_CCTRL1_LITTLEEXP0   0x00008000 /* Little endian EXP0 */
-#define SGIMC_CCTRL1_FIXEDEEXP1   0x00010000 /* Fixed EXP1 endianness */
-#define SGIMC_CCTRL1_LITTLEEXP1   0x00020000 /* Little endian EXP1 */
+	volatile u32 cpuctrl1;	/* CPU control register 1, readwrite */
+#define SGIMC_CCTRL1_EGIOTIMEO	0x00000010 /* GIO bus timeout enable */
+#define SGIMC_CCTRL1_FIXEDEHPC	0x00001000 /* Fixed HPC endianness */
+#define SGIMC_CCTRL1_LITTLEHPC	0x00002000 /* Little endian HPC */
+#define SGIMC_CCTRL1_FIXEDEEXP0	0x00004000 /* Fixed EXP0 endianness */
+#define SGIMC_CCTRL1_LITTLEEXP0	0x00008000 /* Little endian EXP0 */
+#define SGIMC_CCTRL1_FIXEDEEXP1	0x00010000 /* Fixed EXP1 endianness */
+#define SGIMC_CCTRL1_LITTLEEXP1	0x00020000 /* Little endian EXP1 */
 
 	u32 _unused3;
-	volatile u32 watchdogt;    /* Watchdog reg rdonly, write clears */
+	volatile u32 watchdogt;	/* Watchdog reg rdonly, write clears */
 
 	u32 _unused4;
-	volatile u32 systemid;     /* MC system ID register, readonly */
-#define SGIMC_SYSID_MASKREV       0x0000000f /* Revision of MC controller */
-#define SGIMC_SYSID_EPRESENT      0x00000010 /* Indicates presence of EISA bus */
+	volatile u32 systemid;	/* MC system ID register, readonly */
+#define SGIMC_SYSID_MASKREV	0x0000000f /* Revision of MC controller */
+#define SGIMC_SYSID_EPRESENT	0x00000010 /* Indicates presence of EISA bus */
 
 	u32 _unused5[3];
-	volatile u32 divider;      /* Divider reg for RPSS */
+	volatile u32 divider;	/* Divider reg for RPSS */
 
 	u32 _unused6;
-	volatile unsigned char eeprom;       /* EEPROM byte reg for r4k */
-#define SGIMC_EEPROM_PRE          0x00000001 /* eeprom chip PRE pin assertion */
-#define SGIMC_EEPROM_CSEL         0x00000002 /* Active high, eeprom chip select */
-#define SGIMC_EEPROM_SECLOCK      0x00000004 /* EEPROM serial clock */
-#define SGIMC_EEPROM_SDATAO       0x00000008 /* Serial EEPROM data-out */
-#define SGIMC_EEPROM_SDATAI       0x00000010 /* Serial EEPROM data-in */
+	volatile unsigned char eeprom;     /* EEPROM byte reg for r4k */
+#define SGIMC_EEPROM_PRE	0x00000001 /* eeprom chip PRE pin assertion */
+#define SGIMC_EEPROM_CSEL	0x00000002 /* Active high, eeprom chip select */
+#define SGIMC_EEPROM_SECLOCK	0x00000004 /* EEPROM serial clock */
+#define SGIMC_EEPROM_SDATAO	0x00000008 /* Serial EEPROM data-out */
+#define SGIMC_EEPROM_SDATAI	0x00000010 /* Serial EEPROM data-in */
 
 	unsigned char _unused7[3];
 	u32 _unused8[3];
-	volatile unsigned short rcntpre;     /* Preload refresh counter */
+	volatile unsigned short rcntpre;   /* Preload refresh counter */
 
 	unsigned short _unused9;
 	u32 _unused9a;
-	volatile unsigned short rcounter;    /* Readonly refresh counter */
+	volatile unsigned short rcounter;  /* Readonly refresh counter */
 
 	unsigned short _unused10;
 	u32 _unused11[13];
-	volatile u32 gioparm;      /* Parameter word for GIO64 */
-#define SGIMC_GIOPARM_HPC64       0x00000001 /* HPC talks to GIO using 64-bits */
-#define SGIMC_GIOPARM_GFX64       0x00000002 /* GFX talks to GIO using 64-bits */
-#define SGIMC_GIOPARM_EXP064      0x00000004 /* EXP(slot0) talks using 64-bits */
-#define SGIMC_GIOPARM_EXP164      0x00000008 /* EXP(slot1) talks using 64-bits */
-#define SGIMC_GIOPARM_EISA64      0x00000010 /* EISA bus talks 64-bits to GIO */
-#define SGIMC_GIOPARM_HPC264      0x00000020 /* 2nd HPX talks 64-bits to GIO */
-#define SGIMC_GIOPARM_RTIMEGFX    0x00000040 /* GFX device has realtime attr */
-#define SGIMC_GIOPARM_RTIMEEXP0   0x00000080 /* EXP(slot0) has realtime attr */
-#define SGIMC_GIOPARM_RTIMEEXP1   0x00000100 /* EXP(slot1) has realtime attr */
-#define SGIMC_GIOPARM_MASTEREISA  0x00000200 /* EISA bus can act as bus master */
-#define SGIMC_GIOPARM_ONEBUS      0x00000400 /* Exists one GIO64 pipelined bus */
-#define SGIMC_GIOPARM_MASTERGFX   0x00000800 /* GFX can act as a bus master */
-#define SGIMC_GIOPARM_MASTEREXP0  0x00001000 /* EXP(slot0) can bus master */
-#define SGIMC_GIOPARM_MASTEREXP1  0x00002000 /* EXP(slot1) can bus master */
-#define SGIMC_GIOPARM_PLINEEXP0   0x00004000 /* EXP(slot0) has pipeline attr */
-#define SGIMC_GIOPARM_PLINEEXP1   0x00008000 /* EXP(slot1) has pipeline attr */
+	volatile u32 gioparm;	/* Parameter word for GIO64 */
+#define SGIMC_GIOPARM_HPC64	0x00000001 /* HPC talks to GIO using 64-bits */
+#define SGIMC_GIOPARM_GFX64	0x00000002 /* GFX talks to GIO using 64-bits */
+#define SGIMC_GIOPARM_EXP064	0x00000004 /* EXP(slot0) talks using 64-bits */
+#define SGIMC_GIOPARM_EXP164	0x00000008 /* EXP(slot1) talks using 64-bits */
+#define SGIMC_GIOPARM_EISA64	0x00000010 /* EISA bus talks 64-bits to GIO */
+#define SGIMC_GIOPARM_HPC264	0x00000020 /* 2nd HPX talks 64-bits to GIO */
+#define SGIMC_GIOPARM_RTIMEGFX	0x00000040 /* GFX device has realtime attr */
+#define SGIMC_GIOPARM_RTIMEEXP0	0x00000080 /* EXP(slot0) has realtime attr */
+#define SGIMC_GIOPARM_RTIMEEXP1	0x00000100 /* EXP(slot1) has realtime attr */
+#define SGIMC_GIOPARM_MSTREISA	0x00000200 /* EISA bus can act as bus master */
+#define SGIMC_GIOPARM_ONEBUS	0x00000400 /* Exists one GIO64 pipelined bus */
+#define SGIMC_GIOPARM_MSTRGFX	0x00000800 /* GFX can act as a bus master */
+#define SGIMC_GIOPARM_MSTREXP0	0x00001000 /* EXP(slot0) can bus master */
+#define SGIMC_GIOPARM_MSTREXP1	0x00002000 /* EXP(slot1) can bus master */
+#define SGIMC_GIOPARM_PLINEEXP0	0x00004000 /* EXP(slot0) has pipeline attr */
+#define SGIMC_GIOPARM_PLINEEXP1	0x00008000 /* EXP(slot1) has pipeline attr */
 
 	u32 _unused13;
-	volatile unsigned short cputp;       /* CPU bus arb time period */
+	volatile unsigned short cputp;     /* CPU bus arb time period */
 
 	unsigned short _unused14;
 	u32 _unused15[3];
-	volatile unsigned short lbursttp;    /* Time period for long bursts */
+	volatile unsigned short lbursttp;  /* Time period for long bursts */
 
 	unsigned short _unused16;
 	u32 _unused17[9];
-	volatile u32 mconfig0;     /* Memory config register zero */
+	volatile u32 mconfig0;	/* Memory config register zero */
 	u32 _unused18;
-	volatile u32 mconfig1;     /* Memory config register one */
+	volatile u32 mconfig1;	/* Memory config register one */
 
-        /* These defines apply to both mconfig registers above. */
-#define SGIMC_MCONFIG_FOURMB     0x00000000  /* Physical ram = 4megs */
-#define SGIMC_MCONFIG_EIGHTMB    0x00000100  /* Physical ram = 8megs */
-#define SGIMC_MCONFIG_SXTEENMB   0x00000300  /* Physical ram = 16megs */
-#define SGIMC_MCONFIG_TTWOMB     0x00000700  /* Physical ram = 32megs */
-#define SGIMC_MCONFIG_SFOURMB    0x00000f00  /* Physical ram = 64megs */
-#define SGIMC_MCONFIG_OTEIGHTMB  0x00001f00  /* Physical ram = 128megs */
-#define SGIMC_MCONFIG_RMASK      0x00001f00  /* Ram config bitmask */
+	/* These defines apply to both mconfig registers above. */
+#define SGIMC_MCONFIG_FOURMB	0x00000000 /* Physical ram = 4megs */
+#define SGIMC_MCONFIG_EIGHTMB	0x00000100 /* Physical ram = 8megs */
+#define SGIMC_MCONFIG_SXTEENMB	0x00000300 /* Physical ram = 16megs */
+#define SGIMC_MCONFIG_TTWOMB	0x00000700 /* Physical ram = 32megs */
+#define SGIMC_MCONFIG_SFOURMB	0x00000f00 /* Physical ram = 64megs */
+#define SGIMC_MCONFIG_OTEIGHTMB	0x00001f00 /* Physical ram = 128megs */
+#define SGIMC_MCONFIG_RMASK	0x00001f00 /* Ram config bitmask */
 
 	u32 _unused19;
-	volatile u32 cmacc;        /* Mem access config for CPU */
+	volatile u32 cmacc;	/* Mem access config for CPU */
 	u32 _unused20;
-	volatile u32 gmacc;        /* Mem access config for GIO */
+	volatile u32 gmacc;	/* Mem access config for GIO */
 
 	/* This define applies to both cmacc and gmacc registers above. */
-#define SGIMC_MACC_ALIASBIG       0x20000000 /* 512MB home for alias */
+#define SGIMC_MACC_ALIASBIG	0x20000000 /* 512MB home for alias */
 
 	/* Error address/status regs from GIO and CPU perspectives. */
 	u32 _unused21;
-	volatile u32 cerr;         /* Error address reg for CPU */
+	volatile u32 cerr;	/* Error address reg for CPU */
 	u32 _unused22;
-	volatile u32 cstat;        /* Status reg for CPU */
+	volatile u32 cstat;	/* Status reg for CPU */
+#define	SGIMC_CSTAT_RD		0x00000100 /* read parity error */
+#define	SGIMC_CSTAT_PAR		0x00000200 /* CPU parity error */
+#define	SGIMC_CSTAT_ADDR	0x00000400 /* memory bus error bad addr */
+#define	SGIMC_CSTAT_SYSAD_PAR	0x00000800 /* sysad parity error */
+#define	SGIMC_CSTAT_SYSCMD_PAR	0x00001000 /* syscmd parity error */
+#define	SGIMC_CSTAT_BAD_DATA	0x00002000 /* bad data identifier */
+#define	SGIMC_CSTAT_PAR_MASK	0x00001f00 /* parity error mask */
+#define	SGIMC_CSTAT_RD_PAR	(SGIMC_CSTAT_RD | SGIMC_CSTAT_PAR)
 	u32 _unused23;
-	volatile u32 gerr;         /* Error address reg for GIO */
+	volatile u32 gerr;	/* Error address reg for GIO */
 	u32 _unused24;
-	volatile u32 gstat;        /* Status reg for GIO */
-
+	volatile u32 gstat;	/* Status reg for GIO */
+#define	SGIMC_GSTAT_RD		0x00000100 /* read parity error */
+#define	SGIMC_GSTAT_WR		0x00000200 /* write parity error */
+#define	SGIMC_GSTAT_TIME	0x00000400 /* GIO bus timed out */
+#define	SGIMC_GSTAT_PROM	0x00000800 /* write to PROM when PROM_EN not set */
+#define	SGIMC_GSTAT_ADDR	0x00001000 /* parity error on addr cycle */
+#define	SGIMC_GSTAT_BC		0x00002000 /* parity error on byte count cycle */
+#define SGIMC_GSTAT_PIO_RD	0x00004000 /* read data parity on pio */
+#define SGIMC_GSTAT_PIO_WR	0x00008000 /* write data parity on pio */
 	/* Special hard bus locking registers. */
 	u32 _unused25;
-	volatile unsigned char syssembit;    /* Uni-bit system semaphore */
+	volatile unsigned char syssembit;	/* Uni-bit system semaphore */
 	unsigned char _unused26[3];
 	u32 _unused27;
-	volatile unsigned char mlock;        /* Global GIO memory access lock */
+	volatile unsigned char mlock;	/* Global GIO memory access lock */
 	unsigned char _unused28[3];
 	u32 _unused29;
-	volatile unsigned char elock;        /* Locks EISA from GIO accesses */
+	volatile unsigned char elock;	/* Locks EISA from GIO accesses */
 
 	/* GIO dma control registers. */
 	unsigned char _unused30[3];
 	u32 _unused31[14];
-	volatile u32 gio_dma_trans;/* DMA mask to translation GIO addrs */
+	volatile u32 gio_dma_trans;	/* DMA mask to translation GIO addrs */
 	u32 _unused32;
-	volatile u32 gio_dma_sbits;/* DMA GIO addr substitution bits */
+	volatile u32 gio_dma_sbits;	/* DMA GIO addr substitution bits */
 	u32 _unused33;
-	volatile u32 dma_intr_cause; /* DMA IRQ cause indicator bits */
+	volatile u32 dma_intr_cause;	/* DMA IRQ cause indicator bits */
 	u32 _unused34;
-	volatile u32 dma_ctrl;     /* Main DMA control reg */
+	volatile u32 dma_ctrl;		/* Main DMA control reg */
 
 	/* DMA TLB entry 0 */
 	u32 _unused35;
@@ -181,47 +196,47 @@
 
 /* MC misc control registers live at physical 0x1fa00000. */
 extern struct sgimc_misc_ctrl *mcmisc_regs;
-extern u32 *rpsscounter;          /* Chirps at 100ns */
+extern u32 *rpsscounter;		/* Chirps at 100ns */
 
 struct sgimc_dma_ctrl {
 	u32 _unused1;
-	volatile u32 maddronly;   /* Address DMA goes at */
+	volatile u32 maddronly;		/* Address DMA goes at */
 	u32 _unused2;
-	volatile u32 maddrpdeflts; /* Same as above, plus set defaults */
+	volatile u32 maddrpdeflts;	/* Same as above, plus set defaults */
 	u32 _unused3;
-	volatile u32 dmasz;       /* DMA count */
+	volatile u32 dmasz;		/* DMA count */
 	u32 _unused4;
-	volatile u32 ssize;       /* DMA stride size */
+	volatile u32 ssize;		/* DMA stride size */
 	u32 _unused5;
-	volatile u32 gmaddronly;  /* Set GIO DMA but do not start trans */
+	volatile u32 gmaddronly;	/* Set GIO DMA but do not start trans */
 	u32 _unused6;
-	volatile u32 dmaddnpgo;   /* Set GIO DMA addr + start transfer */
+	volatile u32 dmaddnpgo;		/* Set GIO DMA addr + start transfer */
 	u32 _unused7;
-	volatile u32 dmamode;     /* DMA mode config bit settings */
+	volatile u32 dmamode;		/* DMA mode config bit settings */
 	u32 _unused8;
-	volatile u32 dmaccount;    /* Zoom and byte count for DMA */
+	volatile u32 dmaccount;		/* Zoom and byte count for DMA */
 	u32 _unused9;
-	volatile u32 dmastart;    /* Pedal to the metal. */
+	volatile u32 dmastart;		/* Pedal to the metal. */
 	u32 _unused10;
-	volatile u32 dmarunning;  /* DMA op is in progress */
+	volatile u32 dmarunning;	/* DMA op is in progress */
 	u32 _unused11;
 
 	/* Set dma addr, defaults, and kick it */
-	volatile u32 maddr_defl_go; /* go go go! -lm */
+	volatile u32 maddr_defl_go;	/* go go go! -lm */
 };
 
 /* MC controller dma regs live at physical 0x1fa02000. */
 extern struct sgimc_dma_ctrl *dmactrlregs;
 
 /* Base location of the two ram banks found in IP2[0268] machines. */
-#define SGIMC_SEG0_BADDR     0x08000000
-#define SGIMC_SEG1_BADDR     0x20000000
+#define SGIMC_SEG0_BADDR	0x08000000
+#define SGIMC_SEG1_BADDR	0x20000000
 
 /* Maximum size of the above banks are per machine. */
 extern u32 sgimc_seg0_size, sgimc_seg1_size;
-#define SGIMC_SEG0_SIZE_ALL         0x10000000 /* 256MB */
-#define SGIMC_SEG1_SIZE_IP20_IP22   0x08000000 /* 128MB */
-#define SGIMC_SEG1_SIZE_IP26_IP28   0x20000000 /* 512MB */
+#define SGIMC_SEG0_SIZE_ALL		0x10000000 /* 256MB */
+#define SGIMC_SEG1_SIZE_IP20_IP22	0x08000000 /* 128MB */
+#define SGIMC_SEG1_SIZE_IP26_IP28	0x20000000 /* 512MB */
 
 extern void sgimc_init(void);
 
Index: include/asm-mips64/sgi/sgimc.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/sgi/sgimc.h,v
retrieving revision 1.3
diff -u -r1.3 sgimc.h
--- include/asm-mips64/sgi/sgimc.h	9 Jul 2001 00:25:38 -0000	1.3
+++ include/asm-mips64/sgi/sgimc.h	8 Jan 2003 12:22:33 -0000
@@ -15,144 +15,159 @@
 
 struct sgimc_misc_ctrl {
 	u32 _unused1;
-	volatile u32 cpuctrl0;     /* CPU control register 0, readwrite */
-#define SGIMC_CCTRL0_REFS         0x0000000f /* REFS mask */
-#define SGIMC_CCTRL0_EREFRESH     0x00000010 /* Memory refresh enable */
-#define SGIMC_CCTRL0_EPERRGIO     0x00000020 /* GIO parity error enable */
-#define SGIMC_CCTRL0_EPERRMEM     0x00000040 /* Main mem parity error enable */
-#define SGIMC_CCTRL0_EPERRCPU     0x00000080 /* CPU bus parity error enable */
-#define SGIMC_CCTRL0_WDOG         0x00000100 /* Watchdog timer enable */
-#define SGIMC_CCTRL0_SYSINIT      0x00000200 /* System init bit */
-#define SGIMC_CCTRL0_GFXRESET     0x00000400 /* Graphics interface reset */
-#define SGIMC_CCTRL0_EISALOCK     0x00000800 /* Lock CPU from memory for EISA */
-#define SGIMC_CCTRL0_EPERRSCMD    0x00001000 /* SysCMD bus parity error enable */
-#define SGIMC_CCTRL0_IENAB        0x00002000 /* Allow interrupts from MC */
-#define SGIMC_CCTRL0_ESNOOP       0x00004000 /* Snooping I/O enable */
-#define SGIMC_CCTRL0_EPROMWR      0x00008000 /* Prom writes from cpu enable */
-#define SGIMC_CCTRL0_WRESETPMEM   0x00010000 /* Perform warm reset, preserves mem */
-#define SGIMC_CCTRL0_LENDIAN      0x00020000 /* Put MC in little-endian mode */
-#define SGIMC_CCTRL0_WRESETDMEM   0x00040000 /* Warm reset, destroys mem contents */
-#define SGIMC_CCTRL0_CMEMBADPAR   0x02000000 /* Generate bad perr from cpu to mem */
-#define SGIMC_CCTRL0_R4KNOCHKPARR 0x04000000 /* Don't chk parity on mem data reads */
-#define SGIMC_CCTRL0_GIOBTOB      0x08000000 /* Allow GIO back to back writes */
+	volatile u32 cpuctrl0;	/* CPU control register 0, readwrite */
+#define SGIMC_CCTRL0_REFS	0x0000000f /* REFS mask */
+#define SGIMC_CCTRL0_EREFRESH	0x00000010 /* Memory refresh enable */
+#define SGIMC_CCTRL0_EPERRGIO	0x00000020 /* GIO parity error enable */
+#define SGIMC_CCTRL0_EPERRMEM	0x00000040 /* Main mem parity error enable */
+#define SGIMC_CCTRL0_EPERRCPU	0x00000080 /* CPU bus parity error enable */
+#define SGIMC_CCTRL0_WDOG	0x00000100 /* Watchdog timer enable */
+#define SGIMC_CCTRL0_SYSINIT	0x00000200 /* System init bit */
+#define SGIMC_CCTRL0_GFXRESET	0x00000400 /* Graphics interface reset */
+#define SGIMC_CCTRL0_EISALOCK	0x00000800 /* Lock CPU from memory for EISA */
+#define SGIMC_CCTRL0_EPERRSCMD	0x00001000 /* SysCMD bus parity error enable */
+#define SGIMC_CCTRL0_IENAB	0x00002000 /* Allow interrupts from MC */
+#define SGIMC_CCTRL0_ESNOOP	0x00004000 /* Snooping I/O enable */
+#define SGIMC_CCTRL0_EPROMWR	0x00008000 /* Prom writes from cpu enable */
+#define SGIMC_CCTRL0_WRESETPMEM	0x00010000 /* Perform warm reset, preserves mem */
+#define SGIMC_CCTRL0_LENDIAN	0x00020000 /* Put MC in little-endian mode */
+#define SGIMC_CCTRL0_WRESETDMEM	0x00040000 /* Warm reset, destroys mem contents */
+#define SGIMC_CCTRL0_CMEMBADPAR	0x02000000 /* Generate bad perr from cpu to mem */
+#define SGIMC_CCTRL0_R4KNOPAR	0x04000000 /* Don't chk parity on mem data reads */
+#define SGIMC_CCTRL0_GIOBTOB	0x08000000 /* Allow GIO back to back writes */
 
 	u32 _unused2;
-	volatile u32 cpuctrl1;     /* CPU control register 1, readwrite */
-#define SGIMC_CCTRL1_EGIOTIMEO    0x00000010 /* GIO bus timeout enable */
-#define SGIMC_CCTRL1_FIXEDEHPC    0x00001000 /* Fixed HPC endianness */
-#define SGIMC_CCTRL1_LITTLEHPC    0x00002000 /* Little endian HPC */
-#define SGIMC_CCTRL1_FIXEDEEXP0   0x00004000 /* Fixed EXP0 endianness */
-#define SGIMC_CCTRL1_LITTLEEXP0   0x00008000 /* Little endian EXP0 */
-#define SGIMC_CCTRL1_FIXEDEEXP1   0x00010000 /* Fixed EXP1 endianness */
-#define SGIMC_CCTRL1_LITTLEEXP1   0x00020000 /* Little endian EXP1 */
+	volatile u32 cpuctrl1;	/* CPU control register 1, readwrite */
+#define SGIMC_CCTRL1_EGIOTIMEO	0x00000010 /* GIO bus timeout enable */
+#define SGIMC_CCTRL1_FIXEDEHPC	0x00001000 /* Fixed HPC endianness */
+#define SGIMC_CCTRL1_LITTLEHPC	0x00002000 /* Little endian HPC */
+#define SGIMC_CCTRL1_FIXEDEEXP0	0x00004000 /* Fixed EXP0 endianness */
+#define SGIMC_CCTRL1_LITTLEEXP0	0x00008000 /* Little endian EXP0 */
+#define SGIMC_CCTRL1_FIXEDEEXP1	0x00010000 /* Fixed EXP1 endianness */
+#define SGIMC_CCTRL1_LITTLEEXP1	0x00020000 /* Little endian EXP1 */
 
 	u32 _unused3;
-	volatile u32 watchdogt;    /* Watchdog reg rdonly, write clears */
+	volatile u32 watchdogt;	/* Watchdog reg rdonly, write clears */
 
 	u32 _unused4;
-	volatile u32 systemid;     /* MC system ID register, readonly */
-#define SGIMC_SYSID_MASKREV       0x0000000f /* Revision of MC controller */
-#define SGIMC_SYSID_EPRESENT      0x00000010 /* Indicates presence of EISA bus */
+	volatile u32 systemid;	/* MC system ID register, readonly */
+#define SGIMC_SYSID_MASKREV	0x0000000f /* Revision of MC controller */
+#define SGIMC_SYSID_EPRESENT	0x00000010 /* Indicates presence of EISA bus */
 
 	u32 _unused5[3];
-	volatile u32 divider;      /* Divider reg for RPSS */
+	volatile u32 divider;	/* Divider reg for RPSS */
 
 	u32 _unused6;
-	volatile unsigned char eeprom;       /* EEPROM byte reg for r4k */
-#define SGIMC_EEPROM_PRE          0x00000001 /* eeprom chip PRE pin assertion */
-#define SGIMC_EEPROM_CSEL         0x00000002 /* Active high, eeprom chip select */
-#define SGIMC_EEPROM_SECLOCK      0x00000004 /* EEPROM serial clock */
-#define SGIMC_EEPROM_SDATAO       0x00000008 /* Serial EEPROM data-out */
-#define SGIMC_EEPROM_SDATAI       0x00000010 /* Serial EEPROM data-in */
+	volatile unsigned char eeprom;     /* EEPROM byte reg for r4k */
+#define SGIMC_EEPROM_PRE	0x00000001 /* eeprom chip PRE pin assertion */
+#define SGIMC_EEPROM_CSEL	0x00000002 /* Active high, eeprom chip select */
+#define SGIMC_EEPROM_SECLOCK	0x00000004 /* EEPROM serial clock */
+#define SGIMC_EEPROM_SDATAO	0x00000008 /* Serial EEPROM data-out */
+#define SGIMC_EEPROM_SDATAI	0x00000010 /* Serial EEPROM data-in */
 
 	unsigned char _unused7[3];
 	u32 _unused8[3];
-	volatile unsigned short rcntpre;     /* Preload refresh counter */
+	volatile unsigned short rcntpre;   /* Preload refresh counter */
 
 	unsigned short _unused9;
 	u32 _unused9a;
-	volatile unsigned short rcounter;    /* Readonly refresh counter */
+	volatile unsigned short rcounter;  /* Readonly refresh counter */
 
 	unsigned short _unused10;
 	u32 _unused11[13];
-	volatile u32 gioparm;      /* Parameter word for GIO64 */
-#define SGIMC_GIOPARM_HPC64       0x00000001 /* HPC talks to GIO using 64-bits */
-#define SGIMC_GIOPARM_GFX64       0x00000002 /* GFX talks to GIO using 64-bits */
-#define SGIMC_GIOPARM_EXP064      0x00000004 /* EXP(slot0) talks using 64-bits */
-#define SGIMC_GIOPARM_EXP164      0x00000008 /* EXP(slot1) talks using 64-bits */
-#define SGIMC_GIOPARM_EISA64      0x00000010 /* EISA bus talks 64-bits to GIO */
-#define SGIMC_GIOPARM_HPC264      0x00000020 /* 2nd HPX talks 64-bits to GIO */
-#define SGIMC_GIOPARM_RTIMEGFX    0x00000040 /* GFX device has realtime attr */
-#define SGIMC_GIOPARM_RTIMEEXP0   0x00000080 /* EXP(slot0) has realtime attr */
-#define SGIMC_GIOPARM_RTIMEEXP1   0x00000100 /* EXP(slot1) has realtime attr */
-#define SGIMC_GIOPARM_MASTEREISA  0x00000200 /* EISA bus can act as bus master */
-#define SGIMC_GIOPARM_ONEBUS      0x00000400 /* Exists one GIO64 pipelined bus */
-#define SGIMC_GIOPARM_MASTERGFX   0x00000800 /* GFX can act as a bus master */
-#define SGIMC_GIOPARM_MASTEREXP0  0x00001000 /* EXP(slot0) can bus master */
-#define SGIMC_GIOPARM_MASTEREXP1  0x00002000 /* EXP(slot1) can bus master */
-#define SGIMC_GIOPARM_PLINEEXP0   0x00004000 /* EXP(slot0) has pipeline attr */
-#define SGIMC_GIOPARM_PLINEEXP1   0x00008000 /* EXP(slot1) has pipeline attr */
+	volatile u32 gioparm;	/* Parameter word for GIO64 */
+#define SGIMC_GIOPARM_HPC64	0x00000001 /* HPC talks to GIO using 64-bits */
+#define SGIMC_GIOPARM_GFX64	0x00000002 /* GFX talks to GIO using 64-bits */
+#define SGIMC_GIOPARM_EXP064	0x00000004 /* EXP(slot0) talks using 64-bits */
+#define SGIMC_GIOPARM_EXP164	0x00000008 /* EXP(slot1) talks using 64-bits */
+#define SGIMC_GIOPARM_EISA64	0x00000010 /* EISA bus talks 64-bits to GIO */
+#define SGIMC_GIOPARM_HPC264	0x00000020 /* 2nd HPX talks 64-bits to GIO */
+#define SGIMC_GIOPARM_RTIMEGFX	0x00000040 /* GFX device has realtime attr */
+#define SGIMC_GIOPARM_RTIMEEXP0	0x00000080 /* EXP(slot0) has realtime attr */
+#define SGIMC_GIOPARM_RTIMEEXP1	0x00000100 /* EXP(slot1) has realtime attr */
+#define SGIMC_GIOPARM_MSTREISA	0x00000200 /* EISA bus can act as bus master */
+#define SGIMC_GIOPARM_ONEBUS	0x00000400 /* Exists one GIO64 pipelined bus */
+#define SGIMC_GIOPARM_MSTRGFX	0x00000800 /* GFX can act as a bus master */
+#define SGIMC_GIOPARM_MSTREXP0	0x00001000 /* EXP(slot0) can bus master */
+#define SGIMC_GIOPARM_MSTREXP1	0x00002000 /* EXP(slot1) can bus master */
+#define SGIMC_GIOPARM_PLINEEXP0	0x00004000 /* EXP(slot0) has pipeline attr */
+#define SGIMC_GIOPARM_PLINEEXP1	0x00008000 /* EXP(slot1) has pipeline attr */
 
 	u32 _unused13;
-	volatile unsigned short cputp;       /* CPU bus arb time period */
+	volatile unsigned short cputp;     /* CPU bus arb time period */
 
 	unsigned short _unused14;
 	u32 _unused15[3];
-	volatile unsigned short lbursttp;    /* Time period for long bursts */
+	volatile unsigned short lbursttp;  /* Time period for long bursts */
 
 	unsigned short _unused16;
 	u32 _unused17[9];
-	volatile u32 mconfig0;     /* Memory config register zero */
+	volatile u32 mconfig0;	/* Memory config register zero */
 	u32 _unused18;
-	volatile u32 mconfig1;     /* Memory config register one */
+	volatile u32 mconfig1;	/* Memory config register one */
 
-        /* These defines apply to both mconfig registers above. */
-#define SGIMC_MCONFIG_FOURMB     0x00000000  /* Physical ram = 4megs */
-#define SGIMC_MCONFIG_EIGHTMB    0x00000100  /* Physical ram = 8megs */
-#define SGIMC_MCONFIG_SXTEENMB   0x00000300  /* Physical ram = 16megs */
-#define SGIMC_MCONFIG_TTWOMB     0x00000700  /* Physical ram = 32megs */
-#define SGIMC_MCONFIG_SFOURMB    0x00000f00  /* Physical ram = 64megs */
-#define SGIMC_MCONFIG_OTEIGHTMB  0x00001f00  /* Physical ram = 128megs */
-#define SGIMC_MCONFIG_RMASK      0x00001f00  /* Ram config bitmask */
+	/* These defines apply to both mconfig registers above. */
+#define SGIMC_MCONFIG_FOURMB	0x00000000 /* Physical ram = 4megs */
+#define SGIMC_MCONFIG_EIGHTMB	0x00000100 /* Physical ram = 8megs */
+#define SGIMC_MCONFIG_SXTEENMB	0x00000300 /* Physical ram = 16megs */
+#define SGIMC_MCONFIG_TTWOMB	0x00000700 /* Physical ram = 32megs */
+#define SGIMC_MCONFIG_SFOURMB	0x00000f00 /* Physical ram = 64megs */
+#define SGIMC_MCONFIG_OTEIGHTMB	0x00001f00 /* Physical ram = 128megs */
+#define SGIMC_MCONFIG_RMASK	0x00001f00 /* Ram config bitmask */
 
 	u32 _unused19;
-	volatile u32 cmacc;        /* Mem access config for CPU */
+	volatile u32 cmacc;	/* Mem access config for CPU */
 	u32 _unused20;
-	volatile u32 gmacc;        /* Mem access config for GIO */
+	volatile u32 gmacc;	/* Mem access config for GIO */
 
 	/* This define applies to both cmacc and gmacc registers above. */
-#define SGIMC_MACC_ALIASBIG       0x20000000 /* 512MB home for alias */
+#define SGIMC_MACC_ALIASBIG	0x20000000 /* 512MB home for alias */
 
 	/* Error address/status regs from GIO and CPU perspectives. */
 	u32 _unused21;
-	volatile u32 cerr;         /* Error address reg for CPU */
+	volatile u32 cerr;	/* Error address reg for CPU */
 	u32 _unused22;
-	volatile u32 cstat;        /* Status reg for CPU */
+	volatile u32 cstat;	/* Status reg for CPU */
+#define	SGIMC_CSTAT_RD		0x00000100 /* read parity error */
+#define	SGIMC_CSTAT_PAR		0x00000200 /* CPU parity error */
+#define	SGIMC_CSTAT_ADDR	0x00000400 /* memory bus error bad addr */
+#define	SGIMC_CSTAT_SYSAD_PAR	0x00000800 /* sysad parity error */
+#define	SGIMC_CSTAT_SYSCMD_PAR	0x00001000 /* syscmd parity error */
+#define	SGIMC_CSTAT_BAD_DATA	0x00002000 /* bad data identifier */
+#define	SGIMC_CSTAT_PAR_MASK	0x00001f00 /* parity error mask */
+#define	SGIMC_CSTAT_RD_PAR	(SGIMC_CSTAT_RD | SGIMC_CSTAT_PAR)
 	u32 _unused23;
-	volatile u32 gerr;         /* Error address reg for GIO */
+	volatile u32 gerr;	/* Error address reg for GIO */
 	u32 _unused24;
-	volatile u32 gstat;        /* Status reg for GIO */
-
+	volatile u32 gstat;	/* Status reg for GIO */
+#define	SGIMC_GSTAT_RD		0x00000100 /* read parity error */
+#define	SGIMC_GSTAT_WR		0x00000200 /* write parity error */
+#define	SGIMC_GSTAT_TIME	0x00000400 /* GIO bus timed out */
+#define	SGIMC_GSTAT_PROM	0x00000800 /* write to PROM when PROM_EN not set */
+#define	SGIMC_GSTAT_ADDR	0x00001000 /* parity error on addr cycle */
+#define	SGIMC_GSTAT_BC		0x00002000 /* parity error on byte count cycle */
+#define SGIMC_GSTAT_PIO_RD	0x00004000 /* read data parity on pio */
+#define SGIMC_GSTAT_PIO_WR	0x00008000 /* write data parity on pio */
 	/* Special hard bus locking registers. */
 	u32 _unused25;
-	volatile unsigned char syssembit;    /* Uni-bit system semaphore */
+	volatile unsigned char syssembit;	/* Uni-bit system semaphore */
 	unsigned char _unused26[3];
 	u32 _unused27;
-	volatile unsigned char mlock;        /* Global GIO memory access lock */
+	volatile unsigned char mlock;	/* Global GIO memory access lock */
 	unsigned char _unused28[3];
 	u32 _unused29;
-	volatile unsigned char elock;        /* Locks EISA from GIO accesses */
+	volatile unsigned char elock;	/* Locks EISA from GIO accesses */
 
 	/* GIO dma control registers. */
 	unsigned char _unused30[3];
 	u32 _unused31[14];
-	volatile u32 gio_dma_trans;/* DMA mask to translation GIO addrs */
+	volatile u32 gio_dma_trans;	/* DMA mask to translation GIO addrs */
 	u32 _unused32;
-	volatile u32 gio_dma_sbits;/* DMA GIO addr substitution bits */
+	volatile u32 gio_dma_sbits;	/* DMA GIO addr substitution bits */
 	u32 _unused33;
-	volatile u32 dma_intr_cause; /* DMA IRQ cause indicator bits */
+	volatile u32 dma_intr_cause;	/* DMA IRQ cause indicator bits */
 	u32 _unused34;
-	volatile u32 dma_ctrl;     /* Main DMA control reg */
+	volatile u32 dma_ctrl;		/* Main DMA control reg */
 
 	/* DMA TLB entry 0 */
 	u32 _unused35;
@@ -181,47 +196,47 @@
 
 /* MC misc control registers live at physical 0x1fa00000. */
 extern struct sgimc_misc_ctrl *mcmisc_regs;
-extern u32 *rpsscounter;          /* Chirps at 100ns */
+extern u32 *rpsscounter;		/* Chirps at 100ns */
 
 struct sgimc_dma_ctrl {
 	u32 _unused1;
-	volatile u32 maddronly;   /* Address DMA goes at */
+	volatile u32 maddronly;		/* Address DMA goes at */
 	u32 _unused2;
-	volatile u32 maddrpdeflts; /* Same as above, plus set defaults */
+	volatile u32 maddrpdeflts;	/* Same as above, plus set defaults */
 	u32 _unused3;
-	volatile u32 dmasz;       /* DMA count */
+	volatile u32 dmasz;		/* DMA count */
 	u32 _unused4;
-	volatile u32 ssize;       /* DMA stride size */
+	volatile u32 ssize;		/* DMA stride size */
 	u32 _unused5;
-	volatile u32 gmaddronly;  /* Set GIO DMA but do not start trans */
+	volatile u32 gmaddronly;	/* Set GIO DMA but do not start trans */
 	u32 _unused6;
-	volatile u32 dmaddnpgo;   /* Set GIO DMA addr + start transfer */
+	volatile u32 dmaddnpgo;		/* Set GIO DMA addr + start transfer */
 	u32 _unused7;
-	volatile u32 dmamode;     /* DMA mode config bit settings */
+	volatile u32 dmamode;		/* DMA mode config bit settings */
 	u32 _unused8;
-	volatile u32 dmacount;    /* Zoom and byte count for DMA */
+	volatile u32 dmaccount;		/* Zoom and byte count for DMA */
 	u32 _unused9;
-	volatile u32 dmastart;    /* Pedal to the metal. */
+	volatile u32 dmastart;		/* Pedal to the metal. */
 	u32 _unused10;
-	volatile u32 dmarunning;  /* DMA op is in progress */
+	volatile u32 dmarunning;	/* DMA op is in progress */
 	u32 _unused11;
 
 	/* Set dma addr, defaults, and kick it */
-	volatile u32 maddr_defl_go; /* go go go! -lm */
+	volatile u32 maddr_defl_go;	/* go go go! -lm */
 };
 
 /* MC controller dma regs live at physical 0x1fa02000. */
 extern struct sgimc_dma_ctrl *dmactrlregs;
 
 /* Base location of the two ram banks found in IP2[0268] machines. */
-#define SGIMC_SEG0_BADDR     0x08000000
-#define SGIMC_SEG1_BADDR     0x20000000
+#define SGIMC_SEG0_BADDR	0x08000000
+#define SGIMC_SEG1_BADDR	0x20000000
 
 /* Maximum size of the above banks are per machine. */
 extern u32 sgimc_seg0_size, sgimc_seg1_size;
-#define SGIMC_SEG0_SIZE_ALL         0x10000000 /* 256MB */
-#define SGIMC_SEG1_SIZE_IP20_IP22   0x08000000 /* 128MB */
-#define SGIMC_SEG1_SIZE_IP26_IP28   0x20000000 /* 512MB */
+#define SGIMC_SEG0_SIZE_ALL		0x10000000 /* 256MB */
+#define SGIMC_SEG1_SIZE_IP20_IP22	0x08000000 /* 128MB */
+#define SGIMC_SEG1_SIZE_IP26_IP28	0x20000000 /* 512MB */
 
 extern void sgimc_init(void);
 

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75AARRw003159
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 03:10:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75AAQnf003158
	for linux-mips-outgoing; Mon, 5 Aug 2002 03:10:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from kopretinka (mail@p030.as-l025.contactel.cz [212.65.234.30])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75A9aRw003132
	for <linux-mips@oss.sgi.com>; Mon, 5 Aug 2002 03:09:41 -0700
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 17bTTZ-0001WR-00; Mon, 05 Aug 2002 00:03:49 +0200
Date: Mon, 5 Aug 2002 00:03:49 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: [patch] GIO bus support
Message-ID: <20020804220348.GA5277@kopretinka>
References: <20020626205956.GA2079@kopretinka> <Pine.GSO.3.96.1020627140152.21496C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020627140152.21496C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@psi.cz>
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 27, 2002 at 02:21:30PM +0200, Maciej W. Rozycki wrote:
> On Wed, 26 Jun 2002, Ladislav Michl wrote:
> 
> > +int be_ip22_handler(struct pt_regs *regs, int is_fixup)
> > +{
> > +	save_and_clear_buserr();
> > +	if (nofault) {
> > +		nofault = 0;
> > +		compute_return_epc(regs);
> > +		return MIPS_BE_DISCARD;
> > +	}
> > +	return MIPS_BE_FIXUP;
> > +}
> 
>  I wouldn't use nofault -- it leads to reentrancy problems and I don't
> think you really need it.  You probably need to code it like this:
> 
> {
> 	save_and_clear_buserr();
> 
> 	return is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
> }
> 
> unless:
> 
> 1. There is a condition when for is_fixup true you should ignore the fixup
> anyway (e.g. what the bus error logic reports is irrelevant to fixups). 
> You should choose between MIPS_BE_FATAL and MIPS_BE_DISCARD then. 
> 
> 2. There is a condition when for is_fixup false, an error is not fatal and
> execution should get restarted.  You should return MIPS_BE_DISCARD then.

You are probably right. Unfortunately I cannot verify following patch
(my Indy is currently dead). I hope there is enough brave men for this
dirty job :-)

	ladis

--- linux/arch/mips/sgi-ip22/ip22-berr.c.orig	Thu Aug  1 23:26:10 2002
+++ linux/arch/mips/sgi-ip22/ip22-berr.c	Sun Aug  4 23:03:34 2002
@@ -20,8 +20,6 @@
 unsigned int cpu_err_addr;	/* Error address reg for CPU */
 unsigned int gio_err_addr;	/* Error address reg for GIO */
 
-volatile int nofault;
-
 static void save_and_clear_buserr(void)
 {
 	/* save memory controler's error status registers */ 
@@ -33,6 +31,35 @@
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
@@ -43,6 +70,7 @@
 void be_ip22_interrupt(int irq, struct pt_regs *regs)
 {
 	save_and_clear_buserr();
+	print_buserr();
 	printk(KERN_ALERT "Bus error, epc == %08lx, ra == %08lx\n",
 	       regs->cp0_epc, regs->regs[31]);
 	die_if_kernel("Oops", regs);
@@ -52,24 +80,10 @@
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
--- linux/arch/mips/sgi-ip22/ip22-gio.c.orig	Thu Aug  1 23:26:23 2002
+++ linux/arch/mips/sgi-ip22/ip22-gio.c	Sun Aug  4 23:43:35 2002
@@ -11,6 +11,7 @@
 #include <linux/proc_fs.h>
 
 #include <asm/addrspace.h>
+#include <asm/paccess.h>
 #include <asm/sgi/sgimc.h>
 #include <asm/sgi/sgigio.h>
 
@@ -118,8 +119,6 @@
 #define GIO_ROM_PRESENT		0x20000
 #define GIO_VENDOR_CODE(x)	((x >> 18) & 0x3fff)
 
-extern int ip22_baddr(unsigned int *val, unsigned long addr);
-
 /** 
  * sgigio_init - scan the GIO space and figure out what hardware is actually
  * present.
@@ -128,9 +127,10 @@
 {
 	unsigned int i, id, found = 0;
 
-	printk("GIO: Scanning for GIO cards...\n");
+	printk("GIO: Probing bus...\n");
 	for (i = 0; i < GIO_NUM_SLOTS; i++) {
-		if (ip22_baddr(&id, KSEG1ADDR(gio_slot[i].base_addr)))
+		if (get_dbe(id, (volatile unsigned int *) 
+				 KSEG1ADDR(gio_slot[i].base_addr)))
 			continue;
 
 		found = 1;
--- linux/include/asm-mips/sgi/sgimc.h.orig	Sun Aug  4 22:16:03 2002
+++ linux/include/asm-mips/sgi/sgimc.h	Sun Aug  4 22:34:43 2002
@@ -128,11 +128,29 @@
 	volatile u32 cerr;         /* Error address reg for CPU */
 	u32 _unused22;
 	volatile u32 cstat;        /* Status reg for CPU */
+#define	SGIMC_CSTAT_RD		0x00000100	/* read parity error */
+#define	SGIMC_CSTAT_PAR		0x00000200	/* CPU parity error */
+#define	SGIMC_CSTAT_ADDR	0x00000400	/* memory bus error bad addr */
+#define	SGIMC_CSTAT_SYSAD_PAR	0x00000800	/* sysad parity error */
+#define	SGIMC_CSTAT_SYSCMD_PAR	0x00001000	/* syscmd parity error */
+#define	SGIMC_CSTAT_BAD_DATA	0x00002000	/* bad data identifier */
+#define	SGIMC_CSTAT_PAR_MASK	0x00001f00	/* parity error mask */
+#define	SGIMC_CSTAT_RD_PAR	(SGIMC_CSTAT_RD | SGIMC_CSTAT_PAR)
 	u32 _unused23;
 	volatile u32 gerr;         /* Error address reg for GIO */
 	u32 _unused24;
 	volatile u32 gstat;        /* Status reg for GIO */
-
+#define	SGIMC_GSTAT_RD		0x00000100	/* read parity error */
+#define	SGIMC_GSTAT_WR		0x00000200	/* write parity error */
+#define	SGIMC_GSTAT_TIME	0x00000400	/* GIO bus timed out */
+#define	SGIMC_GSTAT_PROM	0x00000800	/* write to PROM when PROM_EN
+						   not set */
+#define	SGIMC_GSTAT_ADDR	0x00001000	/* parity error on addr
+						   cycle */
+#define	SGIMC_GSTAT_BC		0x00002000	/* parity error on byte count
+						   cycle */
+#define SGIMC_GSTAT_PIO_RD	0x00004000	/* read data parity on pio */
+#define SGIMC_GSTAT_PIO_WR	0x00008000	/* write data parity on pio */
 	/* Special hard bus locking registers. */
 	u32 _unused25;
 	volatile unsigned char syssembit;    /* Uni-bit system semaphore */
@@ -146,13 +164,13 @@
 	/* GIO dma control registers. */
 	unsigned char _unused30[3];
 	u32 _unused31[14];
-	volatile u32 gio_dma_trans;/* DMA mask to translation GIO addrs */
+	volatile u32 gio_dma_trans;  /* DMA mask to translation GIO addrs */
 	u32 _unused32;
-	volatile u32 gio_dma_sbits;/* DMA GIO addr substitution bits */
+	volatile u32 gio_dma_sbits;  /* DMA GIO addr substitution bits */
 	u32 _unused33;
 	volatile u32 dma_intr_cause; /* DMA IRQ cause indicator bits */
 	u32 _unused34;
-	volatile u32 dma_ctrl;     /* Main DMA control reg */
+	volatile u32 dma_ctrl;       /* Main DMA control reg */
 
 	/* DMA TLB entry 0 */
 	u32 _unused35;
@@ -181,29 +199,29 @@
 
 /* MC misc control registers live at physical 0x1fa00000. */
 extern struct sgimc_misc_ctrl *mcmisc_regs;
-extern u32 *rpsscounter;          /* Chirps at 100ns */
+extern u32 *rpsscounter;           /* Chirps at 100ns */
 
 struct sgimc_dma_ctrl {
 	u32 _unused1;
-	volatile u32 maddronly;   /* Address DMA goes at */
+	volatile u32 maddronly;    /* Address DMA goes at */
 	u32 _unused2;
 	volatile u32 maddrpdeflts; /* Same as above, plus set defaults */
 	u32 _unused3;
-	volatile u32 dmasz;       /* DMA count */
+	volatile u32 dmasz;        /* DMA count */
 	u32 _unused4;
-	volatile u32 ssize;       /* DMA stride size */
+	volatile u32 ssize;        /* DMA stride size */
 	u32 _unused5;
-	volatile u32 gmaddronly;  /* Set GIO DMA but do not start trans */
+	volatile u32 gmaddronly;   /* Set GIO DMA but do not start trans */
 	u32 _unused6;
-	volatile u32 dmaddnpgo;   /* Set GIO DMA addr + start transfer */
+	volatile u32 dmaddnpgo;    /* Set GIO DMA addr + start transfer */
 	u32 _unused7;
-	volatile u32 dmamode;     /* DMA mode config bit settings */
+	volatile u32 dmamode;      /* DMA mode config bit settings */
 	u32 _unused8;
 	volatile u32 dmaccount;    /* Zoom and byte count for DMA */
 	u32 _unused9;
-	volatile u32 dmastart;    /* Pedal to the metal. */
+	volatile u32 dmastart;     /* Pedal to the metal. */
 	u32 _unused10;
-	volatile u32 dmarunning;  /* DMA op is in progress */
+	volatile u32 dmarunning;   /* DMA op is in progress */
 	u32 _unused11;
 
 	/* Set dma addr, defaults, and kick it */
--- linux/include/asm-mips64/sgi/sgimc.h.orig	Sun Aug  4 22:40:27 2002
+++ linux/include/asm-mips64/sgi/sgimc.h	Sun Aug  4 22:40:40 2002
@@ -128,11 +128,29 @@
 	volatile u32 cerr;         /* Error address reg for CPU */
 	u32 _unused22;
 	volatile u32 cstat;        /* Status reg for CPU */
+#define	SGIMC_CSTAT_RD		0x00000100	/* read parity error */
+#define	SGIMC_CSTAT_PAR		0x00000200	/* CPU parity error */
+#define	SGIMC_CSTAT_ADDR	0x00000400	/* memory bus error bad addr */
+#define	SGIMC_CSTAT_SYSAD_PAR	0x00000800	/* sysad parity error */
+#define	SGIMC_CSTAT_SYSCMD_PAR	0x00001000	/* syscmd parity error */
+#define	SGIMC_CSTAT_BAD_DATA	0x00002000	/* bad data identifier */
+#define	SGIMC_CSTAT_PAR_MASK	0x00001f00	/* parity error mask */
+#define	SGIMC_CSTAT_RD_PAR	(SGIMC_CSTAT_RD | SGIMC_CSTAT_PAR)
 	u32 _unused23;
 	volatile u32 gerr;         /* Error address reg for GIO */
 	u32 _unused24;
 	volatile u32 gstat;        /* Status reg for GIO */
-
+#define	SGIMC_GSTAT_RD		0x00000100	/* read parity error */
+#define	SGIMC_GSTAT_WR		0x00000200	/* write parity error */
+#define	SGIMC_GSTAT_TIME	0x00000400	/* GIO bus timed out */
+#define	SGIMC_GSTAT_PROM	0x00000800	/* write to PROM when PROM_EN
+						   not set */
+#define	SGIMC_GSTAT_ADDR	0x00001000	/* parity error on addr
+						   cycle */
+#define	SGIMC_GSTAT_BC		0x00002000	/* parity error on byte count
+						   cycle */
+#define SGIMC_GSTAT_PIO_RD	0x00004000	/* read data parity on pio */
+#define SGIMC_GSTAT_PIO_WR	0x00008000	/* write data parity on pio */
 	/* Special hard bus locking registers. */
 	u32 _unused25;
 	volatile unsigned char syssembit;    /* Uni-bit system semaphore */
@@ -146,13 +164,13 @@
 	/* GIO dma control registers. */
 	unsigned char _unused30[3];
 	u32 _unused31[14];
-	volatile u32 gio_dma_trans;/* DMA mask to translation GIO addrs */
+	volatile u32 gio_dma_trans;  /* DMA mask to translation GIO addrs */
 	u32 _unused32;
-	volatile u32 gio_dma_sbits;/* DMA GIO addr substitution bits */
+	volatile u32 gio_dma_sbits;  /* DMA GIO addr substitution bits */
 	u32 _unused33;
 	volatile u32 dma_intr_cause; /* DMA IRQ cause indicator bits */
 	u32 _unused34;
-	volatile u32 dma_ctrl;     /* Main DMA control reg */
+	volatile u32 dma_ctrl;       /* Main DMA control reg */
 
 	/* DMA TLB entry 0 */
 	u32 _unused35;
@@ -181,29 +199,29 @@
 
 /* MC misc control registers live at physical 0x1fa00000. */
 extern struct sgimc_misc_ctrl *mcmisc_regs;
-extern u32 *rpsscounter;          /* Chirps at 100ns */
+extern u32 *rpsscounter;           /* Chirps at 100ns */
 
 struct sgimc_dma_ctrl {
 	u32 _unused1;
-	volatile u32 maddronly;   /* Address DMA goes at */
+	volatile u32 maddronly;    /* Address DMA goes at */
 	u32 _unused2;
 	volatile u32 maddrpdeflts; /* Same as above, plus set defaults */
 	u32 _unused3;
-	volatile u32 dmasz;       /* DMA count */
+	volatile u32 dmasz;        /* DMA count */
 	u32 _unused4;
-	volatile u32 ssize;       /* DMA stride size */
+	volatile u32 ssize;        /* DMA stride size */
 	u32 _unused5;
-	volatile u32 gmaddronly;  /* Set GIO DMA but do not start trans */
+	volatile u32 gmaddronly;   /* Set GIO DMA but do not start trans */
 	u32 _unused6;
-	volatile u32 dmaddnpgo;   /* Set GIO DMA addr + start transfer */
+	volatile u32 dmaddnpgo;    /* Set GIO DMA addr + start transfer */
 	u32 _unused7;
-	volatile u32 dmamode;     /* DMA mode config bit settings */
+	volatile u32 dmamode;      /* DMA mode config bit settings */
 	u32 _unused8;
-	volatile u32 dmacount;    /* Zoom and byte count for DMA */
+	volatile u32 dmaccount;    /* Zoom and byte count for DMA */
 	u32 _unused9;
-	volatile u32 dmastart;    /* Pedal to the metal. */
+	volatile u32 dmastart;     /* Pedal to the metal. */
 	u32 _unused10;
-	volatile u32 dmarunning;  /* DMA op is in progress */
+	volatile u32 dmarunning;   /* DMA op is in progress */
 	u32 _unused11;
 
 	/* Set dma addr, defaults, and kick it */

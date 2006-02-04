Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Feb 2006 12:02:50 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:64470 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133511AbWBDMCj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 4 Feb 2006 12:02:39 +0000
Received: (qmail 14834 invoked from network); 4 Feb 2006 12:08:00 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 4 Feb 2006 12:08:00 -0000
Message-ID: <43E499E2.6070805@ru.mvista.com>
Date:	Sat, 04 Feb 2006 15:11:14 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	ralf@linux-mips.org, Manish Lachwani <mlachwani@mvista.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>
Subject: [PATCH] TX49x7: fix reporting of the CPU name and PCI clock
Content-Type: multipart/mixed;
 boundary="------------090708020002000202010300"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090708020002000202010300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     I've noticed that PCI clock was incorrectly reported as 66 MHz while being
mere 33 MHz on RBTX4937 board -- this was due to the different encoding of the
PCI divisor field in CCFG register between TX4927 and TX4937 chips...
     Also, RBTX49x7 was printed out as a CPU name (e.g., "CPU is RBTX4937");
and some debug printk() were duplicating each other...

WBR, Sergei

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------090708020002000202010300
Content-Type: text/plain;
 name="TX49x7-CPU-name-PCI-clock-report-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TX49x7-CPU-name-PCI-clock-report-fix.patch"

diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
index e4d095d..e19e2be 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
@@ -60,7 +60,6 @@ void __init prom_init_cmdline(void)
 
 void __init prom_init(void)
 {
-	const char* toshiba_name_list[] = GROUP_TOSHIBA_NAMES;
 	extern int tx4927_get_mem_size(void);
 	extern char* toshiba_name;
 	int msize;
@@ -69,12 +68,13 @@ void __init prom_init(void)
 
 	mips_machgroup = MACH_GROUP_TOSHIBA;
 
-	if ((read_c0_prid() & 0xff) == PRID_REV_TX4927)
+	if ((read_c0_prid() & 0xff) == PRID_REV_TX4927) {
 		mips_machtype = MACH_TOSHIBA_RBTX4927;
-	else
+ 		toshiba_name  = "TX4927";
+	} else {
 		mips_machtype = MACH_TOSHIBA_RBTX4937;
-
-        toshiba_name = toshiba_name_list[mips_machtype];
+ 		toshiba_name  = "TX4937";
+	}
 
 	msize = tx4927_get_mem_size();
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
diff --git a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
index 0981329..bf9eecd 100644
--- a/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ b/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -539,19 +539,10 @@ void tx4927_pci_setup(void)
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
 				       "0x%08lx=mips_io_port_base",
 				       mips_io_port_base);
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "setup pci_io_resource  to 0x%08lx 0x%08lx\n",
-				       pci_io_resource.start,
-				       pci_io_resource.end);
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
-				       "setup pci_mem_resource to 0x%08lx 0x%08lx\n",
-				       pci_mem_resource.start,
-				       pci_mem_resource.end);
-
 	if (!called) {
 		printk
-		    ("TX4927 PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
+		    ("%s PCIC -- DID:%04x VID:%04x RID:%02x Arbiter:%s\n",
+		     toshiba_name,
 		     (unsigned short) (tx4927_pcicptr->pciid >> 16),
 		     (unsigned short) (tx4927_pcicptr->pciid & 0xffff),
 		     (unsigned short) (tx4927_pcicptr->pciccrev & 0xff),
@@ -564,21 +555,52 @@ void tx4927_pci_setup(void)
 	       (tx4927_ccfgptr->ccfg & TX4927_CCFG_PCI66) ? " PCI66" : "");
 	if (tx4927_ccfgptr->pcfg & TX4927_PCFG_PCICLKEN_ALL) {
 		int pciclk = 0;
-		switch ((unsigned long) tx4927_ccfgptr->
-			ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
-		case TX4927_CCFG_PCIDIVMODE_2_5:
-			pciclk = tx4927_cpu_clock * 2 / 5;
-			break;
-		case TX4927_CCFG_PCIDIVMODE_3:
-			pciclk = tx4927_cpu_clock / 3;
-			break;
-		case TX4927_CCFG_PCIDIVMODE_5:
-			pciclk = tx4927_cpu_clock / 5;
-			break;
-		case TX4927_CCFG_PCIDIVMODE_6:
-			pciclk = tx4927_cpu_clock / 6;
-			break;
-		}
+		if (mips_machtype == MACH_TOSHIBA_RBTX4937)
+			switch ((unsigned long) tx4927_ccfgptr->
+				ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
+			case TX4937_CCFG_PCIDIVMODE_4:
+				pciclk = tx4927_cpu_clock / 4;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_4_5:
+				pciclk = tx4927_cpu_clock * 2 / 9;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_5:
+				pciclk = tx4927_cpu_clock / 5;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_5_5:
+				pciclk = tx4927_cpu_clock * 2 / 11;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_8:
+				pciclk = tx4927_cpu_clock / 8;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_9:
+				pciclk = tx4927_cpu_clock / 9;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_10:
+				pciclk = tx4927_cpu_clock / 10;
+				break;
+			case TX4937_CCFG_PCIDIVMODE_11:
+				pciclk = tx4927_cpu_clock / 11;
+				break;
+			}
+
+		else
+			switch ((unsigned long) tx4927_ccfgptr->
+				ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
+			case TX4927_CCFG_PCIDIVMODE_2_5:
+				pciclk = tx4927_cpu_clock * 2 / 5;
+				break;
+			case TX4927_CCFG_PCIDIVMODE_3:
+				pciclk = tx4927_cpu_clock / 3;
+				break;
+			case TX4927_CCFG_PCIDIVMODE_5:
+				pciclk = tx4927_cpu_clock / 5;
+				break;
+			case TX4927_CCFG_PCIDIVMODE_6:
+				pciclk = tx4927_cpu_clock / 6;
+				break;
+			}
+
 		printk("Internal(%dMHz)", pciclk / 1000000);
 	} else {
 		int pciclk = 0;
@@ -823,17 +845,33 @@ void __init toshiba_rbtx4927_setup(void)
 	/* PCIC */
 	/*
 	   * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
-	   * PCIDIVMODE[12:11]'s initial value are given by S9[4:3] (ON:0, OFF:1).
+	   *
+	   * For TX4927:
+	   * PCIDIVMODE[12:11]'s initial value is given by S9[4:3] (ON:0, OFF:1).
 	   * CPU 166MHz: PCI 66MHz : PCIDIVMODE: 00 (1/2.5)
 	   * CPU 200MHz: PCI 66MHz : PCIDIVMODE: 01 (1/3)
 	   * CPU 166MHz: PCI 33MHz : PCIDIVMODE: 10 (1/5)
 	   * CPU 200MHz: PCI 33MHz : PCIDIVMODE: 11 (1/6)
 	   * i.e. S9[3]: ON (83MHz), OFF (100MHz)
+	   *
+	   * For TX4937:
+	   * PCIDIVMODE[12:11]'s initial value is given by S1[5:4] (ON:0, OFF:1)
+	   * PCIDIVMODE[10] is 0.
+	   * CPU 266MHz: PCI 33MHz : PCIDIVMODE: 000 (1/8)
+	   * CPU 266MHz: PCI 66MHz : PCIDIVMODE: 001 (1/4)
+	   * CPU 300MHz: PCI 33MHz : PCIDIVMODE: 010 (1/9)
+	   * CPU 300MHz: PCI 66MHz : PCIDIVMODE: 011 (1/4.5)
+	   * CPU 333MHz: PCI 33MHz : PCIDIVMODE: 100 (1/10)
+	   * CPU 333MHz: PCI 66MHz : PCIDIVMODE: 101 (1/5)
+	   *
 	 */
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI1,
-				       "ccfg is %lx, DIV is %x\n",
-				       (unsigned long) tx4927_ccfgptr->
-				       ccfg, TX4927_CCFG_PCIDIVMODE_MASK);
+				       "ccfg is %lx, PCIDIVMODE is %x\n",
+				       (unsigned long) tx4927_ccfgptr->ccfg,
+				       (unsigned long) tx4927_ccfgptr->ccfg &
+				       (mips_machtype == MACH_TOSHIBA_RBTX4937 ?
+					TX4937_CCFG_PCIDIVMODE_MASK :
+					TX4927_CCFG_PCIDIVMODE_MASK));
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI1,
 				       "PCI66 mode is %lx, PCI mode is %lx, pci arb is %lx\n",
@@ -844,20 +882,30 @@ void __init toshiba_rbtx4927_setup(void)
 				       (unsigned long) tx4927_ccfgptr->
 				       ccfg & TX4927_CCFG_PCIXARB);
 
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI1,
-				       "PCIDIVMODE is %lx\n",
-				       (unsigned long) tx4927_ccfgptr->
-				       ccfg & TX4927_CCFG_PCIDIVMODE_MASK);
-
-	switch ((unsigned long) tx4927_ccfgptr->
-		ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
-	case TX4927_CCFG_PCIDIVMODE_2_5:
-	case TX4927_CCFG_PCIDIVMODE_5:
-		tx4927_cpu_clock = 166000000;	/* 166MHz */
-		break;
-	default:
-		tx4927_cpu_clock = 200000000;	/* 200MHz */
-	}
+	if (mips_machtype == MACH_TOSHIBA_RBTX4937)
+		switch ((unsigned long)tx4927_ccfgptr->
+			ccfg & TX4937_CCFG_PCIDIVMODE_MASK) {
+		case TX4937_CCFG_PCIDIVMODE_8:
+		case TX4937_CCFG_PCIDIVMODE_4:
+			tx4927_cpu_clock = 266666666;	/* 266MHz */
+			break;
+		case TX4937_CCFG_PCIDIVMODE_9:
+		case TX4937_CCFG_PCIDIVMODE_4_5:
+			tx4927_cpu_clock = 300000000;	/* 300MHz */
+			break;
+		default:
+			tx4927_cpu_clock = 333333333;	/* 333MHz */
+		}
+	else
+		switch ((unsigned long)tx4927_ccfgptr->
+			ccfg & TX4927_CCFG_PCIDIVMODE_MASK) {
+		case TX4927_CCFG_PCIDIVMODE_2_5:
+		case TX4927_CCFG_PCIDIVMODE_5:
+			tx4927_cpu_clock = 166666666;	/* 166MHz */
+			break;
+		default:
+			tx4927_cpu_clock = 200000000;	/* 200MHz */
+		}
 
 	/* CCFG */
 	/* enable Timeout BusError */
diff --git a/include/asm-mips/tx4927/tx4927_pci.h b/include/asm-mips/tx4927/tx4927_pci.h
index 165f6b8..66c0646 100644
--- a/include/asm-mips/tx4927/tx4927_pci.h
+++ b/include/asm-mips/tx4927/tx4927_pci.h
@@ -253,6 +253,16 @@ struct tx4927_pcic_reg {
 #define TX4927_CCFG_PCIDIVMODE_5        0x00001000
 #define TX4927_CCFG_PCIDIVMODE_6        0x00001800
 
+#define TX4937_CCFG_PCIDIVMODE_MASK	0x00001c00
+#define TX4937_CCFG_PCIDIVMODE_8	0x00000000
+#define TX4937_CCFG_PCIDIVMODE_4	0x00000400
+#define TX4937_CCFG_PCIDIVMODE_9 	0x00000800
+#define TX4937_CCFG_PCIDIVMODE_4_5	0x00000c00
+#define TX4937_CCFG_PCIDIVMODE_10	0x00001000
+#define TX4937_CCFG_PCIDIVMODE_5	0x00001400
+#define TX4937_CCFG_PCIDIVMODE_11	0x00001800
+#define TX4937_CCFG_PCIDIVMODE_5_5	0x00001c00
+
 /* PCFG : Pin Configuration */
 #define TX4927_PCFG_PCICLKEN_ALL        0x003f0000
 #define TX4927_PCFG_PCICLKEN(ch)        (0x00010000<<(ch))


--------------090708020002000202010300--

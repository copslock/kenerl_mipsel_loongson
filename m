Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75C31Rw005901
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 05:03:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75C30X6005900
	for linux-mips-outgoing; Mon, 5 Aug 2002 05:03:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75C2GRw005881;
	Mon, 5 Aug 2002 05:02:17 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22083;
	Mon, 5 Aug 2002 14:04:40 +0200 (MET DST)
Date: Mon, 5 Aug 2002 14:04:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>, Carsten Langgaard <carstenl@mips.com>
cc: linux-mips@oss.sgi.com
Subject: Re: [update] [patch] linux: Cache coherency fixes
In-Reply-To: <Pine.GSO.3.96.1020801173504.8256H-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1020805132307.18894M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 1 Aug 2002, Maciej W. Rozycki wrote:

>  I'll cook another patch to fix what got broken.

 OK, here is my proposal, based on my assumptions and the feedback I
received.

 The intent is as follows: systems that want coherent I/O mark it by
setting CONFIG_COHERENT_SYSTEM to "y" and CONFIG_NONCOHERENT_IO is then
set to "n" if both CONFIG_COHERENT_SYSTEM is "y" and the selected CPU
supports it; otherwise it's set to "y".  This implementation retains the
current semantics, (hopefully) provides the least confusion and should be
a reasonable temporary solution until we have a run-time selection. 

 Any comments?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020802-cache-coherency-7
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020802.macro/arch/mips/config-shared.in linux-mips-2.4.19-rc1-20020802/arch/mips/config-shared.in
--- linux-mips-2.4.19-rc1-20020802.macro/arch/mips/config-shared.in	2002-08-03 14:03:11.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020802/arch/mips/config-shared.in	2002-08-03 14:23:38.000000000 +0000
@@ -108,7 +108,6 @@ if [ "$CONFIG_ACER_PICA_61" = "y" ]; the
    define_bool CONFIG_I8259 y
    define_bool CONFIG_ISA y
    define_bool CONFIG_MIPS_JAZZ y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_ROTTEN_IRQ y
    define_bool CONFIG_OLD_TIME_C y
@@ -118,7 +117,6 @@ if [ "$CONFIG_MIPS_PB1000" = "y" ]; then
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
    define_int  MAX_HWIFS 1
 fi
@@ -128,7 +126,6 @@ if [ "$CONFIG_MIPS_PB1100" = "y" ]; then
    define_bool CONFIG_PCI y
    define_bool CONFIG_PCI_AUTO n
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_SWAP_IO_SPACE y
    define_bool CONFIG_AU1000_USB_DEVICE y
@@ -139,12 +136,10 @@ if [ "$CONFIG_MIPS_PB1500" = "y" ]; then
    define_bool CONFIG_PCI y
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
 fi
 if [ "$CONFIG_ALGOR_P4032" = "y" ]; then
    define_bool CONFIG_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_OLD_TIME_C y
 fi
 if [ "$CONFIG_MIPS_COBALT" = "y" ]; then
@@ -152,18 +147,15 @@ if [ "$CONFIG_MIPS_COBALT" = "y" ]; then
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
 fi
 if [ "$CONFIG_DECSTATION" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_IRQ y
-   define_bool CONFIG_NONCOHERENT_IO y
 fi
 if [ "$CONFIG_MIPS_EV64120" = "y" ]; then
    define_bool CONFIG_PCI y
    define_bool CONFIG_ISA n
    define_bool CONFIG_MIPS_GT64120 y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_OLD_TIME_C y
 fi
 if [ "$CONFIG_MIPS_EV96100" = "y" ]; then
@@ -171,7 +163,6 @@ if [ "$CONFIG_MIPS_EV96100" = "y" ]; the
    define_bool CONFIG_MIPS_GT96100 y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_SWAP_IO_SPACE y
 fi
@@ -179,7 +170,6 @@ if [ "$CONFIG_MIPS_IVR" = "y" ]; then
    define_bool CONFIG_PCI y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_IT8172_CIR y
    define_bool CONFIG_NEW_IRQ y
@@ -190,7 +180,6 @@ if [ "$CONFIG_HP_LASERJET" = "y" ]; then
    define_bool CONFIG_NEW_TIME_C y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    #not yet define_bool CONFIG_PCI_AUTO y
 fi
@@ -199,7 +188,6 @@ if [ "$CONFIG_MIPS_ITE8172" = "y" ]; the
    define_bool CONFIG_IT8712 y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_IT8172_CIR y
    define_bool CONFIG_NEW_IRQ y
@@ -210,7 +198,6 @@ if [ "$CONFIG_MIPS_ATLAS" = "y" ]; then
    define_int CONFIG_L1_CACHE_SHIFT 5
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_SWAP_IO_SPACE y
 fi
@@ -222,7 +209,6 @@ if [ "$CONFIG_MIPS_MAGNUM_4000" = "y" -o
    define_bool CONFIG_FB y
    define_bool CONFIG_FB_G364 y
    define_bool CONFIG_MIPS_JAZZ y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_OLD_TIME_C y
 fi
@@ -233,7 +219,6 @@ if [ "$CONFIG_MIPS_MALTA" = "y" ]; then
    define_int CONFIG_L1_CACHE_SHIFT 5
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_SWAP_IO_SPACE y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_PCI y
@@ -242,7 +227,6 @@ if [ "$CONFIG_MIPS_SEAD" = "y" ]; then
    define_int CONFIG_L1_CACHE_SHIFT 5
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI n
 fi
 if [ "$CONFIG_MOMENCO_OCELOT" = "y" ]; then
@@ -250,14 +234,12 @@ if [ "$CONFIG_MOMENCO_OCELOT" = "y" ]; t
    define_bool CONFIG_SYSCLK_100 y
    define_bool CONFIG_SWAP_IO_SPACE y
    define_bool CONFIG_NEW_IRQ y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_OLD_TIME_C y
 fi
 if [ "$CONFIG_DDB5074" = "y" ]; then
    define_bool CONFIG_HAVE_STD_PC_SERIAL_PORT y
    define_bool CONFIG_I8259 y
    define_bool CONFIG_ISA y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_NEW_TIME_C y
@@ -277,7 +259,6 @@ if [ "$CONFIG_DDB5476"  = "y" ]; then
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
 fi
 if [ "$CONFIG_DDB5477" = "y" ]; then
    define_bool CONFIG_PCI y
@@ -285,7 +266,6 @@ if [ "$CONFIG_DDB5477" = "y" ]; then
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_PCI y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_I8259 y
@@ -297,7 +277,6 @@ if [ "$CONFIG_NEC_OSPREY" = "y" ]; then
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_SCSI n
 fi
@@ -307,7 +286,6 @@ if [ "$CONFIG_NEC_EAGLE" = "y" ]; then
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
    define_bool CONFIG_VR41XX_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_ISA n
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
@@ -318,7 +296,6 @@ fi
 if [ "$CONFIG_NINO" = "y" ]; then
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
 fi
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
@@ -330,10 +307,8 @@ if [ "$CONFIG_SGI_IP22" = "y" ]; then
    define_bool CONFIG_SWAP_IO_SPACE y
    define_bool CONFIG_IRQ_CPU y
    define_int CONFIG_L1_CACHE_SHIFT 5
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_SGI y
    define_bool CONFIG_SWAP_IO_SPACE y
@@ -345,6 +320,7 @@ if [ "$CONFIG_SGI_IP27" = "y" ]; then
    define_bool CONFIG_PCI y
    define_bool CONFIG_QL_ISP_A64 y
    define_int CONFIG_L1_CACHE_SHIFT 7
+   define_bool CONFIG_COHERENT_SYSTEM y
 fi
 if [ "$CONFIG_SGI_IP32" = "y" ]; then
    define_bool CONFIG_ARC_MEMORY y
@@ -353,7 +329,6 @@ if [ "$CONFIG_SGI_IP32" = "y" ]; then
    define_bool CONFIG_BOOT_ELF32 y
    define_int CONFIG_L1_CACHE_SHIFT 5
    define_bool CONFIG_MAPPED_PCI_IO n
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_PCI y
 fi
@@ -362,13 +337,13 @@ if [ "$CONFIG_SIBYTE_SB1250" = "y" ]; th
    define_bool CONFIG_NEW_TIME_C y
    define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_SWAP_IO_SPACE y
+   define_bool CONFIG_COHERENT_SYSTEM y
 fi
 if [ "$CONFIG_SNI_RM200_PCI" = "y" ]; then
    define_bool CONFIG_ARC32 y
    define_bool CONFIG_I8259 y
    define_bool CONFIG_ISA y
    define_bool CONFIG_NEW_IRQ y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_OLD_TIME_C y
    define_bool CONFIG_PC_KEYB y
    define_bool CONFIG_PCI y
@@ -380,7 +355,6 @@ if [ "$CONFIG_TOSHIBA_JMR3927" = "y" ]; 
    define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_SWAP_IO_SPACE y
    define_bool CONFIG_PC_KEYB y
 fi
@@ -391,7 +365,6 @@ if [ "$CONFIG_ZAO_CAPCELLA" = "y" ]; the
    define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_NEW_TIME_C y
    define_bool CONFIG_VR41XX_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_ISA n
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
@@ -415,7 +388,8 @@ choice 'CPU type' \
 	 R39XX	CONFIG_CPU_TX39XX \
 	 R41xx	CONFIG_CPU_VR41XX \
 	 R4300	CONFIG_CPU_R4300 \
-	 R4x00	CONFIG_CPU_R4X00 \
+	 R4x00	CONFIG_CPU_R4X00XX \
+	 R4x00MC CONFIG_CPU_R4X00MC \
 	 R49XX	CONFIG_CPU_TX49XX \
 	 R5000	CONFIG_CPU_R5000 \
 	 R5432	CONFIG_CPU_R5432 \
@@ -426,6 +400,10 @@ choice 'CPU type' \
 	 RM7000	CONFIG_CPU_RM7000 \
 	 SB1	CONFIG_CPU_SB1" R4x00
 
+if [ "$CONFIG_CPU_R4X00XX"  = "y" -o "$CONFIG_CPU_R4X00MC" = "y" ]; then
+   define_bool CONFIG_CPU_R4X00 y
+fi
+
 if [ "$CONFIG_CPU_MIPS32" = "y" ]; then
    define_bool CONFIG_CPU_HAS_PREFETCH y
    bool '  Support for Virtual Tagged I-cache' CONFIG_VTAG_ICACHE
@@ -492,6 +470,19 @@ if [ "$CONFIG_CPU_R3000" = "y" ]; then
 else
    define_bool CONFIG_CPU_HAS_SYNC y
 fi
+if [ "$CONFIG_CPU_MIPS32"  = "y" -o \
+     "$CONFIG_CPU_MIPS64"  = "y" -o \
+     "$CONFIG_CPU_R4X00MC" = "y" -o \
+     "$CONFIG_CPU_R10000"  = "y" -o \
+     "$CONFIG_CPU_SB1"     = "y" ]; then
+   if [ "$CONFIG_COHERENT_SYSTEM" = "y" ]; then
+      define_bool CONFIG_NONCOHERENT_IO n
+   else
+      define_bool CONFIG_NONCOHERENT_IO y
+   fi
+else
+   define_bool CONFIG_NONCOHERENT_IO y
+fi
 endmenu
 
 mainmenu_option next_comment

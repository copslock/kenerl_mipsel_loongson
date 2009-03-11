Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2009 11:28:13 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5576 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808998AbZCKL2K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2009 11:28:10 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2BBS7wQ025227;
	Wed, 11 Mar 2009 12:28:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2BBS6oi025225;
	Wed, 11 Mar 2009 12:28:06 +0100
Date:	Wed, 11 Mar 2009 12:28:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Cc:	Thomas Gleixner <tglx@linutronix.de>
Subject: __do_IRQ() going away
Message-ID: <20090311112806.GA24541@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

__do_IRQ() is deprecated since a long time and there are plans to remove
it for 2.6.30.  The MIPS platforms seem to fall into three classes:

 o Platforms setting CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ to explicitly disable
   __do_IRQ():
	capcella_defconfig, cobalt_defconfig, e55_defconfig,
	fulong_defconfig, ip27_defconfig, jazz_defconfig, jmr3927_defconfig,
	lasat_defconfig, mpc30x_defconfig, pnx8335-stb225_defconfig,
	pnx8550-jbs_defconfig, pnx8550-stb810_defconfig, rb532_defconfig,
	rbtx49xx_defconfig, tb0219_defconfig, tb0226_defconfig,
	tb0287_defconfig and workpad_defconfig.

 o Platforms that don't set CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ but don't
   seem to use __do_IRQ():

	bcm47xx_defconfig, cavium-octeon_defconfig, excite_defconfig,
	ip22_defconfig, ip28_defconfig, msp71xx_defconfig, wrppmc_defconfig,

 o Platforms that still seem to rely on __do_IRQ():
     o All Sibyte platforms:
	bigsur_defconfig and sb1250-swarm_defconfig

     o All Alchemy platforms:
	db1000_defconfig, db1100_defconfig, db1200_defconfig, db1500_defconfig,
	db1550_defconfig, mtx1_defconfig, pb1100_defconfig, pb1500_defconfig
	and pb1550_defconfig

     o malta_defconfig.  The platform code itself is ok but irq-gic.c,
	irq-msc01.c, irq-msc01.c and irq_cpu.c are still using set_irq_chip
	and need fixing.

     o And the rest:
	decstation_defconfig, emma2rh_defconfig, ip32_defconfig,
	yosemite_defconfig, mipssim_defconfig and rm200_defconfig.

For now I've checked in the following patch into linux-queue.

  Ralf

MIPS: Enable GENERIC_HARDIRQS_NO__DO_IRQ for all platforms

__do_IRQ() is deprecated and will go away.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/Kconfig |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -77,7 +77,6 @@ config MIPS_COBALT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config MACH_DECSTATION
 	bool "DECstations"
@@ -132,7 +131,6 @@ config MACH_JAZZ
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select SYS_SUPPORTS_100HZ
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	 This a family of machines based on the MIPS R4030 chipset which was
 	 used by several vendors to build RISC/os and Windows NT workstations.
@@ -154,7 +152,6 @@ config LASAT
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if BROKEN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config LEMOTE_FULONG
 	bool "Lemote Fulong mini-PC"
@@ -175,7 +172,6 @@ config LEMOTE_FULONG
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_HAS_EARLY_PRINTK
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select CPU_HAS_WB
 	help
@@ -246,7 +242,6 @@ config MACH_VR41XX
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYS_HAS_CPU_VR41XX
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config NXP_STB220
 	bool "NXP STB220 board"
@@ -360,7 +355,6 @@ config SGI_IP27
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SMP
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	help
 	  This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
 	  workstations.  To compile a Linux kernel that runs on these, say Y
@@ -559,7 +553,6 @@ config MIKROTIK_RB532
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select HW_HAS_PCI
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
@@ -697,8 +690,7 @@ config SCHED_OMIT_FRAME_POINTER
 	default y
 
 config GENERIC_HARDIRQS_NO__DO_IRQ
-	bool
-	default n
+	def_bool y
 
 #
 # Select some configuration options automatically based on user selections.
@@ -905,7 +897,6 @@ config SOC_PNX833X
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GENERIC_GPIO
 	select CPU_MIPSR2_IRQ_VI
 
@@ -924,7 +915,6 @@ config SOC_PNX8550
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
-	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GENERIC_GPIO
 
 config SWAP_IO_SPACE

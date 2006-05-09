Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 23:35:33 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:8 "HELO sorrow.cyrius.com")
	by ftp.linux-mips.org with SMTP id S8133876AbWEIVfX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 23:35:23 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 2A52364D54; Tue,  9 May 2006 21:35:14 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id A43A666E84; Tue,  9 May 2006 23:34:53 +0200 (CEST)
Date:	Tue, 9 May 2006 23:34:53 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] create consistency in "system type" selection
Message-ID: <20060509213453.GA32050@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

The "system type" Kconfig options on MIPS are not consistent.  For
some platforms, only the name is listed while other entries are
prepended with "Support for".  Remove this as it doesn't make sense
when describing the "system type".  This is in line with how e.g.
ARM handles this.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -13,7 +13,7 @@ choice
 	default SGI_IP22
 
 config MIPS_MTX1
-	bool "Support for 4G Systems MTX-1 board"
+	bool "4G Systems MTX-1 board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select SOC_AU1500
@@ -120,7 +120,7 @@ config MIPS_MIRAGE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_COBALT
-	bool "Support for Cobalt Server"
+	bool "Cobalt Server"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select I8259
@@ -132,7 +132,7 @@ config MIPS_COBALT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MACH_DECSTATION
-	bool "Support for DECstations"
+	bool "DECstations"
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select EARLY_PRINTK
@@ -158,7 +158,7 @@ config MACH_DECSTATION
 	  otherwise choose R3000.
 
 config MIPS_EV64120
-	bool "Support for Galileo EV64120 Evaluation board (EXPERIMENTAL)"
+	bool "Galileo EV64120 Evaluation board (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -175,7 +175,7 @@ config MIPS_EV64120
 	  kernel for this platform.
 
 config MIPS_EV96100
-	bool "Support for Galileo EV96100 Evaluation board (EXPERIMENTAL)"
+	bool "Galileo EV96100 Evaluation board (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -195,7 +195,7 @@ config MIPS_EV96100
 	  here if you wish to build a kernel for this platform.
 
 config MIPS_IVR
-	bool "Support for Globespan IVR board"
+	bool "Globespan IVR board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select ITE_BOARD_GEN
@@ -211,7 +211,7 @@ config MIPS_IVR
 	  build a kernel for this platform.
 
 config MIPS_ITE8172
-	bool "Support for ITE 8172G board"
+	bool "ITE 8172G board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select ITE_BOARD_GEN
@@ -228,7 +228,7 @@ config MIPS_ITE8172
 	  a kernel for this platform.
 
 config MACH_JAZZ
-	bool "Support for the Jazz family of machines"
+	bool "Jazz family of machines"
 	select ARC
 	select ARC32
 	select ARCH_MAY_HAVE_PC_FDC
@@ -246,7 +246,7 @@ config MACH_JAZZ
 	 Olivetti M700-10 workstations.
 
 config LASAT
-	bool "Support for LASAT Networks platforms"
+	bool "LASAT Networks platforms"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_GT64120
@@ -258,7 +258,7 @@ config LASAT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_ATLAS
-	bool "Support for MIPS Atlas board"
+	bool "MIPS Atlas board"
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select IRQ_CPU
@@ -283,7 +283,7 @@ config MIPS_ATLAS
 	  board.
 
 config MIPS_MALTA
-	bool "Support for MIPS Malta board"
+	bool "MIPS Malta board"
 	select ARCH_MAY_HAVE_PC_FDC
 	select BOOT_ELF32
 	select HAVE_STD_PC_SERIAL_PORT
@@ -311,7 +311,7 @@ config MIPS_MALTA
 	  board.
 
 config MIPS_SEAD
-	bool "Support for MIPS SEAD board (EXPERIMENTAL)"
+	bool "MIPS SEAD board (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	select IRQ_CPU
 	select DMA_NONCOHERENT
@@ -328,7 +328,7 @@ config MIPS_SEAD
 	  board.
 
 config MIPS_SIM
-	bool 'Support for MIPS simulator (MIPSsim)'
+	bool 'MIPS simulator (MIPSsim)'
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
@@ -341,7 +341,7 @@ config MIPS_SIM
 	  emulator.
 
 config MOMENCO_JAGUAR_ATX
-	bool "Support for Momentum Jaguar board"
+	bool "Momentum Jaguar board"
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -361,7 +361,7 @@ config MOMENCO_JAGUAR_ATX
 	  Momentum Computer <http://www.momenco.com/>.
 
 config MOMENCO_OCELOT
-	bool "Support for Momentum Ocelot board"
+	bool "Momentum Ocelot board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -378,7 +378,7 @@ config MOMENCO_OCELOT
 	  Momentum Computer <http://www.momenco.com/>.
 
 config MOMENCO_OCELOT_3
-	bool "Support for Momentum Ocelot-3 board"
+	bool "Momentum Ocelot-3 board"
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -397,7 +397,7 @@ config MOMENCO_OCELOT_3
 	  PMC-Sierra Rm79000 core.
 
 config MOMENCO_OCELOT_C
-	bool "Support for Momentum Ocelot-C board"
+	bool "Momentum Ocelot-C board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -414,7 +414,7 @@ config MOMENCO_OCELOT_C
 	  Momentum Computer <http://www.momenco.com/>.
 
 config MOMENCO_OCELOT_G
-	bool "Support for Momentum Ocelot-G board"
+	bool "Momentum Ocelot-G board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -431,23 +431,23 @@ config MOMENCO_OCELOT_G
 	  Momentum Computer <http://www.momenco.com/>.
 
 config MIPS_XXS1500
-	bool "Support for MyCable XXS1500 board"
+	bool "MyCable XXS1500 board"
 	select DMA_NONCOHERENT
 	select SOC_AU1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PNX8550_V2PCI
-	bool "Support for Philips PNX8550 based Viper2-PCI board"
+	bool "Philips PNX8550 based Viper2-PCI board"
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PNX8550_JBS
-	bool "Support for Philips PNX8550 based JBS board"
+	bool "Philips PNX8550 based JBS board"
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config DDB5074
-	bool "Support for NEC DDB Vrc-5074 (EXPERIMENTAL)"
+	bool "NEC DDB Vrc-5074 (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	select DDB5XXX_COMMON
 	select DMA_NONCOHERENT
@@ -465,7 +465,7 @@ config DDB5074
 	  evaluation board.
 
 config DDB5476
-	bool "Support for NEC DDB Vrc-5476"
+	bool "NEC DDB Vrc-5476"
 	select DDB5XXX_COMMON
 	select DMA_NONCOHERENT
 	select HAVE_STD_PC_SERIAL_PORT
@@ -486,7 +486,7 @@ config DDB5476
 	  IDE controller, PS2 keyboard, PS2 mouse, etc.
 
 config DDB5477
-	bool "Support for NEC DDB Vrc-5477"
+	bool "NEC DDB Vrc-5477"
 	select DDB5XXX_COMMON
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
@@ -504,10 +504,10 @@ config DDB5477
 	  ether port USB, AC97, PCI, etc.
 
 config MACH_VR41XX
-	bool "Support for NEC VR41XX-based machines"
+	bool "NEC VR41XX-based machines"
 
 config PMC_YOSEMITE
-	bool "Support for PMC-Sierra Yosemite eval board"
+	bool "PMC-Sierra Yosemite eval board"
 	select DMA_COHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
@@ -524,7 +524,7 @@ config PMC_YOSEMITE
 	  manufactured by PMC-Sierra.
 
 config QEMU
-	bool "Support for Qemu"
+	bool "Qemu"
 	select DMA_COHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_STD_PC_SERIAL_PORT
@@ -544,7 +544,7 @@ config QEMU
 	  can be found at http://www.linux-mips.org/wiki/Qemu.
 
 config SGI_IP22
-	bool "Support for SGI IP22 (Indy/Indigo2)"
+	bool "SGI IP22 (Indy/Indigo2)"
 	select ARC
 	select ARC32
 	select BOOT_ELF32
@@ -564,7 +564,7 @@ config SGI_IP22
 	  that runs on these, say Y here.
 
 config SGI_IP27
-	bool "Support for SGI IP27 (Origin200/2000)"
+	bool "SGI IP27 (Origin200/2000)"
 	select ARC
 	select ARC64
 	select BOOT_ELF64
@@ -580,7 +580,7 @@ config SGI_IP27
 	  here.
 
 config SGI_IP32
-	bool "Support for SGI IP32 (O2) (EXPERIMENTAL)"
+	bool "SGI IP32 (O2) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	select ARC
 	select ARC32
@@ -601,7 +601,7 @@ config SGI_IP32
 	  If you want this kernel to run on SGI O2 workstation, say Y here.
 
 config SIBYTE_BIGSUR
-	bool "Support for Sibyte BCM91480B-BigSur"
+	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select PCI_DOMAINS
@@ -612,7 +612,7 @@ config SIBYTE_BIGSUR
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_SWARM
-	bool "Support for Sibyte BCM91250A-SWARM"
+	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select SIBYTE_SB1250
@@ -623,7 +623,7 @@ config SIBYTE_SWARM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_SENTOSA
-	bool "Support for Sibyte BCM91250E-Sentosa"
+	bool "Sibyte BCM91250E-Sentosa"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -634,7 +634,7 @@ config SIBYTE_SENTOSA
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_RHONE
-	bool "Support for Sibyte BCM91125E-Rhone"
+	bool "Sibyte BCM91125E-Rhone"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -645,7 +645,7 @@ config SIBYTE_RHONE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_CARMEL
-	bool "Support for Sibyte BCM91120x-Carmel"
+	bool "Sibyte BCM91120x-Carmel"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -656,7 +656,7 @@ config SIBYTE_CARMEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_PTSWARM
-	bool "Support for Sibyte BCM91250PT-PTSWARM"
+	bool "Sibyte BCM91250PT-PTSWARM"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -668,7 +668,7 @@ config SIBYTE_PTSWARM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_LITTLESUR
-	bool "Support for Sibyte BCM91250C2-LittleSur"
+	bool "Sibyte BCM91250C2-LittleSur"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -680,7 +680,7 @@ config SIBYTE_LITTLESUR
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_CRHINE
-	bool "Support for Sibyte BCM91120C-CRhine"
+	bool "Sibyte BCM91120C-CRhine"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -691,7 +691,7 @@ config SIBYTE_CRHINE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_CRHONE
-	bool "Support for Sibyte BCM91125C-CRhone"
+	bool "Sibyte BCM91125C-CRhone"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -703,7 +703,7 @@ config SIBYTE_CRHONE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SNI_RM200_PCI
-	bool "Support for SNI RM200 PCI"
+	bool "SNI RM200 PCI"
 	select ARC
 	select ARC32
 	select ARCH_MAY_HAVE_PC_FDC
@@ -729,7 +729,7 @@ config SNI_RM200_PCI
 	  support this machine type.
 
 config TOSHIBA_JMR3927
-	bool "Support for Toshiba JMR-TX3927 board"
+	bool "Toshiba JMR-TX3927 board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_TX3927
@@ -740,7 +740,7 @@ config TOSHIBA_JMR3927
 	select TOSHIBA_BOARDS
 
 config TOSHIBA_RBTX4927
-	bool "Support for Toshiba TBTX49[23]7 board"
+	bool "Toshiba TBTX49[23]7 board"
 	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
@@ -757,7 +757,7 @@ config TOSHIBA_RBTX4927
 	  support this machine type
 
 config TOSHIBA_RBTX4938
-	bool "Support for Toshiba RBTX4938 board"
+	bool "Toshiba RBTX4938 board"
 	select HAVE_STD_PC_SERIAL_PORT
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA

-- 
Martin Michlmayr
http://www.cyrius.com/

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2007 09:27:20 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:57667 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022282AbXG0I0x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2007 09:26:53 +0100
Received: by mo.po.2iij.net (mo31) id l6R8PYRu094796; Fri, 27 Jul 2007 17:25:34 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l6R8PVoL027449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Jul 2007 17:25:32 +0900
Message-Id: <200707270825.l6R8PVoL027449@po-mbox301.hop.2iij.net>
Date:	Fri, 27 Jul 2007 15:25:43 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][2/2][MIPS] sort system types by alphabetical order
In-Reply-To: <20070727152024.0758f2f7.yoichi_yuasa@tripeaks.co.jp>
References: <20070727152024.0758f2f7.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


This patch has sorted system types by alphabetical order.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-07-27 14:08:16.682243750 +0900
+++ mips/arch/mips/Kconfig	2007-07-27 14:16:05.303530750 +0900
@@ -15,29 +15,6 @@ choice
 	prompt "System type"
 	default SGI_IP22
 
-config LEMOTE_FULONG
-	bool "Lemote Fulong mini-PC"
-	select ARCH_SPARSEMEM_ENABLE
-	select SYS_HAS_CPU_LOONGSON2
-	select DMA_NONCOHERENT
-	select BOOT_ELF32
-	select BOARD_SCACHE
-	select HAVE_STD_PC_SERIAL_PORT
-	select HW_HAS_PCI
-	select I8259
-	select ISA
-	select IRQ_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_HAS_EARLY_PRINTK
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select CPU_HAS_WB
-	help
-	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
-	  an FPGA northbridge
-
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
 
@@ -131,6 +108,29 @@ config MACH_JAZZ
 	 Members include the Acer PICA, MIPS Magnum 4000, MIPS Millenium and
 	 Olivetti M700-10 workstations.
 
+config LEMOTE_FULONG
+	bool "Lemote Fulong mini-PC"
+	select ARCH_SPARSEMEM_ENABLE
+	select SYS_HAS_CPU_LOONGSON2
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select HAVE_STD_PC_SERIAL_PORT
+	select HW_HAS_PCI
+	select I8259
+	select ISA
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_EARLY_PRINTK
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select CPU_HAS_WB
+	help
+	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
+	  an FPGA northbridge
+
 config MIPS_ATLAS
 	bool "MIPS Atlas board"
 	select BOOT_ELF32
@@ -210,27 +210,6 @@ config MIPS_SEAD
 	  This enables support for the MIPS Technologies SEAD evaluation
 	  board.
 
-config WR_PPMC
-	bool "Wind River PPMC board"
-	select IRQ_CPU
-	select BOOT_ELF32
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select PCI_GT64XXX_PCI0
-	select SWAP_IO_SPACE
-	select SYS_HAS_CPU_MIPS32_R1
-	select SYS_HAS_CPU_MIPS32_R2
-	select SYS_HAS_CPU_MIPS64_R1
-	select SYS_HAS_CPU_NEVADA
-	select SYS_HAS_CPU_RM7000
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	help
-	  This enables support for the Wind River MIPS32 4KC PPMC evaluation
-	  board, which is based on GT64120 bridge chip.
-
 config MIPS_SIM
 	bool 'MIPS simulator (MIPSsim)'
 	select DMA_NONCOHERENT
@@ -266,16 +245,6 @@ config MOMENCO_OCELOT
 	  The Ocelot is a MIPS-based Single Board Computer (SBC) made by
 	  Momentum Computer <http://www.momenco.com/>.
 
-config PNX8550_JBS
-	bool "Philips PNX8550 based JBS board"
-	select PNX8550
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
-config PNX8550_STB810
-	bool "Philips PNX8550 based STB810 board"
-	select PNX8550
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-
 config DDB5477
 	bool "NEC DDB Vrc-5477"
 	select DDB5XXX_COMMON
@@ -296,11 +265,35 @@ config DDB5477
 	  Features : kernel debugging, serial terminal, NFS root fs, on-board
 	  ether port USB, AC97, PCI, etc.
 
+config MARKEINS
+	bool "NEC EMMA2RH Mark-eins"
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_CPU_R5000
+	help
+	  This enables support for the R5432-based NEC Mark-eins
+	  boards with R5500 CPU.
+
 config MACH_VR41XX
 	bool "NEC VR4100 series based machines"
 	select SYS_HAS_CPU_VR41XX
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
+config PNX8550_JBS
+	bool "Philips PNX8550 based JBS board"
+	select PNX8550
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
+config PNX8550_STB810
+	bool "Philips PNX8550 based STB810 board"
+	select PNX8550
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+
 config PMC_MSP
 	bool "PMC-Sierra MSP chipsets"
 	depends on EXPERIMENTAL
@@ -367,20 +360,6 @@ config QEMU
 	  simulate actual MIPS hardware platforms.  More information on Qemu
 	  can be found at http://www.linux-mips.org/wiki/Qemu.
 
-config MARKEINS
-	bool "NEC EMMA2RH Mark-eins"
-	select DMA_NONCOHERENT
-	select HW_HAS_PCI
-	select IRQ_CPU
-	select SWAP_IO_SPACE
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_HAS_CPU_R5000
-	help
-	  This enables support for the R5432-based NEC Mark-eins
-	  boards with R5500 CPU.
-
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
 	select ARC
@@ -443,41 +422,38 @@ config SGI_IP32
 	help
 	  If you want this kernel to run on SGI O2 workstation, say Y here.
 
-config SIBYTE_BIGSUR
-	bool "Sibyte BCM91480B-BigSur"
+config SIBYTE_CRHINE
+	bool "Sibyte BCM91120C-CRhine"
+	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
-	select NR_CPUS_DEFAULT_4
-	select PCI_DOMAINS
-	select SIBYTE_BCM1x80
+	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config SIBYTE_SWARM
-	bool "Sibyte BCM91250A-SWARM"
+config SIBYTE_CARMEL
+	bool "Sibyte BCM91120x-Carmel"
+	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
-	select NR_CPUS_DEFAULT_2
-	select SIBYTE_SB1250
+	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_SUPPORTS_KGDB
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config SIBYTE_SENTOSA
-	bool "Sibyte BCM91250E-Sentosa"
+config SIBYTE_CRHONE
+	bool "Sibyte BCM91125C-CRhone"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
-	select NR_CPUS_DEFAULT_2
-	select SIBYTE_SB1250
+	select SIBYTE_BCM1125
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SIBYTE_RHONE
@@ -491,19 +467,21 @@ config SIBYTE_RHONE
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config SIBYTE_CARMEL
-	bool "Sibyte BCM91120x-Carmel"
-	depends on EXPERIMENTAL
+config SIBYTE_SWARM
+	bool "Sibyte BCM91250A-SWARM"
 	select BOOT_ELF32
 	select DMA_COHERENT
-	select SIBYTE_BCM1120
+	select NR_CPUS_DEFAULT_2
+	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_KGDB
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config SIBYTE_PTSWARM
-	bool "Sibyte BCM91250PT-PTSWARM"
+config SIBYTE_LITTLESUR
+	bool "Sibyte BCM91250C2-LittleSur"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -515,8 +493,8 @@ config SIBYTE_PTSWARM
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config SIBYTE_LITTLESUR
-	bool "Sibyte BCM91250C2-LittleSur"
+config SIBYTE_SENTOSA
+	bool "Sibyte BCM91250E-Sentosa"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
@@ -525,30 +503,31 @@ config SIBYTE_LITTLESUR
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config SIBYTE_CRHINE
-	bool "Sibyte BCM91120C-CRhine"
+config SIBYTE_PTSWARM
+	bool "Sibyte BCM91250PT-PTSWARM"
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
-	select SIBYTE_BCM1120
+	select NR_CPUS_DEFAULT_2
+	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config SIBYTE_CRHONE
-	bool "Sibyte BCM91125C-CRhone"
-	depends on EXPERIMENTAL
+config SIBYTE_BIGSUR
+	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
 	select DMA_COHERENT
-	select SIBYTE_BCM1125
+	select NR_CPUS_DEFAULT_4
+	select PCI_DOMAINS
+	select SIBYTE_BCM1x80
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
 	select SYS_SUPPORTS_BIG_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config SNI_RM
@@ -632,6 +611,27 @@ config TOSHIBA_RBTX4938
 	  This Toshiba board is based on the TX4938 processor. Say Y here to
 	  support this machine type
 
+config WR_PPMC
+	bool "Wind River PPMC board"
+	select IRQ_CPU
+	select BOOT_ELF32
+	select DMA_NONCOHERENT
+	select HW_HAS_PCI
+	select PCI_GT64XXX_PCI0
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_CPU_MIPS64_R1
+	select SYS_HAS_CPU_NEVADA
+	select SYS_HAS_CPU_RM7000
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	help
+	  This enables support for the Wind River MIPS32 4KC PPMC evaluation
+	  board, which is based on GT64120 bridge chip.
+
 endchoice
 
 source "arch/mips/au1000/Kconfig"

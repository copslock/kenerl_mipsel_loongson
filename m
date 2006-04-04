Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 11:32:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:4774 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133433AbWDDKcc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2006 11:32:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k34AhdpI010039;
	Tue, 4 Apr 2006 11:43:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k34Ahafe010038;
	Tue, 4 Apr 2006 11:43:36 +0100
Date:	Tue, 4 Apr 2006 11:43:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: build error about current git
Message-ID: <20060404104336.GA3142@linux-mips.org>
References: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 04, 2006 at 10:22:21AM +0900, Yoichi Yuasa wrote:

> I got the following error, when I built the kernel using current git.
> 
> Yoichi
> 
> $ make tb0287_defconfig
> .
> .
> .
> gcc: 0: No such file or directory
> gcc: unrecognized option `-G'
> gcc: unrecognized option `-EL'
> cc1: error: invalid option `no-abicalls'

It seems to happen because no SYS_HAS_CPU_xxx is set for this config,
so no CONFIG_CPU_VR41XX option will be choosen either, similar for a
bunch of other settings.  Below patch fixes  make tb0287_defconfig but
you may want to add some further settings such 

select SYS_SUPPORTS_32BIT_KERNEL if EXPERIMENTAL

Just let me know,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/vr41xx/Kconfig b/arch/mips/vr41xx/Kconfig
index a7add16..ea21094 100644
--- a/arch/mips/vr41xx/Kconfig
+++ b/arch/mips/vr41xx/Kconfig
@@ -4,6 +4,8 @@ config CASIO_E55
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config IBM_WORKPAD
@@ -12,6 +14,8 @@ config IBM_WORKPAD
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config NEC_CMBVR4133
@@ -21,12 +25,18 @@ config NEC_CMBVR4133
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config ROCKHOPPER
 	bool "Support for Rockhopper baseboard"
 	depends on NEC_CMBVR4133
 	select I8259
 	select HAVE_STD_PC_SERIAL_PORT
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config TANBAC_TB022X
 	bool "Support for TANBAC VR4131 multichip module and TANBAC VR4131DIMM"
@@ -34,6 +44,8 @@ config TANBAC_TB022X
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  The TANBAC VR4131 multichip module(TB0225) and
@@ -46,6 +58,9 @@ config TANBAC_TB0226
 	bool "Support for TANBAC Mbase(TB0226)"
 	depends on TANBAC_TB022X
 	select GPIO_VR41XX
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  The TANBAC Mbase(TB0226) is a MIPS-based platform
 	  manufactured by TANBAC.
@@ -54,6 +69,9 @@ config TANBAC_TB0226
 config TANBAC_TB0287
 	bool "Support for TANBAC Mini-ITX DIMM base(TB0287)"
 	depends on TANBAC_TB022X
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  The TANBAC Mini-ITX DIMM base(TB0287) is a MIPS-based platform
 	  manufactured by TANBAC.
@@ -65,6 +83,8 @@ config VICTOR_MPC30X
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config ZAO_CAPCELLA
@@ -73,6 +93,8 @@ config ZAO_CAPCELLA
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PCI_VR41XX

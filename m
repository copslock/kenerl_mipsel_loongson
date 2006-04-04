Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 12:37:55 +0100 (BST)
Received: from mo00.po.2iij.Net ([210.130.202.204]:46794 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133385AbWDDLhn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 12:37:43 +0100
Received: NPO MO00 id k34Bmmw1002074; Tue, 4 Apr 2006 20:48:48 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox00) id k34BmlqH014596
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Tue, 4 Apr 2006 20:48:47 +0900 (JST)
Date:	Tue, 4 Apr 2006 20:48:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: build error about current git
Message-Id: <20060404204847.6244de31.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060404104336.GA3142@linux-mips.org>
References: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp>
	<20060404104336.GA3142@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 11024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

On Tue, 4 Apr 2006 11:43:36 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Apr 04, 2006 at 10:22:21AM +0900, Yoichi Yuasa wrote:
> 
> > I got the following error, when I built the kernel using current git.
> > 
> > Yoichi
> > 
> > $ make tb0287_defconfig
> > .
> > .
> > .
> > gcc: 0: No such file or directory
> > gcc: unrecognized option `-G'
> > gcc: unrecognized option `-EL'
> > cc1: error: invalid option `no-abicalls'
> 
> It seems to happen because no SYS_HAS_CPU_xxx is set for this config,
> so no CONFIG_CPU_VR41XX option will be choosen either, similar for a
> bunch of other settings.  Below patch fixes  make tb0287_defconfig but
> you may want to add some further settings such 
> 
> select SYS_SUPPORTS_32BIT_KERNEL if EXPERIMENTAL
> 
> Just let me know,

ROCKHOPPER, TB0226 and TB0287 are only base board(CPU is not included in these boards).
These configs don't need "select SYS_HAS_CPU_VR41XX" and "select SYS_SUPPORTS_32BIT_KERNEL".

Thanks,

Yoichi

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X dontdiff mips-orig/arch/mips/vr41xx/Kconfig mips/arch/mips/vr41xx/Kconfig
--- mips-orig/arch/mips/vr41xx/Kconfig	2006-04-04 20:27:53.335428500 +0900
+++ mips/arch/mips/vr41xx/Kconfig	2006-04-04 20:37:51.396805000 +0900
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
@@ -21,6 +25,9 @@ config NEC_CMBVR4133
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config ROCKHOPPER
 	bool "Support for Rockhopper baseboard"
@@ -34,6 +41,8 @@ config TANBAC_TB022X
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	help
 	  The TANBAC VR4131 multichip module(TB0225) and
@@ -65,6 +74,8 @@ config VICTOR_MPC30X
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config ZAO_CAPCELLA
@@ -73,6 +84,8 @@ config ZAO_CAPCELLA
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
+	select SYS_HAS_CPU_VR41XX
+	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PCI_VR41XX

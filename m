Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 03:54:47 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:24193
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8224939AbTBYDyr>; Tue, 25 Feb 2003 03:54:47 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1P40i44002463;
	Tue, 25 Feb 2003 13:00:44 +0900
Date: Tue, 25 Feb 2003 12:48:50 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: Re: Change -mcpu option for VR41xx
Message-Id: <20030225124850.32cfa6f5.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20030224212146.A764@linux-mips.org>
References: <20030224210755.1f5fac0a.yoichi_yuasa@montavista.co.jp>
	<20030224212146.A764@linux-mips.org>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__25_Feb_2003_12:48:50_+0900_0828eae8"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Tue__25_Feb_2003_12:48:50_+0900_0828eae8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ralf,

On Mon, 24 Feb 2003 21:21:46 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Feb 24, 2003 at 09:07:55PM +0900, Yoichi Yuasa wrote:
> 
> > We need to change -mcpu in order to use an instruction peculiar to VR4100.
> > The option of -mcpu changes with versions of binutils.
> > 
> > If it is limited to some versions, I can be corresponded using check_gcc.
> > Can you tell me some versions of binutils?
> 
> Binutils starting with about 2.10 should support -mcpu=4100.

I checked about some binutils.

binutils -mcpu option for VR4100 series

2.10:
        * VR4100
        * vr4100
        * 4100
        * mips64vr4100
        * r4100

2.11:
2.12:
2.13:
        * VR4100
        * 4100
        * mips64vr4100
        * r4100

In addition for the VR4100 series, there is an -m4100 option.

As for us, it is best to use the following option.

GCCFLAGS        += -mcpu=r4100 -mips2 -Wa,-m4100,--trap

Would you apply this patch to CVS?

Thanks,

Yoichi

--Multipart_Tue__25_Feb_2003_12:48:50_+0900_0828eae8
Content-Type: text/plain;
 name="vr41xx-makefile-v24.diff"
Content-Disposition: attachment;
 filename="vr41xx-makefile-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/arch/mips/Makefile	Fri Feb 21 03:53:37 2003
+++ linux/arch/mips/Makefile	Tue Feb 25 12:27:57 2003
@@ -66,7 +66,7 @@
 GCCFLAGS	+= -mcpu=r4300 -mips2 -Wa,--trap
 endif
 ifdef CONFIG_CPU_VR41XX
-GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap
+GCCFLAGS	+= -mcpu=r4100 -mips2 -Wa,-m4100,--trap
 endif
 ifdef CONFIG_CPU_R4X00
 GCCFLAGS	+= -mcpu=r4600 -mips2 -Wa,--trap

--Multipart_Tue__25_Feb_2003_12:48:50_+0900_0828eae8
Content-Type: text/plain;
 name="vr41xx-makefile-v25.diff"
Content-Disposition: attachment;
 filename="vr41xx-makefile-v25.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/arch/mips/Makefile	Fri Jan 24 10:26:58 2003
+++ linux/arch/mips/Makefile	Tue Feb 25 12:40:23 2003
@@ -57,7 +57,7 @@
 cflags-$(CONFIG_CPU_TX39XX)	+= -mcpu=r3000 -mips1
 cflags-$(CONFIG_CPU_R6000)	+= -mcpu=r6000 -mips2 -Wa,--trap
 cflags-$(CONFIG_CPU_R4300)	+= -mcpu=r4300 -mips2 -Wa,--trap
-cflags-$(CONFIG_CPU_VR41XX)	+= -mcpu=r4600 -mips2 -Wa,--trap
+cflags-$(CONFIG_CPU_VR41XX)	+= -mcpu=r4100 -mips2 -Wa,-m4100,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -mcpu=r4600 -mips2 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -mcpu=r4600 -mips2 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32)	+= -mcpu=r4600 -mips2 -Wa,--trap

--Multipart_Tue__25_Feb_2003_12:48:50_+0900_0828eae8--

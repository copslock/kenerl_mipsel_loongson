Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 04:19:53 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:29781
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225201AbTBUETw>; Fri, 21 Feb 2003 04:19:52 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1L4Oa44025021;
	Fri, 21 Feb 2003 13:24:37 +0900
Date: Fri, 21 Feb 2003 13:14:01 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org,
	matsu@megasolution.jp, jsun@mvista.com
Subject: [patch] vr41xx giu bug fix
Message-Id: <20030221131401.59e3e7ae.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__21_Feb_2003_13:14:01_+0900_0824f3b0"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Fri__21_Feb_2003_13:14:01_+0900_0824f3b0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ralf,

I got the report that a problem is in giu.c of vr41xx.
These patches to the problem are appended to this e-mail.

Please apply these patches to CVS tree.

Yoichi

--Multipart_Fri__21_Feb_2003_13:14:01_+0900_0824f3b0
Content-Type: text/plain;
 name="vr41xx-giu-24.diff"
Content-Disposition: attachment;
 filename="vr41xx-giu-24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux.orig/arch/mips/vr41xx/common/giu.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/common/giu.c	Fri Feb 21 12:33:33 2003
@@ -108,9 +108,9 @@
 void vr41xx_clear_giuint(int pin)
 {
 	if (pin < 16)
-		write_giuint(GIUINTSTATL, (u16)1 << pin);
+		write_giuint((u16)1 << pin, GIUINTSTATL);
 	else
-		write_giuint(GIUINTSTATH, (u16)1 << (pin - 16));
+		write_giuint((u16)1 << (pin - 16), GIUINTSTATH);
 }
 
 void vr41xx_set_irq_trigger(int pin, int trigger, int hold)

--Multipart_Fri__21_Feb_2003_13:14:01_+0900_0824f3b0
Content-Type: text/plain;
 name="vr41xx-giu-25.diff"
Content-Disposition: attachment;
 filename="vr41xx-giu-25.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/giu.c linux/arch/mips/vr41xx/common/giu.c
--- linux.orig/arch/mips/vr41xx/common/giu.c	Fri Oct  4 10:52:37 2002
+++ linux/arch/mips/vr41xx/common/giu.c	Fri Feb 21 13:05:14 2003
@@ -108,9 +108,9 @@
 void vr41xx_clear_giuint(int pin)
 {
 	if (pin < 16)
-		write_giuint(GIUINTSTATL, (u16)1 << pin);
+		write_giuint((u16)1 << pin, GIUINTSTATL);
 	else
-		write_giuint(GIUINTSTATH, (u16)1 << (pin - 16));
+		write_giuint((u16)1 << (pin - 16), GIUINTSTATH);
 }
 
 void vr41xx_set_irq_trigger(int pin, int trigger, int hold)

--Multipart_Fri__21_Feb_2003_13:14:01_+0900_0824f3b0--

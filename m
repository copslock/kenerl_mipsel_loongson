Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 11:54:46 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:20150
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225262AbTB0Lyq>; Thu, 27 Feb 2003 11:54:46 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1RC1P44029907;
	Thu, 27 Feb 2003 21:01:25 +0900
Date: Thu, 27 Feb 2003 20:48:46 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: [patch] simulate_ll and simulate_sc
Message-Id: <20030227204846.61e13c90.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__27_Feb_2003_20:48:46_+0900_082acd58"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Thu__27_Feb_2003_20:48:46_+0900_082acd58
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ralf,

I found a bug in simulate_ll and simulate_sc.

When send_sig in these, in order not to operate the value of EPC correctly,
simulate_* happens continuously.

Please apply these patches to CVS tree.

Thanks,

Yoichi


--Multipart_Thu__27_Feb_2003_20:48:46_+0900_082acd58
Content-Type: text/plain;
 name="simulate_llsc-v24.diff"
Content-Disposition: attachment;
 filename="simulate_llsc-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Tue Feb 11 07:50:48 2003
+++ linux/arch/mips/kernel/traps.c	Thu Feb 27 20:00:43 2003
@@ -140,6 +140,7 @@
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 
@@ -184,6 +185,7 @@
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 

--Multipart_Thu__27_Feb_2003_20:48:46_+0900_082acd58
Content-Type: text/plain;
 name="simulate_llsc-v25.diff"
Content-Disposition: attachment;
 filename="simulate_llsc-v25.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Wed Feb 12 13:26:43 2003
+++ linux/arch/mips/kernel/traps.c	Thu Feb 27 20:34:29 2003
@@ -135,6 +135,7 @@
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 
@@ -179,6 +180,7 @@
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 

--Multipart_Thu__27_Feb_2003_20:48:46_+0900_082acd58--

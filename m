Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 18:14:40 +0000 (GMT)
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:12393 "EHLO
	outbound9-blu-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20030427AbXLKSOb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 18:14:31 +0000
Received: from outbound9-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound9-blu-R.bigfish.com (Postfix) with ESMTP id 99EAAD0BA42;
	Tue, 11 Dec 2007 18:13:24 +0000 (UTC)
Received: from mail19-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound9-blu.bigfish.com (Postfix) with ESMTP id 867D417E005A;
	Tue, 11 Dec 2007 18:13:24 +0000 (UTC)
Received: from mail19-blu (localhost.localdomain [127.0.0.1])
	by mail19-blu-R.bigfish.com (Postfix) with ESMTP id E5C36178812E;
	Tue, 11 Dec 2007 18:13:23 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.66.75;Service: EHS
Received: by mail19-blu (MessageSwitch) id 1197396802965085_1845; Tue, 11 Dec 2007 18:13:22 +0000 (UCT)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail19-blu.bigfish.com (Postfix) with ESMTP id 610361F009A;
	Tue, 11 Dec 2007 18:13:21 +0000 (UTC)
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id lBBIDJ2F020817;
	Tue, 11 Dec 2007 18:13:19 GMT
Received: from USSDIXIM02.am.sony.com (ussdixim02.am.sony.com [43.130.140.34])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id lBBIDJ9E001405;
	Tue, 11 Dec 2007 18:13:19 GMT
Received: from ussdixms03.am.sony.com ([43.130.140.23]) by USSDIXIM02.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 11 Dec 2007 10:13:19 -0800
Received: from [43.135.148.200] ([43.135.148.200]) by ussdixms03.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 11 Dec 2007 10:13:18 -0800
Subject: [PATCH] RBTX4927: linux-2.6.24-rc4 hang on boot
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	linux-mips@linux-mips.org
Cc:	frank.rowand@am.sony.com
Content-Type: text/plain
Date:	Tue, 11 Dec 2007 10:16:27 -0500
Message-Id: <1197386187.5610.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2007 18:13:18.0948 (UTC) FILETIME=[81CF1A40:01C83C21]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips

In linux-2.6.24-rc4 the Toshiba RBTX4927 hangs on boot.

The cause is that plat_time_init() from arch/mips/tx4927/common/tx4927_setup.c
does not override the __weak plat_time_init() from arch/mips/kernel/time.c.
This is due to a compiler bug in gcc 4.1.1.  The bug is reported to not exist
in earlier versions of gcc, and to be fixed in 4.1.2.  The problem is that
the __weak plat_time_init() is empty and thus gets optimized out of
existence (thus the linker is never given the option to replace the
__weak function).

For more info on the gcc bug see

   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27781

The attached patch is one workaround.  Another possible workaround
would be to change the __weak plat_time_init() to be a non-empty
function.


Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

---
 arch/mips/kernel/Makefile |    4 	4 +	0 -	0 !
 1 files changed, 4 insertions(+)

Index: linux-2.6.24-rc4/arch/mips/kernel/Makefile
===================================================================
--- linux-2.6.24-rc4.orig/arch/mips/kernel/Makefile
+++ linux-2.6.24-rc4/arch/mips/kernel/Makefile
@@ -83,6 +83,10 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_prin
 
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
+# workaround for http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27781,
+# which impacts plat_time_init() for tx4927, gcc 4.1.1
+CFLAGS_time.o			+= -fno-unit-at-a-time
+
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
 EXTRA_CFLAGS += -Werror

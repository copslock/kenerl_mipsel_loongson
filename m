Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 01:32:43 +0100 (BST)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:1766 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133828AbWDEAaK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 01:30:10 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k350fE24023775;
	Wed, 5 Apr 2006 00:41:15 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k350fEGe008848;
	Wed, 5 Apr 2006 00:41:14 GMT
Message-ID: <4433122A.1090104@am.sony.com>
Date:	Tue, 04 Apr 2006 17:41:14 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: [PATCH 4/4] fix tx4938 undefined reference
Content-Type: multipart/mixed;
 boundary="------------080506050707030507070005"
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080506050707030507070005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




--------------080506050707030507070005
Content-Type: text/x-patch;
 name="fix-mips-undefined-sio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-mips-undefined-sio.patch"

Fix undefined reference to `txx9_sio_kdbg_rd' when 
CONFIG_KGDB_8250=y, CONFIG_KGDB_8250=n.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: linux-2.6.16.1/arch/mips/tx4938/common/Makefile
===================================================================
--- linux-2.6.16.1.orig/arch/mips/tx4938/common/Makefile	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16.1/arch/mips/tx4938/common/Makefile	2006-03-07 11:05:05.000000000 -0800
@@ -7,5 +7,5 @@
 #
 
 obj-y	+= prom.o setup.o irq.o irq_handler.o rtc_rx5c348.o
-obj-$(CONFIG_KGDB) += dbgio.o
+obj-$(CONFIG_KGDB_8250) += dbgio.o
 



--------------080506050707030507070005--

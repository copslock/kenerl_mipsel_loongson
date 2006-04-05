Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 01:33:32 +0100 (BST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:3249 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133829AbWDEAaL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 01:30:11 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k350fD6i019530;
	Wed, 5 Apr 2006 00:41:13 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k350fC89008838;
	Wed, 5 Apr 2006 00:41:12 GMT
Message-ID: <44331228.5020707@am.sony.com>
Date:	Tue, 04 Apr 2006 17:41:12 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: [PATCH 3/4] fix tx4927 header dep
Content-Type: multipart/mixed;
 boundary="------------050703010509030407050801"
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050703010509030407050801
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




--------------050703010509030407050801
Content-Type: text/x-patch;
 name="fix-tx4927-header-dep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-tx4927-header-dep.patch"

fix-tx4927-header-dep.patch:

This patch fixes a header dependency problem in tx4927_mips.h.

tx4927_mips.h:58: error: parse error before "s08"
tx4927_mips.h:58: warning: type defaults to `int' in declaration of `s08'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: linux-2.6.16.1/include/asm-mips/tx4927/tx4927_mips.h
===================================================================
--- linux-2.6.16.1.orig/include/asm-mips/tx4927/tx4927_mips.h	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.16.1/include/asm-mips/tx4927/tx4927_mips.h	2006-03-23 10:49:24.000000000 -0800
@@ -28,6 +28,7 @@
 #define __ASM_TX4927_TX4927_MIPS_H
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 static inline void asm_wait(void)
 {



--------------050703010509030407050801--

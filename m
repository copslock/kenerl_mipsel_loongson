Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 04:42:20 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:51744
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225316AbTIKDls>; Thu, 11 Sep 2003 04:41:48 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 11 Sep 2003 03:41:45 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h8B3fagc058161
	for <linux-mips@linux-mips.org>; Thu, 11 Sep 2003 12:41:37 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 11 Sep 2003 12:43:50 +0900 (JST)
Message-Id: <20030911.124350.41627177.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: mips64 _access_ok fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The mips64 _access_ok macro in 2.4 tree returns 0 if 'addr' + 'size'
== TASK_SIZE.

Also, __ua_size macro returus 0 if 'size' is negative constant.  I
think we must not skip checking negative constant.

Here is a fix.  For 2.6 tree, only _access_ok fix will be needed
(__ua_size is already fixed).

diff -u linux-mips-cvs/include/asm-mips64/uaccess.h linux.new/include/asm-mips64/uaccess.h
--- linux-mips-cvs/include/asm-mips64/uaccess.h	Tue Jul 15 20:21:59 2003
+++ linux.new/include/asm-mips64/uaccess.h	Thu Sep 11 12:29:08 2003
@@ -46,10 +46,10 @@
  *  - OR we are in kernel mode.
  */
 #define __ua_size(size)							\
-	((__builtin_constant_p(size) && (size)) > 0 ? 0 : (size))
+	(__builtin_constant_p(size) && (signed long) (size) > 0 ? 0 : (size))
 
 #define __access_ok(addr, size, mask)					\
-	(((mask) & ((addr) | ((addr) + (size)) | __ua_size(size))) == 0)
+	(((mask) & ((addr) | ((addr) + (size) - 1) | __ua_size(size))) == 0)
 
 #define __access_mask get_fs().seg
 
---
Atsushi Nemoto

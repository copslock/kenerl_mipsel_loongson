Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 06:44:05 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:30457 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20040024AbXAXGoB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 06:44:01 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 24 Jan 2007 15:43:59 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0018123ECE;
	Wed, 24 Jan 2007 15:43:35 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E9479203B8;
	Wed, 24 Jan 2007 15:43:35 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l0O6hYW0098951;
	Wed, 24 Jan 2007 15:43:35 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 24 Jan 2007 15:43:34 +0900 (JST)
Message-Id: <20070124.154334.130239327.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, Al Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH] Fix wrong checksum calculation on 64-bit MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The commit 8e3d8433d8c22ca6c42cba4a67d300c39aae7822 ([NET]: MIPS
checksum annotations and cleanups) broke 64-bit MIPS.

The problem is the commit replaces some unsigned long with __be32.  On
64bit MIPS, a __be32 (i.e. unsigned int) value is represented as a
sign-extented 32-bit value in a 64-bit argument register.  So the
address 192.168.0.1 (0xc0a80001) is passed as 0xffffffffc0a80001 to
csum_tcpudp_nofold() but the asm code in the function expects
0x00000000c0a80001, therefore it returns a wrong checksum.  Explicit
cast to unsigned long is needed to drop high 32bit.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/checksum.h b/include/asm-mips/checksum.h
index 24cdcc6..20a81e1 100644
--- a/include/asm-mips/checksum.h
+++ b/include/asm-mips/checksum.h
@@ -159,7 +159,8 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr,
 #endif
 	"	.set	pop"
 	: "=r" (sum)
-	: "0" (daddr), "r"(saddr),
+	: "0" ((__force unsigned long)daddr),
+	  "r" ((__force unsigned long)saddr),
 #ifdef __MIPSEL__
 	  "r" ((proto + len) << 8),
 #else

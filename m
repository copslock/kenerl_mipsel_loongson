Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 04:29:16 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:6936 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133362AbVK3E26 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 04:28:58 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 30 Nov 2005 04:33:31 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 7148C2017A;
	Wed, 30 Nov 2005 13:33:27 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 65B1320034;
	Wed, 30 Nov 2005 13:33:27 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jAU4XQ4D010653;
	Wed, 30 Nov 2005 13:33:27 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 30 Nov 2005 13:33:26 +0900 (JST)
Message-Id: <20051130.133326.126937941.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix mdelay(1) for 64bit kernel with HZ == 1000
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
X-archive-position: 9559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

mdelay(1) (i.e. udelay(1000)) does not work correctly due to overflow.

1000 * 0x004189374BC6A7f0 = 0x10000000000000180 (>= 2**64)

0x004189374BC6A7ef (0x004189374BC6A7f0 - 1) is OK and it is exactly
same as catchall case (0x8000000000000000UL / (500000 / HZ)).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/delay.h b/include/asm-mips/delay.h
index 48d00cc..64dd451 100644
--- a/include/asm-mips/delay.h
+++ b/include/asm-mips/delay.h
@@ -52,13 +52,11 @@ static inline void __udelay(unsigned lon
 	unsigned long lo;
 
 	/*
-	 * The common rates of 1000 and 128 are rounded wrongly by the
-	 * catchall case for 64-bit.  Excessive precission?  Probably ...
+	 * The rates of 128 is rounded wrongly by the catchall case
+	 * for 64-bit.  Excessive precission?  Probably ...
 	 */
 #if defined(CONFIG_64BIT) && (HZ == 128)
 	usecs *= 0x0008637bd05af6c7UL;		/* 2**64 / (1000000 / HZ) */
-#elif defined(CONFIG_64BIT) && (HZ == 1000)
-	usecs *= 0x004189374BC6A7f0UL;		/* 2**64 / (1000000 / HZ) */
 #elif defined(CONFIG_64BIT)
 	usecs *= (0x8000000000000000UL / (500000 / HZ));
 #else /* 32-bit junk follows here */

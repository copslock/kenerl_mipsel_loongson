Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 14:28:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:31450 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224947AbULUO2L>; Tue, 21 Dec 2004 14:28:11 +0000
Received: from localhost (p7164-ipad25funabasi.chiba.ocn.ne.jp [220.104.85.164])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2E57382A2; Tue, 21 Dec 2004 23:27:58 +0900 (JST)
Date: Tue, 21 Dec 2004 23:33:24 +0900 (JST)
Message-Id: <20041221.233324.41626824.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: nunoe@co-nss.co.jp, linux-mips@linux-mips.org
Subject: Re: HIGHMEM
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041215141613.GB29222@linux-mips.org>
References: <20041207095837.GA13264@linux-mips.org>
	<20041213.133409.11964920.nemoto@toshiba-tops.co.jp>
	<20041215141613.GB29222@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 15 Dec 2004 15:16:13 +0100, Ralf Baechle <ralf@linux-mips.org> said:

>> And this is a small step to a 64-bit kernel for TX49XX.  Could you
>> apply?

ralf> Sure, done.

Thanks.  And this is next step.  Could you apply too?

diff -u linux-mips/include/asm-mips/addrspace.h linux/include/asm-mips/addrspace.h 
--- linux-mips/include/asm-mips/addrspace.h	Sun Sep 26 21:31:45 2004
+++ linux/include/asm-mips/addrspace.h	Sat Dec 18 21:21:01 2004
@@ -126,6 +126,7 @@
     || defined (CONFIG_CPU_R4X00)					\
     || defined (CONFIG_CPU_R5000)					\
     || defined (CONFIG_CPU_NEVADA)					\
+    || defined (CONFIG_CPU_TX49XX)					\
     || defined (CONFIG_CPU_MIPS64)
 #define	KUSIZE			0x0000010000000000	/* 2^^40 */
 #define	KUSIZE_64		0x0000010000000000	/* 2^^40 */

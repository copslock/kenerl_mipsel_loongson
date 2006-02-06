Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 09:31:40 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:14883 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S3458260AbWBFJbb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 09:31:31 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 6 Feb 2006 18:37:04 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BF95B2033E;
	Mon,  6 Feb 2006 18:36:56 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id B37BD20041;
	Mon,  6 Feb 2006 18:36:56 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k169at4D037481;
	Mon, 6 Feb 2006 18:36:56 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 06 Feb 2006 18:36:55 +0900 (JST)
Message-Id: <20060206.183655.129447619.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060203144420.GA3375@linux-mips.org>
References: <20060202172434.GE17352@linux-mips.org>
	<20060203.111012.130238823.nemoto@toshiba-tops.co.jp>
	<20060203144420.GA3375@linux-mips.org>
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
X-archive-position: 10340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Fri, 3 Feb 2006 14:44:20 +0000, Ralf Baechle <ralf@linux-mips.org> said:
>> So here is a patch against current GIT.

ralf> Okay, applied.

Thanks.  And please apply this also...


Remove TX49XX_MFC0_WAR completely.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/war.h b/include/asm-mips/war.h
index 229afaa..ad374bd 100644
--- a/include/asm-mips/war.h
+++ b/include/asm-mips/war.h
@@ -228,9 +228,6 @@
 #ifndef TX49XX_ICACHE_INDEX_INV_WAR
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #endif
-#ifndef TX49XX_MFC0_WAR
-#define TX49XX_MFC0_WAR	0
-#endif
 #ifndef RM9000_CDEX_SMP_WAR
 #define RM9000_CDEX_SMP_WAR		0
 #endif

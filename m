Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jan 2008 05:08:16 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:37115 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022142AbYAZFII (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Jan 2008 05:08:08 +0000
Received: from localhost (p8236-ipad210funabasi.chiba.ocn.ne.jp [58.88.127.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C19579C53; Sat, 26 Jan 2008 14:07:59 +0900 (JST)
Date:	Sat, 26 Jan 2008 14:08:02 +0900 (JST)
Message-Id: <20080126.140802.126142689.anemo@mba.ocn.ne.jp>
To:	okumoto@ucsd.edu
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <479A134D.7090206@ucsd.edu>
References: <479A134D.7090206@ucsd.edu>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 25 Jan 2008 08:50:21 -0800, Max Okumoto <okumoto@ucsd.edu> wrote:
> I have a JMR3927 based system and I got it to work with the 2.6.23.14 kernel, but
> used 0xff0000 instead of 0xff000.  The offset passed in was 0xfffec000 which isn't
> within the 0xff000000 - 0xff0ff000.

Thank you for good news.  (and excuse my double fault...)

Ralf, please apply this to 2.6.23-stable and 2.6.24-stable.


Subject: [MIPS] Fix plat_ioremap for JMR3927 (take 2)

TX39XX's "reserved" segment in CKSEG3 area is 0xff000000-0xfffeffff.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/mach-jmr3927/ioremap.h b/include/asm-mips/mach-jmr3927/ioremap.h
index aa131ad..29989ff 100644
--- a/include/asm-mips/mach-jmr3927/ioremap.h
+++ b/include/asm-mips/mach-jmr3927/ioremap.h
@@ -25,7 +25,7 @@ static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
 {
 #define TXX9_DIRECTMAP_BASE	0xff000000ul
 	if (offset >= TXX9_DIRECTMAP_BASE &&
-	    offset < TXX9_DIRECTMAP_BASE + 0xf0000)
+	    offset < TXX9_DIRECTMAP_BASE + 0xff0000)
 		return (void __iomem *)offset;
 	return NULL;
 }

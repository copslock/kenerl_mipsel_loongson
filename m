Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2007 16:56:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:5102 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022335AbXFMP4P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2007 16:56:15 +0100
Received: from localhost (p5198-ipad211funabasi.chiba.ocn.ne.jp [58.91.161.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 250BBBA7F; Thu, 14 Jun 2007 00:56:09 +0900 (JST)
Date:	Thu, 14 Jun 2007 00:56:31 +0900 (JST)
Message-Id: <20070614.005631.27954615.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: smp_mb() in asm-mips/bitops.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070607122344.GD26047@linux-mips.org>
References: <20070607.165301.63743560.nemoto@toshiba-tops.co.jp>
	<20070607122344.GD26047@linux-mips.org>
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
X-archive-position: 15382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jun 2007 13:23:44 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> @@ -310,6 +306,7 @@ static inline int test_and_clear_bit(unsigned long nr,
>  	volatile unsigned long *addr)
>  {
>  	unsigned short bit = nr & SZLONG_MASK;
> +	unsigned long res;
>  
>  	if (cpu_has_llsc && R10000_LLSC_WAR) {
>  		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);

You forgot to remove one more 'res' variable.


Subject: Remove a duplicated local variable in test_and_clear_bit()

Fix a sparse warning caused by 2c921d07f8c641e691b0dfd80a5cfe14c60ec489

include2/asm/bitops.h:313:23: warning: symbol 'res' shadows an earlier one
include2/asm/bitops.h:309:16: originally declared here

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
index ffe245b..d9e81af 100644
--- a/include/asm-mips/bitops.h
+++ b/include/asm-mips/bitops.h
@@ -310,7 +310,7 @@ static inline int test_and_clear_bit(unsigned long nr,
 
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
-		unsigned long temp, res;
+		unsigned long temp;
 
 		__asm__ __volatile__(
 		"	.set	mips3					\n"

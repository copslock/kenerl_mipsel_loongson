Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2004 03:39:22 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:24345
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225250AbUK1DjR>; Sun, 28 Nov 2004 03:39:17 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CYFu8-0008Hv-00; Sun, 28 Nov 2004 04:39:16 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CYFu7-0007BR-00; Sun, 28 Nov 2004 04:39:15 +0100
Date: Sun, 28 Nov 2004 04:39:15 +0100
To: Paul Jakma <paul@clubi.ie>
Cc: linux-mips@linux-mips.org
Subject: Re: ip32 kconfig patch
Message-ID: <20041128033915.GQ902@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.61.0411280316090.6275@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411280316090.6275@sheen.jakma.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Paul Jakma wrote:
> Hi,
> 
> IP32 needs the below to build CVS. rm7k_sc_enable and 
> __rm7k_sc_enable in arch/mips/mm/sc-r7k.c reference the MIPS32 
> KSEG{0,1}ADDR macros. I dont know enough about MIPS to fixup the 
> KSEGxADDR references unfortunately, but this lets me build for R10k 
> at least.

Use this patch instead.


Thiemo


Index: arch/mips/mm/sc-rm7k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/sc-rm7k.c,v
retrieving revision 1.6
diff -u -p -r1.6 sc-rm7k.c
--- arch/mips/mm/sc-rm7k.c	24 Jun 2004 20:41:28 -0000	1.6
+++ arch/mips/mm/sc-rm7k.c	25 Nov 2004 18:17:47 -0000
@@ -96,13 +96,13 @@ static void rm7k_sc_inv(unsigned long ad
 }
 
 /*
- * This function is executed in the uncached segment KSEG1.
+ * This function is executed in the uncached segment CKSEG1.
  * It must not touch the stack, because the stack pointer still points
- * into KSEG0.
+ * into CKSEG0.
  *
  * Three options:
  *	- Write it in assembly and guarantee that we don't use the stack.
- *	- Disable caching for KSEG0 before calling it.
+ *	- Disable caching for CKSEG0 before calling it.
  *	- Pray that GCC doesn't randomly start using the stack.
  *
  * This being Linux, we obviously take the least sane of those options -
@@ -127,13 +127,13 @@ static __init void __rm7k_sc_enable(void
 		      ".set mips0\n\t"
 		      ".set reorder"
 		      :
-		      : "r" (KSEG0ADDR(i)), "i" (Index_Store_Tag_SD));
+		      : "r" (CKSEG0ADDR(i)), "i" (Index_Store_Tag_SD));
 	}
 }
 
 static __init void rm7k_sc_enable(void)
 {
-	void (*func)(void) = (void *) KSEG1ADDR(&__rm7k_sc_enable);
+	void (*func)(void) = (void *) CKSEG1ADDR(&__rm7k_sc_enable);
 
 	if (read_c0_config() & 0x08)			/* CONF_SE */
 		return;

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2003 13:58:21 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:1228 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbTFCM6T>; Tue, 3 Jun 2003 13:58:19 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA00804;
	Tue, 3 Jun 2003 14:58:45 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 3 Jun 2003 14:58:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: mips64 LOAD_KPTE2 fix
In-Reply-To: <20030602.202345.08315331.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030603141712.29576C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 2 Jun 2003, Atsushi Nemoto wrote:

> Please ignore it.  I missed an another fix.  The beqz lacks delay
> slot.  Here is a new patch.
> 
> diff -u linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S linux.new/arch/mips64/mm/tlbex-r4k.S
> --- linux-mips-cvs/arch/mips64/mm/tlbex-r4k.S	Mon Apr 28 09:44:54 2003
> +++ linux.new/arch/mips64/mm/tlbex-r4k.S	Mon Jun  2 20:16:41 2003
> @@ -72,9 +72,12 @@
>  	/*
>  	 * Determine that fault address is within vmalloc range.
>  	 */
> +	bgez	\ptr, \not_vmalloc		# check overflow
> +	nop
>  	dla	\tmp, ekptbl
>  	sltu	\tmp, \ptr, \tmp
>  	beqz	\tmp, \not_vmalloc		# not vmalloc
> +	nop
>  	.endm

 The missing delay slot filler might be called a feature, but LOAD_KPTE2
is so far always used near such code it cannot be avoided.  So the "nop"
is correct.  Please pay attention to proper indentation of instructions in
branch delay slots -- this helps avoiding such errors.

 I don't think a separate overflow check is needed, even I see how the
code can fail for large offsets into XKSEG.  How about this patch?  Does
it work for you?  It would not incur unnecessary overhead.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-pre4-20030505-load_kpte2-0
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S
--- linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S	2003-04-27 02:56:39.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S	2003-06-03 12:54:41.000000000 +0000
@@ -73,8 +73,9 @@
 	 * Determine that fault address is within vmalloc range.
 	 */
 	dla	\tmp, ekptbl
-	sltu	\tmp, \ptr, \tmp
+	slt	\tmp, \ptr, \tmp
 	beqz	\tmp, \not_vmalloc		# not vmalloc
+	 nop
 	.endm
 
 

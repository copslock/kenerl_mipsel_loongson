Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 15:11:40 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:1176 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTEWOLi>; Fri, 23 May 2003 15:11:38 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA17254;
	Fri, 23 May 2003 16:12:20 +0200 (MET DST)
Date: Fri, 23 May 2003 16:12:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Vr41xx unaligned access update
In-Reply-To: <Pine.GSO.4.21.0305231553070.26586-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030523160920.14542F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 May 2003, Geert Uytterhoeven wrote:

> @@ -145,8 +146,6 @@
>  	 * but the BD bit in the cause register is not set.
>  	 */
>  	case bcond_op:
> -	case j_op:
> -	case jal_op:
>  	case beq_op:
>  	case bne_op:
>  	case blez_op:
> @@ -155,7 +154,11 @@
>  	case bnel_op:
>  	case blezl_op:
>  	case bgtzl_op:
> -	case jalx_op:
> +		if (branch) {
> +		    /* branch in a branch delay slot */
> +		    goto sigill;
> +		}
> +		branch = 1;
>  		pc += 4;
>  		goto retry;

 Hmm, what tree is it against?  I can't see code matching these hunks in
our tree at linux-mips.org.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

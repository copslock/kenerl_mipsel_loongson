Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 15:08:29 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:9617 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225253AbTFDOI1>; Wed, 4 Jun 2003 15:08:27 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA20159;
	Wed, 4 Jun 2003 16:09:11 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 4 Jun 2003 16:09:10 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: mips64 LOAD_KPTE2 fix
In-Reply-To: <20030604.100204.74756139.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030604160418.18707B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Jun 2003, Atsushi Nemoto wrote:

> macro> diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S
> macro> --- linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/mm/tlbex-r4k.S	2003-04-27 02:56:39.000000000 +0000
> macro> +++ linux-mips-2.4.21-pre4-20030505/arch/mips64/mm/tlbex-r4k.S	2003-06-03 12:54:41.000000000 +0000
> macro> @@ -73,8 +73,9 @@
> macro>  	 * Determine that fault address is within vmalloc range.
> macro>  	 */
> macro>  	dla	\tmp, ekptbl
> macro> -	sltu	\tmp, \ptr, \tmp
> macro> +	slt	\tmp, \ptr, \tmp
> macro>  	beqz	\tmp, \not_vmalloc		# not vmalloc
> macro> +	 nop
> macro>  	.endm
> 
> 
> Thank you for pointing out this.  I did not think very much.  But you
> mean "slt \tmp, \tmp, \ptr", don't you?

 Not at all.  Why would I want to reverse the comparison? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

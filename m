Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 11:06:23 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:63961 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225206AbTBNLGW>; Fri, 14 Feb 2003 11:06:22 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA02291;
	Fri, 14 Feb 2003 12:06:21 +0100 (MET)
Date: Fri, 14 Feb 2003 12:06:21 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.sphere.ne.jp>
cc: jsun@mvista.com, ralf@linux-mips.org, quintela@mandrakesoft.com,
	linux-mips@linux-mips.org, nemoto@toshiba-tops.co.jp
Subject: Re: [RFC & PATCH] fixing tlb flush race problem on smp
In-Reply-To: <20030214.134825.112283876.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1030214120450.2266A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 14 Feb 2003, Atsushi Nemoto wrote:

> The attached patch seems to break r3k codes.  Here is a patch to fix
> it (only for 2.4/mips).
> 
> diff -ur linux-mips-cvs/include/asm-mips/mmu_context.h linux.new/include/asm-mips/mmu_context.h
> --- linux-mips-cvs/include/asm-mips/mmu_context.h	Fri Feb 14 09:41:31 2003
> +++ linux.new/include/asm-mips/mmu_context.h	Fri Feb 14 13:40:24 2003
> @@ -151,7 +151,7 @@
>  
>  	if (test_bit(cpu, &mm->cpu_vm_mask))  {
>  		get_new_mmu_context(mm, cpu);
> -		write_c0_entryhi(cpu_context(cpu, mm) & 0xff);
> +		write_c0_entryhi(cpu_context(cpu, mm) & ASID_MASK);
>  	} else {
>  		/* will get a new context next time */
>  		cpu_context(cpu, mm) = 0;

 I've checked in a slightly different fix.  Thanks for spotting the
problem.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 11:50:05 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:42968 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224802AbTGUKuB>; Mon, 21 Jul 2003 11:50:01 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA13685;
	Mon, 21 Jul 2003 12:49:57 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 21 Jul 2003 12:49:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: ralf@linux-mips.org
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030720230140Z8224861-1272+3549@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030721124445.13489A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 21 Jul 2003 ralf@linux-mips.org wrote:

> Modified files:
> 	arch/mips      : Makefile 
> 	arch/mips/mm   : Makefile 
> 	arch/mips64    : Makefile 
> Added files:
> 	arch/mips/mm   : tlb-andes.c 
> 	arch/mips/mm-32: Makefile c-sb1.c c-tx39.c cex-gen.S fault.c 
> 	                 init.c pg-r4k.S pg-sb1.c tlb-r4k.c tlb-sb1.c 
> 	                 tlbex-r4k.S 
> 	arch/mips/mm-64: .cvsignore Makefile c-sb1.c fault.c init.c 
> 	                 pg-r4k.c pg-sb1.c tlb-dbg-r4k.c tlb-glue-r4k.S 
> 	                 tlb-glue-sb1.S tlb-r4k.c tlb-sb1.c tlbex-r4k.S 
> Removed files:
> 	arch/mips/mm   : c-sb1.c c-tx39.c cex-gen.S fault.c init.c 
> 	                 pg-r4k.S pg-sb1.c tlb-r4k.c tlb-sb1.c 
> 	                 tlbex-r4k.S 
> 	arch/mips64/mm : .cvsignore Makefile c-r4k.c c-sb1.c cache.c 
> 	                 cerr-sb1.c cex-sb1.S extable.c fault.c init.c 
> 	                 loadmmu.c pg-r4k.c pg-sb1.c pgtable.c sc-ip22.c 
> 	                 sc-r5k.c sc-rm7k.c tlb-andes.c tlb-dbg-r4k.c 
> 	                 tlb-glue-r4k.S tlb-glue-sb1.S tlb-r4k.c 
> 	                 tlb-sb1.c tlbex-r4k.S 
> 
> Log message:
> 	Coarsly sort out 32-bit-only, 64-bit-only and ``portable'' MIPS memory
> 	managment code.  Another few thousand lines of code bite the dust and
> 	it could be even more ...

 Any justifiable reason for getting rid of arch/mips64?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

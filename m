Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2003 15:28:10 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:33719 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225521AbTKYP16>; Tue, 25 Nov 2003 15:27:58 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DA5BA47B41; Tue, 25 Nov 2003 16:27:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id CC1B647607; Tue, 25 Nov 2003 16:27:49 +0100 (CET)
Date: Tue, 25 Nov 2003 16:27:49 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
In-Reply-To: <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.55.0311251623180.6716@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
 <20031121185035.GC8318@linux-mips.org> <Pine.LNX.4.55.0311212021420.32551@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 21 Nov 2003, Maciej W. Rozycki wrote:

> > The kernel is already passing AT_PAGESZ to ELF binaries.  Wouldn't that
> > be sufficient?  Currently it's passing the largest supported page size,
> 
>  Well, AFAICS in glibc it's ld.so that is responsible for interpreting the
> auxiliary vector -- see _dl_aux_init() in elf/dl-support.c.  If the
> dynamic linker isn't run (which is the usual case for static binaries,
> although calling dlopen() from them might complicate things), the
> dl_pagesize variable remains set to zero.  Please prove me wrong if I am
> missing anything.
> 
> > that is 64k.  However this constant is always passed even when a smaller
> > page size is configured.
> 
>  Are you sure?  I can see create_elf_tables() in fs/binfmt_elf.c sets 
> AT_PAGESZ to ELF_EXEC_PAGESIZE, which, in turn, is set in 
> include/asm-mips/elf.h to PAGE_SIZE.  Which is the currently used page 
> size and probably the optimal solution.

 After rebuilding glibc (2.2.5) with the patch applied, the following
program:

#include <stdio.h>
#include <unistd.h>

int main(void)
{
	printf("%u\n", getpagesize());
	return 0;
}

prints "4096" if dynamically linked and "65536" if statically linked on my
system, as expected.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

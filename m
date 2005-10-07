Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 21:55:06 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:6161 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133582AbVJGUyr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 21:54:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 57BEBF5996; Fri,  7 Oct 2005 22:54:40 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10178-04; Fri,  7 Oct 2005 22:54:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 0E642F5969; Fri,  7 Oct 2005 22:54:40 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j97KsjF5002496;
	Fri, 7 Oct 2005 22:54:45 +0200
Date:	Fri, 7 Oct 2005 21:54:57 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Brett Foster <fosterb@uoguelph.ca>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cross-compiling Linux problem
In-Reply-To: <4346DD97.40106@uoguelph.ca>
Message-ID: <Pine.LNX.4.61L.0510072154500.11243@blysk.ds.pg.gda.pl>
References: <002b01c5cb7c$45c181e0$0400a8c0@buzz> <4346DD97.40106@uoguelph.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87/1121/Fri Oct  7 19:38:02 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 7 Oct 2005, Brett Foster wrote:

> > include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlining
> > failed
> > in call to '__fixup_bigphys_addr': function body not available
> > arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
> > make[1]: *** [arch/mips/mm/ioremap.o] Error 1
> > make: *** [arch/mips/mm] Error 2
> > 
> > 
> I once had this sort of problem when I forgot to specify the cross compiler
> while invoking make and tried to compile a MIPS kernel on X86 gcc.

 In this case the header is truly broken -- "extern inline 
__attribute__((always_inline))" is self-contradicting.

  Maciej

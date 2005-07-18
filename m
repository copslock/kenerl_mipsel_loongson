Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2005 17:32:32 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:62219 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226834AbVGRQcQ>; Mon, 18 Jul 2005 17:32:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C213FE1C9A; Mon, 18 Jul 2005 18:33:50 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00548-03; Mon, 18 Jul 2005 18:33:50 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 843D0E1C96; Mon, 18 Jul 2005 18:33:50 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6IGXsF5010423;
	Mon, 18 Jul 2005 18:33:54 +0200
Date:	Mon, 18 Jul 2005 17:34:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	Pete Popov <ppopov@embeddedalley.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Support for (au1100) 64-bit physical address space broken on
 2.6.12?
In-Reply-To: <20050718161949.GB28995@enneenne.com>
Message-ID: <Pine.LNX.4.61L.0507181729050.527@blysk.ds.pg.gda.pl>
References: <20050716124205.GA26127@enneenne.com> <1121528575.27121.3.camel@localhost.localdomain>
 <20050718161949.GB28995@enneenne.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/982/Sun Jul 17 14:45:12 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 Jul 2005, Rodolfo Giometti wrote:

> I get:
> 
>    arch/mips/mm/ioremap.c: In function `__ioremap':
>    include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlining failed in call to '__fixup_bigphys_addr': function body not available
>    arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
>    make[1]: *** [arch/mips/mm/ioremap.o] Error 1
>    make: *** [arch/mips/mm] Error 2

 Well, "extern inline __attribute__((always_inline))" certainly makes no 
sense.  Pete?

  Maciej

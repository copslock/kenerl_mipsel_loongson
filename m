Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 14:10:08 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:48402 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224979AbVHZNJv>; Fri, 26 Aug 2005 14:09:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E7B84F59A9; Fri, 26 Aug 2005 15:09:54 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11235-04; Fri, 26 Aug 2005 15:09:54 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A1145F59A1; Fri, 26 Aug 2005 15:09:54 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j7QD9v7o027366;
	Fri, 26 Aug 2005 15:09:58 +0200
Date:	Fri, 26 Aug 2005 14:10:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: patch / rfc
In-Reply-To: <1125006681.14435.1065.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0508261340460.9561@blysk.ds.pg.gda.pl>
References: <1125006681.14435.1065.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1042/Fri Aug 26 10:00:27 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 25 Aug 2005, Pete Popov wrote:

> This is an experimental (though tested) patch for early ioremap support
> on mips, before mem_init runs. Something like this is only needed on
> certain SoCs that have all of their I/O on high addresses such that they
> can't me ioremapped through kseg1.

 Hmm, wouldn't a temporary large page and a wired TLB entry be an easier 
solution?  Somebody designing these SoCs must have taken such an approach 
into account when deciding to put I/O devices outside the space that's 
directly accessible through unmapped spaces, so I'd expect them all to be 
reachable in a single page of the largest size supported by a given 
implementation.  Especially as not all software is expected to implement 
fully-featured page management.  This entry would of course be no longer 
available after the final paging setup (TLBs tend to be too small for 
entries to be wasted).

> I think the CONFIG_64 stuff needs to removed since we don't need it. The
> patch was tested on a MIPS32 CPU only. Some of the significant changes:

 Well, MIPS64 has XPHYS, so there is no need for going through paging for 
ioremap() at all.

> - trap_init() became early_trap_init() since too much stuff happens
> there that is needed to support early ioremap. The old trap_init() is
> now empty.

 That just provides a strong suggestion considering an alternative 
approach, such as one proposed above is not a bad idea -- this changes the 
order subsystems are initialized for the MIPS platform, which makes it 
different from all the others and therefore problematic.

> - added plat_setup_late() call. All ports would need to add that call,
> or at least a placeholder. Early ioremap is possible only at that point.
> However, most of the code in each plat_setup() can be moved to
> plat_setup_late()

 Which means it should rather be a function pointer initialized somewhere 
earlier, possibly in plat_setup() and then:

static void __init null_plat_setup_late(void) { }
void (*plat_setup_late)(void) __initdata = null_plat_setup_late;
[...]
	plat_setup_late()

or:

void (*plat_setup_late)(void);
[...]
	if (plat_setup_late)
		plat_setup_late()

or something like that.

  Maciej

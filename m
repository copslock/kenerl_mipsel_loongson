Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 16:19:55 +0100 (BST)
Received: from smtp101.biz.mail.mud.yahoo.com ([IPv6:::ffff:68.142.200.236]:41348
	"HELO smtp101.biz.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8224980AbVHZPTb>; Fri, 26 Aug 2005 16:19:31 +0100
Received: (qmail 78643 invoked from network); 26 Aug 2005 15:25:03 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 26 Aug 2005 15:25:03 -0000
Subject: Re: patch / rfc
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61L.0508261340460.9561@blysk.ds.pg.gda.pl>
References: <1125006681.14435.1065.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0508261340460.9561@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 26 Aug 2005 08:24:57 -0700
Message-Id: <1125069898.14435.1215.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-08-26 at 14:10 +0100, Maciej W. Rozycki wrote:
> On Thu, 25 Aug 2005, Pete Popov wrote:
> 
> > This is an experimental (though tested) patch for early ioremap support
> > on mips, before mem_init runs. Something like this is only needed on
> > certain SoCs that have all of their I/O on high addresses such that they
> > can't me ioremapped through kseg1.
> 
>  Hmm, wouldn't a temporary large page and a wired TLB entry be an easier 
> solution?  

Yes, you can do that. It's just not as nice and the problem is that you
either have to remember these wired mappings, flush them later, and
properly ioremap them, or forever use up a few tlbs.

> Somebody designing these SoCs must have taken such an approach 
> into account when deciding to put I/O devices outside the space that's 
> directly accessible through unmapped spaces, so I'd expect them all to be 
> reachable in a single page of the largest size supported by a given 
> implementation.  

They may or may not be reachable with a single tlb. I've twice now seen
new SoCs with a huge I/O address range. There may or may not be a good
reason for this but we are not always hired early enough to change the
design.

> Especially as not all software is expected to implement 
> fully-featured page management.  This entry would of course be no longer 
> available after the final paging setup (TLBs tend to be too small for 
> entries to be wasted).

Right.

> > I think the CONFIG_64 stuff needs to removed since we don't need it. The
> > patch was tested on a MIPS32 CPU only. Some of the significant changes:
> 
>  Well, MIPS64 has XPHYS, so there is no need for going through paging for 
> ioremap() at all.

Right. I can easily change that.

> > - trap_init() became early_trap_init() since too much stuff happens
> > there that is needed to support early ioremap. The old trap_init() is
> > now empty.
> 
>  That just provides a strong suggestion considering an alternative 
> approach, such as one proposed above is not a bad idea -- this changes the 
> order subsystems are initialized for the MIPS platform, which makes it 
> different from all the others and therefore problematic.

Well, yes and no. On PowerPC, they do all this ahead of trap_init so
their trap_init is empty as well. Looking at the code, I just don't see
any reason why we can't do that init earlier.

> > - added plat_setup_late() call. All ports would need to add that call,
> > or at least a placeholder. Early ioremap is possible only at that point.
> > However, most of the code in each plat_setup() can be moved to
> > plat_setup_late()
> 
>  Which means it should rather be a function pointer initialized somewhere 
> earlier, possibly in plat_setup() and then:
> 
> static void __init null_plat_setup_late(void) { }
> void (*plat_setup_late)(void) __initdata = null_plat_setup_late;
> [...]
> 	plat_setup_late()
> 
> or:
> 
> void (*plat_setup_late)(void);
> [...]
> 	if (plat_setup_late)
> 		plat_setup_late()
> 
> or something like that.

Sure, we can do that.

Thanks,

Pete

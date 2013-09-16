Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2013 07:54:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41038 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817258Ab3IPFyzO6Tee (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Sep 2013 07:54:55 +0200
Date:   Mon, 16 Sep 2013 06:54:55 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
In-Reply-To: <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1309160606110.2176@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org> <20130905180825.GB11592@linux-mips.org> <alpine.LFD.2.03.1309052118560.11570@linux-mips.org> <20130907073450.GE11592@linux-mips.org> <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, 7 Sep 2013, Maciej W. Rozycki wrote:

> > >  Unfortunately that can't be said of the 64-bit kernel that hangs solidly 
> > > (reset does not help, need to power-cycle) early on, after:
> > > 
> > > Linux version 3.11.0-rc2 (macro@tp) (gcc version 4.1.2) #1 Sun Sep 1 18:06:20 BST 2013
> > > bootconsole [prom0] enabled
> > > 
> > > has been printed.  The next line should be:
> > > 
> > > This is a DECstation 5000/2x0
> > 
> > No idea why this might be hanging.  You might try git-bisect, if that's
> > not too painful?
> 
>  Given that printk works and it's just a couple of lines to examine I 
> think I'll do it in the old fashion. ;)

 So it turned out harder to debug than I anticipated and I resorted to 
`git-bisect' after all.  That took several hours, including the fun of 
figuring out how to actually make the states of the tree chosen by `git' 
(or any nearby candidates) build at all -- the period covered was clearly 
the dark age of DECstation support.

 Eventually I tracked it down to 231a35d37293ab88d325a9cb94e5474c156282c0 
that introduced an incompatible copy of arch/mips/dec/prom/call_o32.S in 
arch/mips/fw/lib/, built unconditionally.  The copy happens to land 
earlier of the two among the modules used in the link and is therefore 
chosen for the DECstation rather than the intended original.  As a result 
random kernel data is corrupted because a pointer to the "%s" formatted 
output template is used as a temporary stack pointer rather than being 
passed down to prom_printf.  This also explains why prom_printf still 
works, up to a point -- the next argument is the actual string to output 
so it works just fine as the output template until enough kernel data has 
been corrupted to cause a crash.

 Now that the cause is known it is straightforward to correct one way or 
another -- the only question remaining is which one to choose.

 Thomas, what was the rationale behind arranging things in this way?  Did 
you mean to make this code shared among platforms needing it?  I would 
guess so, but then the copy in arch/mips/dec/prom/ would have to be 
removed and macros in <asm/dec/prom.h> adjusted according to the new API 
which you didn't do in your change.  Also why the need for stack 
switching?  It looks like an unnecessary complication to me, any firmware 
callbacks exported have to maintain stack integrity or they would be 
unusable.  Is that to work around some SNI firmware quirk?

 [And does it work for the SNI in the first place? -- it looks to me like 
`o32_stk' has an alignment problem (8 is required for the stack pointer in 
the o32 ABI though 4 will often be enough to satisfy hardware); but 
perhaps it just happens to get correct alignment by virtue of merely 
always following a data object that enforces it, hmm...]

 No wonder it was so weird to debug, and I guess I need to build the 
64-bit config a bit more often...

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 18:33:47 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:37358 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225262AbTFMRdn>;
	Fri, 13 Jun 2003 18:33:43 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5DHXep10071;
	Fri, 13 Jun 2003 10:33:40 -0700
Date: Fri, 13 Jun 2003 10:33:40 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	jsun@mvista.com
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030613103340.D9837@mvista.com>
References: <20030613135835Z8225250-1272+2544@linux-mips.org> <Pine.GSO.4.21.0306131617210.13821-100000@vervain.sonytel.be> <20030613143049.GA27401@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030613143049.GA27401@linux-mips.org>; from ralf@linux-mips.org on Fri, Jun 13, 2003 at 04:30:49PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2003 at 04:30:49PM +0200, Ralf Baechle wrote:
> On Fri, Jun 13, 2003 at 04:19:46PM +0200, Geert Uytterhoeven wrote:
> 
> > Is this really a good idea? You moved board-specific code (`everything related
> > to one board in a single dir') into one directory? So for a new port, you now
> > have to add a arch/mips/<board>/ directory, and add files to arch/mips/pci/.
> > 
> > I agree that extracting common parts and cleaning up the code is a good idea,
> > though.
> 
> It's just toooo much to do in one step, expect forther moving of code
> to get everything to it's final place.  The amount of code that was
> being duplicated was just insane and trying to sort boards by chipset
> was part of the evil.  So MIPS's boards may come with one of several
> PCI chipsets and the Lasat systems may have either a NEC Nile4 or a
> Galileo 64120 chipset.  Result?  Each was duplicating the code to support
> both chipsets into it's arch/mips/foo/ code.  Similar things with code
> to support various firmware such as PMON etc.
> 
> Anyway, suggestions welcome,
>

Ralf and I chatted a little before the change.  I think this _may_ be
a good thing.  It does not hurt to give it whirl first.

I was trying to promote chipset based grouping, like gt64120/ or ddb5xxx/, 
but apparently not everybody likes that.  People are still going with 
company or machine based grouping, which makes chipset code sharing impossible.

I also realize that chipset based grouping (and sharing) requires more
design and synchronization between developers, and thus probably harder
to do.  So in that sense, arch/mips/pci, as a less restrictive mechnism
for sharing, might work better.

So I like to view arch/mips/pci as some PCI library routines for 
chipsets instead of another place for board-specific code to live.

Jun

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 19:57:01 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:61390 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225262AbTFMS47>;
	Fri, 13 Jun 2003 19:56:59 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5DIunpI006151;
	Fri, 13 Jun 2003 20:56:49 +0200 (MEST)
Date: Fri, 13 Jun 2003 20:56:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030613103340.D9837@mvista.com>
Message-ID: <Pine.GSO.4.21.0306132052290.14094-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 13 Jun 2003, Jun Sun wrote:
> On Fri, Jun 13, 2003 at 04:30:49PM +0200, Ralf Baechle wrote:
> > On Fri, Jun 13, 2003 at 04:19:46PM +0200, Geert Uytterhoeven wrote:
> > > Is this really a good idea? You moved board-specific code (`everything related
> > > to one board in a single dir') into one directory? So for a new port, you now
> > > have to add a arch/mips/<board>/ directory, and add files to arch/mips/pci/.
> > > 
> > > I agree that extracting common parts and cleaning up the code is a good idea,
> > > though.
> > 
> > It's just toooo much to do in one step, expect forther moving of code
> > to get everything to it's final place.  The amount of code that was
> > being duplicated was just insane and trying to sort boards by chipset
> > was part of the evil.  So MIPS's boards may come with one of several
> > PCI chipsets and the Lasat systems may have either a NEC Nile4 or a
> > Galileo 64120 chipset.  Result?  Each was duplicating the code to support
> > both chipsets into it's arch/mips/foo/ code.  Similar things with code
> > to support various firmware such as PMON etc.
> > 
> > Anyway, suggestions welcome,
> 
> Ralf and I chatted a little before the change.  I think this _may_ be
> a good thing.  It does not hurt to give it whirl first.
> 
> I was trying to promote chipset based grouping, like gt64120/ or ddb5xxx/, 
> but apparently not everybody likes that.  People are still going with 
> company or machine based grouping, which makes chipset code sharing impossible.
> 
> I also realize that chipset based grouping (and sharing) requires more
> design and synchronization between developers, and thus probably harder
> to do.  So in that sense, arch/mips/pci, as a less restrictive mechnism
> for sharing, might work better.
> 
> So I like to view arch/mips/pci as some PCI library routines for 
> chipsets instead of another place for board-specific code to live.

That's fine!  I just didn't realize there was that much chipset sharing between
the different boards. E.g. for Vr41xx, all board code is already in subdirs
within the vr41xx directory.

So in the future we may see something like this:

  arch/mips/chipset1/...
           /chipset2/...
	   /...
	   /board1/...
	   /board2/...

where the board* directories contain the glue code for the specific boards?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

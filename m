Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2003 15:30:57 +0100 (BST)
Received: from p508B7C8B.dip.t-dialin.net ([IPv6:::ffff:80.139.124.139]:32693
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbTFMOay>; Fri, 13 Jun 2003 15:30:54 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5DEUobY027588;
	Fri, 13 Jun 2003 07:30:50 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5DEUnPq027587;
	Fri, 13 Jun 2003 16:30:49 +0200
Date: Fri, 13 Jun 2003 16:30:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030613143049.GA27401@linux-mips.org>
References: <20030613135835Z8225250-1272+2544@linux-mips.org> <Pine.GSO.4.21.0306131617210.13821-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0306131617210.13821-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2003 at 04:19:46PM +0200, Geert Uytterhoeven wrote:

> Is this really a good idea? You moved board-specific code (`everything related
> to one board in a single dir') into one directory? So for a new port, you now
> have to add a arch/mips/<board>/ directory, and add files to arch/mips/pci/.
> 
> I agree that extracting common parts and cleaning up the code is a good idea,
> though.

It's just toooo much to do in one step, expect forther moving of code
to get everything to it's final place.  The amount of code that was
being duplicated was just insane and trying to sort boards by chipset
was part of the evil.  So MIPS's boards may come with one of several
PCI chipsets and the Lasat systems may have either a NEC Nile4 or a
Galileo 64120 chipset.  Result?  Each was duplicating the code to support
both chipsets into it's arch/mips/foo/ code.  Similar things with code
to support various firmware such as PMON etc.

Anyway, suggestions welcome,

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2003 23:16:05 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:32568
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225531AbTJUWQD>; Tue, 21 Oct 2003 23:16:03 +0100
Received: from ares.mmc.atmel.com (ares.mmc.atmel.com [10.127.240.37])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id SAA09380;
	Tue, 21 Oct 2003 18:15:56 -0400 (EDT)
Received: from localhost (dkesselr@localhost)
	by ares.mmc.atmel.com (8.9.3/8.9.3) with ESMTP id SAA14660;
	Tue, 21 Oct 2003 18:15:56 -0400 (EDT)
X-Authentication-Warning: ares.mmc.atmel.com: dkesselr owned process doing -bs
Date: Tue, 21 Oct 2003 18:15:56 -0400 (EDT)
From: David Kesselring <dkesselr@mmc.atmel.com>
To: Jeff Angielski <jeff@theptrgroup.com>
cc: linux-mips@linux-mips.org
Subject: Re: module dependency files
In-Reply-To: <1066771519.3289.45.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.44.0310211814340.14473-100000@ares.mmc.atmel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

That's what I did. I defined INSTALL_MOD_PATH as $(TOPDIR)/modules. The
modules get put there but depmod fails.

On 21 Oct 2003, Jeff Angielski wrote:

> >From the Linux kernel Makefile...
>
> #
> # INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
> # relocations required by build roots.  This is not defined in the
> # makefile but the arguement can be passed to make if needed.
> #
>                                                                                 Just set this to the location of your target filesystem when you do the modules_install.
>
> Jeff Angielski
> The PTR Group
>
> On Tue, 2003-10-21 at 17:22, David Kesselring wrote:
> > I have now gotten the modules to build but there is one part of the
> > process that doesn't work. On my pc I want to build all of the files which
> > are to be installed on the mips board. I am trying to create the files
> > which can be copied onto (or into) the redhat 7.3 miniport. "make modules"
> > works fine. It seems like I need to run "make modules_install" but it
> > complains about the .o files being the wrong architecture. So the basic
> > question seems to be how can I run depmod on the pc for mips?
> > Thanks again.
> >
> > David Kesselring
> > Atmel MMC
> > dkesselr@mmc.atmel.com
> > 919-462-6587
> >
>
>

David Kesselring
Atmel MMC
dkesselr@mmc.atmel.com
919-462-6587

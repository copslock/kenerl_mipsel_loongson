Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA85038 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Oct 1998 09:16:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA50275
	for linux-list;
	Thu, 8 Oct 1998 09:15:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA54570
	for <linux@engr.sgi.com>;
	Thu, 8 Oct 1998 09:14:58 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA05232
	for <linux@engr.sgi.com>; Thu, 8 Oct 1998 09:14:56 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from newshost (root@newshost.uni-koblenz.de [141.26.4.18])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with SMTP id SAA22294
	for <linux@engr.sgi.com>; Thu, 8 Oct 1998 18:14:41 +0200 (MET DST)
Received: from lappi.waldorf-gmbh.de by newshost (SMI-8.6/KO-2.0)
	id SAA24598; Thu, 8 Oct 1998 18:14:39 +0200
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id RAA09608;
	Thu, 8 Oct 1998 17:03:35 +0200
Message-ID: <19981008170335.H4058@uni-koblenz.de>
Date: Thu, 8 Oct 1998 17:03:35 +0200
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: Tags are dead alias Milo is dead part II
References: <19981007002547.44731@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981007002547.44731@alpha.franken.de>; from Thomas Bogendoerfer on Wed, Oct 07, 1998 at 12:25:47AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Oct 07, 1998 at 12:25:47AM +0200, Thomas Bogendoerfer wrote:

> In the process of making Milo obsolete I've also removed tags stuff. This
> was simple for the Indy and took only a few hours for the Olivetti. I hope
> it's also possible for the Decstation. Before I'll start commiting the changes
> we should make sure, how to solve the missing tags for all plattforms.
> 
> Another old code, which might be obsolete now is the wired entry stuff
> in arch/mips/kernel/head.S. It's already disabled for R4k CPUs and
> I would prefer to remove that stuff also for the other CPUs. If you
> need wired entries, I would propose using the add_wired_entry()
> function as I already do it for the JAZZ hardware (arch/mips/jazz/setup.c).

People should consider that TLB entries are a scarce resource.  Wiring them
can seriously impact performance.  (Which reminds me of the lock warning
bit in the 68851 - Moto people we seriously assuming somebody could wire all
ATC (that is TLB in Moto slang) entries ...)

Our current 32 bit page table structure is good for mapping everything in
the lowest 4gb of physical address space.  Things outside of this area are
the only things which will need to be mapped by some other mean.  We've
so far used wired entries which in most cases they're a bad idea for the
above mentioned reason.  Since loading and flushing a single TLB entry is
a quite cheap thing on MIPS parts of the kernel could do things like

	struct wired {
		caddr_t physical;
		caddr_t virtual;
		u32	mask;
		u32	usage;
		u8 entry;
	} gfx_entry = {
		GFX_PBASE,
		GFX_VBASE,
		PM_4M
	};

	entry = load_wired_entry(&gfx_entry);

	... /* Munge mapped address space */

	flush_wired_entry(entry);

Applied to the G364 drivers (which as of now is still MIPS specific anyway)
this means that we'll avoid TLB trashing in the case of scrolling and have
the full TLB available for userland.

The second alternative which can be used where it's ok to disable interrupts
is to access memory using one of the XKPHYS segments.

  Ralf

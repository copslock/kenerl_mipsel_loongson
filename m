Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6Q0GUK22097
	for linux-mips-outgoing; Wed, 25 Jul 2001 17:16:30 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6Q0GSO22093
	for <linux-mips@oss.sgi.com>; Wed, 25 Jul 2001 17:16:28 -0700
Received: from ayrnetworks.com (IDENT:phil@bagpipe.ayrnetworks.com [10.1.1.149])
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f6PNihr17703;
	Wed, 25 Jul 2001 16:44:43 -0700
Message-ID: <3B5F5A18.F94328CB@ayrnetworks.com>
Date: Wed, 25 Jul 2001 16:45:28 -0700
From: Phil Hopely <phil@ayrnetworks.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Jhun <wjhun@ayrnetworks.com>
CC: "John D. Davis" <johnd@stanford.edu>,
   Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Replacing the Console driver
References: <Pine.LNX.4.21.0107251604280.12368-100000@earth.ayrnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

William Jhun wrote:

> Hi Phil :o),
>
> The only problem with pure emulation is writing a good emulator for an
> MMU. I wrote a SPARC V8 instruction set emulator a year ago and stopped
> around the time I had to face the fact that a direct virtual->physical
> mapping would no longer be of any use. (also the semester started again
> :o). Not that it's not possible, but it's difficult and would require a
> mapping with every memory access (being very slow). However, a little
> creative help from the kernel and some creative mmap()ing might do the job
> (you can request a specific linear address with mmap()). If anyone knows
> some good methods for doing this, please inform! (and I might finish that
> emulator :o)
>
> William
>

:)  yep, you are right - the r3000 core in the mame sources I am perusing do not
implement an mmu
(the playstation and williams standups use "a custom r3000a by LSI Logic" - see
src/cpu/mips/mips.c - no cache mechanism either).

Poking around the mame sources (I've got xmame b13 r1 - ancient really, from sometime
late 1999 I think), it appears that the z180 cpu is the only core that has some kind
of mmu emulation.  The z8k & m68k also have mmu instructions, but those were not
emulated in this version of mame...

I haven't checked more recent versions, but I think recent mess (uses same cpu cores
as mame) supports early macs, so there may be an implementation example there?..


Phil


>
> On Wed, 25 Jul 2001, Phil Hopely wrote:
>
> >
> > I do not know if you have examined any of the current open source emulation
> > projects that exist, but I believe
> > you might be interested to examine www.mame.net or mess.emuverse.com?
> >
> > They have a cpu core for mips emulation, I believe it may only be r3000
> > though?..
> >
> > Also, there exist numerous open-source playstation emulators, which I believe
> > are r3000 based too...
> >
> > The mame & mess projects are matured open-source projects that have been ported
> > across the universe, they're really pretty cool, this work would be a likely fit
> > with the mess project.
> >
> > If you implement by way of pure emulation, you'd not need to change the kernel
> > at all?
> >
> > Phil
> >
> > "John D. Davis" wrote:
> >
> > > I am modifying the linux kernel to be able to be run by a simulator.  I
> > > need to modify the console driver and interrupt handler.  I have been
> > > going through the various files, console.*, tty.* and the serial files to
> > > see how to interface to the console.  I have also read some kernel korner
> > > articles, but they seem a little out of date.  Is there any other
> > > recommended documentation on the console driver and how it works on an
> > > indy? I am trying to sort out the low-level interfaces from the
> > > higher-level ones.  I just need to change the low-level interface from
> > > using the hardware to using the simulator interface.
> > >
> > > thanks,
> > > john
> > >
> > > --
> > > To UNSUBSCRIBE, email to debian-mips-request@lists.debian.org
> > > with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> >

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6PNDe714616
	for linux-mips-outgoing; Wed, 25 Jul 2001 16:13:40 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6PNDcO14607
	for <linux-mips@oss.sgi.com>; Wed, 25 Jul 2001 16:13:38 -0700
Received: from localhost (wjhun@localhost)
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f6PNCRb17172;
	Wed, 25 Jul 2001 16:12:27 -0700
Date: Wed, 25 Jul 2001 16:12:27 -0700 (PDT)
From: William Jhun <wjhun@ayrnetworks.com>
To: Phil Hopely <phil@ayrnetworks.com>
cc: "John D. Davis" <johnd@stanford.edu>,
   Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Replacing the Console driver
In-Reply-To: <3B5F43EC.2B03E744@ayrnetworks.com>
Message-ID: <Pine.LNX.4.21.0107251604280.12368-100000@earth.ayrnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Phil :o),

The only problem with pure emulation is writing a good emulator for an
MMU. I wrote a SPARC V8 instruction set emulator a year ago and stopped
around the time I had to face the fact that a direct virtual->physical
mapping would no longer be of any use. (also the semester started again
:o). Not that it's not possible, but it's difficult and would require a
mapping with every memory access (being very slow). However, a little
creative help from the kernel and some creative mmap()ing might do the job
(you can request a specific linear address with mmap()). If anyone knows
some good methods for doing this, please inform! (and I might finish that
emulator :o)

William

On Wed, 25 Jul 2001, Phil Hopely wrote:

> 
> I do not know if you have examined any of the current open source emulation
> projects that exist, but I believe
> you might be interested to examine www.mame.net or mess.emuverse.com?
> 
> They have a cpu core for mips emulation, I believe it may only be r3000
> though?..
> 
> Also, there exist numerous open-source playstation emulators, which I believe
> are r3000 based too...
> 
> The mame & mess projects are matured open-source projects that have been ported
> across the universe, they're really pretty cool, this work would be a likely fit
> with the mess project.
> 
> If you implement by way of pure emulation, you'd not need to change the kernel
> at all?
> 
> Phil
> 
> "John D. Davis" wrote:
> 
> > I am modifying the linux kernel to be able to be run by a simulator.  I
> > need to modify the console driver and interrupt handler.  I have been
> > going through the various files, console.*, tty.* and the serial files to
> > see how to interface to the console.  I have also read some kernel korner
> > articles, but they seem a little out of date.  Is there any other
> > recommended documentation on the console driver and how it works on an
> > indy? I am trying to sort out the low-level interfaces from the
> > higher-level ones.  I just need to change the low-level interface from
> > using the hardware to using the simulator interface.
> >
> > thanks,
> > john
> >
> > --
> > To UNSUBSCRIBE, email to debian-mips-request@lists.debian.org
> > with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> 

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VIr9G01891
	for linux-mips-outgoing; Thu, 31 Jan 2002 10:53:09 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VIqsd01886
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 10:52:54 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0VHopB26369;
	Thu, 31 Jan 2002 09:50:51 -0800
Subject: Re: More data: I've made a CVS build that doesn't crash!
From: Pete Popov <ppopov@pacbell.net>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <20020131013038.A3729@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIEEDACFAA.mdharm@momenco.com>
	<1012445753.1463.8.camel@zeus>  <20020131013038.A3729@momenco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 31 Jan 2002 09:53:55 -0800
Message-Id: <1012499635.1448.23.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-01-31 at 01:30, Matthew Dharm wrote:
> Well, discontiguous memory works on all other arches I know (PPC and x86,
> at least), so why not here too?

PPC and x86 are unfortunately ahead of mips in some areas.  For one,
there's a lot more cheap hardware out there for developers to play with
and thus more developers.  Not many hackers can afford to shell out
$3-$5k for a ref board.   We definitely need something like the Sony PS2
to attract more mips developers, I think.  But I digress.  

I could be wrong but I thought you need explicit support for
discontiguous memory.   "find . -name *.[ch] |xarsg grep
CONFIG_DISCONTIGMEM"  doesn't show anything in arch/mips, though there
appears to be support for some mips64 target(s).  Like I said though, I
could be wrong, but do check with someone who knows before you waste too
much time down that path.

Pete
 
> Matt
> 
> On Wed, Jan 30, 2002 at 06:55:52PM -0800, Pete Popov wrote:
> > On Wed, 2002-01-30 at 18:45, Matthew Dharm wrote:
> > > (I aplogize for the duplicate... this message has more information
> > > than the other one... Outlook decided that I meant "send" not
> > > "paste"... grr...)
> > > 
> > > Well, I've figured out my crashing problem, but I'm not certain how to
> > > fix it... I've got a couple of choices, and my first choice doesn't
> > > seem to work too well, tho I'm not sure if that's my fault or another
> > > bug...
> > > 
> > > Basically, what happens is this:  The SDRAM is in two banks (0,2) in
> > > equal parts.  So, on our 128MByte boards, it's two banks of 64MBytes.
> > > On our 512MByte boards, it's 2 banks of 256MBytes each.
> > > 
> > > The bridge is programmed to place the first bank at 0x0, and the other
> > > bank at 256MBytes.  add_memory_region() is called earlier in the boot
> > > sequence to set up the first 64MBytes at address 0.  Now we call
> > > add_memory_region() with incorrect parameters.
> > > 
> > > So, I thought to myself, let's just change the 'start' address of the
> > > add_memory_region() call.  For good luck, I even threw in some calls
> > > with BOOT_MEM_RESERVED, so we now have (printed on bootup):
> > 
> > Can you actually do that and have discontiguous memory work??  Why don't
> > you program the bridge based on your memory size, so that it would place
> > the first mem module at 0 and the second at 64MB?
> > 
> > Pete
> >  
> > > Determined physical RAM map:
> > >  memory: 04000000 @ 00000000 (usable)
> > >  memory: 0c000000 @ 04000000 (reserved)
> > >  memory: 04000000 @ 10000000 (usable)
> > >  memory: 0c000000 @ 14000000 (reserved)
> > > 
> > > Which looks okay to me.  The problem is, my ethernet driver has gone
> > > to the dogs.  It works, but it's _really_ slow and the console is
> > > printing out messages like:
> > > 
> > > eth0: Transmit timed out: status 0050  0c00 at 9710/9738 command
> > > 00000c00.
> > > eth0: Transmit timed out: status 0050  0c00 at 9745/9773 command
> > > 00000c00.
> > > eth0: Transmit timed out: status 0050  0c00 at 9801/9829 command
> > > 00000c00.
> > > 
> > > I'm guessing that something bad has happened in terms of what part of
> > > memory the ethernet controller allocates for it's descriptors... or
> > > something like that.  The fact that it works at all is puzzling.. I
> > > would have expected a more fatal mode of failure.
> > > 
> > > So, am I doing something wrong in setting up my memory map?  Is there
> > > something else I need to do when calling add_memory_region()?
> > > 
> > > Also, how are DMAable addresses handed out?  I'm wondering if the
> > > conversion between CPU address and PCI address is working correctly...
> > > I'm going to try to get a PCI analyizer, but I don't know how long
> > > that will take.
> > > 
> > > Thanks everyone for all your help... hopefully, I'll have this problem
> > > put to bed soon.
> > > 
> > > Matthew Dharm
> > > 
> > > --
> > > Matthew D. Dharm                            Senior Software Designer
> > > Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> > > (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> > > Momentum Works For You                      www.momenco.com
> > > 
> > > > -----Original Message-----
> > > > From: Pete Popov [mailto:ppopov@pacbell.net]
> > > > Sent: Wednesday, January 30, 2002 5:35 PM
> > > > To: Matthew Dharm
> > > > Cc: linux-mips
> > > > Subject: RE: More data: I've made a CVS build that doesn't crash!
> > > >
> > > >
> > > > On Wed, 2002-01-30 at 17:23, Matthew Dharm wrote:
> > > > > Well, I'm closer... and more confused.
> > > > >
> > > > > I've managed to make a 2.4.3 build which does not exhibit
> > > > any of the
> > > > > instability or crashing... but I did it by disabling half of the
> > > > > memory!
> > > > >
> > > > > In linux/arch/mips/gt64120/momenco_ocelot/setup.c is some
> > > > code to read
> > > > > a PLD and add a memory region.  64MByte is already added
> > > > much earlier,
> > > > > and now we're adding the rest.  The board I'm testing on
> > > > is 128MByte,
> > > > > so it tries to add another 64MByte region which is physically
> > > > > contiguous to the first region.
> > > > >
> > > > > As far as I can tell, all of my memory works perfectly.
> > > > I'm going to
> > > > > do some more tests, but both vxWorks and OpenBSD run on this board
> > > > > without any problems.
> > > > >
> > > > > So, can anyone think of some likely culprits for what is
> > > > wrong here?
> > > > > Some piece of code which only works with addresses under 64MByte,
> > > > > perhaps?
> > > >
> > > > And 2.4.2 works with all of the memory?
> > > >
> > > > Pete
> > > >
> > > 
> > 
> 
> -- 
> Matthew Dharm                              Work: mdharm@momenco.com
> Senior Software Designer, Momentum Computer
> 

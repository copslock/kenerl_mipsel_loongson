Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHLFLK00562
	for linux-mips-outgoing; Mon, 17 Dec 2001 13:15:21 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBHLFHo00555
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 13:15:17 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fBHKFFR05569
	for linux-mips@oss.sgi.com; Mon, 17 Dec 2001 15:15:15 -0500
Date: Mon, 17 Dec 2001 15:15:15 -0500
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011217151515.A9188@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf, perhaps you (or someone else here) can help:

> From: Pete Popov <ppopov@mvista.com>
> To: jim@jtan.com
>
> On Sun, 2001-12-16 at 18:37, Jim Paris wrote:
> > I'm confused.  Shouldn't ioremap use isa_slot_offset for ISA
> > addresses, and if not, why not?  Where should isa_slot_offset go?  It
> > can't go into read[bwl]/write[bwl], because ioremap would add KSEG1,
> > and isa_slot_offset would already include KSEG1.
> 
> What would be considered an ISA address -- the standard PC definition? 
> I don't think that would work on most mips boards.
> 
> I'm not sure what isa_slot_offset is meant to do at all.  Shoot Ralf an
> email, perhaps he has a clear explanation (and then let us know :-)). 

If I make ioremap use isa_slot_offset for addresses under 16MB, then
PCMCIA works for me.  I don't see any other way to get isa_slot_offset
in there without hacking PCMCIA in ways that break other arches.

--

On a somewhat related note, I've noticed that if I include IDE disk
support in my kernel (CONFIG_BLK_DEV_IDEDISK, ide-disk.o), then stuff
breaks; most noticibly, the PCMCIA IRQ scan returns the negative (!)
of the correct values.  I'm guessing this is something miscompiling --
I'm using the latest binutils plus gcc-3.0.2 -- has anyone see these
problems with ide-disk?  Or can you suggest a newer gcc CVS that
you've used successfully?  (I suppose I should set up gdb and try to
find where the problem is, but I'm in the middle of finals right now
and won't have time to do that for a while)

-jim

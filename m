Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 11:03:31 +0100 (BST)
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:55266 "EHLO
	stout.engsoc.carleton.ca") by ftp.linux-mips.org with ESMTP
	id S20021393AbZDWKDX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 11:03:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id A33F05840BA;
	Thu, 23 Apr 2009 06:03:14 -0400 (EDT)
Received: from stout.engsoc.carleton.ca ([127.0.0.1])
	by localhost (stout.engsoc.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSLprWedgyNW; Thu, 23 Apr 2009 06:03:14 -0400 (EDT)
Received: from mobius.cowpig.ca (cowpig.ca [134.117.69.79])
	by stout.engsoc.carleton.ca (Postfix) with ESMTP id 747265840B9;
	Thu, 23 Apr 2009 06:03:14 -0400 (EDT)
Received: by mobius.cowpig.ca (Postfix, from userid 1000)
	id C959416018B; Thu, 23 Apr 2009 06:03:12 -0400 (EDT)
Date:	Thu, 23 Apr 2009 06:03:12 -0400
From:	Philippe Vachon <philippe@cowpig.ca>
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
Message-ID: <20090423100312.GC6138@cowpig.ca>
References: <20090422063747.GA2009@cowpig.ca> <m363gxgic8.fsf@anduin.mandriva.com> <20090422161631.GA2317@cowpig.ca> <m3skjzg4mk.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3skjzg4mk.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.9i
Return-Path: <philippe@cowpig.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippe@cowpig.ca
Precedence: bulk
X-list: linux-mips

Hi,

Please refer to this mess -- 
http://lebesgue.cowpig.ca/~philippe/gdium/0001-Clean-up-Lemote-Loongson-2-Support.patch -- 
for my subsequent commentary. This is what I would envision being moved 
upstream eventually, and how I think Loongson support would eventually best 
be structured. This adds basic support for the Emtec Gdium as well as the 
Fulong. I created a special case for the Menglan, but it doesn't do
anything particularily different from the Fulong other than change what
the machine name is in /proc/cpuinfo.

I've been working on this with the following goals in mind:
- Determine what functionality is specific to a particular platform and
  split it off elsewhere.
- Build up a directory of code common to the Loongson 2 "series" of
  CPUs.
- Attempt to move away from anything using CKSEG1ADDR(); this is far
  from complete. Ralf will gut me if I try to submit a patch using
  CKSEG1ADDR().
- Attempt to unify the Loongson 2E/F register names in their own header.
  One thing I've noticed is that where there was a Bonito register it
  would be used -- otherwise, the 'raw' number would be cast to a
  pointer and dereferenced!
- Try to build a framework on which a new Loongson 2E/2F/2G(?) machines
  could be added quickly. I actually did that with the Gdium, borrowing
  some of the existing code Mandriva and Lemote have done for it.

Of course, at a glance you'll see it's far from being ready to be
submitted upstream -- and I need to do a rebase or two to make it a
little more pallatable, given the size of the patch.

I've laid out the directories as follows:

arch/mips/
	+- loongson/
	|	+- common/ /* common code */
	|	+- gdium/    /* all the other directories are for */
	|	+- fulong-2e /* particular platforms */
	|
	...
	+- include/asm/
		+- mach-loongson/ 
			/* platform-specific headers */
			+- fulong-2e/
			+- gdium/

On Thu, Apr 23, 2009 at 10:23:47AM +0200, Arnaud Patard wrote:
> That's not a good reason to repeat wrong naming from the
> past. Moverover, Lemote is trying to get 2f support merged so I would
> say that you're pessimistic.
> 

Generally, the purpose of this patch was to clean up some ugliness I saw
when I was trying to help someone figure out why they were having
trouble with kernels they were building. I didn't want to set out to do
something too invasive, as that would just lead to headaches for
everyone.

I don't mean to come off as pessimistic, either -- I'm quite excited
that Lemote is trying to move things up-stream. I do recognize how much
work it is to move a gargantuan patch like that upstream, however, and I
didn't want to get in the way of that.

> >
> > Given how Loongson actually differs a lot from Bonito64 beyond a few of
> > the control registers' addresses, perhaps it is worthwhile to start
> > moving away from using bonito64.h anyways; it's a bit odd that ICT chose
> > to base some of the SoC on the Bonito64 design, IMO, but that's a
> > different conversation.
> >
> >> > +/* UART address (16550 -- on the Fulong) */
> >> > +#define LS2E_UART_BASE		0x1fd003f8
> >> 
> >> It happens to be 0x1fd003f8 but it could have been at a different
> >> address base. For instance, on 2f, depending on the board, there's
> >> 0x1ff003f8 and 0x1fd003f8 (I think there's also some board with a
> >> different address than theses but I'm not sure).
> >> 
> >
> > One option I was thinking of was moving that into a device-specific
> > header. However, of the two Loongson 2E devices I have, both have the
> > UART at the same address -- are there any Loongson 2E devices that have
> > the UART at a different location? None that I'm aware of (and on the 2F
> > side, I only know of the Gdium).
> 
> 1 is more than 0 so, please take 2f into account. I don't see the
> benefit of creating yet an other header containing only difference
> something like "UART_BASE 0x1ff003f8" 

See my above proposed patch. Since there are definitely cases where
there will be code that will be reused (plus-or-minus an address or
two), building a mechanism that allows easy reuse of this code makes
sense in my mind. 

They way I'd propose implementing this (and is how I implemented it in
the above patch) is a per-unique-platform header. This would contain
certain values that might change depending on the platform (i.e. the
UART base address, machine name, etc.). It'd actually be nice to be able
to detect which of these paramters should be used during boot, but as
far as I know there's no universal mechanism to do this (for example,
Cisco hardware of the same series have board registers that contain a
device identifier).

> ok, I read the code too quickly. thanks.
> 
> Please note also that my remark about calling it everytime still
> stands. Reading a variable is taking less instructions than calling
> ioremap_nocache.

I'm not entirely sure I agree with you. While there is an overhead
incurred by using ioremap() on each character for prom_putc(), that
overhead is likely amortized by the fact you're waiting for the
8250-compatible's transmit buffer to clear. Those 5-6 instructions are
nothing compared to that!

Thanks for your comments, I'll try to take some of your ideas and
integrate them back into what I've been working on.

Cheers,
Phil

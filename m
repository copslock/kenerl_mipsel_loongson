Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 15:24:11 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:42352
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225546AbTJHOXj>; Wed, 8 Oct 2003 15:23:39 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A7FE1-0002TY-00; Wed, 08 Oct 2003 16:23:37 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A7FE1-0004af-00; Wed, 08 Oct 2003 16:23:37 +0200
Date: Wed, 8 Oct 2003 16:23:37 +0200
To: debian-mips@lists.debian.org
Cc: linux-mips@linux-mips.org
Subject: Re: Question about use of PMAD-AA ethernet adapter on Decstation
Message-ID: <20031008142337.GI12409@rembrandt.csv.ica.uni-stuttgart.de>
References: <20031006202941.GS16118@opengraphics.com> <20031006213700.GA482@excalibur.cologne.de> <20031007142422.GU16118@opengraphics.com> <20031007174733.GX16118@opengraphics.com> <20031007180804.GQ9600@rembrandt.csv.ica.uni-stuttgart.de> <20031007191159.GY16118@opengraphics.com> <20031007205622.GT9600@rembrandt.csv.ica.uni-stuttgart.de> <20031008134509.GZ16118@opengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031008134509.GZ16118@opengraphics.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Len Sorensen wrote:
> On Tue, Oct 07, 2003 at 10:56:22PM +0200, Thiemo Seufer wrote:
> > Len Sorensen wrote:
> > [snip]
> > > Trace; 8005da74 <update_process_times+34/11c>
> > > Trace; 8005dd18 <timer_bh+160/168>
> > > Trace; 8005de64 <do_timer+144/14c>
> > > Trace; 800598e4 <bh_action+60/d8>
> > > Trace; 801263bc <timer_interrupt+f8/1cc>
> > > Trace; 800596a0 <tasklet_hi_action+110/1a4>
> > > Trace; 80158898 <lance_interrupt+2b0/2d8>
> > > Trace; 80158888 <lance_interrupt+2a0/2d8>
> > > Trace; 80059170 <do_softirq+1a0/1a8>
> > > Trace; 8004a6e8 <do_IRQ+e4/12c>
> > > Trace; 8004a728 <do_IRQ+124/12c>
> > > Trace; 80125574 <handle_it+8/10>
> > > Trace; 80125574 <handle_it+8/10>
> > > Trace; 800432dc <cpu_idle+6c/74>
> > > Trace; 800432c0 <cpu_idle+50/74>
> > > Trace; 8020a37c <p.1+324/d38>
> > > Trace; 8004042c <init+0/194>
> > > Trace; 8020959c <genexcept_early+dc/9f0>
> > 
> > Those twice mentioned functions look funny.
> 
> I wonder if both drivers got an interrupt at the same time, but I am not
> really sure how interrupts are handled in the kernel.

The code in linux/arch/mips/dec/int-handler.S should serialize incoming
interrupts. I guess the stack trace was already overwritten in some way,
it is bogus. E.g., handle_it could never call itself.

> > [snip]
> > > Command running: ping 192.168.8.255\
> > > 
> > > About 15 machines are on the network and were responding to the ping.
> > 
> > Does the DECstation work stable in this case if it runs only with
> > the onboard interface?
> 
> I have had uptimes of 2 months on this machine, doing apt-get upgrades
> and such.  Never had it lock up on me before I tried using the PMAD-AA
> yesterday.
> 
> > Any chance the PMAD-AA crashes always after the same amount of
> > rx/tx traffic?
> 
> Doesn't look like it.  I wonder if it needs both network cards to have
> an interrupt simultaniously for it to happen.  I am having a hard time
> rerpoducing it today.
> 
> > Btw, while looking at the drivers source, I found some strange bits:
> > In dec_lance_init(), the lp->[rt]x_buf_ptr_cpu pointers for PMAD-AA are
> > initialized differently than the others, but the cp_{to,from}_buf()
> > functions handle it the same way than the onboard interface. AFAICS
> > this is a bug.
> > 
> > Further, dev->mem_end is only initialized for the onboard lance, not
> > for the others, but that's probably a minor glitch.
> 
> So at least a couple of things look like they need a bit of fixing then.

Unfortunately I don't have a PMAD-AA, but probably some of the
linux-mips folks can help. I'm Cc'ing that list.


Thiemo

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 16:31:21 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:28064 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225545AbTJHPbS>; Wed, 8 Oct 2003 16:31:18 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA01514;
	Wed, 8 Oct 2003 17:31:10 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 8 Oct 2003 17:31:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: Question about use of PMAD-AA ethernet adapter on Decstation
In-Reply-To: <20031008142337.GI12409@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1031008162829.26799D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 8 Oct 2003, Thiemo Seufer wrote:

> > > [snip]
> > > > Trace; 8005da74 <update_process_times+34/11c>
> > > > Trace; 8005dd18 <timer_bh+160/168>
> > > > Trace; 8005de64 <do_timer+144/14c>
> > > > Trace; 800598e4 <bh_action+60/d8>
> > > > Trace; 801263bc <timer_interrupt+f8/1cc>
> > > > Trace; 800596a0 <tasklet_hi_action+110/1a4>
> > > > Trace; 80158898 <lance_interrupt+2b0/2d8>
> > > > Trace; 80158888 <lance_interrupt+2a0/2d8>
> > > > Trace; 80059170 <do_softirq+1a0/1a8>
> > > > Trace; 8004a6e8 <do_IRQ+e4/12c>
> > > > Trace; 8004a728 <do_IRQ+124/12c>
> > > > Trace; 80125574 <handle_it+8/10>
> > > > Trace; 80125574 <handle_it+8/10>
> > > > Trace; 800432dc <cpu_idle+6c/74>
> > > > Trace; 800432c0 <cpu_idle+50/74>
> > > > Trace; 8020a37c <p.1+324/d38>
> > > > Trace; 8004042c <init+0/194>
> > > > Trace; 8020959c <genexcept_early+dc/9f0>
> > > 
> > > Those twice mentioned functions look funny.

 The trace dump looks through the kernel stack and uses simple heuristics
to judge whether a word should be included or not: if it is in the range
covered by the kernel's text segment, it's printed.  It might be pure
coincidence a specific value corresponding to a kernel address is present
at the stack as it may actually be a leftover from past execution, e.g. 
within a stack frame reserved for local variables that hasn't been
initialized yet, or are simply unused for a particular execution path. 
You need to analyze the backtrace, comparing it to actual code involved to
see which of the addresses are results of real function calls. 

> > I wonder if both drivers got an interrupt at the same time, but I am not
> > really sure how interrupts are handled in the kernel.
> 
> The code in linux/arch/mips/dec/int-handler.S should serialize incoming
> interrupts. I guess the stack trace was already overwritten in some way,
> it is bogus. E.g., handle_it could never call itself.

 Well, most interrupt handlers can be interrupted by other interrupts,
only the high priority ones cannot.  These are marked with SA_INTERRUPT in
the flags.  Of course the entry code for IRQ handling cannot be
interrupted and only a single interrupt source is selected for handling
based on predefined priorities, but once execution reaches
handle_IRQ_event() (which calls specific handlers registered by drivers),
another interrupt can be taken. 

 The trace doesn't look suspicious at first sight to me.

> > > Btw, while looking at the drivers source, I found some strange bits:
> > > In dec_lance_init(), the lp->[rt]x_buf_ptr_cpu pointers for PMAD-AA are
> > > initialized differently than the others, but the cp_{to,from}_buf()
> > > functions handle it the same way than the onboard interface. AFAICS
> > > this is a bug.

 The PMAD-A cannot be handled the same way as the others since it has a
sane buffer space layout, something that cannot be said of the others. 
Therefore the stock declance.c driver doesn't handle the PMAD-A properly
-- that's functionality that needs to be implemented when the driver gets
restructured (it'll happen for 2.6 and probably a backport to 2.4 will be
available later as well).  There is a patch that converts the stock driver
into one working for the PMAD-A (but it doesn't work for the others than)
and I'm told Debian uses thus modified code as a separate driver.  The
patch is based on work by Dave Airlie and is available here:
'ftp://ftp.ds2.pg.gda.pl/pub/macro/drivers/pmad-a/patch-mips-2.4.20-pre6-20021222-declance-pmad-12.gz' 
-- it applies cleanly to the current version of declance.c.

> > > Further, dev->mem_end is only initialized for the onboard lance, not
> > > for the others, but that's probably a minor glitch.

 Both dev->mem_start and dev->mem_end are initialized incorrectly as they
should use bus addresses and now they use CPU virtual ones.  For
MIPS-based TURBOchannel systems, the mapping between the addresses is
quite straightforward, but it's not necessarily the case for the others.
The addresses should also be used for I/O resource allocation mamagement
which is not implemented in the driver.

 Your point about dev->mem_end is of course valid -- the bug wasn't
noticed, because the variable isn't used for anything in these cases.

> Unfortunately I don't have a PMAD-AA, but probably some of the
> linux-mips folks can help. I'm Cc'ing that list.

 Please send me the full oops report and I'll see what I can decipher from
it.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

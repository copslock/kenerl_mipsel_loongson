Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 17:11:00 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:42609
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225454AbTJHQKV>; Wed, 8 Oct 2003 17:10:21 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A7GtF-0003Xj-00; Wed, 08 Oct 2003 18:10:17 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A7GtF-0004yZ-00; Wed, 08 Oct 2003 18:10:17 +0200
Date: Wed, 8 Oct 2003 18:10:17 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: Question about use of PMAD-AA ethernet adapter on Decstation
Message-ID: <20031008161017.GL12409@rembrandt.csv.ica.uni-stuttgart.de>
References: <20031008142337.GI12409@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1031008162829.26799D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1031008162829.26799D-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 8 Oct 2003, Thiemo Seufer wrote:
> 
> > > > [snip]
> > > > > Trace; 8005da74 <update_process_times+34/11c>
> > > > > Trace; 8005dd18 <timer_bh+160/168>
> > > > > Trace; 8005de64 <do_timer+144/14c>
> > > > > Trace; 800598e4 <bh_action+60/d8>
> > > > > Trace; 801263bc <timer_interrupt+f8/1cc>
> > > > > Trace; 800596a0 <tasklet_hi_action+110/1a4>
> > > > > Trace; 80158898 <lance_interrupt+2b0/2d8>
> > > > > Trace; 80158888 <lance_interrupt+2a0/2d8>
> > > > > Trace; 80059170 <do_softirq+1a0/1a8>
> > > > > Trace; 8004a6e8 <do_IRQ+e4/12c>
> > > > > Trace; 8004a728 <do_IRQ+124/12c>
> > > > > Trace; 80125574 <handle_it+8/10>
> > > > > Trace; 80125574 <handle_it+8/10>
> > > > > Trace; 800432dc <cpu_idle+6c/74>
> > > > > Trace; 800432c0 <cpu_idle+50/74>
> > > > > Trace; 8020a37c <p.1+324/d38>
> > > > > Trace; 8004042c <init+0/194>
> > > > > Trace; 8020959c <genexcept_early+dc/9f0>
> > > > 
> > > > Those twice mentioned functions look funny.
> 
>  The trace dump looks through the kernel stack and uses simple heuristics
> to judge whether a word should be included or not: if it is in the range
> covered by the kernel's text segment, it's printed.  It might be pure
> coincidence a specific value corresponding to a kernel address is present
> at the stack as it may actually be a leftover from past execution, e.g. 
> within a stack frame reserved for local variables that hasn't been
> initialized yet, or are simply unused for a particular execution path. 
> You need to analyze the backtrace, comparing it to actual code involved to
> see which of the addresses are results of real function calls. 

Ouch. I assumed ksymoops would do stack frame analysis.

[snip]
> There is a patch that converts the stock driver
> into one working for the PMAD-A (but it doesn't work for the others than)
> and I'm told Debian uses thus modified code as a separate driver.  The
> patch is based on work by Dave Airlie and is available here:
> 'ftp://ftp.ds2.pg.gda.pl/pub/macro/drivers/pmad-a/patch-mips-2.4.20-pre6-20021222-declance-pmad-12.gz' 
> -- it applies cleanly to the current version of declance.c.

Debian calls this specific driver pmadaa.c. I looked only at declance.c,
which seems to be the same as te linux-mips CVS version.

> > > > Further, dev->mem_end is only initialized for the onboard lance, not
> > > > for the others, but that's probably a minor glitch.
> 
>  Both dev->mem_start and dev->mem_end are initialized incorrectly as they
> should use bus addresses and now they use CPU virtual ones.  For
> MIPS-based TURBOchannel systems, the mapping between the addresses is
> quite straightforward, but it's not necessarily the case for the others.
> The addresses should also be used for I/O resource allocation mamagement
> which is not implemented in the driver.
> 
>  Your point about dev->mem_end is of course valid -- the bug wasn't
> noticed, because the variable isn't used for anything in these cases.
> 
> > Unfortunately I don't have a PMAD-AA, but probably some of the
> > linux-mips folks can help. I'm Cc'ing that list.
> 
>  Please send me the full oops report and I'll see what I can decipher from
> it.

Forwarded separately. It can also be found in the debian-mips archive.


Thiemo

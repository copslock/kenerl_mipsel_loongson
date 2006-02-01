Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 11:51:18 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:60701 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133406AbWBBLu6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 11:50:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12BtXjK005974;
	Thu, 2 Feb 2006 11:55:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k11BU7SJ003774;
	Wed, 1 Feb 2006 11:30:07 GMT
Date:	Wed, 1 Feb 2006 11:30:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Philip Mucci <mucci@cs.utk.edu>
Cc:	Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: /dev/cpuid or /proc/cpuinfo
Message-ID: <20060201113006.GA3562@linux-mips.org>
References: <Pine.LNX.4.44.0601271349350.2185-100000@bharathi.midascomm.com> <1138647269.4077.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138647269.4077.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 30, 2006 at 06:54:29PM +0000, Philip Mucci wrote:

> In reference to the performance counting thread we had going earlier,
> I've noticed a 'feature' I need out of MIPS/Linux that isn't currently
> available. This has also recently come up on the oprofile list with one
> of the oprofile/mips tools not being able to grab cpu Mhz
> from /proc/cpuinfo because it's not there.

Surprise - the kernel doesn't actually have that information.  The closest
available would be the counting speed of the c0 count register which - if
something like that is available at all - could be calibrated against an
external counter to figure out the clock speed.  To complicate matters
not all processors have have a c0 counter, it's sometimes incrementing
every cycle but it might just as well counting at half the clock rate and
oh yes, more recently there is clock scaling.

> I have need to execute the mfc0 instruction on the config register and
> grok the results to find out things like cache size etc. In addition, it
> might be nice to also actually be able to find out the clock rate.
> (Currently I grab BogoMIPS and punt.)

Considering above complexities a BogoMIPS-based approach doesn't sound too
bad - but it has other problem to implement since it requires knowing the
exact execution timing.  A think that could be done is meassuring two
loops containing a different number of nops and use that to compute the
execution time for the loop closing branch.  Now knowing that based on
knowing the # of cycles per loop we can compute the clock speed - all it
takes is a timer running at a known speed.

A funny complexity is that some multiprocessor MIPS systems have processors
running at different speeds.  So knowing the clock rate doesn't make life
too much easier ;-)

> On the intel and PPC systems, I believe you can execute similar
> instructions from user mode which makes things easy. However, of course
> an MFC0 is a privileged instruction...meaning that if the value or
> values aren't found in /proc/cpuinfo, I'm s.o.l.

We have a long tradition of emulating instructions, could use that to
permit access to a bunch of cp0 registers from userland ;)

> What does the list think about this? Making a mips /dev/cpuid is a bit
> gross but extending and grokking /proc/cpuinfo is perhaps grosser...and
> many tools do just this (like PAPI and oprofile's opreport...)
> 
> Comments? I'm certainly willing to implement this, but I'd rather 'do it
> right the first time' rather than get rotten vegetables thrown my way.

/proc/cpuinfo is meant to have per processor information so I don't have
a problem with adding cache configuration information.  I was considering
to do so to make such information available for bug reports.

  Ralf

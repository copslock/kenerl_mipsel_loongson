Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 21:29:52 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:3036 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8224847AbSLDU3v>;
	Wed, 4 Dec 2002 21:29:51 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB4KStNf024956;
	Wed, 4 Dec 2002 12:28:55 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA04578;
	Wed, 4 Dec 2002 12:28:43 -0800 (PST)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB4KSgb20289;
	Wed, 4 Dec 2002 21:28:42 +0100 (MET)
Message-ID: <3DEE6572.5331C5CD@mips.com>
Date: Wed, 04 Dec 2002 21:28:34 +0100
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org,
	Jun Sun <jsun@mvista.com>
Subject: Re: possible Malta 4Kc cache problem ...
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <3DEDD414.3854664F@mips.com> <3DEDE537.CD58AD8F@mips.com> <013d01c29b95$fb487f60$10eca8c0@grendel> <3DEDFFB9.3312BA1A@mips.com> <021401c29bb7$cd02abe0$10eca8c0@grendel> <20021204173248.GA23213@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Could you please tell us, which 4Kc you are running on ?
What are the cache configuration (size, number of ways) ?
Are you running on the latest kernel sources from the CVS tree ?
Have you tried the mips32_cache.h file I send and/or have you tried the kernel
from the ftp.mips.com FTP server ?

Many question at the same time ;-)
/Carsten


Daniel Jacobowitz wrote:

> On Wed, Dec 04, 2002 at 06:08:22PM +0100, Kevin D. Kissell wrote:
> > > > I think that Carsten's patch (or equivalent) should certainly be
> > > > applied to the main tree, but I wonder how relevant it is here.
> > > > The flushes associated with trampolines don't do indexed
> > > > flush operations, do they?
> > >
> > > True, but are we sure that it's the trampoline that's the problem here?
> >
> > Jun Sun seemed to think it was. To quote his original message
> >
> > "The problem involves emulating a "lw" instruction in cp1 branch delay
> >  slot, which needs to  set up trampoline in user stack.  The net effect
> >  looks as if the icache line or dcache line is not flushed properly."
> >
> > I don't know what his actual observations were that lead to that
> > conclusion, but the resemblence to what was reported under LTP
> > with the pre-break_cow()-patch kernel intrigues me.
>
> Here's some of the actual observations: if you single-step over the
> bc1t instruction, then it comes out as you'd expect; the load in the
> delay slot was executed.  Even if you breakpoint in the general
> vicinity and then continue.
>
> But if you breakpoint _after_ the instruction, it is evident that the
> load did not occur as expected.
>
> > So, I repeat...
> > > > ...I don't have a 4Kc platform at
> > > > hand, but I think that Jun Sun *may* have found a better
> > > > way to get at the other problem I was referring to, which
> > > > we rarely saw on non-superscalar issue CPUs, and which
> > > > seems to be masked by an otherwise superfluous flush of
> > > > the Icache that was added to the latest versions of break_cow().
> > > > If Carsten's patch solves the problem without applying that
> > > > other update, I'd want to know that.  If it *doesn't*, I'd be
> > > > really interested to know if, by any chance, there is a
> > > > corelation between failures of Jun Sun's test and the incidence
> > > > of page faults on the CACHE op in protected_icache_invalidate_line().
> > > >
> > > >             Kevin K.
> >
> >
> >
>
> --
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer

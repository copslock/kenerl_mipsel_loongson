Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2002 09:37:47 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:21974 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123927AbSJHHhq>;
	Tue, 8 Oct 2002 09:37:46 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g987ZSNf028100;
	Tue, 8 Oct 2002 00:35:28 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA07277;
	Tue, 8 Oct 2002 00:36:03 -0700 (PDT)
Message-ID: <004e01c26e9d$abfa65b0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Johannes Stezenbach" <js@convergence.de>
Cc: <linux-mips@linux-mips.org>
References: <20020916164034.GA12489@convergence.de> <20021007144749.GB16641@convergence.de> <01fd01c26e1d$add77240$10eca8c0@grendel> <20021007184344.GA17548@convergence.de>
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Date: Tue, 8 Oct 2002 09:38:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Mon, Oct 07, 2002 at 06:21:52PM +0200, Kevin D. Kissell wrote:
> >
> > When I first proposed the branch-likely hack last winter,
> > I thought it might be worth while to do a through code
> > inspection to determine what set of values could never
> > be returned in k1 (or k0 for all I care) if an exception
> > was taken, such that there would be no mods to the
> > kernel required whatsoever.  I spent a little time going 
> > down that path, and it does look at first glance as if one 
> > could guarantee that one will never come out of an exception 
> > with k1 equal to 0xffdadaff in current oss/linux-mips cvs
> > sources, but the guys at Sony, who have a big interest in 
> > this technique, given that the PS2 has no LL/SC,
> > prefered a more conservative approach which explicitly
> > clobbered the selective register on all exceptions,
> > even if it meant some small performance impact.
> > That's probably going to be a more reliable design,
> > though I would still consider leaving the TLB refill handler
> > untouched and counting on the fact that k1 must contain
> > a non-lethal EntryLo value on return from the exception.
> 
> In my original posting from Mon, Sep 16, 2002 (maybe I should
> have reposted it in full?), a had appended a patch which
> leaves the TLB handlers alone (k1 always ends up with an EntryLo value,
> thus bit 31 is guaranteed to be 0), but explicitly sets k1 to zero in
> RESTORE_SP_AND_RET.

Note that you've still got a handful of erets that aren't
generated by RESTORE_SP_AND_RET that we
would need to "hunt down and kill" if we were serious
about nailing all non-TLB-miss cases explicitly.
(gdb-stub.S, head.S).

> > As for glibc, the possibilities are numerous and I'm not
> > the guy who'd have to make it work.
> 
> The question is how the glibc can detect if
> a) the CPU does not have LL/SC
> b) the kernel guarantees k1 != MAGIC
> 
> I think the kernel should announce this explicitly.
> In my patch from Sep 16 I used a sysctl, but that's
> probably bad because glibc would rely on a real new
> include/linux/sysctl.h.
> 
> I need some advice on this (maybe add a line to /proc/cpuinfo,
> or create a new /proc entry? or add a sysmips call to get
> this info?).

/proc/cpuinfo strikes me as being a better mechanism
than creating a new system call variant, but again, I
would defer to a large measure to the glibc maintainers.
If we do enhance cpuinfo, I note that there are some
other parameters that seem to be in the queue to go
into that data structure, and that they should presumably
be swept up in any such revision.  Is there a reason why
/proc/cpuinfo information doesn't have a version field
to let users know what level of information they are getting,
by the way?

> I also want to know if there's public interest to get such
> a change in the kernel. If yes, I will try to get a matching
> patch into glibc. If no, I will just post the current patch I
> use to the list for the hackers to pick up.

There is certainly interest at MIPS in seeing this mod 
propagated. I'd really like to see the Playstation 2 running 
something a lot closer to manistream MIPS/Linux, which 
isn't going to happen so long as the only choices on offer 
for synchronization on LL/SC-less CPUs are system calls 
and OS emulation of LL/SC.  People running Linux 
on Vr41xx-based PDAs would get a performance benefit 
as well.  Keep in mind that the majority of developers on
this list have either CPUs that support LL/SC, or really
old systems that have neither LL/SC nor branch likely,
which may account for a lack of enthusiasm for the project,
particuarly coming as it does not too long after a long 
debate on system calls versus emulation.

            Regards,

            Kevin K. 

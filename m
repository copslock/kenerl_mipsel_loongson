Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2006 22:09:20 +0100 (BST)
Received: from bes.cs.utk.edu ([160.36.56.220]:1447 "EHLO bes.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S20027658AbWIQVJS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2006 22:09:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by bes.cs.utk.edu (Postfix) with ESMTP id 63988FD24;
	Sun, 17 Sep 2006 17:08:57 -0400 (EDT)
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Received: from bes.cs.utk.edu ([127.0.0.1])
	by localhost (bes.cs.utk.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkHD6pz5qQ+P; Sun, 17 Sep 2006 17:08:51 -0400 (EDT)
Received: from [192.168.1.3] (c83-248-50-12.bredband.comhem.se [83.248.50.12])
	by bes.cs.utk.edu (Postfix) with ESMTP id 5FB1EFD28;
	Sun, 17 Sep 2006 17:08:38 -0400 (EDT)
Subject: Re: Performance counters and profiling on MIPS
From:	Philip Mucci <mucci@cs.utk.edu>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	Prasad Boddupalli <bprasad@cs.arizona.edu>,
	linux-mips@linux-mips.org, Stephane Eranian <eranian@hpl.hp.com>
In-Reply-To: <20060614181431.38314.qmail@web31506.mail.mud.yahoo.com>
References: <20060614181431.38314.qmail@web31506.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Innovative Computing Laboratory
Date:	Sun, 17 Sep 2006 23:08:23 +0200
Message-Id: <1158527303.3722.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Hi folks,

I just got around to checking this thread...about 4 months late. Stefane
will release another version of the perfmon2 kernel patch in a few
days, he's been working with LKML on cleaning things up. The current
patch should go reasonably cleanly into the latest tree. The problem is
that he's maintaining the core patch against linux mainline, so there is
a bit of skew...be prepared to fix up some sys call numbers and some
includes, that's about it. There have been some issues with some
versions of linux mips not registering a cpu in /sys/devices, but that
may be fixed in the latest snapshots. 

A part of this patch is the libpfm support library, which helps in
counter allocation amongst other things. It isn't necessary to use the
interface. It can also support the scenario where 

The new release of PAPI will include support for this subsystem on
Linux/MIPS, but only for some MIPS64 processors. To add a new MIPS
processors should be fairly easy, as the performance hardware on these
chips isn't so exciting. 

Regards,

Philip

On Wed, 2006-06-14 at 11:14 -0700, Jonathan Day wrote:
> Ok, the kernel version number listed is current to
> 2.6.17-rc6, and the MIPS patches -almost- go in
> cleanly.
> 
> In the syscalls in arch/mips/kernel, there is a new
> syscall (sys_tee) that throws the patches off as it is
> not in the context. This is very easy to massage.
> 
> The same is true of include/asm-mips/unistd.h, except
> there the count of syscalls is also off by one. Again,
> a very easy fix.
> 
> Other than that, it looks current and looks good. I'm
> going to be doing some testing on it, to see whether
> it works as well as it looks, or whether it causes the
> CPU to leap three feet in the air, discharging the
> magic blue smoke.
> 
> If other people have had success with it, though, I
> would definitely suggest considering it for inclusion
> in the linux-mips GIT tree. Those who don't need
> performance counters won't be adversely affected, and
> those of us who do would likely benefit.
> 
> If the linux-mips tree would not be appropriate, then
> could someone take up hypnosis and get it included in
> the main tree?
> 
> Jonathan
> 
> --- Nigel Stephens <nigel@mips.com> wrote:
> 
> > Prasad Boddupalli wrote:
> > > Perfctr
> > (http://user.it.uu.se/~mikpe/linux/perfctr/) and
> > PAPI
> > > (http://icl.cs.utk.edu/papi/) are precisely such
> > attempts. Except that
> > > MIPS ports of them do not seem to be available.
> > 
> > There's also perfmon2, for which a MIPS patch is
> > available - though no 
> > idea how up-to-date it is. See
> > http://www.linux-mips.org/wiki/Perfmon2
> > 
> > Nigel
> > 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 

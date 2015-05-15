Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 23:13:13 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012621AbbEOVNKa3Bwo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 23:13:10 +0200
Date:   Fri, 15 May 2015 22:13:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: malta-time: Don't switch RTC to BCD mode
In-Reply-To: <20150515181413.GA30774@NP-P-BURTON>
Message-ID: <alpine.LFD.2.11.1505152038050.4923@eddie.linux-mips.org>
References: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com> <1431519473-24049-2-git-send-email-james.hogan@imgtec.com> <alpine.LFD.2.11.1505131829580.1538@eddie.linux-mips.org> <20150513221956.GE7723@jhogan-linux.le.imgtec.org>
 <20150514084130.GE22815@NP-P-BURTON> <55547238.1040005@imgtec.com> <alpine.LFD.2.11.1505141122380.19904@eddie.linux-mips.org> <20150515180351.GE2322@linux-mips.org> <20150515181413.GA30774@NP-P-BURTON>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 15 May 2015, Paul Burton wrote:

> > >  I'd prefer RTC state not to be touched at all if its state is sane.  
> > > That is read Register B, check for the only valid divider setting 
> > > (32kHz), and if so then exit right away, and otherwise initialise the 
> > > chip from scratch.  Consistency with YAMON might be a good idea in that 
> > > initialisation, but I have no strong feeling towards that.  If you think 
> > > there's value in having the chip set to the BCD mode, then feel free to 
> > > keep that option.
> > > 
> > >  Note that any inhibition of the RTC previously initialised by 
> > > temporarily setting the SET bit in Register B during bootstrap will 
> > > disturb timekeeping that the system may carry over reset using 
> > > adjtimex(8).
> > 
> > So you're instead suggesting to revoke a87ea88d8f6c ?

 No, now that I have the full picture -- everyone, please try to include 
as much details with our commit messages as required for the reader to be 
able to have a full understanding of the reasons behind the change without 
having to guess or ask around.  You may not be around in a few years' 
time, having moved on with your career or interests, or suchlike, and 
people will have to cope without your assistance.  It's OK to give these 
messages a meaning, they are not GNU ChangeLogs!

> > If YAMON and U-Boot are differing in RTC handling then I suggest to
> > treat that as a U-Boot bug. YAMON was there first.

 And that is a grand first, 15+ years!

> That would be fair enough, and is why I added RTC handling to Malta
> U-boot at all. I could see logic in suggesting U-boot be changed to use
> the binary mode instead of BCD. But...

 I find it a shame BTW that the handling of RTC has fallen so bad recently 
across various platforms.  Here you shouldn't have been required to do 
anything beyond enabling the right RTC driver (the Motorola clone has been 
so ubiquitous that a driver must have been done eons ago), defining its 
mapping on the bus (again 0x70/0x71 in the PCI I/O space is the vastly 
most common arrangement) and maybe setting some configuration flags for 
the mode (binary vs BCD and the like).

 A while ago I had to deal with some U-Boot-based Freescale Power boards 
and the firmware had no commands to set the clock/date in the RTC at all.  
Furthermore the installed userland had no access to the RTC, either 
because of the /dev/rtc ABI change that happened a while ago (a different 
error code is returned these days for some kind of a failure than it used 
to be and unpatched `hwclock' bails out), or because no driver claimed the 
clock (I don't remember anymore), even though some platform code did 
initialise the system time from the RTC.

 Consequently the board booted with nonsensical time stamps recorded in 
logs up to the point the system time was synchronised from a networked 
source and any time stamps on files modified in the single user-mode were 
useless unless you first ran `date' to set the time manually.  Very 
frustrating when I had to investigate what happened when.

 Also related to clock handling, though not RTC this time, I had some 
system clock issues with SEAD-3, with time drifting so much (amounting to 
minutes per hour IIRC) and so irregularly that the NTP daemon couldn't 
cope and eventually bailed out.  Have they been addressed now?

> > However these Malta kernels are also frequently booted without firmware
> > in Qemu. No idea how Qemu initializes the RTC.

 No idea offhand, although reasonably I expect the clock/calendar to have 
been initialised from the host's system clock and the control registers 
according to target hardware platform settings.  For many platforms these 
are fixed according to some kind of an industry standard (e.g. IBM PC/AT) 
or implementation (e.g. workstations and servers), so QEMU has to reflect 
that in its environment or software dedicated to individual systems will 
malfunction.  So I expect QEMU to have a way to deal with it.

> ...kernels can also be booted on real Malta boards with minimal prodding
> over JTAG, and the RTC is one more thing that you need to prod if the
> kernel doesn't ensure it's running. That's what motivated a87ea88d8f6c
> and the other patches from the same series at all.

 So these kind of details (including a reference to U-Boot as well) are 
ones I expect to have been included with a87ea88d8f6c.  Please try and 
keep it in mind in the future, I'll appreciate that.

 So to recap and FAOD I think `init_rtc' needs to stay after all, but I 
request that it is updated so that a sane RTC state is not changed.  I 
hope that either of you, James and Paul, can handle it.

  Maciej

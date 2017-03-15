Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 16:52:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41788 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991232AbdCOPwRwp3UV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 16:52:17 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2FFqG7H011583;
        Wed, 15 Mar 2017 16:52:16 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2FFqG1c011582;
        Wed, 15 Mar 2017 16:52:16 +0100
Date:   Wed, 15 Mar 2017 16:52:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
Message-ID: <20170315155216.GA10914@linux-mips.org>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <20170313094757.GI2878@jhogan-linux.le.imgtec.org>
 <20170315092536.GC22089@linux-mips.org>
 <CAOLZvyGRn5JgeRoiHv0AH8LVwLF5MtXF2KwS5Yr5N8QOK6eYnw@mail.gmail.com>
 <CAEdQ38FU6H7ThmP2MgUY-uLhf9feZ6US2JwhEQsCuPw9AeV3nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38FU6H7ThmP2MgUY-uLhf9feZ6US2JwhEQsCuPw9AeV3nQ@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Mar 15, 2017 at 08:31:19AM -0700, Matt Turner wrote:

> On Wed, Mar 15, 2017 at 7:00 AM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> >
> > On Wed, Mar 15, 2017 at 10:25 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> >>
> >> On Mon, Mar 13, 2017 at 09:47:57AM +0000, James Hogan wrote:
> >>
> >> > >
> >> > > Note that the corruption is different across reboots, both in the size
> >> > > of the corruption and the location. I saw 1900~ and 1400~ byte
> >> > > sequences corrupted on separate occasions, which don't correspond to
> >> > > the system's 16kB page size.
> >> > >
> >> > > I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
> >> > > today). All exhibit this behavior with differing frequencies. Earlier
> >> > > kernels seem to reproduce the issue less often, while more recent
> >> > > kernels reliably exhibit the problem every boot.
> >> > >
> >> > > How can I further debug this?
> >> >
> >> > It smells a bit like a DMA / caching issue.
> >> >
> >> > Can you provide a full kernel log. That might provide some information
> >> > about caching that might be relevant (e.g. does dcache have aliases?).
> >>
> >> The architecture of the BCM1250 SOC used for the BCM91250 boards are
> >> fully coherent, S-cache and D-cache are physically indexed and tagged.
> >> Only the VIVT (plus the usual ASID tagging) I-cache leaves space for
> >> software to screw up cache management but that shouldn't matter for this
> >> case, so I suggest to start looking into this from the NFS side.
> >
> >
> > I did Matt's tests on Alchemy (VIPT caches) with kernels 3.18 to 4.11-rc
> > against
> > an x86 4.9.15 host, and did not see any problems.   Given Ralf's comment
> > about the BCM1250 caches, maybe you have bad hardware (BCM board or
> > network) ?
> 
> I certainly cannot rule that possibility out. If that is the case, I
> would like to be sure of it -- see a failure in memtester or something
> for instance. Any suggestions? (I have run memtester and never found
> anything)
> 
> For what its worth, did you determine the cause of the NFS corruption
> you reported [1]?
> 
> [1] https://www.spinics.net/lists/mips/msg44006.html

I've chased my fair share of kernel bugs on Sibyte systems that were
caused by faulty or unsuitable memory modules, even the BGA solder points
of the BCM1250 SOC coming off.  If you have memory modules in both
banks you may want to try if you can reproduce them with only one
bank populated and if it makes a difference if only bank one or only
bank two is populated.  Firmware updates have fixed various issues with
memory controller initialization over the years so if you haven't
updated to the latest and greatest CFE for the board, you may want to
try that.

  Ralf

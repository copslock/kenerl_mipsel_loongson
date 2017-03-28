Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2017 16:25:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35194 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993552AbdC1OZNjSikl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Mar 2017 16:25:13 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2SEP66V030621;
        Tue, 28 Mar 2017 16:25:06 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2SEP2BN030620;
        Tue, 28 Mar 2017 16:25:02 +0200
Date:   Tue, 28 Mar 2017 16:25:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: Does the R10K family support the "wait" instruction?
Message-ID: <20170328142502.GC5734@linux-mips.org>
References: <88c3cc1d-fd80-bb9a-d1ec-ed3c44dea71b@gentoo.org>
 <20170327130539.GA5734@linux-mips.org>
 <0c62c4a7-b44c-45f6-2428-5b9b9e6a6204@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c62c4a7-b44c-45f6-2428-5b9b9e6a6204@gentoo.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57456
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

On Mon, Mar 27, 2017 at 05:04:27PM -0400, Joshua Kinard wrote:

> On 03/27/2017 09:05, Ralf Baechle wrote:
> > On Sun, Mar 26, 2017 at 09:50:08PM -0400, Joshua Kinard wrote:
> > 
> >> Does anyone know if the R1x000 family of CPUs support the "wait" instruction?
> >> The 'check_wait' function in arch/mips/kernel/idle.c doesn't have a case for
> >> any of the R10K CPUs, and I can't find any specific guidance in the final R10K
> >> manual produced by Renesas, nor in the MIPS-IV instruction set.  It appears
> >> this was added in MIPS-II, and the R4K CPUs use it, with one version for when
> >> interrupts are enabled, and one where they're disabled.  Since a lot of CPUs
> >> tend to reuse R4K-compatible code, I wasn't sure.
> > 
> > Interesting, didn't know Renesas did another R10000 manual.  Presumably
> > they only rebranded NEC's manual?
> 
> Yup, mostly.  It's document U10278EJ4V0UM00, 4th edition, though I can't get
> the search engine on their site to cough a link up, so I've attached the copy I
> found.  The manual looks like it was dated from March 2001, which covers at
> least up to R12000, but has a "phased-out/discontinued" stamp and a notice to
> customers dated April 2010.
> 
> I still, to this date, have never come across any documentation on the R14000
> or R16000.  That must be internal to SGI and HP (used in their NonStop servers)
> and never saw the light of day.  Technically HP now, since they recently
> scooped up what was left of SGI.
> 
> 
> > If you have any documentation to indicate a MIPS II CPU to support WAIT,
> > I'm interested.  From all that I know the feature was introduced by the
> > R4600.
> 
> One of my Google searches, using the keywords "mips wait instruction", has been
> returning search results from a Harvard computer sciences course detailing the
> "instructional operating system OS/161", which uses an instructional CPU that
> borrows heavily from the R3000 (which they dub MIPS-161):
> 
> http://os161.eecs.harvard.edu/documentation/sys161-1.99.07/mips.html
> 
> In there, they state:
> "The WAIT instruction has been borrowed from MIPS-II. This operation puts the
> processor into a low-power state and suspends execution until some external
> event occurs, such as an interrupt. Since the exact behavior of WAIT is not
> clearly specified anywhere I could find, the MIPS-161 behavior is as follows"
> 
> So it could be that the instructor for that course simply got some wrong
> information, but good luck teaching Google that.  I figure once its spider
> crawls this e-mail in the archives, it'll further strengthen hits like the above.

Hint, MIPS II was defined by the '89 R6000, a CPU implemented in ECL.  That's
a technology that sucks the wiring from the wall (3 CPU 90MHz R6000 = 6kW!).

Best I can say the R4600 was the first CPU to support the WAIT instruction.

There were a number of not quite proper MIPS II CPUs which appeared to be
like MIPS I pimped with a bit of MIPS III.  IDT called theirs "enhanced
MIPS II".

> It might make sense to add the R10K cases to the switch in cpu_wait, right
> above the "default" block, with a comment stating that R10K doesn't support
> wait.  That way it's documented in the right spot in case this question ever
> comes up in the future.  I can send a patch for this later on if interested.

Yeah, one might do that for documentation purposes.  It won't result in
kernel bloat after all.

  Ralf

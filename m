Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 16:02:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60496 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006877AbaHZOCW21JoE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Aug 2014 16:02:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7QE2KKX027005;
        Tue, 26 Aug 2014 16:02:20 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7QE2Jhi027004;
        Tue, 26 Aug 2014 16:02:19 +0200
Date:   Tue, 26 Aug 2014 16:02:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
Message-ID: <20140826140219.GA26140@linux-mips.org>
References: <53FC5300.4070902@gentoo.org>
 <20140826102004.GA22221@linux-mips.org>
 <53FC6A50.9090709@gentoo.org>
 <20140826120326.GB24146@linux-mips.org>
 <53FC88C8.6000209@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53FC88C8.6000209@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42260
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

On Tue, Aug 26, 2014 at 09:16:56AM -0400, Joshua Kinard wrote:

> On 08/26/2014 08:03, Ralf Baechle wrote:
> > On Tue, Aug 26, 2014 at 07:06:56AM -0400, Joshua Kinard wrote:
> > 
> >> o32 userland is the primary on both systems.  However, the last SIGILL was
> >> under the 64k PAGE_SIZE kernel inside of an n32 chroot compiling the 'boost'
> >> package on the Octane, which I restarted that and it's not complained since.
> >>  Also got SIGILL on the 16k PAGE_SIZE kernel when I booted 16k PAGE_SIZE the
> >> first time and ran 'ps'.  Subsequent runs of 'ps' didn't reproduce the
> >> error.  Also saw SIGILLs in the bootlog of the 16k PAGE_SIZE kernel when
> >> "rm" was ran once (couldn't reproduce) and when mdadm tried to put one of
> >> the arrays back together.  Subsequent runs using similar argument lines
> >> don't reproduce once I got to a root shell.
> >>
> >> Being it's a Gentoo install...the o32 userland is pretty fresh.  Especially
> >> on the Octane, where I literally rebuilt the old userland over 2-3 times
> >> just to make sure all the old 5-year cruft was gone.  The n32 userland
> >> chroot is brand-spanking new.  gcc-4.7.x only for now on both, because of
> >> PR61538 in gcc.  Latest binutils.
> >>
> >> The O2 is chugging away happily so far in updating a bunch of packages.  So
> >> I am leaning towards this being another quirk I have to hunt down in the
> >> Octane's code again.  There isn't much in the Octane-specific code that
> >> deals with memory, though -- it seems the higher-level MIPS memory code
> >> handles most things just fine.
> > 
> > Can you enable core dumps?  I'm wondering about the EPC of the crashed
> > process.  If it's at a function entry or the beginning of a page that
> > might indicate there is an issue with flushing caches after the containing
> > page got loaded.  Also interesting to know if this possibly happened in a
> > signal trampoline or VDSO.
> > 
> > These are just the usual suspects - nothing indicates this case is actually
> > related.
> 
> (Missed the reply all on the last one)
> 
> Enabled coredumps and got the 'shash' program to fail a second time (first
> program to do so)...so I'll rebuild that with debugging symbols and try to
> trip it up again later on.
> 
> Is a core file from a binary w/o debugging of any value?

Yes - it will contain registers etc.  Just what really matters in this case.
We don't need the debug info because we're not interested in debugging the
application.

  Ralf

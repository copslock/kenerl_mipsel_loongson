Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 14:44:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54607 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012469AbbFBMoQ1N154 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jun 2015 14:44:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t52Ci5Qq022800;
        Tue, 2 Jun 2015 14:44:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t52Ci1YA022796;
        Tue, 2 Jun 2015 14:44:01 +0200
Date:   Tue, 2 Jun 2015 14:44:01 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, macro@linux-mips.org,
        Steven.Hill@imgtec.com, alexander.h.duyck@redhat.com,
        davem@davemloft.net
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
Message-ID: <20150602124400.GG29986@linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
 <20150602100835.GG24014@NP-P-BURTON>
 <20150602121227.GA1474@macpro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150602121227.GA1474@macpro.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47789
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

On Tue, Jun 02, 2015 at 02:12:29PM +0200, Luc Van Oostenryck wrote:
> Date:   Tue, 2 Jun 2015 14:12:29 +0200
> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> To: Paul Burton <paul.burton@imgtec.com>
> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
>  linux-mips@linux-mips.org, benh@kernel.crashing.org, will.deacon@arm.com,
>  linux-kernel@vger.kernel.org, ralf@linux-mips.org,
>  markos.chandras@imgtec.com, macro@linux-mips.org, Steven.Hill@imgtec.com,
>  alexander.h.duyck@redhat.com, davem@davemloft.net
> Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in
>  smp_* memory barriers
> Content-Type: text/plain; charset=us-ascii
> 
> On Tue, Jun 02, 2015 at 11:08:35AM +0100, Paul Burton wrote:
> > Hi Leonid,
> > 
> 
> <snip>
> 
> > > +
> > > +	  If that instructions are not implemented in processor then it is
> > > +	  converted to generic "SYNC 0".
> > 
> > I think this would read better as something like:
> > 
> >   If a processor does not implement the lightweight sync operations then
> >   the architecture requires that they interpret the corresponding sync
> >   instructions as the typical heavyweight "sync 0". Therefore this
> >   should be safe to enable on all CPUs implementing release 2 or
> >   later of the MIPS architecture.
> > 
> 
> Is it really the case for release 2?
> 
> I'm asking because recently I needed to do something similar and I couldn't
> find this garantee in the revision 2.00 of the manual.
> May it's just poorly formulated but here is what I find in it:
> - "The stype values 1-31 are reserved for future extensions to the architecture."
>   (ok)
> - "A value of zero will always be defined such that it performs all defined
>    synchronization operations." (ok)
> - "Non-zero values may be defined to remove some synchronization operations."
>   (ok, certainly if we understand the word "weaker" instead of "remove")

Yes, "weaker" is what was meant here.

> - "As such, software should never use a non-zero value of the stype field, as
>   this may inadvertently cause future failures if non-zero values remove
>   synchronization operations." (Mmmm, ok but ...)
> Nowhere is there something close to what is found in the revision 5.0 or later:

I think that's just a very convoluted way to say non-zero values are
reserved and the CPU may bite you and your kittens if you dare to use
such values.

>   "If an implementation does not use one of these non-zero values to define a
>    different synchronization behavior, then that non-zero value of stype must
>    act the same as stype zero completion barrier."

"We try to be nice to bad code but ... you've been warned!" :-)

> The wording may have changed since revision 2.8 but I don't have access to the
> corresponding manual.

The page about the SYNC instruction has changed significantly over time -
the SYNC instruction's documentation manual has grown from one page for the
R4000 to four pages for MIPS32 R1 and R2.5 to five pages for MIPS64 R3.02
and newer.  R3 added read, write, rw, acquire and release sync types.

But the sentence in question exists unchanged even in the R6 manual.

  Ralf

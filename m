Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 22:54:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33740 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993096AbcLMVyBHhLNX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Dec 2016 22:54:01 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBDLrxFZ014394;
        Tue, 13 Dec 2016 22:53:59 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBDLrxp5014393;
        Tue, 13 Dec 2016 22:53:59 +0100
Date:   Tue, 13 Dec 2016 22:53:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
Subject: Re: [RFC] MIPS: Add cacheinfo support
Message-ID: <20161213215359.GB14262@linux-mips.org>
References: <20161208011626.20885-1-justinpopo6@gmail.com>
 <5849EC43.2070802@imgtec.com>
 <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
 <584A0281.3040505@imgtec.com>
 <3004fca6-3688-65bb-7c86-248603482088@gmail.com>
 <584F0C71.5010004@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584F0C71.5010004@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56042
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

On Mon, Dec 12, 2016 at 12:45:37PM -0800, Leonid Yegoshin wrote:

> On 12/12/2016 10:24 AM, Florian Fainelli wrote:
> > 
> > What Justin's patch is about is not so much about providing hints to
> > user-space to bypass the kernel's own management of caches, (even though
> > that has been used as an argument by the original introduction of
> > cacheinfo), but more to provide some information to user-space about the
> > cache topology and hierarchy.
> 
> I missed that, if it is for information purpose only, then it is OK.

Cache information can also be used for some software optimizations though
I think GCC at this time doesn't do this kind of trickery.

> > Even though this is limited information this is still helpful to
> > applications like lshw and others out there.
> > 
> > What would be needed from your perspective to get cacheinfo added to
> > MIPS, shall we go back and address your initial comment about all the
> > little details about coherency, snooping and re-filling strategy?
> 
> It depends. Initially, I thought Justin wants to replace
> arch/mips/mm/c-XXX.c with some universal approach and listed the missed
> stuff for that (I actually missed some more points in that list).
> 
> But for information purpose I don't have any more addition to Justin's
> patch... may be the coherency status, it has impact on performance:
> coherency of L1D->L2, L2->memory and L1I->L1D/L2.

Coherency is hard to properly describe, there are many shades of grey
between fully coherent and not coherent at all.

If we expose something to userspace which constitutes some kind of API
then we really need to get it right because we can't change it arbitrarily
later on.

  Ralf

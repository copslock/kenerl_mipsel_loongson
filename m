Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 17:14:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30745 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008088AbbILPOmMMK4l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Sep 2015 17:14:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 963D66E138375;
        Sat, 12 Sep 2015 16:14:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sat, 12 Sep 2015 16:14:36 +0100
Received: from localhost (192.168.159.171) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sat, 12 Sep
 2015 16:14:35 +0100
Date:   Sat, 12 Sep 2015 08:14:33 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     John Crispin <john@phrozen.org>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 6/6] MIPS: CPS: drop .set mips64r2 directives
Message-ID: <20150912151433.GB3831@NP-P-BURTON>
References: <1438814560-19821-1-git-send-email-paul.burton@imgtec.com>
 <1438814560-19821-7-git-send-email-paul.burton@imgtec.com>
 <20150910180323.GA22682@NP-P-BURTON>
 <55F3C273.3030704@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <55F3C273.3030704@phrozen.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.171]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Thanks John,

That's fine & understood, it's the month before that when these sat
quietly - through the release of a kernel which they fix a regression in
no less, and despite my having asked Ralf on IRC about them a couple of
weeks before v4.2 was released.

If they just fell off the radar or through the cracks, fine, it happens.
I just want to be sure that regression gets fixed as soon as possible.

Thanks,
    Paul

On Sat, Sep 12, 2015 at 08:13:07AM +0200, John Crispin wrote:
> Hi Paul,
> 
> --> http://www.linux-mips.org/archives/linux-mips/2015-09/msg00057.html
> 
> 	John
> 
> On 10/09/2015 20:03, Paul Burton wrote:
> > Ralf: is there a reason you've only applied patch 1 of this series?
> > 
> > v4.2 is broken because these didn't get in (despite being submitted well
> > before the release), and master is still broken because they still
> > haven't gotten in. If there's a reason you didn't merge them please let
> > me know, otherwise please can we get them in ASAP.
> > 
> > Thanks,
> >     Paul
> > 
> > On Wed, Aug 05, 2015 at 03:42:40PM -0700, Paul Burton wrote:
> >> Commit 977e043d5ea1 ("MIPS: kernel: cps-vec: Replace mips32r2 ISA level
> >> with mips64r2") leads to .set mips64r2 directives being present in 32
> >> bit (ie. CONFIG_32BIT=y) kernels. This is incorrect & leads to MIPS64
> >> instructions being emitted by the assembler when expanding
> >> pseudo-instructions. For example the "move" instruction can legitimately
> >> be expanded to a "daddu". This causes problems when the kernel is run on
> >> a MIPS32 CPU, as CONFIG_32BIT kernels of course often are...
> >>
> >> Fix this by dropping the .set <ISA> directives entirely now that Kconfig
> >> should be ensuring that kernels including this code are built with a
> >> suitable -march= compiler flag.
> >>
> >> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >> Cc: Markos Chandras <markos.chandras@imgtec.com>
> >> Cc: <stable@vger.kernel.org> # 3.16+
> >> ---
> >>
> >>  arch/mips/kernel/cps-vec.S | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> >> index 209ded1..763d8b7 100644
> >> --- a/arch/mips/kernel/cps-vec.S
> >> +++ b/arch/mips/kernel/cps-vec.S
> >> @@ -229,7 +229,6 @@ LEAF(mips_cps_core_init)
> >>  	has_mt	t0, 3f
> >>  
> >>  	.set	push
> >> -	.set	mips64r2
> >>  	.set	mt
> >>  
> >>  	/* Only allow 1 TC per VPE to execute... */
> >> @@ -348,7 +347,6 @@ LEAF(mips_cps_boot_vpes)
> >>  	 nop
> >>  
> >>  	.set	push
> >> -	.set	mips64r2
> >>  	.set	mt
> >>  
> >>  1:	/* Enter VPE configuration state */
> >> -- 
> >> 2.5.0
> >>
> > 

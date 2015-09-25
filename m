Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2015 14:25:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28262 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007751AbbIYMY6Gdlpw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Sep 2015 14:24:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3D2A0560C1C19
        for <linux-mips@linux-mips.org>; Fri, 25 Sep 2015 13:24:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 25 Sep 2015 13:24:51 +0100
Received: from localhost (192.168.159.195) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 25 Sep
 2015 13:24:50 +0100
Date:   Fri, 25 Sep 2015 05:24:48 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] FIXUP: MIPS: fix n64 syscall address calculation
Message-ID: <20150925122448.GA3712@NP-P-BURTON>
References: <1442995677-20591-1-git-send-email-markos.chandras@imgtec.com>
 <1443152025-1975-1-git-send-email-paul.burton@imgtec.com>
 <20150925071505.GA5740@mchandras-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150925071505.GA5740@mchandras-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.195]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49361
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

On Fri, Sep 25, 2015 at 08:15:06AM +0100, Markos Chandras wrote:
> On Thu, Sep 24, 2015 at 08:33:45PM -0700, Paul Burton wrote:
> > The patch "MIPS: kernel: scall: Always run the seccomp syscall filters"
> > incorrectly calculates the address of the syscall function and instead
> > attempts a load from the offset of the syscall being invoked into the
> > table. This completely trashes all n64 userland syscalls. Fix the
> > address calculation.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> > Markos: could you please test all 3 ABIs you modified? The n64 one at
> >         least has clearly not been tested.
> > ---
> 
> Calm down. it was an honest mistake. The version I sent was slighly different to
> what I had in my tree and that's why the tests were passing for me. I will send it
> again.
> 
> -- 
> markos

I'm quite calm, simply stating facts & asking you to fix your patch.
Please don't presume to know my state of mind in lieu of a very strong
indicator!

Thanks for submitting v2, though from your description I presume it's
just v1 plus this fixup, correct?

Paul

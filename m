Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 22:31:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24183 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012841AbbHFUbbwjdIh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 22:31:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CFA65BE75C5E0;
        Thu,  6 Aug 2015 21:31:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 6 Aug 2015 21:31:25 +0100
Received: from localhost (192.168.159.103) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 6 Aug
 2015 21:31:25 +0100
Date:   Thu, 6 Aug 2015 13:31:23 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Kamal Mostafa <kamal@canonical.com>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <kernel-team@lists.ubuntu.com>
Subject: Re: [3.19.y-ckt stable] Patch "MIPS: kernel: cps-vec: Replace
 mips32r2 ISA level with mips64r2" has been added to staging queue
Message-ID: <20150806203123.GG26603@NP-P-BURTON>
References: <1438811234-29408-1-git-send-email-kamal@canonical.com>
 <20150805224934.GE2057@NP-P-BURTON>
 <1438876276.12629.5.camel@fourier>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1438876276.12629.5.camel@fourier>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.103]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48695
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

On Thu, Aug 06, 2015 at 08:51:16AM -0700, Kamal Mostafa wrote:
> On Wed, 2015-08-05 at 15:49 -0700, Paul Burton wrote:
> > On Wed, Aug 05, 2015 at 02:47:14PM -0700, Kamal Mostafa wrote:
> > > This is a note to let you know that I have just added a patch titled
> > >     MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
> > > to the linux-3.19.y-queue 
> 
> > Hi Kamal,
> > 
> > This patch breaks the boot of SMP kernels on Imagination's current
> > MIPS32 systems. This & the other MIPS64 related patches that were
> > submitted as part of the same series do not improve things for any CPUs
> > that Linux supports even as of the v4.2 cycle, so I do not believe they
> > should have been marked for backport.
> > 
> > So please either drop this patch (& preferrably the other MIPS64 CPS SMP
> > ones too)
> 
> Hi Paul-
> 
> Thanks for the heads-up!  Please confirm that these are the specific
> commits to be dropped / not-applied to stable:
> 
> b677bc0 MIPS: cps-vec: Use macros for various arithmetics and memory operations
> 717f142 MIPS: kernel: cps-vec: Replace KSEG0 with CKSEG0
> 0586ac7 MIPS: kernel: cps-vec: Use ta0-ta3 pseudo-registers for 64-bit
> 977e043 MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
> 81a02e3 MIPS: kernel: cps-vec: Replace 'la' macro with PTR_LA
> fd5ed30 MIPS: kernel: smp-cps: Fix 64-bit compatibility errors due to pointer casting

Hi Kamal,

Yes those are the ones.

Thanks,
    Paul

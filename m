Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 00:49:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43405 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010939AbbHEWtmsxAz8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 00:49:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B4339A2326313;
        Wed,  5 Aug 2015 23:49:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Aug 2015 23:49:36 +0100
Received: from localhost (192.168.159.103) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 5 Aug
 2015 23:49:36 +0100
Date:   Wed, 5 Aug 2015 15:49:34 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Kamal Mostafa <kamal@canonical.com>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <kernel-team@lists.ubuntu.com>
Subject: Re: [3.19.y-ckt stable] Patch "MIPS: kernel: cps-vec: Replace
 mips32r2 ISA level with mips64r2" has been added to staging queue
Message-ID: <20150805224934.GE2057@NP-P-BURTON>
References: <1438811234-29408-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1438811234-29408-1-git-send-email-kamal@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.103]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48626
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

On Wed, Aug 05, 2015 at 02:47:14PM -0700, Kamal Mostafa wrote:
> This is a note to let you know that I have just added a patch titled
> 
>     MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
> 
> to the linux-3.19.y-queue branch of the 3.19.y-ckt extended stable tree 
> which can be found at:
> 
>     http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.19.y-queue
> 
> This patch is scheduled to be released in version 3.19.8-ckt5.
> 
> If you, or anyone else, feels it should not be added to this tree, please 
> reply to this email.

Hi Kamal,

This patch breaks the boot of SMP kernels on Imagination's current
MIPS32 systems. This & the other MIPS64 related patches that were
submitted as part of the same series do not improve things for any CPUs
that Linux supports even as of the v4.2 cycle, so I do not believe they
should have been marked for backport.

So please either drop this patch (& preferrably the other MIPS64 CPS SMP
ones too) or also backport the series I've just submitted:

    http://marc.info/?l=linux-mips&m=143881461431570&w=2

My preference would be for not backporting any of them.

Thanks,
    Paul

> For more information about the 3.19.y-ckt tree, see
> https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable
> 
> Thanks.
> -Kamal
> 
> ------
> 
> From 22a7e30c46134b8c9978a237c6d143b59b66609a Mon Sep 17 00:00:00 2001
> From: Markos Chandras <markos.chandras@imgtec.com>
> Date: Wed, 1 Jul 2015 09:13:30 +0100
> Subject: MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
> 
> commit 977e043d5ea1270ce985e4c165724ff91dc3c3e2 upstream.
> 
> mips32r2 is a subset of mips64r2, so we replace mips32r2 with mips64r2
> in preparation for 64-bit CPS support.
> 
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/10588/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> ---
>  arch/mips/kernel/cps-vec.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> index a4b2d81..bbbd88e 100644
> --- a/arch/mips/kernel/cps-vec.S
> +++ b/arch/mips/kernel/cps-vec.S
> @@ -229,7 +229,7 @@ LEAF(mips_cps_core_init)
>  	 nop
> 
>  	.set	push
> -	.set	mips32r2
> +	.set	mips64r2
>  	.set	mt
> 
>  	/* Only allow 1 TC per VPE to execute... */
> @@ -346,7 +346,7 @@ LEAF(mips_cps_boot_vpes)
>  	 nop
> 
>  	.set	push
> -	.set	mips32r2
> +	.set	mips64r2
>  	.set	mt
> 
>  1:	/* Enter VPE configuration state */
> --
> 1.9.1
> 

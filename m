Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 18:41:35 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44586 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903269Ab2H3Qlb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Aug 2012 18:41:31 +0200
Received: by pbbrq8 with SMTP id rq8so3586253pbb.36
        for <multiple recipients>; Thu, 30 Aug 2012 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NVmNLb62guqMGL8MrA8AB0+CM6ICPlD/nZ6cnwddFSA=;
        b=KSpp1xa4ElOmUaN2pCvfx3vOI8GOeFs/7pyN4m3forfWO1S08eer4Nq3/ozRaVedtn
         mXDk2cylg7w+PxV5Lxt/xCaRUPhxDOF3elIBT06RIaa17ttrPdy0rzHtFDg12FrBKnm1
         xKMCgEcmSmMhg1YGa8OgrM5NFozQTmTgfHg8y+B66OpJHdYEpuLNECLi5u0Di3TVltdp
         0V3yR+xRQOF1FyAgkOLyoph+epEvqA+SrOJ4chgXorUoy4Y9gVYH/MuvTheKwBWSybBZ
         NcCzajnG4bp3R5Myw3HX5R4l9H69IJKnJ7aSub0Krd3hQPz8DOG+Tft0FKgdUa+/KuXM
         2LcA==
Received: by 10.68.213.195 with SMTP id nu3mr12321997pbc.81.1346344884333;
        Thu, 30 Aug 2012 09:41:24 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id or1sm1847285pbb.10.2012.08.30.09.41.22
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 09:41:23 -0700 (PDT)
Message-ID: <503F97B1.9070804@gmail.com>
Date:   Thu, 30 Aug 2012 09:41:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     Jim Quinlan <jim2101024@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 2/2] MIPS: irqflags.h: make funcs preempt-safe for
 non-mipsr2
References: <y> <1346279647-27955-1-git-send-email-jim2101024@gmail.com> <1346279647-27955-2-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1346279647-27955-2-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/29/2012 03:34 PM, Jim Quinlan wrote:
> For non MIPSr2 processors, such as the BMIPS 5000, calls to
> arch_local_irq_disable() and others may be preempted, and in doing
> so a stale value may be restored to c0_status.  This fix disables
> preemption for such processors prior to the call and enables it
> after the call.
>
> This bug was observed in a BMIPS 5000, occuring once every few hours
> in a continuous reboot test.  It was traced to the write_lock_irq()
> function which was being invoked in release_task() in exit.c.
> By placing a number of "nops" inbetween the mfc0/mtc0 pair in
> arch_local_irq_disable(), which is called by write_lock_irq(), we
> were able to greatly increase the occurance of this bug.  Similarly,
> the application of this commit silenced the bug.
>
> It is better to use the preemption functions declared in <linux/preempt.h>
> rather than defining new ones as is done in this commit.  However,
> including that file from irqflags effected many compiler errors.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   arch/mips/include/asm/irqflags.h |   81 ++++++++++++++++++++++++++++++++++++++
>   1 files changed, 81 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
> index 309cbcd..d6e71ed 100644
> --- a/arch/mips/include/asm/irqflags.h
> +++ b/arch/mips/include/asm/irqflags.h
> @@ -16,6 +16,71 @@
>   #include <linux/compiler.h>
>   #include <asm/hazards.h>
>
> +#if defined(__GENERATING_BOUNDS_H) || defined(__GENERATING_OFFSETS_S)
> +#define __TI_PRE_COUNT (-1)
> +#else
> +#include <asm/asm-offsets.h>
> +#define __TI_PRE_COUNT TI_PRE_COUNT
> +#endif
> +
> +
> +/*
> + * Non-mipsr2 processors executing functions such as arch_local_irq_disable()
> + * are not preempt-safe: if preemption occurs between the mfc0 and the mtc0,
> + * a stale status value may be stored.  To prevent this, we define
> + * here arch_local_preempt_disable() and arch_local_preempt_enable(), which
> + * are called before the mfc0 and after the mtc0, respectively.  A better
> + * solution would "#include <linux/preempt.h> and use its declared routines,
> + * but that is not viable due to numerous compile errors.
> + *

I'm with Ralf's idea from the other branch of the thread.  Put all this 
non-mipsr2 stuff out of line (perhaps creating lib/mips-atomic.c).


> + * MipsR2 processors with atomic interrupt enable/disable instructions
> + * (ei/di) do not have this issue.
> + */

For mipsr2, we leave them alone so they can be inlined.

This way you shouldn't need the ugly #include hackery.

David Daney

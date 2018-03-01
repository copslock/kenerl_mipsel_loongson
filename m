Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 03:35:24 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:36820
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992404AbeCACfOVaPr8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 03:35:14 +0100
Received: by mail-io0-x241.google.com with SMTP id e30so5510665ioc.3;
        Wed, 28 Feb 2018 18:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oNjFnKQuJqWqDBM9q+ZJVgHCCDYVT0nYMZJw+pNGmP0=;
        b=QcxozZFACxBoa3JA9lczEVj/iJ0up+2m/Can9KRX1hTkb3J+br4m9qkvjMDAo7gTUw
         3TExpZclhW4EP0C8/08qGRlDvKltGAqZ6hjpI+wqn3f9udNTBdrHqu23bsPRirf7oHQE
         iUvcp7kfyd/3RL4+CoV0p53ruG/j46q8ES+rvJ/1mFzg3vujipKUWJMA7h8M85Pw18It
         cgXJCvF9VlOlEVOdBSGMJ0sOi2r0Oo0Fb5ERpMNl9A/ueXW6a55P38K+SwDSsLJMVVFv
         1v2Th+JJyHI97omo8U+AisHqEo91FV9lDncCjV5N5JpaFoI573AY55MRz/5/r96rnFqp
         6NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oNjFnKQuJqWqDBM9q+ZJVgHCCDYVT0nYMZJw+pNGmP0=;
        b=NO8f36UXVDU7nNt45NCqTmK/4aOCKXldRUQKSW4cMbEqdzFYt+D/nd7WfHLLJW4MMz
         we34BNNgUQfutJ2WSYNyHsYq6L8U00qnVk0T2EREccVy6f97TXOVDUwj9BC/UEEcLIJB
         PrfdAv41HKl7pzjcO9Lvxqa0V0rxCae5CW7yGDv/G1OV5LyC6I8g1f3z36h5uXdQCuBq
         kxpJXsyTLQlpzulo9NM2Rv2dqS+bXcvvMiePBqaiBP9fpMneKlwySPhO7md5OrZ8SXv2
         MgBf5xbjgpELZZ1ynlqQDpyX/lHYgKCaLHHvq/kZrpUESxW1xxNLlek38L83cFswm/0d
         EATQ==
X-Gm-Message-State: APf1xPD0FmU77tZoPihXJ9x0TbkkjOYf+9361EpCEygrq3a3Cyx9Mpkz
        ZZF0rY7T/LzE6vC9eAA1CxL/Joiqi1wL3tsW58A=
X-Google-Smtp-Source: AG47ELskoScgH3DPQR/yKPsdh8ym3tyh7ETIDeIIW2eNiwpIVS7NUllen1FDXP7f/RcaCU5rvEDwX3j11OQDvuG3MTQ=
X-Received: by 10.107.143.151 with SMTP id r145mr259320iod.297.1519871706907;
 Wed, 28 Feb 2018 18:35:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.187.1 with HTTP; Wed, 28 Feb 2018 18:35:06 -0800 (PST)
In-Reply-To: <20180228100353.GP6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <20180215110506.GH3986@saruman> <CAAhV-H7RMmtcc6BW7dCnZ617dx5ZZrzvbFTUekGSgLYCkZfZEw@mail.gmail.com>
 <20180228100353.GP6245@saruman>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 1 Mar 2018 10:35:06 +0800
X-Google-Sender-Auth: t6HU1ObfuEtEqZ1lzZHBkwCF4OI
Message-ID: <CAAhV-H7t956QctPMn5mbdU+YYeB9Ckv=ZHR310KCzpouYaPkYg@mail.gmail.com>
Subject: Re: [PATCH V2 00/12] MIPS: Loongson: new features and improvements
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On Wed, Feb 28, 2018 at 6:03 PM, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Feb 28, 2018 at 10:23:09AM +0800, Huacai Chen wrote:
>> Hi, James,
>>
>> I really don't want send many patches in a seris. But in practise, my
>> single patch in linux-mips usually be ignored (even they are very
>> simple and well described)....
>
> Then please feel free to reply to the patch and ask if anybody has
> feedback, stating how important the patch is for you, so it can be
> prioritised. Resends as part of other series just adds to the noise.
>
>>
>> For example:
>> https://patchwork.linux-mips.org/patch/17723/
>
> Yes, that one needs a proper look.
>
>> https://patchwork.linux-mips.org/patch/18587/
>
> This one apparently knowingly breaks the feature on other platforms, so
> can't really be applied as is. I think Matt Redfearn & I were thinking
> his single IPI stuff could potentially be helpful there too.
I think this does't break other platforms, because:
1, arch_trigger_cpumask_backtrace() will not be called in normal cases;
2, If arch_trigger_cpumask_backtrace() really be called, the old code
also doesn't work (deadlock).

>
>> https://patchwork.linux-mips.org/patch/18682/
>
> You sent that this morning so its hardly had time to be ignored, and I
> had already spotted it on my phone and intended to apply it today. Also
> I disagree that "Commit x breaks Loongson64 platforms, so fix it" counts
> as well described, even if it is simple, and obvious (to me at least)
> what you're talking about.
>
> E.g. a better description would along the lines of:
>
> Commit 7a407aa5e0d3 ("MIPS: Push ARCH_MIGHT_HAVE_PC_SERIO down to
> platform level") moves the global MIPS ARCH_MIGHT_HAVE_PC_SERIO select
> down to various platforms, but doesn't add it to Loongson64 platforms
> which need it, so add the selects to these platforms too.
I'll update my commit messages.

>
>>
>> Anyway, thank you for your susggestions, I will rework other patches.
>
> Thank you.
>
> Cheers
> James

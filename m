Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2012 11:09:09 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38128 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2G1JJF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jul 2012 11:09:05 +0200
Received: by obbta17 with SMTP id ta17so5945551obb.36
        for <linux-mips@linux-mips.org>; Sat, 28 Jul 2012 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z7SkNGRZ70BVnzB7iFrNqvOiYYMEflKFV9Uo5+7Cbjw=;
        b=Y45NFkQzlrHGdERa87NXE7vIvEFpSPx6r6wciu/jOV+YRTCSC5j+fn1+yFAVI+5tBt
         0k7VOnsgjwwT0DfddlDMmFaTsXlaDewSJReQUNv9LE0T9cv0sopIj5ecRyScWCsFdIqG
         73eBi4nZ56iSsO7nZouufmeScHgCKuaEePBhkClUthns6HLg8++JxiXpAjjsPdIdU2if
         JOmLTY+53ehCcBgsi4uujh31YGmLe0PVCQvO+ko9JSz5KqC0xin1pOQHXMqmXp2gyLbM
         qTol0g84cgM3yJc9Zxrt4nLvAPQM9G4ZJm0A136qjZWsAZnnJ8QW2eO323YVYi7jG4Tn
         Rzyw==
MIME-Version: 1.0
Received: by 10.60.19.232 with SMTP id i8mr7390477oee.35.1343466539424; Sat,
 28 Jul 2012 02:08:59 -0700 (PDT)
Received: by 10.60.61.193 with HTTP; Sat, 28 Jul 2012 02:08:59 -0700 (PDT)
In-Reply-To: <1341203670-17544-1-git-send-email-roy.qing.li@gmail.com>
References: <1341203670-17544-1-git-send-email-roy.qing.li@gmail.com>
Date:   Sat, 28 Jul 2012 17:08:59 +0800
Message-ID: <CAJFZqHxBE6wc2hJd=mKfx9D59S73qxJZFvbfqgmLkWZvtR7f_A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix tc_id calculation
From:   RongQing Li <roy.qing.li@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roy.qing.li@gmail.com
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

Any advice

2012/7/2  <roy.qing.li@gmail.com>:
> From: RongQing.Li <roy.qing.li@gmail.com>
>
> Now the tc_id is:
>   (read_c0_tcbind() >> TCBIND_CURTC_SHIFT) & TCBIND_CURTC;
> After substitute macro:
>   (read_c0_tcbind() >> 21) & ((0xff) << 21)
> It should be:
>   (read_c0_tcbind() & ((0xff)<< 21)) >>21
>
> Signed-off-by: RongQing.Li <roy.qing.li@gmail.com>
> ---
>  arch/mips/kernel/smp-cmp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
> index e7e03ec..afc379c 100644
> --- a/arch/mips/kernel/smp-cmp.c
> +++ b/arch/mips/kernel/smp-cmp.c
> @@ -102,7 +102,7 @@ static void cmp_init_secondary(void)
>         c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE;
>  #endif
>  #ifdef CONFIG_MIPS_MT_SMTC
> -       c->tc_id  = (read_c0_tcbind() >> TCBIND_CURTC_SHIFT) & TCBIND_CURTC;
> +       c->tc_id  = (read_c0_tcbind() & TCBIND_CURTC) >> TCBIND_CURTC_SHIFT;
>  #endif
>  }
>
> --
> 1.7.1
>

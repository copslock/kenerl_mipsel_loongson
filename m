Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 13:41:39 +0100 (CET)
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33258 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008752AbcBYMlfygbp- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 13:41:35 +0100
Received: by mail-wm0-f51.google.com with SMTP id g62so30155038wme.0;
        Thu, 25 Feb 2016 04:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=RVAKcbACL9y2oiJTI1uEOloUxBjy4eDsqQtqUEHjoFY=;
        b=uMrE7i7N443PAD5BjAqcMlQPqxNBbBTVHbORPkprfayyYx/QByKVdfd69elBuBwmCg
         rmS3NR/7DLwx+43cBOjilmUCWPdc+qrnwVQq9UQAqVnF14J91a5HyAcWu9FL7rZ25B8J
         mvt023UOFDMNf5rs0kxXb0SwQ3Ihwz2wZpo55Ft2YCAJVyH9tS8A7uX3a+khMGuzktgc
         nfBjCeRbHSN9SBq0JB7V3Xq/cpgsii4Op6JhHM7TRYSb1C065bwSD9kspU+YeSA7CsUk
         LOFA+8rGNiR39lXKG+n89yO5ukNRI7il54j4OrTBU4VbdBBt+9A+SUwPUgw0CpZJQ+hX
         oFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RVAKcbACL9y2oiJTI1uEOloUxBjy4eDsqQtqUEHjoFY=;
        b=N6QpKwL8y170P7NU14hpbAs6N4qOOvbgnj963Uc5I51YRgmBJEcxDnhJaawzyS0YCS
         S29XaRI8833+1WZZTqnY51wWOb/ewHH1rLlmcGlLDgTUARnGbcXAeBAV3Dt0ef2zrPJj
         z/iiMJq8twYiACkhw3KDYEJcX1L14Aw+ECcAINL6V6gclDBlcYsbe/gBKVzdOQgbzCRd
         nNTrKndGux05JaQ+59Qb8PcIwOu+N2le7CbFkBldNyxZ103Tbv561LTganUbPut8qk1R
         009gFyoANnCPi7s3yJjLNCdax/tlt88m9d6qULozckw6bNtKntLZdWqa0yP6XoXKLKgF
         25Lg==
X-Gm-Message-State: AG10YORD0ZavovEg+a+uvZC7KwMAn8sXh3c5icDG7adKCmj7LWu5lU04sKTHYfjGvxv3ZoJebE5NsfDcXhcZ9A==
MIME-Version: 1.0
X-Received: by 10.28.221.136 with SMTP id u130mr3239517wmg.40.1456404090563;
 Thu, 25 Feb 2016 04:41:30 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Thu, 25 Feb 2016 04:41:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1602251050290.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-2-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250029390.15885@tp.orcam.me.uk>
        <56CE5382.4090800@gmail.com>
        <CAAhV-H7MDTRWoDx-j-DHH1UnUmhb1CFK1go-W+Qxz+8W21qrhg@mail.gmail.com>
        <alpine.DEB.2.00.1602251050290.15885@tp.orcam.me.uk>
Date:   Thu, 25 Feb 2016 20:41:30 +0800
X-Google-Sender-Auth: TgwumbnWWpFJY42_8V5wvnW_FGA
Message-ID: <CAAhV-H46N3svYR8SPTLxZgTnQcZYOxN1H_CgG2mrw1SsP0We-g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: tlbex: Fix bugs in tlbchange handler
From:   Huacai Chen <chenhc@lemote.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52258
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

OK, I know, let me have a think. This patch fix a "bug" on Loongson,
but maybe we don't have get the root cause.

Huacai

On Thu, Feb 25, 2016 at 7:02 PM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Thu, 25 Feb 2016, Huacai Chen wrote:
>
>> I *do* have answered your quesition, which you can see here:
>> https://patchwork.linux-mips.org/patch/12240/
>>
>> When unaligned access triggered, do_ade() will access user address
>> with EXL=1, and that may trigger tlb refill.
>
>  Thank you and I can see your original answer as well, which would need to
> go into the patch description itself, however it is too vague for me I'm
> afraid.
>
>  Unaligned accesses have been likewise handled since forever and no one
> else has hit an issue with `do_ade' making user accesses with EXL=1, as
> this handler is only called once KMODE has cleared EXL.  So please explain
> us the scenario in which it doesn't happen and you still have EXL=1 in
> `do_ade'.  What the conditions for this to be the case?
>
>  Without a further explanation it looks like a bug elsewhere to me, which
> needs to be treated accordingly there, rather than by complicating TLB
> handlers.
>
>   Maciej
>

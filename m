Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 13:49:07 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34614 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008752AbcBYMtFuoeg- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 13:49:05 +0100
Received: by mail-wm0-f67.google.com with SMTP id b205so3283616wmb.1;
        Thu, 25 Feb 2016 04:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=IyZhqH8ejvZxD80LO3K61AnfLiyiHA8wKMQ6PWE09sI=;
        b=HhJ2YqGDJN02dsdFggVV7/vu2OhZ0eeIuPY8x+pRWKR26YSaW4rNqakKvi6Wuuyndw
         GAhRRygYpKWJ9HWcTlkhCd3u9585xYaR1rostXkY6OtRBtARvHvIdi5lN6Kt3rAsh30G
         +gj84NADQ0f2LS/bE3OdmepgM8M5BQ6w3gfo7nNRtWjCA1InKzR3mlIDoCdXSKvitLCB
         7hbNPR2K82KflT5XSC6tjVdyjO6hGeKL00IuszylYjZCKsD+XDEkjM4UQB79fF6fNJkr
         Nzlfw9AB8ywFzcrk6yYnjRmbJpZX7i7rUL9AmZOCq9YErDjJ5hrpX1zEE0yuny2EO0fW
         4JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IyZhqH8ejvZxD80LO3K61AnfLiyiHA8wKMQ6PWE09sI=;
        b=aEig737d358Gr/w0Sb+aVav+uigbQz5HgzlLrh87e+HwLtqD7tYFrM6tdqOcOgCMa9
         0JJK/oV6yYwNvfVpCZlNkkVbTb7uxNo4HCXJMJRhRiPcTns/YLRWwHVZFu44felA0My2
         R2zUq141pB/lloSu7vS/iP6AAzRcbkXmDbEmqBMQmgaPL1rK53e29QVvCIIMbJ5IDQsK
         C1yFmWRQYTFKRwQxnKsXTcYe6WrPxKr1GB9JOw3DJdLJ1SNj8pnqjVD4eWsNlP58L3t2
         BT/aQfxwIrs5f2iKwqHbBNvUySvTygRQZWVqdNHSzBlukJaewHHD379cq9xrnffFao/Z
         ox8Q==
X-Gm-Message-State: AG10YOScObSCEV0DI8hk3SVFaiJEhFcNEW/RRBh4cc9R75F6QZefzZySSgHJ0lj7m9AEUTszrveCnO8Cey47zg==
MIME-Version: 1.0
X-Received: by 10.28.221.136 with SMTP id u130mr3276221wmg.40.1456404540645;
 Thu, 25 Feb 2016 04:49:00 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Thu, 25 Feb 2016 04:49:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1602251221250.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-8-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250046480.15885@tp.orcam.me.uk>
        <CAAhV-H5rGWVooK5RaWxPDYV2dYBes9JetmvCisCsF1ouLWiKDA@mail.gmail.com>
        <alpine.DEB.2.00.1602251221250.15885@tp.orcam.me.uk>
Date:   Thu, 25 Feb 2016 20:49:00 +0800
X-Google-Sender-Auth: 32LJ0BOqvnMeXeiSzHzD4ZgXBfs
Message-ID: <CAAhV-H4hZM_xoe85WkB1cLwNv6XS5egpEjmV=t8RA=YANTs7rQ@mail.gmail.com>
Subject: Re: [PATCH V3 5/5] MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT
From:   Huacai Chen <chenhc@lemote.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
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
X-archive-position: 52259
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

Hi, Maciej,

Yes, we can probe whether the platform support ei/di or not. But
whether use ei/di is not depend on runtime flag, but depend on
CONFIG_* in current kernel. So I have no idea how to use ei/di by
probing.

Huacai

On Thu, Feb 25, 2016 at 8:25 PM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Thu, 25 Feb 2016, Huacai Chen wrote:
>
>> Please read my explaination: New Loongson 3 has a bug that di
>> instruction can not save the irqflag, so arch_local_irq_save() is
>> modified. Since CPU_MIPSR2 is selected by
>> CONFIG_LOONGSON3_ENHANCEMENT, generic kernel doesn't use ei/di at all
>> (because old Loongson 3 doesn't support ei/di at all).
>
>  Thanks.  This opens an interesting question though.  You've written that
> the enhancements controlled by CONFIG_LOONGSON3_ENHANCEMENT cannot be
> determined at the run time, but it looks to me like they can, either by
> checking for MIPSr2 in the CP0.Config.AR or, if you did something wrong
> about that, by trying to execute EI or DI early on and seeing if it's
> triggered an RI exception or not.
>
>  Have I missed anything?
>
>   Maciej
>

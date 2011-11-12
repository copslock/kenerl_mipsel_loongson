Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2011 17:07:35 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:58369 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab1KLQH3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Nov 2011 17:07:29 +0100
Received: by yenl9 with SMTP id l9so4897519yen.36
        for <multiple recipients>; Sat, 12 Nov 2011 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KvLU04nagQcM5Y7YkZQQVq3ZZGH2X7FzN1IX4UiFcR0=;
        b=GiGdEv5mMiNR8XyvtROsGnICsTVuoOH3lCkAQTTU4KEPcgg30eDohHIB07wuO4luRh
         43dav+BQ2Olj85DQ99zkfaTodNlMFbQkPaNXm2zWXdnP/tpVNyRf+6RAbXygL6Wc194U
         qM++j8qi+KSRHBOpjZDj2v7aJ4Y/UUrfkEkbs=
MIME-Version: 1.0
Received: by 10.68.62.136 with SMTP id y8mr33626007pbr.87.1321114042499; Sat,
 12 Nov 2011 08:07:22 -0800 (PST)
Received: by 10.68.62.169 with HTTP; Sat, 12 Nov 2011 08:07:22 -0800 (PST)
In-Reply-To: <201111121531.31483.ffainelli@freebox.fr>
References: <5f9666eb295ce196b2a9688afab07dea@localhost>
        <3989f772f7fef3b4937ab01fd3af192e@localhost>
        <201111121531.31483.ffainelli@freebox.fr>
Date:   Sat, 12 Nov 2011 08:07:22 -0800
Message-ID: <CAJiQ=7Db0gra+LHFv0nDF8+GxBfsihtHYCTw6sSgPR=8BqjJhg@mail.gmail.com>
Subject: Re: [PATCH V2 8/8] MIPS: BMIPS: Add SMP support code for BMIPS43xx/BMIPS5000
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Florian Fainelli <ffainelli@freebox.fr>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10906

On Sat, Nov 12, 2011 at 6:31 AM, Florian Fainelli <ffainelli@freebox.fr> wrote:
> - considering that BMIPS4350 has a shared TLB, is it still working fine? I must
> say that I have not yet tested on e.g: BCM6358

BCM6368 (which I did test) has a private TLB for each thread.  I have
not tested any of the shared TLB chips.

It is possible that more work will be required to cover the shared TLB case.

> - there a couple of places in the code where we have:
>
> #if defined (CONFIG_BMIPS_4350) || defined (CONFIG_BMIPS_4380)
>  ... do something
> #elif defined(CONFIG_BMIPS_4380)
>
> can we turn this into a #if BMIPS43xx case .. #endif  #if BMIPS5000 ... #endif
> to allow a single image supporting both BMIPS43xx and BMIPS5000?

Although it would be easy to check current_cpu_type() for the cases in
smp-bmips.c, there are other decisions (not in this patchset) that are
harder to make at runtime.  One obvious case is
cpu-feature-overrides.h; other cases include low-level code sequences
in the exception vectors, power management standby/resume/reentry
assembly code, HIGHMEM and cache configuration, memory map, etc.

Side note: one of Ralf's earlier comments on this patch was a request
to use pr_info() instead of printk().  This somehow fell off my TODO
list.  I will fix it and submit V4 later today.

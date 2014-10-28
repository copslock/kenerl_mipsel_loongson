Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 23:05:24 +0100 (CET)
Received: from mail-qc0-f178.google.com ([209.85.216.178]:44131 "EHLO
        mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011735AbaJ1WFWyEGgu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 23:05:22 +0100
Received: by mail-qc0-f178.google.com with SMTP id b13so1550392qcw.37
        for <multiple recipients>; Tue, 28 Oct 2014 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FePCSEBBhW5XQxG7K8BLD9KPwxn+UCBItNyPWI9nIc4=;
        b=zDnMlCsMBkyc8NwQ5J9rolbK85sOPTP42seyBZ+eTf5UrCTPEkXOYc7ufQmX/f47vW
         PKSPfeMN/eHn71oBPqPHfAUD5ZCtZR6BfkmMiHZHVeZTe43LRuJe23umd0u7dQ4hNoKd
         HPgAxDvxziffMUD4Ue5vmAk1zW+04YrPYkz+/ooCpEkBZYECbfJoyagkGc82nFdhavcz
         SVYE3C/HBywzXjp8RxYk6VxKHt67TRFaRhfBrXiFb4wXIPDUpKjQL2/RmAA6zX+Rkx6u
         /cu+HndYeJpp9RUmLrVakzJA3P2XAI/kmXpXX11xYP/gMRhC9dl6LepR8ehw5cIzgfsA
         m20Q==
X-Received: by 10.224.135.196 with SMTP id o4mr9142190qat.35.1414533916916;
 Tue, 28 Oct 2014 15:05:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Tue, 28 Oct 2014 15:04:56 -0700 (PDT)
In-Reply-To: <CAL1qeaEw-1RYcAo9Vo2e3gsV1JBVsJVOP0WSqpfrErCw0xufNw@mail.gmail.com>
References: <1414445904-4781-1-git-send-email-abrestic@chromium.org>
 <1414445904-4781-3-git-send-email-abrestic@chromium.org> <CAJiQ=7Bk4jiByynau2nR_BO6o5Rg3LpumNpDOpb=UQaYQCSknQ@mail.gmail.com>
 <CAL1qeaEw-1RYcAo9Vo2e3gsV1JBVsJVOP0WSqpfrErCw0xufNw@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Tue, 28 Oct 2014 15:04:56 -0700
Message-ID: <CAJiQ=7AvWzUu6ZYaaF54Pdz0iagwU9SgQOC=mw9ZYSu0JBTCJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip: mips-gic: Use __raw_{readl,writel} for GIC registers
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Oct 28, 2014 at 2:39 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
>> I just ran into a related problem on bcm3384, a big-endian platform on
>> which readl/writel perform extra endian swaps (CONFIG_SWAP_IO_SPACE).
>> My solution was twofold:
>>
>>  - Change the irq_reg_{readl,writel} macros so that they can be
>> configured to use the __raw_ variants on individual platforms
>>
>>  - Use irq_reg_{readl,writel} instead of directly invoking
>> __raw_{readl,writel} in our irqchip driver, so that the irqchip driver
>> code always uses the same I/O accessors as the helper functions we're
>> using from kernel/irq/generic-chip.c
>
> You could also specify your own irq_reg_{readl,writel} in your
> platform's irq.h.  Though since it seems like this is pretty common on
> MIPS platforms, maybe it makes more sense to have a Kconfig option.
> I've added the irqchip maintainers to see what they think.

I thought about just adding it to my own <irq.h>, but it looks like
several other platforms also use the __raw_ variants:

$ git grep -l __raw_ drivers/irqchip/
drivers/irqchip/exynos-combiner.c
drivers/irqchip/irq-brcmstb-l2.c
drivers/irqchip/irq-mxs.c
drivers/irqchip/irq-s3c24xx.c

Aside from irq-brcmstb-l2, these don't currently reference any of the
irq_gc_* functions.  But if they wanted to do so in the future (e.g.
because newer helper functions are introduced) they would need
generic-chip.c to use the __raw_  accessors.  So having the Kconfig
option would simplify things.

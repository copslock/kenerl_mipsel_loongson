Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 20:57:35 +0100 (CET)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:57719 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006921AbaKXT5eRUrC9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 20:57:34 +0100
Received: by mail-qc0-f172.google.com with SMTP id m20so7461755qcx.31
        for <multiple recipients>; Mon, 24 Nov 2014 11:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4ZBJC1XmW5kAv8oRXjftYnsniZ6e8kpwZMyyZegNrSo=;
        b=TMHiclgsTJcKi8J6n1vasR7uUwEfQ7pRll7BaE2XMB+geMAH3VFHiMXSd32FNPzXtj
         NN/6h6sxNNg7JK51X4+WZuAg21+8Pbb98fg6d78GyPM69DQg9bEVUiwNan8JQzSfUbJf
         VoqTvQRIm1FbzKY76SgJi9yj90nCZLDxbUenIlcKuZNtjtFt+fAV6M55Iry4PIRtMxjV
         dF6Lnri+IoHlAi9TP9FQjulk9n525eW7xgkJUYXiVJSPH3BL0MJps62Xi8GIQBMOe+Py
         xg7Tn7EKTmdgTU9SmQ9ZtCIyQRXy67CAyLNdVh54uSuTY+haVHrEHMIYfrnMtHPO7WE4
         weZQ==
X-Received: by 10.140.102.169 with SMTP id w38mr30827510qge.95.1416859048541;
 Mon, 24 Nov 2014 11:57:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 24 Nov 2014 11:57:08 -0800 (PST)
In-Reply-To: <CAL1qeaG+cmQDW3ceqq4kGgWBsf4RgfFpQ76OG0dg3SJy6nitgw@mail.gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
 <1416796846-28149-12-git-send-email-cernekee@gmail.com> <CAL1qeaG+cmQDW3ceqq4kGgWBsf4RgfFpQ76OG0dg3SJy6nitgw@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 24 Nov 2014 11:57:08 -0800
Message-ID: <CAJiQ=7BRjxaGki515mZRUt7h9917DwUpkY6yVsz-WsF8WCpvEw@mail.gmail.com>
Subject: Re: [PATCH V3 11/11] MIPS: Add multiplatform BMIPS target
To:     Andrew Bresticker <abrestic@google.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonas Gorski <jogo@openwrt.org>, Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44398
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

On Mon, Nov 24, 2014 at 11:29 AM, Andrew Bresticker <abrestic@google.com> wrote:
>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>
>> +void __init plat_time_init(void)
>> +{
>> +       struct device_node *np;
>> +       u32 freq;
>> +
>> +       np = of_find_node_by_name(NULL, "cpus");
>> +       if (!np)
>> +               panic("missing 'cpus' DT node");
>> +       if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
>> +               panic("missing 'mips-hpt-frequency' property");
>> +       of_node_put(np);
>> +
>> +       mips_hpt_frequency = freq;
>> +}
>
> Could you use common clock framework for this?  Isn't the HPT just a
> fixed factor of the CPU clock?  I'm planning on doing something very
> similar for ImgTec MIPS SoCs, so perhaps this could go in a common
> place, like the r4k clocksource driver?

Jonas and I had tossed some ideas around earlier, and I included a few
random thoughts in the cover letter.

One concern is that this currently has to be set pretty early in the
boot process (prior to jiffies calibration IIRC), so it might still
need to be handled as a special case.

Regarding the "fixed factor" question: that is true on all of the
chips I've seen, with a few additional caveats:

 - Most MIPS cores use cpu_clk/2, but BMIPS5000 uses cpu_clk/8.

 - Some MIPS cores scale the CP0 counter frequency when the cpu_clk is
changed, but others do not.  Sometimes this depends on the core rev
(e.g. 65nm BMIPS438x cores do scale, but 40nm BMIPS438x cores do not).

 - We might not necessarily have a good way to determine cpu_clk on
every platform, either.

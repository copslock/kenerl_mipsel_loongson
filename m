Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 11:52:50 +0200 (CEST)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:63553 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011590AbaJPJwtCLAid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 11:52:49 +0200
Received: by mail-oi0-f47.google.com with SMTP id a141so2374331oig.6
        for <linux-mips@linux-mips.org>; Thu, 16 Oct 2014 02:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C2kgXaINDlbm/AZfV6fs4f36JY8reCNZR7Lv9GpU9bs=;
        b=EaA1XuFFQJu1U43URNsIfejtCok4cU6QRqPLzw3xFGrpZtvLiPvjJ0708p2juKIIkK
         oJzG8fvJ1Rfo5DBglfu00+MIJyOect+XRxgRBDsFUfsfBTG7EpmDfWnwpU0Hj6aq5jo8
         2t97SHeo0xvNwqvph1wWMzah+AHcOP0/VsTwv1/4DspGafqekt4S1ZzEL6maCwoPC73r
         ZD0vAhR2hiDhnVZf8HDs9jUNqeS0puDAb+df5wgixRCf54d88gS71eIIVLI3m/RRt4+n
         PJUqMjvlno56UrBR8hdIuKDhObxc3KIXX0pLP8so4cSmaxxDR/N4xWhjotI3WdEKYtRD
         Ea8g==
X-Gm-Message-State: ALoCoQm3C+FWF0R4lJO6WYg8WUvUVjMDQ3QEmVqnvEdIuKfEomeX90bmlKbuwQMN6WdwHoGpf5mC
MIME-Version: 1.0
X-Received: by 10.202.204.200 with SMTP id c191mr73062oig.81.1413453162623;
 Thu, 16 Oct 2014 02:52:42 -0700 (PDT)
Received: by 10.182.233.170 with HTTP; Thu, 16 Oct 2014 02:52:42 -0700 (PDT)
In-Reply-To: <CAJhJPsVV74gVEMpMZfBcnm-=sHivpPZGY==tzT-rXsv82B0Scg@mail.gmail.com>
References: <CAJhJPsVV74gVEMpMZfBcnm-=sHivpPZGY==tzT-rXsv82B0Scg@mail.gmail.com>
Date:   Thu, 16 Oct 2014 15:22:42 +0530
Message-ID: <CAKohpomFP5=eO7hFJyXQqM6_jOGT9gY+f3g3qqKgYwg5rgh3Ag@mail.gmail.com>
Subject: Re: [PATCH 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B (UPDATED)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 16 October 2014 15:00, Kelvin Cheung <keguang.zhang@gmail.com> wrote:

Just to let u know, your mails are probably generated in html whereas they
should be in text mode.

> 2014-10-16 16:23 GMT+08:00 Viresh Kumar <viresh.kumar@linaro.org>:
>>
>> This is not how we send updated versions, GIT and other tools will commit
>> the "(UPDATED)" part while applying. What you were required to do was
>> something like:
>>
>> git format-patch A..B --subject-prefix="PATCH V2"
>
>
> I use 'updated' because only one patch in the patch set need to be updated.
> If you insist, I will regenerate this patch.

Even in that case you can do what I was saying. No, you don't need to resend
for that reason now. :)

>> On 15 October 2014 12:53, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
>> > +static int ls1x_cpufreq_remove(struct platform_device *pdev)
>> > +{
>> > +       cpufreq_unregister_notifier(&ls1x_cpufreq_notifier_block,
>> > +                                   CPUFREQ_TRANSITION_NOTIFIER);
>> > +       cpufreq_unregister_driver(&ls1x_cpufreq_driver);
>> > +       clk_put(ls1x_cpufreq.osc_clk);
>> > +       clk_put(ls1x_cpufreq.clk);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int ls1x_cpufreq_probe(struct platform_device *pdev)
>> > +{
>> > +       struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
>> > +       struct clk *clk;
>> > +       int ret;
>> > +
>> > +       if (!pdata)
>> > +               return -EINVAL;
>> > +       if (!pdata->clk_name)
>> > +               return -EINVAL;
>> > +       if (!pdata->osc_clk_name)
>> > +               return -EINVAL;
>>
>> I didn't wanted you to do this, You could have done this:
>>
>>        if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
>>                return -EINVAL;
>>
>> So, just a || instead of && :)
>>
>> > +
>> > +       ls1x_cpufreq.dev = &pdev->dev;
>> > +
>> > +       clk = clk_get(NULL, pdata->clk_name);
>>
>> I believe we agreed for devm_clk_get(), isn't it ?
>
>
> In my case I think clk_get() is enough.

Obviously its enough but wouldn't it be better to use a infrastructure
which is somewhat better ?

> Moreover, most of cpufreq drivers use clk_get().

So what? Is that a good enough reason for adopting a good change?

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2014 09:23:00 +0200 (CEST)
Received: from mail-oi0-f43.google.com ([209.85.218.43]:53091 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011348AbaJNHW7P-8Qd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2014 09:22:59 +0200
Received: by mail-oi0-f43.google.com with SMTP id u20so15452358oif.2
        for <linux-mips@linux-mips.org>; Tue, 14 Oct 2014 00:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TsKSYsiBG6qCtQky0JpvEhYCImCIDCtVNPS1hMifb04=;
        b=XtD6YcVaTC0u+WgkUbcfe+sBKN5bdezszugwUCLDZOwpwhDw33qTyg5RHF2P+5o0kE
         hcI9kV7ZNN0/HDMBv4+MfdfDA9NxkmJ8KtKkJwKnMarQWO+XII+snHRVAqrMQMlzjLgd
         LLRu4Fs8qI7SkotHBanAkteWTzRtKli/IFoIpYdDwrF+vBRpjkCFRygmm2nTNXYOswnr
         DQdpi5ofKeHCyKlDsVT9MW59IZuJ7zAzVofQMKvsurCtuM6Kr39PEseMwv9jwevBtt/E
         0WNlA4wFiaG4CRSOjVsD6avac7C2Ixy6HjwFMXHk3SUF5FNKU7yUKmADyVWXspoB4yfW
         huUw==
X-Gm-Message-State: ALoCoQk6DnJwuEhjPNqF+G8VI+dbV44xTbcmXWsnUQdQrBBy89B7VM+/MoTFIV76EN3MsCoN2Nxz
MIME-Version: 1.0
X-Received: by 10.202.194.67 with SMTP id s64mr3088964oif.22.1413271373211;
 Tue, 14 Oct 2014 00:22:53 -0700 (PDT)
Received: by 10.182.233.170 with HTTP; Tue, 14 Oct 2014 00:22:53 -0700 (PDT)
In-Reply-To: <CAJhJPsW+h9DEEEKfhBdz3e4tTxmA_ZBR6SbLr2jY6XJY7pMHhA@mail.gmail.com>
References: <CAJhJPsW+h9DEEEKfhBdz3e4tTxmA_ZBR6SbLr2jY6XJY7pMHhA@mail.gmail.com>
Date:   Tue, 14 Oct 2014 12:52:53 +0530
Message-ID: <CAKohpomcJM53bnRA7ef-+61KHq0DxTZ=Lf3oEUWejif5X+g_2Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43258
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

On 14 October 2014 12:29, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
>
> 2014-10-10 12:40 GMT+08:00 Viresh Kumar <viresh.kumar@linaro.org>:

>> > +#include <cpufreq.h>
>> > +#include <loongson1.h>
>>
>> Okay, it looks like I have forgotten some of the C basics :)
>> But wouldn't the above two lines search for this file in <include/*>, unless
>> you have compiled it with something like -I include/linux ??
>> And even then I don't think loongson1.h is present there ..
>>
>> What am I missing ?
>
>
> The two header files are located in arch/mips/include/asm/mach-loongson1

Okay, but I didn't knew it works this way as well. I thought preprocessor will
search in include/ and arch/mips/include/ directories only and so you need to
do this:

#include <asm/mach-loongson1/cpufreq.h>

Do you know why it works directly in your case? Probably for readability above
might be better ?

>> > +static int ls1x_cpufreq_notifier(struct notifier_block *nb,
>> > +                                unsigned long val, void *data)
>> > +{
>> > +       if (val == CPUFREQ_POSTCHANGE)
>> > +               current_cpu_data.udelay_val = loops_per_jiffy;
>> > +
>> > +       return NOTIFY_OK;
>> > +}
>>
>> Why don't you do this at a single place in mips core instead of every
>> mips cpufreq driver ?
>
>
> Most of MIPS CPUs use performance counter as the system timer, which is built-in to the CPU core. They can't do cpufreq due to lack of external timer. Therefore, the above section is not a common code.

Not sure if I understood your reply Or you understood mine :)
Let me try again to clarify the question. On freq change you need
to update 'current_cpu_data.udelay_val', this is done in both
loongson drivers.

What I was asking you is to register the notifier in some core code,
so that this isn't required to be done in all cpufreq drivers.

NOTE: The notifier routine will only be called if cpufreq is enabled
for the platform..

>> > +static int ls1x_cpufreq_probe(struct platform_device *pdev)
>> > +{
>> > +       struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
>> > +       struct clk *clk;
>> > +       int ret;
>> > +
>>
>> Try this code here:
>>
>> pdata = NULL;
>>
>> > +       if (!pdata && !pdata->clk_name && !pdata->osc_clk_name) {
>>
>> And tell me what happens here then. :)
>
>
> I will add an error message here.

Did you try what I asked you to? I wasn't talking about the message..
Though you better add it as well..

What I have asked you will result in kernel crash ..

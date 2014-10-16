Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 10:23:28 +0200 (CEST)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33713 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011575AbaJPIX0jcZwj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 10:23:26 +0200
Received: by mail-oi0-f47.google.com with SMTP id a141so2280667oig.6
        for <linux-mips@linux-mips.org>; Thu, 16 Oct 2014 01:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oHhlKXuJ6Y2g5YGnkb4P6iIsQkZxYJvR2z2Oplh/49U=;
        b=DMCQJDueIQo5+E9NrcIwMpeINP5ozcLcvF0ZGz8wo6sjPYAoJG4KRwGoBY+kcAPFfO
         fdEYbKsFiaNS+d1ZmQynH8BkK5EFOClJe8Qn+XIblgLzngrVezfbDIoybD+vgrfCIzdW
         e+/W4w6k1neBnW6bCD/sk+72e/DAIKO6zN90dNgVcrud3qBYLmNrDnzOMDqfvl09VVnc
         QlhmzlM2xEKyCvIHJC+dPvgxKusszzd0AIqRxyNiRkkBa6IRvhQvp6RxRKOQNawcSDCW
         x1vUuYBIbK22YfznSo13SVVKowXC19SFXaLC+wLi/T8kWVtbn7E0DFa+Y3iaapXrZVWb
         F0xg==
X-Gm-Message-State: ALoCoQmaNCMGnMTxtg35UcRO3hn0EvRdlojKbYhifZW2RyRpLa+cbz04JmddFfa6YRrgeg+938Bf
MIME-Version: 1.0
X-Received: by 10.60.47.84 with SMTP id b20mr623707oen.55.1413447799658; Thu,
 16 Oct 2014 01:23:19 -0700 (PDT)
Received: by 10.182.233.170 with HTTP; Thu, 16 Oct 2014 01:23:19 -0700 (PDT)
In-Reply-To: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
References: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
Date:   Thu, 16 Oct 2014 13:53:19 +0530
Message-ID: <CAKohpok9T1mT0Pb9ue0Pe8SMo4e6DEXzBn2mPoTo2rUHG+MTXQ@mail.gmail.com>
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
X-archive-position: 43296
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

This is not how we send updated versions, GIT and other tools will commit
the "(UPDATED)" part while applying. What you were required to do was
something like:

git format-patch A..B --subject-prefix="PATCH V2"

On 15 October 2014 12:53, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
> +static int ls1x_cpufreq_remove(struct platform_device *pdev)
> +{
> +       cpufreq_unregister_notifier(&ls1x_cpufreq_notifier_block,
> +                                   CPUFREQ_TRANSITION_NOTIFIER);
> +       cpufreq_unregister_driver(&ls1x_cpufreq_driver);
> +       clk_put(ls1x_cpufreq.osc_clk);
> +       clk_put(ls1x_cpufreq.clk);
> +
> +       return 0;
> +}
> +
> +static int ls1x_cpufreq_probe(struct platform_device *pdev)
> +{
> +       struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
> +       struct clk *clk;
> +       int ret;
> +
> +       if (!pdata)
> +               return -EINVAL;
> +       if (!pdata->clk_name)
> +               return -EINVAL;
> +       if (!pdata->osc_clk_name)
> +               return -EINVAL;

I didn't wanted you to do this, You could have done this:

       if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
               return -EINVAL;

So, just a || instead of && :)

> +
> +       ls1x_cpufreq.dev = &pdev->dev;
> +
> +       clk = clk_get(NULL, pdata->clk_name);

I believe we agreed for devm_clk_get(), isn't it ?

> +       if (IS_ERR(clk)) {
> +               dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
> +                       pdata->clk_name);
> +               ret = PTR_ERR(clk);
> +               goto out;
> +       }
> +       ls1x_cpufreq.clk = clk;
> +
> +       clk = clk_get_parent(clk);
> +       if (IS_ERR(clk)) {
> +               dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
> +                       __clk_get_name(ls1x_cpufreq.clk));
> +               ret = PTR_ERR(clk);
> +               goto err_mux;
> +       }
> +       ls1x_cpufreq.mux_clk = clk;
> +
> +       clk = clk_get_parent(clk);
> +       if (IS_ERR(clk)) {
> +               dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
> +                       __clk_get_name(ls1x_cpufreq.mux_clk));
> +               ret = PTR_ERR(clk);
> +               goto err_mux;
> +       }
> +       ls1x_cpufreq.pll_clk = clk;
> +
> +       clk = clk_get(NULL, pdata->osc_clk_name);
> +       if (IS_ERR(clk)) {
> +               dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
> +                       pdata->osc_clk_name);
> +               ret = PTR_ERR(clk);
> +               goto err_mux;
> +       }
> +       ls1x_cpufreq.osc_clk = clk;
> +
> +       ls1x_cpufreq.max_freq = pdata->max_freq;
> +       ls1x_cpufreq.min_freq = pdata->min_freq;
> +
> +       ret = cpufreq_register_driver(&ls1x_cpufreq_driver);
> +       if (ret) {
> +               dev_err(ls1x_cpufreq.dev,
> +                       "failed to register cpufreq driver: %d\n", ret);
> +               goto err_driver;
> +       }
> +
> +       ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
> +                                       CPUFREQ_TRANSITION_NOTIFIER);
> +
> +       if (!ret)
> +               goto out;
> +
> +       dev_err(ls1x_cpufreq.dev, "failed to register cpufreq notifier: %d\n",
> +               ret);
> +
> +       cpufreq_unregister_driver(&ls1x_cpufreq_driver);
> +err_driver:
> +       clk_put(ls1x_cpufreq.osc_clk);
> +err_mux:
> +       clk_put(ls1x_cpufreq.clk);
> +out:
> +       return ret;
> +}
> +
> +static struct platform_driver ls1x_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "ls1x-cpufreq",
> +               .owner  = THIS_MODULE,
> +       },
> +       .probe          = ls1x_cpufreq_probe,
> +       .remove         = ls1x_cpufreq_remove,
> +};
> +
> +module_platform_driver(ls1x_cpufreq_platdrv);
> +
> +MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> +MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
> +MODULE_LICENSE("GPL");
> --
> 1.9.1
>

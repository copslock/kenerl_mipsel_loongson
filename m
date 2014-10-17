Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 12:37:58 +0200 (CEST)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:57372 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011673AbaJQKh4SyAZv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2014 12:37:56 +0200
Received: by mail-oi0-f45.google.com with SMTP id i138so365957oig.4
        for <linux-mips@linux-mips.org>; Fri, 17 Oct 2014 03:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zABfAz09Ph2sSnD8Ipi6fUxaDgV0m+PLw20f5+9CCMU=;
        b=JHSf7wnhog9vxhkvtvSX8KT0+0OoGQdj8MZK3d6CvLDjW6cDfzhILb5uItSNvDl3E4
         /q5oO5m2G6lWuyiXkJ41cWtzQJuCUhvUoWgFw0c53kIl7DDdHMdTghq8VO9pYFiv5ZvK
         XPQETuK4oPG+abCpdKK1RmC4cxf3rmNhxqXou7QdxSJGI2XvL2dR8q7B/XzDLcAhaKZP
         RQBBx0rCpy0deFoYoDMgEsN66mTW6iNDBwV9hT6dxuIvpVgqHbBC+h6byS9CRyB89dP8
         VuSfzJLxaqZcz54mX1nLkBdZ6bIq60hR+k8tjKyB9hQeIcKcHFzX6R66XmhkjFc4dD+8
         wCSw==
X-Gm-Message-State: ALoCoQkGFaVeLXKCJ7tZIvlJzUzOv6gc2wrzUoj9VxKbuLFFOUDtLUX3WliP4TULttPlg4aYklx/
MIME-Version: 1.0
X-Received: by 10.182.98.168 with SMTP id ej8mr6242245obb.41.1413542270230;
 Fri, 17 Oct 2014 03:37:50 -0700 (PDT)
Received: by 10.182.233.170 with HTTP; Fri, 17 Oct 2014 03:37:50 -0700 (PDT)
In-Reply-To: <1413541411-26609-1-git-send-email-keguang.zhang@gmail.com>
References: <1413541411-26609-1-git-send-email-keguang.zhang@gmail.com>
Date:   Fri, 17 Oct 2014 16:07:50 +0530
Message-ID: <CAKohponU38r6V_VvGz0bd_nXsNeZQy5=KYK2UGKAQxpey7q9cg@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B
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
X-archive-position: 43328
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

On 17 October 2014 15:53, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
> This patch adds cpufreq driver for Loongson1B which
> is capable of changing the CPU frequency dynamically.
>
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
>
> ---
> V3:
>    Remove superfluous devm_clk_put().

Sorry for being bad to you :)

> +static int ls1x_cpufreq_probe(struct platform_device *pdev)
> +{
> +       struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
> +       struct clk *clk;
> +       int ret;
> +
> +       if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
> +               return -EINVAL;
> +
> +       ls1x_cpufreq.dev = &pdev->dev;
> +
> +       clk = devm_clk_get(&pdev->dev, pdata->clk_name);
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
> +               goto out;
> +       }
> +       ls1x_cpufreq.mux_clk = clk;
> +
> +       clk = clk_get_parent(clk);
> +       if (IS_ERR(clk)) {
> +               dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
> +                       __clk_get_name(ls1x_cpufreq.mux_clk));
> +               ret = PTR_ERR(clk);
> +               goto out;
> +       }
> +       ls1x_cpufreq.pll_clk = clk;
> +
> +       clk = devm_clk_get(&pdev->dev, pdata->osc_clk_name);
> +       if (IS_ERR(clk)) {
> +               dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
> +                       pdata->osc_clk_name);
> +               ret = PTR_ERR(clk);
> +               goto out;
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
> +               goto out;
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
> +out:

But all these goto out; doesn't make sense anymore. Just issue returns
from all places and add

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

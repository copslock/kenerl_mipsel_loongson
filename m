Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 06:21:53 +0200 (CEST)
Received: from mail-ob0-f180.google.com ([209.85.214.180]:65343 "EHLO
        mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822081AbaDCEVtA5TDB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2014 06:21:49 +0200
Received: by mail-ob0-f180.google.com with SMTP id wn1so1341061obc.25
        for <linux-mips@linux-mips.org>; Wed, 02 Apr 2014 21:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LxzBKJ1w/jXof57qyMS7KqAgRCIYwJgOKd3BTOpb5n8=;
        b=irAF7LpAcYKBn7v7pWuYFKx7I9QMDtI5PxCXYOWVnt4sch09V2fToTD2EK+1oBV+51
         dFxKQ+dOhqF2sZFmjt1DU+zgKlD3r9kykEAJ6Qs3uSlabS7XJZMd9hW2u7qygd+FVKLR
         Y8air8v0Rqo9sEa1wEVvXqolUVCmFyksy2+fMbFfCUyyrduD2aWa1ZmMOAYTseszlzv4
         yS3UhI5pEWukNVriFjsbvw6iRCuWpDyWDaz8+0lv0maCGlp55IBJIYhGFcZ2oSSL3hMN
         DmpmTFWo3W1WnFP9OdMmV4lh4mBiJ9YmcGXy5hcCCNsWlLE77uoUqx0MPF5OM8c9jPwu
         5qNg==
X-Gm-Message-State: ALoCoQn5c0JghXz92bgGlrnINYPUGlf0fx6TRRngRErtOBfd0zD227ydpFZ/XQspYHFxbtMmQ4dB
MIME-Version: 1.0
X-Received: by 10.60.131.172 with SMTP id on12mr4478585oeb.18.1396498902011;
 Wed, 02 Apr 2014 21:21:42 -0700 (PDT)
Received: by 10.182.28.168 with HTTP; Wed, 2 Apr 2014 21:21:41 -0700 (PDT)
In-Reply-To: <1396465624-21661-1-git-send-email-aaro.koskinen@iki.fi>
References: <1396465624-21661-1-git-send-email-aaro.koskinen@iki.fi>
Date:   Thu, 3 Apr 2014 09:51:41 +0530
Message-ID: <CAKohpokxg=UsiXyq1kJAqgVyj6qYoiQfryfpXGebPtB4f253FQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS/loongson2_cpufreq: fix CPU clock rate setting
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39618
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

On 3 April 2014 00:37, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Loongson2 has been using (incorrectly) kHz for cpu_clk rate. This has
> been unnoticed, as loongson2_cpufreq was the only place where the rate
> was set/get. After commit 652ed95d5fa6074b3c4ea245deb0691f1acb6656
> (cpufreq: introduce cpufreq_generic_get() routine) things however broke,
> and now loops_per_jiffy adjustments are incorrect (1000 times too long).
> The patch fixes this by changing cpu_clk rate to Hz.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: stable@vger.kernel.org
> ---
>  arch/mips/loongson/lemote-2f/clock.c | 7 +++++--
>  drivers/cpufreq/loongson2_cpufreq.c  | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/loongson/lemote-2f/clock.c b/arch/mips/loongson/lemote-2f/clock.c
> index aed32b8..699f388 100644
> --- a/arch/mips/loongson/lemote-2f/clock.c
> +++ b/arch/mips/loongson/lemote-2f/clock.c
> @@ -91,6 +91,7 @@ EXPORT_SYMBOL(clk_put);
>
>  int clk_set_rate(struct clk *clk, unsigned long rate)
>  {
> +       unsigned int rate_khz;

Initialize rate_khz here only instead of doing it separately..

>         int ret = 0;
>         int regval;
>         int i;
> @@ -106,15 +107,17 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>         if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
>                 propagate_rate(clk);
>
> +       rate_khz = rate / 1000;
> +

From here:

>         for (i = 0; loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END;
>              i++) {
>                 if (loongson2_clockmod_table[i].frequency ==
>                     CPUFREQ_ENTRY_INVALID)
>                         continue;
> -               if (rate == loongson2_clockmod_table[i].frequency)
> +               if (rate_khz == loongson2_clockmod_table[i].frequency)
>                         break;
>         }
> -       if (rate != loongson2_clockmod_table[i].frequency)
> +       if (rate_khz != loongson2_clockmod_table[i].frequency)
>                 return -ENOTSUPP;

To here:

All this code is junk and not required anymore as rate is guaranteed
to be in loongson2_clockmod_table[].. Probably you need value of
'i' here and you can pass that directly from loongson2_cpufreq_target().

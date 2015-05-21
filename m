Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 00:32:35 +0200 (CEST)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:33282 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013595AbbEUWcc6mf1P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 00:32:32 +0200
Received: by qcblr10 with SMTP id lr10so789707qcb.0
        for <linux-mips@linux-mips.org>; Thu, 21 May 2015 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oNFilUJR2mF+0bz2xu1m3UgW+VohibFIGyqN59k0laE=;
        b=RFEfYiLUHbtXFHgiwb7kFqNCpG0z1JhX3w/nfsEC4NgurY3DyHVlPs7wjM9ptVl1tJ
         hgDmdr4LJrrei4FCrc+/RF2j1bM5m3ooYhBXby3rJ2XKZif7Hz41HITYoq5lNVlxpzGW
         3zS+CC/+m62/v7p8CyeUdCN+zoGBOlJ5EmyUR690MpRFqutWshif3MmHOa5SDLYLGLgf
         yQKE4OycyBAdDwbp8q4u6a5+5g1IAAdtfVnCSGrl4H3105p4pL00ZFtv0Fjy/CxMfIMC
         1dmlbcQZvSGOfb7rc7YXcMN6tFO8ZbQ4VqxDhDz50C5IpkSrJ0rTHHFZASwS6uCcv+Li
         FTcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oNFilUJR2mF+0bz2xu1m3UgW+VohibFIGyqN59k0laE=;
        b=KiNl5XUxhVFo7MDLMgHqithobpdDeiiFXK2zmQO/MnW54X2e775HGibI92a7IRGcEx
         slSBqoqD17ijdC10jNrDD5M5nQsClGjHWZnDQuzqiV1uUBxwvGL2ojmN3saEizcGW5M5
         8lDvn6karnkFrfyZLFyviJ3xJs9rKZ98lgqxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oNFilUJR2mF+0bz2xu1m3UgW+VohibFIGyqN59k0laE=;
        b=R7OzvB69qus0EYUDEmkm1htljWO3W8h7krhYu/Ef4tkCp4Cf4n5jIHkt4smsUQQnLx
         ns9fbHV0HentFnqtD2EpdGazCsHr7jFlBxxewy8Zwb7lt3+LVYsLXtesyl5++qrRNm6P
         utveOlpWB0no0PeiRt5SkkqfzjbHlmb2i9vcrQT0CZH3kdf71qgx21aILZaseEcxhl64
         grM4oqt3yG9WgviZDKoV7/2bCahW51GU3FIKbk5ioPVqFeCVlT7nfqitnsbUq2kf9B3Z
         HuwIhFH9yRxBl/jKTr22XnGqGKxxISamHwuyffWHSWQ5NMNyxt4xn8jljaUMc1zHNEYF
         jKMA==
X-Gm-Message-State: ALoCoQn9BFwOQ1GTjft+DbmSRX5Nx5gH/P61t3uS59DgcT5swzf09cEDySIPagyYBBNxFJSBv+EQ
MIME-Version: 1.0
X-Received: by 10.140.237.67 with SMTP id i64mr7171252qhc.86.1432247549894;
 Thu, 21 May 2015 15:32:29 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Thu, 21 May 2015 15:32:29 -0700 (PDT)
In-Reply-To: <1432244260-14908-5-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244260-14908-5-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Thu, 21 May 2015 15:32:29 -0700
X-Google-Sender-Auth: er5yKp6jAlVKQ85eO3nBnkrtq2I
Message-ID: <CAL1qeaEzKh6H8HBCULJWM4yMnSQGexWmV0rrnYMViMpuzKWyLg@mail.gmail.com>
Subject: Re: [PATCH 4/7] clocksource: mips-gic: Update clockevent frequency on
 clock rate changes
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Thu, May 21, 2015 at 2:37 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> This commit introduces the clockevent frequency update, using
> a clock notifier. It will be used to support CPUFreq on platforms
> using MIPS GIC based clockevents.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/clocksource/mips-gic-timer.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index 22a4daf..71bbd42 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -79,6 +79,13 @@ static void gic_clockevent_cpu_exit(struct clock_event_device *cd)
>         disable_percpu_irq(gic_timer_irq);
>  }
>
> +static void gic_update_frequency(void *data)
> +{
> +       unsigned long rate = (unsigned long)data;
> +
> +       clockevents_update_freq(this_cpu_ptr(&gic_clockevent_device), rate);
> +}
> +
>  static int gic_cpu_notifier(struct notifier_block *nb, unsigned long action,
>                                 void *data)
>  {
> @@ -94,10 +101,26 @@ static int gic_cpu_notifier(struct notifier_block *nb, unsigned long action,
>         return NOTIFY_OK;
>  }
>
> +static int gic_clk_notifier(struct notifier_block *nb, unsigned long action,
> +                           void *data)
> +{
> +       struct clk_notifier_data *cnd = data;
> +
> +       if (action == POST_RATE_CHANGE)
> +               on_each_cpu(gic_update_frequency, (void *)cnd->new_rate, 1);
> +
> +       return NOTIFY_OK;
> +}
> +
> +
>  static struct notifier_block gic_cpu_nb = {
>         .notifier_call = gic_cpu_notifier,
>  };
>
> +static struct notifier_block gic_clk_nb = {
> +       .notifier_call = gic_clk_notifier,
> +};
> +
>  static int gic_clockevent_init(void)
>  {
>         int ret;
> @@ -160,6 +183,7 @@ void __init gic_clocksource_init(unsigned int frequency)
>  static void __init gic_clocksource_of_init(struct device_node *node)
>  {
>         struct clk *clk;
> +       int ret;
>
>         if (WARN_ON(!gic_present || !node->parent ||
>                     !of_device_is_compatible(node->parent, "mti,gic")))
> @@ -186,7 +210,12 @@ static void __init gic_clocksource_of_init(struct device_node *node)
>         }
>
>         __gic_clocksource_init();
> -       gic_clockevent_init();
> +
> +       ret = gic_clockevent_init();
> +       if (ret < 0 && !IS_ERR(clk)) {

I think you mean ret == 0 here?

> +               if (clk_notifier_register(clk, &gic_clk_nb) < 0)
> +                       pr_warn("GIC: Unable to register clock notifier\n");
> +       }

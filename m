Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 12:28:28 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37146 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011696AbbHGK20a73aA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 12:28:26 +0200
Received: by wibhh20 with SMTP id hh20so59878826wib.0
        for <linux-mips@linux-mips.org>; Fri, 07 Aug 2015 03:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8gXOcLB0hVJ2y56otkLsxCkMII+tYDju392QdVEer1U=;
        b=ikAEaJoIIZ1HxopWzQJX1zaqYLdfQFviLgttpyu3P1X8dPqzQiBAWWXl2ZuwGTmmXN
         f6gsNsIyMeo/DCblJJKEZRqc60bix/MdkjEndKqfhib6ZGQ0ZDal2K51J9UehMYUbXg6
         ULF+FWOs2SjtqIkmslFcb2zebCv7Pj0r0tV/gs5iZ5DGT6OLnf54DHRRmQZtXYxs3w2L
         Xlj5RMhG2SLgGQA5m4TKfk1CMko1DLV9Lk4zPZ+dj3s6pwMZu2zHWv9Ell7H78+GeiYf
         Rx56vphQOyQxIMLMA/FDHPFTpCiBLGLdHLONrKkmMvM4n3exgHu0LTJ9MC8ROeXQE96b
         peKg==
X-Gm-Message-State: ALoCoQl2I8PHL6MrUu+nhTVR8DY6XCLVQNkJLVkVNfwXzovHVh8SggkNxpk5zmNxOdx3KeDvmbPW
X-Received: by 10.194.239.167 with SMTP id vt7mr14353035wjc.5.1438943301241;
        Fri, 07 Aug 2015 03:28:21 -0700 (PDT)
Received: from [192.168.1.150] (185.Red-213-96-199.staticIP.rima-tde.net. [213.96.199.185])
        by smtp.googlemail.com with ESMTPSA id bg6sm13976155wjc.13.2015.08.07.03.28.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2015 03:28:19 -0700 (PDT)
Message-ID: <55C48841.3050902@linaro.org>
Date:   Fri, 07 Aug 2015 12:28:17 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH v5 6/7] clocksource: Add Pistachio clocksource-only driver
References: <1438860138-31718-1-git-send-email-govindraj.raja@imgtec.com>
In-Reply-To: <1438860138-31718-1-git-send-email-govindraj.raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 08/06/2015 01:22 PM, Govindraj Raja wrote:
> From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>
> The Pistachio SoC provides four general purpose timers, and allow
> to implement a clocksource driver.
>
> This driver can be used as a replacement for the MIPS GIC and MIPS R4K
> clocksources and sched clocks, which are clocked from the CPU clock.
>
> Given the general purpose timers are clocked from an independent clock,
> this new clocksource driver will be useful to introduce CPUFreq support
> for Pistachio machines.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
> ---
>
> changes from v4
> ----------------
> Fixes comments from Daniel as dicussed in below thread:
> http://patchwork.linux-mips.org/patch/10784/
>
>
>   drivers/clocksource/Kconfig          |   5 +
>   drivers/clocksource/Makefile         |   1 +
>   drivers/clocksource/time-pistachio.c | 216 +++++++++++++++++++++++++++++++++++
>   3 files changed, 222 insertions(+)
>   create mode 100644 drivers/clocksource/time-pistachio.c
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig

[ ... ]

> index 4e57730..e642825 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -111,6 +111,11 @@ config CLKSRC_LPC32XX
>   	select CLKSRC_MMIO
>   	select CLKSRC_OF
>
> +config CLKSRC_PISTACHIO
> +	bool
> +	default y if MACH_PISTACHIO

You don't need to add this condition.

> +	select CLKSRC_OF

[ ... ]

> +
> +struct pistachio_clocksource pcs_gpt;

static.

> +#define to_pistachio_clocksource(cs)	\
> +	container_of(cs, struct pistachio_clocksource, cs)
> +
> +static inline u32 gpt_readl(void __iomem *base, u32 offset, u32 gpt_id)
> +{
> +	return readl(base + 0x20 * gpt_id + offset);

Are you sure of the address computation ? I guess it is correct but just 
wanted you to double check.

> +}
> +
> +static inline void gpt_writel(void __iomem *base, u32 value, u32 offset,
> +		u32 gpt_id)
> +{
> +	writel(value, base + 0x20 * gpt_id + offset);
> +}
> +
> +static cycle_t pistachio_clocksource_read_cycles(struct clocksource *cs)
> +{
> +	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
> +	u32 counter, overflw;
> +	unsigned long flags;
> +
> +	/* The counter value is only refreshed after the overflow value is read.
> +	 * And they must be read in strict order, hence raw spin lock added.
> +	 */

nit: extra carriage return and comment format:

	/*
	 * blabla
	 */

> +	raw_spin_lock_irqsave(&pcs->lock, flags);
> +	overflw = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
> +	counter = gpt_readl(pcs->base, TIMER_CURRENT_VALUE, 0);
> +	raw_spin_unlock_irqrestore(&pcs->lock, flags);
> +
> +	return ~(cycle_t)counter;
> +}
> +
> +static u64 notrace pistachio_read_sched_clock(void)
> +{
> +	return pistachio_clocksource_read_cycles(&pcs_gpt.cs);

Can you double check the u32 cast to cycle_t returning a u64 from this 
function ?

> +}
> +
> +static void pistachio_clksrc_set_mode(struct clocksource *cs, int timeridx,
> +			int enable)
> +{
> +	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
> +	u32 val;
> +
> +	val = gpt_readl(pcs->base, TIMER_CFG, timeridx);
> +	if (enable)
> +		val |= TIMER_ME_LOCAL;
> +	else
> +		val &= ~TIMER_ME_LOCAL;
> +
> +	gpt_writel(pcs->base, val, TIMER_CFG, timeridx);
> +}
> +
> +static void pistachio_clksrc_enable(struct clocksource *cs, int timeridx)
> +{
> +	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
> +
> +	/* Disable GPT local before loading reload value */
> +	pistachio_clksrc_set_mode(cs, timeridx, false);
> +	gpt_writel(pcs->base, RELOAD_VALUE, TIMER_RELOAD_VALUE, timeridx);
> +	pistachio_clksrc_set_mode(cs, timeridx, true);
> +}
> +
> +static void pistachio_clksrc_disable(struct clocksource *cs, int timeridx)
> +{
> +	/* Disable GPT local */
> +	pistachio_clksrc_set_mode(cs, timeridx, false);
> +}
> +
> +static int pistachio_clocksource_enable(struct clocksource *cs)
> +{
> +	pistachio_clksrc_enable(cs, 0);
> +	return 0;
> +}
> +
> +static void pistachio_clocksource_disable(struct clocksource *cs)
> +{
> +	pistachio_clksrc_disable(cs, 0);
> +}
> +
> +/* Desirable clock source for pistachio platform */
> +struct pistachio_clocksource pcs_gpt = {

static.

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

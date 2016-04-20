Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 15:25:04 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32957 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027131AbcDTNZC3-r5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 15:25:02 +0200
Received: by mail-pa0-f41.google.com with SMTP id zm5so17969257pac.0
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/1KY9Q3sowO0zrL2LPOcIR+aXxzfr8KX/WIo+S1woYA=;
        b=tWC8yS400UulTYyd9rjpHaFZQi1MV2WbwhipZKf3HzHymtJlKc84lTKIJJytYuU0tO
         G5qBEQj472IjiW+foTIx3OpMER3dmslFCwrTleuy0YqIFOU/ifGZjd46zQoKf3q4RrQ8
         vJ7NpvKegZTtQx0/xMRzMmmVYmkfOnJESK9ax/0bdFnFSIdvHUObcM+jTueuf1xKXAfn
         o5OEk6kZru95yQun3u9+0l/yDxy/7vKQbCfK+T4zcQQAKpnCqqvP9nMnScWF+RIS25IK
         fn8aUtOZF0zIeGJSjaTCzH6XU4Yr5Ol9aaKRIwlw1SOyw9KxJqb7BLuId/Vpw0+D+R+y
         rDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/1KY9Q3sowO0zrL2LPOcIR+aXxzfr8KX/WIo+S1woYA=;
        b=HU+6fBO0eFqzWu+Z7FySOT1l0aRusAJ7Ooy/YRn3KYxuSKMPN3E6+juW8kaLP0e8oL
         xkPC/sf4W0dSiEhppbdaY1fgRo0wgc2qeZ+yzlL5PW9vO6QZrhj9zO4xkDdTV9L9LwYR
         f52xaVC4/YrJGtnYyGqzXcYbVPYxLKzIUEi4rpNf+8yPfI6KZAJ2xU+POV3ky98P3Zny
         gEFaV/sPyV+eKC/XdvHmOf9SCnnS5HfHAhiG+QtGg6l4Nh5HCm5x80owfZXnskKDYpjM
         HRQlKb9EhB7fdP6cyCuCczd7q+WWPkrKejhi//CCwlzL9sBJZffIMeLGo9NjC7+6oNGH
         zMWg==
X-Gm-Message-State: AOPr4FU8OVaTOp7hg+2viSbPz44CcZ3dmPfxa/rCmbuCey/4u6t/nIjg1jA+5yGeHS2WvChu
X-Received: by 10.66.149.194 with SMTP id uc2mr12379759pab.116.1461158696342;
        Wed, 20 Apr 2016 06:24:56 -0700 (PDT)
Received: from [192.168.27.3] ([173.71.13.195])
        by smtp.gmail.com with ESMTPSA id v9sm98512851pfi.50.2016.04.20.06.24.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 06:24:55 -0700 (PDT)
Subject: Re: [PATCH] mips: Fix crash registers on non-crashing CPUs
To:     minyard@acm.org, linux-mips@linux-mips.org
References: <1460383819-5213-1-git-send-email-minyard@acm.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <57178326.1090801@mvista.com>
Date:   Wed, 20 Apr 2016 08:24:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1460383819-5213-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <cminyard@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cminyard@mvista.com
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

Anything on this?

-corey

On 04/11/2016 09:10 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> As part of handling a crash on an SMP system, an IPI is send to
> all other CPUs to save their current registers and stop.  It was
> using task_pt_regs(current) to get the registers, but that will
> only be accurate if the CPU was interrupted running in userland.
> Instead allow the architecture to pass in the registers (all
> pass NULL now, but allow for the future) and then use get_irq_regs()
> which should be accurate as we are in an interrupt.  Fall back to
> task_pt_regs(current) if nothing else is available.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>   arch/mips/kernel/crash.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
> index d434d5d..610f0f3 100644
> --- a/arch/mips/kernel/crash.c
> +++ b/arch/mips/kernel/crash.c
> @@ -14,12 +14,22 @@ static int crashing_cpu = -1;
>   static cpumask_t cpus_in_crash = CPU_MASK_NONE;
>   
>   #ifdef CONFIG_SMP
> -static void crash_shutdown_secondary(void *ignore)
> +static void crash_shutdown_secondary(void *passed_regs)
>   {
> -	struct pt_regs *regs;
> +	struct pt_regs *regs = passed_regs;
>   	int cpu = smp_processor_id();
>   
> -	regs = task_pt_regs(current);
> +	/*
> +	 * If we are passed registers, use those.  Otherwise get the
> +	 * regs from the last interrupt, which should be correct, as
> +	 * we are in an interrupt.  But if the regs are not there,
> +	 * pull them from the top of the stack.  They are probably
> +	 * wrong, but we need something to keep from crashing again.
> +	 */
> +	if (!regs)
> +		regs = get_irq_regs();
> +	if (!regs)
> +		regs = task_pt_regs(current);
>   
>   	if (!cpu_online(cpu))
>   		return;

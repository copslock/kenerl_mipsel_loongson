Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 14:09:46 +0200 (CEST)
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37110 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992897AbcHBMJdwIA2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2016 14:09:33 +0200
Received: by mail-wm0-f51.google.com with SMTP id i5so286952436wmg.0
        for <linux-mips@linux-mips.org>; Tue, 02 Aug 2016 05:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dk8uBB+1POOth15yb1IE+czIKEddJTqZjXERODKtylw=;
        b=R30C/ephGH3qS9WNjlALZ8HZR5tZ5oXg7ecPgnS/wdlpB10KOvRPCrGTqSQ8aIAf/l
         IRFstIhU3f9kjvBJMMhqVxdhYzdTpaJX5nlQbkzksAdF883VQUBdGsx72YoTT5HEDHZE
         7cCSv+tXBk+IagOpZ64FgQixh57uLd7MSp7tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dk8uBB+1POOth15yb1IE+czIKEddJTqZjXERODKtylw=;
        b=an+8dRpSvQcmYm/oa1xjGQptuSjylaorC2OsRmQ9Kv0fzrWTzxviF4fl2GJ9KHf8dN
         AXigeYBHlU40uMb/XwHyVN5FWR0R3OdssiH0d61Ni82YSq48NBt22qVSJSjsgwOT/E+5
         1K1PrGPVBA29mSalWMpXiho3qiaa05RMCpP4FDlNTSyWUispMNSV+DWoqtQKHsi4Ku2+
         RkczkqFgk4p+d9s1BRrkArQmi6DuatF+L/T5K1SYRlgES7reXsHJ9B4ShODSfzMuiTzZ
         EdrNop/1MLk826ajuK5KLIBxiRTnKdM2hTXtF7Vk0yVCegGys8qdo5Saq6+M+9OfbvsZ
         Sbdg==
X-Gm-Message-State: AEkooutWM4eszrjnGuGt7diyYWbeYE+9gEfLVBz7mWzAP1FhrEfSGKOqejyqtmj0rjCSv8T6
X-Received: by 10.28.198.6 with SMTP id w6mr19479783wmf.63.1470139767437;
        Tue, 02 Aug 2016 05:09:27 -0700 (PDT)
Received: from [192.168.43.196] ([37.165.243.79])
        by smtp.googlemail.com with ESMTPSA id n6sm2366108wjj.5.2016.08.02.05.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 05:09:26 -0700 (PDT)
Subject: Re: [PATCH] clocksource: mips-gic-timer: make gic_clocksource_of_init
 return int
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20160801033546.26472-1-paul.gortmaker@windriver.com>
Cc:     linux-mips@linux-mips.org
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <57A08D73.6070100@linaro.org>
Date:   Tue, 2 Aug 2016 14:09:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160801033546.26472-1-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54397
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

On 08/01/2016 05:35 AM, Paul Gortmaker wrote:
> In commit d8152bf85d2c057fc39c3e20a4d623f524d9f09c:
>   ("clocksource/drivers/mips-gic-timer: Convert init function to return error")
> 
> several return values were added to a void function resulting in:
> 
>  clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
>  clocksource/mips-gic-timer.c:175:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:183:4: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:190:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:195:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:200:3: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c:211:2: warning: 'return' with a value, in function returning void [enabled by default]
>  clocksource/mips-gic-timer.c: At top level:
>  clocksource/mips-gic-timer.c:213:1: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>  clocksource/mips-gic-timer.c: In function 'gic_clocksource_of_init':
>  clocksource/mips-gic-timer.c:183:18: warning: ignoring return value of 'PTR_ERR', declared with attribute warn_unused_result [-Wunused-result]
> 
> Given that the addition of the return values was intentional, it seems
> that the conversion of the containing function from void to int was
> simply overlooked.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thomas,

can you merge this patch in tip/timers/urgent ?

Thanks !

  -- Daniel


> ---
>  drivers/clocksource/mips-gic-timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index d91e8725917c..b4b3ab5a11ad 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -164,7 +164,7 @@ void __init gic_clocksource_init(unsigned int frequency)
>  	gic_start_count();
>  }
>  
> -static void __init gic_clocksource_of_init(struct device_node *node)
> +static int __init gic_clocksource_of_init(struct device_node *node)
>  {
>  	struct clk *clk;
>  	int ret;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 11:09:18 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:52425
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990414AbdJSJJLJCwwX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 11:09:11 +0200
Received: by mail-wm0-x242.google.com with SMTP id k4so14949731wmc.1
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OpRpUyeIlRG8F1oqjx93V05/DHesxGKZ2SXrXFhYAXQ=;
        b=EBdr7o1d0K47YjDnKEuaCkPwy4OCfZxyS/scXR8DY8PIH6u56MbryL5OLjJe58CwNP
         rKzHcMJNp0jNFnnxBxcjKkAR+wmvLbcLGgSs1jblt3gTWgA+olZw/oBykvHfTkhTaSyU
         ypmZ6bfzEoR/z9y/5OECYaX8vn8r1y1m39e3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OpRpUyeIlRG8F1oqjx93V05/DHesxGKZ2SXrXFhYAXQ=;
        b=lAhDDG5J9OCgxinQmXAkr89fWzju1yrocSqekC4Gz29VpTLMlfWtB3z/BBVzvHMXhC
         mWbSoO/7Zoo8fy6GDXB5fTwT5ZeqIs7RkgEFnOqTHIBYWe/5VQa+DXkPcve5bpFVHeZd
         WoRxGJ+/9amx25ctq4zKAsq0PBfGkd+U3kpGfmfKcADB+QBvEB7GLjPsiKerOaHVy6sl
         zbvr3lKahGvfMqWY5QDyRMO6pVLBcsNNeFwSh/CUxUXZKFNLoB7AXTtPQUNd76zLoaYI
         hYy3zcVvGwES/WR+ieZOemjuPN5spzyro4T3HUpAU9g+1QK35r9f6AGoCKRPCscdUr/L
         6ojg==
X-Gm-Message-State: AMCzsaWrux9h9FTySp0sblcPxxLIxTnbbgm1RipuVphTRQsgVukW3+ad
        7jbIVifXNuyTMJfDLf15kbPMeA==
X-Google-Smtp-Source: ABhQp+QM5M9pHWVAyVIpEjM39egIRDupzH+BPfKZlMCjj7EPvXlzO4JvEfQ6lIZF2qWiV6gEJXfwJA==
X-Received: by 10.28.50.200 with SMTP id y191mr1006109wmy.74.1508404144265;
        Thu, 19 Oct 2017 02:09:04 -0700 (PDT)
Received: from ?IPv6:2a01:e35:879a:6cd0:3e97:eff:fe5b:1402? ([2a01:e35:879a:6cd0:3e97:eff:fe5b:1402])
        by smtp.googlemail.com with ESMTPSA id m26sm21407956wrb.81.2017.10.19.02.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 02:09:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] clocksource/mips-gic-timer: Fix rcu_sched timeouts
 from multithreading
To:     Matt Redfearn <matt.redfearn@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "# v3 . 19 +" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <935fff7a-674a-a9c5-904f-6ed4ec6366e2@linaro.org>
Date:   Thu, 19 Oct 2017 11:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60455
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

On 11/10/2017 16:01, Matt Redfearn wrote:
> When the MIPS GIC clockevent code was written, it appears to have
> inherited the 0x300 cycle min delta from the MIPS CPU timer driver. This
> is suboptimal for two reasons.
> 
> Firstly, the CPU timer counts once every other cycle (i.e. half the
> clock rate). The GIC counts once per clock. Assuming that the GIC and
> CPU share the same clock this means the GIC is counting twice as fast,
> and so the min delta should be (at least) doubled. Fix this by doubling
> the min delta to 0x600.
> 
> Secondly, the fixed min delta ignores the fact that with MIPS
> multithreading active, execution resource within a core is shared
> between the hardware threads within that core. An inconvenienly timed
> switch of executing thread within gic_next_event, between the read and
> write of updated count, can result in the CPU writing an event in the
> past, and subsequently not receiving a tick interrupt until the counter
> wraps. This stalls the CPU from the RCU scheduler. Other CPUs detect
> this and print rcu_sched timeout messages in  the kernel log. It can
> lead to other issues as well if the CPU is holding locks or other
> resources at the point at which it stalls. Fix this by scaling the min
> delta for the timer based on the number of threads in the core
> (smp_num_siblings). This accounts for the greater average runtime of
> CPUs within a multithreading core.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Fixes: b695d8e6ad6f ("clocksource: mips-gic: Use clockevents_config_and_register")
> Cc: <stable@vger.kernel.org> # v3.19 +
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---

Matt,

I'm dropping your series.

The first patch fails to compile because of the smp_num_siblings
variable undefined when compile testing on another arch (probably a
header is missing).

The issue the patch address could be fixed in the time framework as
stated by Thomas.

As spotted by Thomas also, the local_irq_save() is not needed in the
set_next_event() function, so the second patch is pointless and a patch
removing those local_irq_save()/restore() would make more sense.

The third patch does not longer apply after removing the two above.

 -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

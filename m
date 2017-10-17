Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 20:15:45 +0200 (CEST)
Received: from mail-wr0-x22a.google.com ([IPv6:2a00:1450:400c:c0c::22a]:46094
        "EHLO mail-wr0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992312AbdJQSPekhQvj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 20:15:34 +0200
Received: by mail-wr0-x22a.google.com with SMTP id l1so2624916wrc.3
        for <linux-mips@linux-mips.org>; Tue, 17 Oct 2017 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NVqCDIy8v6smNtiNYH1DC8eKKmD4kzRkrQKI8xBVif0=;
        b=fvPkZWeHuKWutVLcSdAStbFWDIdQ62J3nCYBV64WhWYKakruNR3BFEopVMUZyNhzWn
         oEeQxx9bEbxJecT8Fh5VV3/bwFycSA2lf6S3IPPP3gcvgZo9fOf/q/GmffQKfOHH8gUR
         QspEOE9OI8OmDgpa22wlUTE/0TTjNezMWZ4UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NVqCDIy8v6smNtiNYH1DC8eKKmD4kzRkrQKI8xBVif0=;
        b=jDEBPol/v7jxa6pgoehtKIB7uoN1I3jfmwHHO/H6WQpNPbpx3OSqAQFzRSdJPIlHmw
         URljM4U4Ka6iMxubl2Hje+5TUE0vGDFkTVP/ffQKgKd90C1nCbkzticE+Pr0+6DivXnU
         hI5N+5AAWvmgIl+gvXxfXh8RGQuhmc6+Ur4sUjGO3ZGCNe2zGcdznXh6+vriiH7yn2sX
         nweAoiDqyfAN76tBg5a2VmX2wj0tfPEnlBsx3cmewBiWIU47+zh6ApyZRcmCTeACingm
         PxLCdVicw3N36sjsn3IUYCJmk7ZybDQzEmG9s8MpkqbLFK9gh2zCvW/aOx/0/e9CqEsN
         7qlA==
X-Gm-Message-State: AMCzsaWtDxTU68jkMIHn0+CZQZ+d5uAlOSS/eM3P5OzIw3UQi9N8lLw1
        GXSFTpgYUnC65+x1RgzGwLNKUw==
X-Google-Smtp-Source: ABhQp+T6pf1cXBUcMiJfD/PYGKJlYSfwZAufd5+btw9QuMKvm0HhKjraD9YdT1CMeHEYxj3e5+adfw==
X-Received: by 10.223.157.45 with SMTP id k45mr4749126wre.94.1508264129095;
        Tue, 17 Oct 2017 11:15:29 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:d43:ee51:5d9a:a42a? ([2001:41d0:fe90:b800:d43:ee51:5d9a:a42a])
        by smtp.googlemail.com with ESMTPSA id i10sm8158416wmf.14.2017.10.17.11.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 11:15:28 -0700 (PDT)
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
Message-ID: <894a34fc-3ad2-95d8-4e44-12a8692cd152@linaro.org>
Date:   Tue, 17 Oct 2017 20:15:25 +0200
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
X-archive-position: 60432
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
Hi Matt,

I applied the 3 patches for 4.15.

Thanks.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

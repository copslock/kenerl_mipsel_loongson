Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 04:29:33 +0100 (CET)
Received: from mail-pg0-x22b.google.com ([IPv6:2607:f8b0:400e:c05::22b]:34598
        "EHLO mail-pg0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992136AbdBTD3YfT9sS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2017 04:29:24 +0100
Received: by mail-pg0-x22b.google.com with SMTP id z67so34384817pgb.1
        for <linux-mips@linux-mips.org>; Sun, 19 Feb 2017 19:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rVo67v5dTLr7wVi8boV+MV7E3felQv9VYbtfSHx8juQ=;
        b=kEHbnwna8U9NtuFWijy2vXsoy+g58ODZbBYHzIVr9ShmOL6xHXTWOLmMhwWugzkkuZ
         7ilnmj+GoAI2dXRS1xOVGvuDVZklDahAXyHyYrpubbNqG5DtoW62Si1bMPo6Vqmyf9iL
         vmY8dmolcDpDgh+kmkrCm5PgseXI/cckT32hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rVo67v5dTLr7wVi8boV+MV7E3felQv9VYbtfSHx8juQ=;
        b=tTXhR6X1D2qNSQzpC82eaILX5im4fN4LXvsk/fk5tr3m8R5c0oh/Vi7Cy+8fV9bG6z
         t4TgSUJQkogPecdn9t+9LDkYM6enPsgA3+bkB28nK6I16tqwuobGK7lKOiHQFW/S8oCi
         6MXk4/9zcCLdrkTEQLuEwoyE4Bcl/UJKxxiP7rObxxz8It6xsap1Jl9n/sGtsin/osd0
         3baXm13YPG88OGJVCZuUTgIIb1yJVFbRp93Z9fB73Q80hMrgk7d8LN3FfccIugXg7Acr
         fB+UFjgd6LgJbkuPkLNImFCXdQJ0qpHU/POz5OHVj7fANE1Ddcvoci75b8gWcm8VEgW3
         Qh1A==
X-Gm-Message-State: AMke39nN57eb+zglpUvLqIwGsP13BH3yH9Auuff13czP7Y9Ud5odfZ64Qecm1m2hQnPlgzmE
X-Received: by 10.99.160.17 with SMTP id r17mr20194691pge.50.1487561358556;
        Sun, 19 Feb 2017 19:29:18 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id m29sm31516362pfi.54.2017.02.19.19.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Feb 2017 19:29:17 -0800 (PST)
Date:   Mon, 20 Feb 2017 08:59:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Message-ID: <20170220032911.GM21911@vireshk-i7>
References: <20170217202704.33596-1-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170217202704.33596-1-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56870
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

On 17-02-17, 12:27, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add maintainer information for bmips-cpufreq.c.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> 
> This is based on PM's linux-next from today (February 17).
> 
> This patch could be squashed into patch 3/4 of the original series if that
> is acceptable (see [1]) or it can remain separate.
> 
> [1] https://lkml.org/lkml/2017/2/7/775
> 
> Changes in v2:
>   - added bcm-kernel-feedback-list@broadcom.com
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 107c10e..d4ac248 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2692,6 +2692,13 @@ F:	drivers/irqchip/irq-brcmstb*
>  F:	include/linux/bcm963xx_nvram.h
>  F:	include/linux/bcm963xx_tag.h
>  
> +BROADCOM BMIPS CPUFREQ DRIVER
> +M:	Markus Mayer <mmayer@broadcom.com>
> +M:	bcm-kernel-feedback-list@broadcom.com

Isn't this a list as well? Shouldn't this be L: ?

> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/cpufreq/bmips-cpufreq.c
> +
>  BROADCOM TG3 GIGABIT ETHERNET DRIVER
>  M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
>  M:	Prashant Sreedharan <prashant@broadcom.com>

-- 
viresh

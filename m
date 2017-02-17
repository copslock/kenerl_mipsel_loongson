Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2017 20:25:20 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:34860
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992121AbdBQTZF7gxk1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2017 20:25:05 +0100
Received: by mail-pg0-x241.google.com with SMTP id y6so4519814pgy.2;
        Fri, 17 Feb 2017 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ci+mDTeH4QgRkmLoobPqowbw3PVnVqZFE5100kpqiTM=;
        b=Fa81wXOTcbOH/2aeZYuuDjtDGjVgvS3ig8wF1rd3U3L+UH8t6qelsHDhLythr6V0rd
         WuCzgE2HbvkNnGb7auxoY/4cQnAoO0lup4Qy/0K1ivbcvYFwv2qbZVyAVpzew/aP5az7
         BARbVHzkstCbTsDdJ0SSA3WBizm7s9ArM1xsQ1qQkywFp6JLt2MBJDJU3F5FbnYDv/wr
         1d9VRHn3Z0XD8v4JoGAMnw6N4xlHiMKmkSAVsemKjs+k96tm2D9WTwd1K+h1jvpz3vKd
         3Ad33Fl2dTJqOK/P4R1lthTOhAZZ/O6V5iIPBd6+k5zN3LpeBzOXHR6GwWoHDicmu1WU
         r00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ci+mDTeH4QgRkmLoobPqowbw3PVnVqZFE5100kpqiTM=;
        b=X0G6idVW1jrYaTqXlmuEr41g6PexaUKnalPh/2ZBnBl/kG1bvdlKhs71toQTmlpcOB
         ls+WOLZDag0rifFJW1Pqm8KL9ov25aMIneM+3KQYNJj9LkakOcugs6ACqMOLgV93LCwE
         S7dJlzqVqGFvj4UKkQ70ogVfUuNGRVIMM09O4WSXrMPJS//xSV3WJWkjmQbZ92SS/EPU
         1WzAnbY6faO+mwP6zBVwOSRB+h/Y7sNTd5/uboEwLEUCNzOts0dVxjkKnZ57IuYP+9dw
         VvKPdMsfRh78qUr35+Rtgk67XHhJBZAc6Z7AofbISwkOF3LVa5L7wrocJYhVtcVwWobx
         lhBw==
X-Gm-Message-State: AMke39m3rvsrQnnVt9MFLT1XJ6OyakeuoJehe+Wihw+2Y/r+/XJbeoLS7u9Tg3/ZzrEjNg==
X-Received: by 10.84.232.5 with SMTP id h5mr13552472plk.134.1487359499850;
        Fri, 17 Feb 2017 11:24:59 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id m15sm20982278pfk.104.2017.02.17.11.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 11:24:59 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: cpufreq: add bmips-cpufreq.c
To:     Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20170217183050.31889-1-code@mmayer.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c7a1f607-6619-445a-db35-902f11569dad@gmail.com>
Date:   Fri, 17 Feb 2017 11:24:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170217183050.31889-1-code@mmayer.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 02/17/2017 10:30 AM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add maintainer information for bmips-cpufreq.c.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Looks great, thanks for adding this, one nit below:

> ---
> 
> This is based on PM's linux-next from today (February 17).
> 
> This patch could be squashed into patch 3/4 of the original series if that
> is acceptable (see [1]) or it can remain separate.
> 
> [1] https://lkml.org/lkml/2017/2/7/775
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 107c10e..db251c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2692,6 +2692,12 @@ F:	drivers/irqchip/irq-brcmstb*
>  F:	include/linux/bcm963xx_nvram.h
>  F:	include/linux/bcm963xx_tag.h
>  
> +BROADCOM BMIPS CPUFREQ DRIVER
> +M:	Markus Mayer <mmayer@broadcom.com>
> +L:	linux-pm@vger.kernel.org

Please also include bcm-kernel-feedback-list@broadcom.com here

With that:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 07:17:47 +0200 (CEST)
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36573 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014228AbcDLFRnEWDO2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 07:17:43 +0200
Received: by mail-pf0-f173.google.com with SMTP id e128so6613483pfe.3
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WEky9z4ToZpqAgd3YBxQJtd0WIL1S8nS9o3PXtL23UM=;
        b=IB37d1xQfscpXF+oCXT3PkrH+nIRuQgrmf0sdmjj+mNvsS7eZSX+SbhqF38ZBGSW9M
         gsQO0/yJhNDFVLvS7EmAAWdB9x+3AYNWypT5yU8Y/oFDse37BdBKf/KcmQFqPw7EqLzo
         ZpsjWqYnTsmYgxG82Z0f/MH1V0qRrFFKGZqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WEky9z4ToZpqAgd3YBxQJtd0WIL1S8nS9o3PXtL23UM=;
        b=W5Gji5icHVwt6ev82qUC5qBpVTDqUsMhF7rxFPQCo181DRSc/sICL5aYh0Igzy0UKI
         dcnRttZaMB6L4/z4JG9DgGUswSsuxWlXfv6L6zjH7UtOjhCM0T3mz8Vw7xnVgcKmw0m4
         7nKHs27qNYlShtqbAlmU++AvXdODzqrd+wovD6fEJC3udfWjufOZiYl6nN/kkMPhYM/+
         DDi2ZG561AmQsSjpkERbQrr3/Qe3OrvJTOkz/b3SKcm6cC3UWt5EIeOtiSvQkeD+TeQh
         HpuoQ5Ss73Zp7vML+EyZ2mPgXzSiOg2IvoguFIy+cq+eEuYTugcNfExQhbdgTlYYQ/Tb
         xPYQ==
X-Gm-Message-State: AOPr4FUULfvd7DLT6xY1iyrZKv59b+UDYCpKhiAgfQM4zui6SQ4sVu7216yjnDV8yqWUUpCj
X-Received: by 10.98.67.139 with SMTP id l11mr1915572pfi.112.1460438257008;
        Mon, 11 Apr 2016 22:17:37 -0700 (PDT)
Received: from localhost ([122.172.42.224])
        by smtp.gmail.com with ESMTPSA id r191sm39897558pfr.36.2016.04.11.22.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 22:17:36 -0700 (PDT)
Date:   Tue, 12 Apr 2016 10:47:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] cpufreq: Loongson1: Rename the file to
 loongson1-cpufreq.c
Message-ID: <20160412051732.GO16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52954
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

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch renames the file to loongson1-cpufreq.c
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/Makefile                                | 2 +-
>  drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (100%)
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 9e63fb1..bebe9c8 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -100,7 +100,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
>  obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
>  obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
> -obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
> +obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
>  obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
>  obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
>  obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
> diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
> similarity index 100%
> rename from drivers/cpufreq/ls1x-cpufreq.c
> rename to drivers/cpufreq/loongson1-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

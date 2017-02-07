Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 05:20:15 +0100 (CET)
Received: from mail-pg0-x22f.google.com ([IPv6:2607:f8b0:400e:c05::22f]:35380
        "EHLO mail-pg0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdBGEUHjreMJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 05:20:07 +0100
Received: by mail-pg0-x22f.google.com with SMTP id 194so34692757pgd.2
        for <linux-mips@linux-mips.org>; Mon, 06 Feb 2017 20:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmtEqZ/YDsczhndpLmNsk65DKDor1PzVnlKW657u9U0=;
        b=BBq/9f1FOLKKYbAGBHKRfNuAYwS/w0s/htflA69hlTljmw7awngy267W8lr05EFau2
         upcluKcdKfab77O8siSLkyrBfStZaV1HMZ00q5a1xndXZucM/BTvaBwMrAceCp6aXoRc
         SA5OYQlDTJKLPVrsGGNenzDvFxwF9BcJ4n4Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmtEqZ/YDsczhndpLmNsk65DKDor1PzVnlKW657u9U0=;
        b=kXLnHVne7BIaZe6KmchL3nQvvWeX7ODWvQaYx73qFfy5ED8oBHlhci8IGK9Y6t0+D0
         73q2XQ0TzynL/fuMhr+L+P7DK0aj6ioOstCaLLa8o/Zi9ujMvyf7H1RegK69e0VQz1gx
         8jaKEoG/q2MdwBpBQJe5a+SpMg11XFTKSiTo/gJzmSKxUjp/nHfc4MM7omq4zP1/9aMD
         d+5gpMfr0bQe66JyPEuuYftQLfJjFrMcXlhNymVWZVSX/XOJOmNcsa33ZIjHzxT0tUmG
         SpaWOdwHJyYFZ45d+IHZrphPNtCN8O6jGgaU+oK8m1qIr4wWDmOsI9RWSXINiIdakmuI
         iFug==
X-Gm-Message-State: AIkVDXILij3KfRDJcZKUpw1kZj3z29wJS+JtZyPHPELACTJ2+LX6IOBle8+Q5j6xrT1KJnOw
X-Received: by 10.99.101.199 with SMTP id z190mr17351492pgb.219.1486441201840;
        Mon, 06 Feb 2017 20:20:01 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id w76sm6227315pfd.74.2017.02.06.20.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 20:20:01 -0800 (PST)
Date:   Tue, 7 Feb 2017 09:49:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] MIPS: BMIPS: enable CPUfreq
Message-ID: <20170207041959.GP3131@vireshk-i7>
References: <20170206215119.87099-1-code@mmayer.net>
 <20170206215119.87099-5-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206215119.87099-5-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56669
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

On 06-02-17, 13:51, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Enable all applicable CPUfreq options.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  arch/mips/configs/bmips_stb_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> index 3be15cb..3cefa6b 100644
> --- a/arch/mips/configs/bmips_stb_defconfig
> +++ b/arch/mips/configs/bmips_stb_defconfig
> @@ -15,6 +15,14 @@ CONFIG_EXPERT=y
>  # CONFIG_BLK_DEV_BSG is not set
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> +CONFIG_BMIPS_CPUFREQ=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_PACKET_DIAG=y

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

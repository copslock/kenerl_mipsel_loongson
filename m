Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 05:29:34 +0100 (CET)
Received: from mail-pf0-x231.google.com ([IPv6:2607:f8b0:400e:c00::231]:33353
        "EHLO mail-pf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990778AbdBCE303m2XU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 05:29:26 +0100
Received: by mail-pf0-x231.google.com with SMTP id y143so2748007pfb.0
        for <linux-mips@linux-mips.org>; Thu, 02 Feb 2017 20:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytff7MHjpKBwWK660PijZxun+JB1rYrc8u1y3QYk8Zs=;
        b=QYv7ZBEl8eljmqbKAnum30sMxVcwTxuYuz1l18Bh5olL95hG1aZMu2mS5kv0838TM9
         Nn7G4HNJ0anAbMaQlg3rWNZMbM3dFyUf3/wnmsd4sPvc1HxiM2gr0p/vh3xqe59XkuVo
         YhZnoyx76PM3wRpT7UYqPFQgsKAngPptZAW0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytff7MHjpKBwWK660PijZxun+JB1rYrc8u1y3QYk8Zs=;
        b=faCXu15GqzmhvY5pRl6iayPKI5ejdzfqJHgxUfPX9efkXNd1754QS8jyZ3sOcr7tIq
         U9Gme0ghZJk/8VuzZJ4H9tuMJ+DsBG8IXixyG/rCzuRzJ/uBoNR5RtxpVuI2F9wq0cZ7
         a77FduH93PzqTMp9RbZPp4yhdBcWLZ0MPALjdCR6TlKceKCiQV+Oow4DlrvW7CRqR1RZ
         DscWpNuA/QFMVy4AY6Hj7EOSGVNgJs1tOykeWXzEwbfqUlg/W8iGIEEXWEgnBSUcyOBV
         8owKLeFwAwCuH40aNPj4snyuSqHHaUX/nwHTF5MWPelKYVbrZUcjgeDMbuFJAl4pokgt
         EEmA==
X-Gm-Message-State: AIkVDXIyFVAyIEl6dxQFaB0H1I/QmMdMhoK57TniKLt0S+p48ZmFpOkK8646ESz9O/dGnK+t
X-Received: by 10.98.20.81 with SMTP id 78mr15267003pfu.171.1486096160081;
        Thu, 02 Feb 2017 20:29:20 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id i21sm62361412pfi.94.2017.02.02.20.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 20:29:19 -0800 (PST)
Date:   Fri, 3 Feb 2017 09:59:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
Message-ID: <20170203042917.GL7458@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net>
 <20170202010601.75995-4-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170202010601.75995-4-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56623
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

On 01-02-17, 17:06, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Enable all applicable CPUfreq options.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> index 4eb5d6e..6fda604 100644
> --- a/arch/mips/configs/bmips_stb_defconfig
> +++ b/arch/mips/configs/bmips_stb_defconfig
> @@ -26,6 +26,16 @@ CONFIG_INET=y
>  # CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_BMIPS_CPUFREQ=y
>  CONFIG_CFG80211=y
>  CONFIG_NL80211_TESTMODE=y
>  CONFIG_MAC80211=y

Rebase your stuff over pm/linux-next and you will see some changes here. Also
schedutil is the new governor in town, you must give it a try.

-- 
viresh

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 04:31:49 +0100 (CET)
Received: from mail-pg0-x234.google.com ([IPv6:2607:f8b0:400e:c05::234]:33253
        "EHLO mail-pg0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990720AbdBHDbmJ3nhM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 04:31:42 +0100
Received: by mail-pg0-x234.google.com with SMTP id 204so44548338pge.0
        for <linux-mips@linux-mips.org>; Tue, 07 Feb 2017 19:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VYKdLF6mxuoTAZiJgIggFDLLigv/2jza1TutY7JqHZI=;
        b=RRsPeNKfD1e6e+QlpHLZr7mTKp+RygbePUXVsFDqrQJKvOLBmOl1oq2c92IjM525o5
         RBmtBEG2u5Mg6T4NuTj9RnKqUPM+HZtny9YGSlXQTDuYJBCYlSO2I194jMTGNcP8ndAz
         tD2F8T+mIDeo9k10RIxee6mwfc2ZP2Ph6Bkjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VYKdLF6mxuoTAZiJgIggFDLLigv/2jza1TutY7JqHZI=;
        b=kXQfVjgN7DZX2onjlKleOv1nHsuNpY5FEro493seBLCFnqwNCVQDtQc8sPQyxrRZh5
         QFWOnBr21IIe2RyGSCyzAt4rLoNZkQibr6a5LBDTN2bevut7VJFxqDjOcJOWr/KQqLve
         eNUFIz3gATcEgbJN3LgQuE4iy1xm6yy9wXRyKux3nSSHZYQoVHUXfaMJ2LWrFcmx7V+p
         8b88oT2aJSwiLsVccYTs7w3VigS/MGEazRVAei8Pm8XhwMv4hPz1c7rpjBO1WlgD4B+h
         lDx40rIAyNeEtwB9z3ybvQKBmxIF6tyvbnLH3WN9KQjsXgBn6+LC/o1kl9VheTjJIqaY
         3K4w==
X-Gm-Message-State: AIkVDXIBcsv3TJUcqPUQrpGhORGU7NCmM8fDpjslVjokjywpq3e9qsPFoB1K5I3eiVGyk8hV
X-Received: by 10.84.231.142 with SMTP id g14mr30973186plk.13.1486524696280;
        Tue, 07 Feb 2017 19:31:36 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id e127sm14840991pfh.89.2017.02.07.19.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 19:31:35 -0800 (PST)
Date:   Wed, 8 Feb 2017 09:01:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] cpufreq: bmips-cpufreq: CPUfreq driver for
 Broadcom's BMIPS SoCs
Message-ID: <20170208033130.GD14503@vireshk-i7>
References: <20170207215856.8999-1-code@mmayer.net>
 <20170207215856.8999-4-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170207215856.8999-4-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56729
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

On 07-02-17, 13:58, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add the MIPS CPUfreq driver. This driver currently supports CPUfreq on
> BMIPS5xxx-based SoCs.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig         |  10 +++
>  drivers/cpufreq/Makefile        |   1 +
>  drivers/cpufreq/bmips-cpufreq.c | 188 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 drivers/cpufreq/bmips-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

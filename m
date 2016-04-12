Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 07:20:27 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33160 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014448AbcDLFUYrBX62 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 07:20:24 +0200
Received: by mail-pa0-f54.google.com with SMTP id zm5so6586914pac.0
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x4OPrMtU4Uskd8AVWXzZPuzN77EyWDvAWNXhwE5u2HM=;
        b=BQRQCm2aJr9Aa37I8+5sB28C+sUv9kP5I+KNf1ab9vvk8Z3q6PZoUTY1stOSXMDmop
         zeYe1Mqm/4kWuzo1f97vs7kcPJHWekiIf64Zu30W4GorWRP8tZyvCLrSyGZ0rknavEay
         D6q0d8JwAr5h1vDlX+xAU6ktD66Bi0LYQaUSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4OPrMtU4Uskd8AVWXzZPuzN77EyWDvAWNXhwE5u2HM=;
        b=Kiv69t/7dDWyxln8RZZYVBjL34rww5HopbGwFWp5Dkukv4RdPZLS0WgdC2Gp57ZTXS
         vxvdJUbl2YHNKUKBiFmpJ4Qa66o0k8vMQtWk1T/06Pd36N6l3Yi9m0P/5UCgyUnoAWoa
         mXKgaYJ+vgy/rRn+1ehqlQjeDjsJXuzTPbvHPqKNNxYm+vqLgP4nfzKh0dU8YHsZv42c
         T3s4EAJJQTNa5we1PCRsezKvaXYJNJudHJohtMPaaHdVOElEYmzFoXckxy2MEZzJe4a8
         GuVx6HMAPAMqN5XQdEwFF6dfulQex85vAy0QcRyx/KZlOTNsnJN89eRSYmSe2DgIpQab
         jQKg==
X-Gm-Message-State: AOPr4FWGy70UIcSEIAaz+34c09hpQKkW4mXyMWd8wa8WTZoIwcveMjzA/ZtjorDnGS+4LKyS
X-Received: by 10.66.33.1 with SMTP id n1mr1897204pai.65.1460438418730;
        Mon, 11 Apr 2016 22:20:18 -0700 (PDT)
Received: from localhost ([122.172.42.224])
        by smtp.gmail.com with ESMTPSA id dh8sm39982158pad.46.2016.04.11.22.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 22:20:17 -0700 (PDT)
Date:   Tue, 12 Apr 2016 10:50:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] cpufreq: Loongson1: Use devm_kzalloc() instead of
 global structure
Message-ID: <20160412052014.GR16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-4-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460375759-20705-4-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52957
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
> This patch uses devm_kzalloc() instead of global structure.
> 

Why are you doing this? The commit log should contain that.

> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 63 ++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)

I don't have any issues with you doing this, but I don't think that's
necessary to do.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 12:43:33 +0200 (CEST)
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33089 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026402AbcDLKna0BXNN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 12:43:30 +0200
Received: by mail-pf0-f175.google.com with SMTP id 184so11810008pff.0
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2016 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oFG6935Yk+JbDFrwxlxEvgHCY9AtSVJFLLandKqMvNE=;
        b=Y6VFJkPMm+DHl+E+csP14iDpCbrMITrg0cjC8s5m3uzNu44WIUbL0Hcgz47c7GYJhb
         iyS2nneaXYjk8bykIYBrGFWDOK5qIcSN9P4ST/FSF+aGaBiiKF30+rTWVWRNe/5msD4v
         oGp0RcHaNDt3efVfeUnODzliZ8RIXXs0H20mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oFG6935Yk+JbDFrwxlxEvgHCY9AtSVJFLLandKqMvNE=;
        b=ZoruuVieTGIzbDZSUe/sV6TX8Btejn9vcDjiTlmyY5IgloGAHHWL9qZxZBgDTxhm5B
         qgQ5Vj52ItBpnqh/gQ5G3zP3qDqp6JEy7pd1ZgcEBUhva7epHGw+3cY4yJD2h6wI2qd7
         1EVDxkLEa9AmhTFInfRyzriUHE2pAAKSaBVWdVxOOxj3sq7kRnv2bN8kbObiWbTqju3O
         yHr9vdfGujAmhvGh00LZTNrEdUGXXhitbAaNhweN8Ts+eMcaoNO2f/1r5TphUmJQtidM
         tzAmpiSP4LhYXUQxVy8hHWmRJq3RAD6jA2zoyHVmuGENx5YBcMHgCF/KReF/lZ9TQuYl
         HPiA==
X-Gm-Message-State: AOPr4FWqsvncAl3V1tIhpDoRESAy/RS6fb9joR1v1japn3LZguS9TnznxPInEVjlMJwmE3fq
X-Received: by 10.98.44.73 with SMTP id s70mr3634691pfs.2.1460457804737;
        Tue, 12 Apr 2016 03:43:24 -0700 (PDT)
Received: from localhost ([122.172.42.224])
        by smtp.gmail.com with ESMTPSA id u2sm42619049pfi.26.2016.04.12.03.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2016 03:43:23 -0700 (PDT)
Date:   Tue, 12 Apr 2016 16:13:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V1 1/5] cpufreq: Loongson1: Rename the file to
 loongson1-cpufreq.c
Message-ID: <20160412104319.GA17650@vireshk-i7>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52964
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

On 12-04-16, 18:40, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch renames the file to loongson1-cpufreq.c,
> and also includes some minor updates.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> ---
> V1:
>    Merge the minor updates into this patch.
> ---
>  drivers/cpufreq/Makefile                                |  2 +-
>  drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (96%)

For the entire series.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

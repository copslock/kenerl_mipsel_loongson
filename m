Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2016 08:57:08 +0200 (CEST)
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34499 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025675AbcDGG5EY5x1C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2016 08:57:04 +0200
Received: by mail-pf0-f171.google.com with SMTP id c20so50074153pfc.1
        for <linux-mips@linux-mips.org>; Wed, 06 Apr 2016 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HwoQSKaIMOWOxfSbjYL8xMEMiDdbqPGbmHo3EhF0Tig=;
        b=fkv5CrahDz5n39NWLyYd6Zb69hCIzvO8nD/HWnZ7EB2X99rJXViKB/cD+iZfkp2FwD
         vUGezhye2liNl3NEr7aF2D8w5hthmngddp7SRGbxuPPSLRFQIEVh1Bqa/xSQwNS9Oarl
         ZUVXF6xQiglhFh9Uu94BxoijFLWY5EiFfMA+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwoQSKaIMOWOxfSbjYL8xMEMiDdbqPGbmHo3EhF0Tig=;
        b=DwRtVRdx9xRVwmYz7uJL9ur+fMR1YWEmTaOcnKpdqyOuJr0f23DYyu2EIpIgp2Htc0
         Ypjj1c/xhzij8CE51Tp5QU6TMswg2LwPv7vCAbGrnBp4s75ZIWpRuZWHqMhZGJs6/ylW
         ZmWtgfuDqgYXmwwD5oGe+0MotchPDBU6bMUxm+tWZJBcjWDuUGBTYthNy8/ZfaMFKL05
         RG4Iy+1bHE+KzBTcdeqlj/dG6glBXnqWKLIscf0Pt+PiIrZFbEVZK9Ljk1K44n0V+QN5
         6Y7qgjAFKJbPbXnQjCltUEIafq7SRjsBuZ1/cVXaR1I/dRqKIwM3IeoOHN+Am2CA0uFg
         /i1Q==
X-Gm-Message-State: AD7BkJLlwtWZc7WFLv5n2qrhda4gd3bswDSJ+jb9TW18pRRv0FnGcTiDpghWrHiGJjfXVgdu
X-Received: by 10.98.13.216 with SMTP id 85mr2395143pfn.143.1460012218262;
        Wed, 06 Apr 2016 23:56:58 -0700 (PDT)
Received: from localhost ([122.171.65.211])
        by smtp.gmail.com with ESMTPSA id l81sm9409889pfj.21.2016.04.06.23.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Apr 2016 23:56:57 -0700 (PDT)
Date:   Thu, 7 Apr 2016 12:26:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH V1 2/7] cpufreq: Loongson1: Update cpufreq of Loongson1B
Message-ID: <20160407065655.GH14903@vireshk-i7>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-3-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459946095-7637-3-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52922
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

On 06-04-16, 20:34, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Rename the file to loongson1-cpufreq.c
> - Use kcalloc() instead of kzalloc()
> - Use devm_kzalloc() instead of global structure
> - Use dev_get_platdata() to access the platform_data field
>   instead of referencing it directly
> - Remove superfluous error messages
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/Makefile            |   2 +-
>  drivers/cpufreq/loongson1-cpufreq.c | 230 ++++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/ls1x-cpufreq.c      | 222 ----------------------------------
>  3 files changed, 231 insertions(+), 223 deletions(-)
>  create mode 100644 drivers/cpufreq/loongson1-cpufreq.c
>  delete mode 100644 drivers/cpufreq/ls1x-cpufreq.c

This can't be reviewed. I am not going to compare them line by line to
see what you might have changed in between.

Please use '-C -M' options of git format-patch to generate this, it
will give a review-able output of this.
-- 
viresh

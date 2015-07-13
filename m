Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 04:30:47 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35448 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbbGMCapW892u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 04:30:45 +0200
Received: by pdrg1 with SMTP id g1so83424353pdr.2
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 19:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=b4jPR+F9b4S/6rxAeWo+6O9CdBrYlqvJToPlGDDp4fA=;
        b=bQF4ppNQQFsuiF+TwEiZczKKCFYbklbXmJYHw/A6W9c9DPJwmeTTxyz8m356rWXhLh
         QYSZOfE3tSzzTqYgLImQ7h61YJHrpqm5k2V0ayfrfqFCpBo0S1VFf+ovvWtQ2ZwENZtD
         U20IpW30/XmvkcuRvSmh+qYuOQH/bQDtH868T9aBobPu9+qH4ObDQTmYBG8Zdi6z43fN
         obASq8MpvcQkikX9p7KyMw0fiaiwSGErYvbrUzR2GCslnU4M9OFux7ChBKzQD49+IpvE
         GQnjdjYpLNlxsAdKrav+5+8I4OXuCBMIZfn07pXu6unKZ/WRHwx7/OATMVPANnPSdqGB
         rL0A==
X-Gm-Message-State: ALoCoQm85sb7TrI648Xgj4eszcy4tHlf08lQsxGeEWlE9J9RJ5MmxzKURDexM3+77BCiVOyTSMRm
X-Received: by 10.68.94.37 with SMTP id cz5mr18385474pbb.70.1436754639159;
        Sun, 12 Jul 2015 19:30:39 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by smtp.gmail.com with ESMTPSA id si7sm16485651pbc.54.2015.07.12.19.30.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 19:30:38 -0700 (PDT)
Date:   Mon, 13 Jul 2015 08:00:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] MIPS: Loongson 2F: fix broken build due incorrect
 includes
Message-ID: <20150713023032.GB10415@linux>
References: <1436537377-7138-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436537377-7138-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48213
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

On 10-07-15, 17:09, Aaro Koskinen wrote:
> Commit 30ad29bb4888 ("MIPS: Loongson: Naming style cleanup and rework")
> renamed mach-loongson to mach-loongson64. Some files are including
> loongson.h using the asm/mach-loongson directory name, so the build
> got broken. Fix by removing the directory name; the mach directory
> is automatically in the include path.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Fixes: 30ad29bb4888 ("MIPS: Loongson: Naming style cleanup and rework")

> ---
>  arch/mips/loongson64/lemote-2f/clock.c | 2 +-
>  drivers/cpufreq/loongson2_cpufreq.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

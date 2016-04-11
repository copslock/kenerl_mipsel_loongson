Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2016 05:52:27 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34239 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007911AbcDKDwWhxyJI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2016 05:52:22 +0200
Received: by mail-pa0-f51.google.com with SMTP id ot11so29654243pab.1
        for <linux-mips@linux-mips.org>; Sun, 10 Apr 2016 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bncTgeEF1gpa6GWbfap2wHgmUchce6Jb+8+iquqYzac=;
        b=bsosoT9640yQK5OfvXkiH6m0fKUPXGJmkjg5ciNqlVnApKu5tRa3AHAd42g1FU/LtD
         uDPI/Kg+boSgFUn6LJuPMZJYqNpHFTmnSvF2uK+oGBEGRmRu8JW7Rj0wLIxPRVtJ2SA3
         Gz9n7b0N+szaJ6y0UkXuBtwWZsN40wS6y+n4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bncTgeEF1gpa6GWbfap2wHgmUchce6Jb+8+iquqYzac=;
        b=aPdEA98fib6XK+1ae0hp25CRWB3KJNzmQf5sYkiL9qoarTx6pyACG37fskbFJFT2yh
         dbIIX7qHqYmw4EVcZkZtJiPU4jPjiMNj4bopUJJ93Okc4GSWUsyfPGmyuo4pq6j3Xs34
         yr1lrB2uVJUxQrXvAABPhktXxME6orH0I74uHnyTJGits/5hTZa0bipfd+9+MuoS7q0h
         DOmUpTCxzk910i5kFqKkpjkpyR1E2ZriUPvcPxQhJQ3xEZIdjyh3sulIOuAXjKLTJAa4
         d5oWcB94iPL+8PotkL2zIeWeWVxqKrzRe4sEZg0lXAuZhbcnLe4rfbua4EF04LUtVcvq
         oKGw==
X-Gm-Message-State: AD7BkJLf6tDzzcApYrsnRiF7w3B8+A7EwzPS06QzrlObKU+loHbxioHkrpkCDmw1ncK5aNZL
X-Received: by 10.67.21.205 with SMTP id hm13mr29920535pad.56.1460346736436;
        Sun, 10 Apr 2016 20:52:16 -0700 (PDT)
Received: from localhost ([122.172.42.224])
        by smtp.gmail.com with ESMTPSA id 3sm32097502pfn.59.2016.04.10.20.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Apr 2016 20:52:15 -0700 (PDT)
Date:   Mon, 11 Apr 2016 09:22:11 +0530
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
Subject: Re: [PATCH V2 2/7] cpufreq: Loongson1: Update cpufreq of Loongson1B
Message-ID: <20160411035211.GA16238@vireshk-i7>
References: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
 <1460115779-13141-2-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460115779-13141-2-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52945
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

On 08-04-16, 19:42, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Rename the file to loongson1-cpufreq.c
> - Use kcalloc() instead of kzalloc()
> - Use devm_kzalloc() instead of global structure
> - Use dev_get_platdata() to access the platform_data field
>   instead of referencing it directly
> - Remove superfluous error messages

Its much better now, in the sense that I can see what you have done.
And see you have done a lot.

That's not how you are supposed to send the patches, sorry.

You need to break this patch into multiple patches, each targeting a
particular fix.

And I have no idea now, what change you have done to make it work for
Loongson1B. Which of the above changes does that?

And please, just send out a separate cpufreq series and don't send
everything in a single patchset that covers DMA, cpufreq, clk, etc..

-- 
viresh

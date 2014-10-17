Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 11:48:08 +0200 (CEST)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:48256 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011672AbaJQJsHN6KHX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2014 11:48:07 +0200
Received: by mail-oi0-f45.google.com with SMTP id i138so310517oig.32
        for <linux-mips@linux-mips.org>; Fri, 17 Oct 2014 02:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=e0cGZvM01eIa37OWBceZgXqH8cMlx18cinI9M7UJekI=;
        b=Cx31F/ci7M2UNy6FojcBaNjYVIBn3G5jp84FHsFYvi20ZG3AiY/REIcFCR8Qb3/6Hr
         OzUecRxJNW6USJ8zDR2PnRbxbDOlGM6Uq3QIbU6GAnevokTnpE/WUY8PfIUKOARyC9p4
         0C+IUkqksfw56NiMfxRjgHeWAj0Lam5adZY6saRpY5GIEFUDMgIh1QwI1JUDIRvN4pPw
         KytQj0yMXidYyYeKBiML13vLt/aeH2ocMpfevtVzbDAXGvlBBYZMQ+e5sCjUuBmW0W3S
         AWwV4QDRD7l+5u+EF3TZV7HIntLzJEziSAvqAJFXourhCgKijnTMUCXX9D8lZRDKJCfd
         Pv1w==
X-Gm-Message-State: ALoCoQlVmHPLbxVRs4S4pSr0Q86QpMdtF2fHv4VOMpW/EPPBmPWqMvDoq3OcBURCSud5D449W7y9
MIME-Version: 1.0
X-Received: by 10.182.38.135 with SMTP id g7mr6091894obk.19.1413539280930;
 Fri, 17 Oct 2014 02:48:00 -0700 (PDT)
Received: by 10.182.233.170 with HTTP; Fri, 17 Oct 2014 02:48:00 -0700 (PDT)
In-Reply-To: <CAKohpo=iRubshWkv0xj6DDomeR-wdYs3y2QebCgW5u-dvu0J3g@mail.gmail.com>
References: <1413527826-22906-1-git-send-email-keguang.zhang@gmail.com>
        <CAKohpo=iRubshWkv0xj6DDomeR-wdYs3y2QebCgW5u-dvu0J3g@mail.gmail.com>
Date:   Fri, 17 Oct 2014 15:18:00 +0530
Message-ID: <CAKohpokYhpTU-SXYuLbGz4TxhhWvring_2PB-CVBWeGjdeeXKA@mail.gmail.com>
Subject: Re: [PATCH V2 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43325
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

On 17 October 2014 13:47, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17 October 2014 12:07, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
>> V2:
>>    Use devm_clk_get() instead of clk_get().
>
> Search for a few drivers which have used this API and understand how
> to use it.

To elaborate it a bit further, devm_* routines are there to make our
lives simple.
And they do it by allowing us to skip error handling.

So in your case because you are doing devm_clk_get(), you don't have to put
the clk on errors or in remove() routine. The device core will do that for you
once the device/driver bond finishes.

Also, what about clk_enable/prepare for these clks? You don't need them ?

--
viresh

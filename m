Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 21:44:00 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:40111
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeABUnyPAzSn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 21:43:54 +0100
Received: by mail-wm0-x243.google.com with SMTP id f206so62690946wmf.5
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sqa4wcFOzsK/w+xWWltjSkD10+sFhWH89avhZ7OYMBE=;
        b=tI5FjQeY8ltc4iMW0OjEKRa58qWv8PrQK827+39V2WHLKGOk2faN8v8wri8HOeIpfj
         Zhoo3UWg3CtdI1v9poUxg8bUp4pX38nI0SVC6snz+e6eYPU8So4X4l4HihtWmT1HCoi+
         BpEpA+lTY4s7W33ee1qxLxFqOKNzZji8T5ApCLnYTH1H1P0OZtSdNCwYmAWGEQqqbzWD
         WP83e7XSdLbihVJPCQFfJzv/xe8NmMTmyIbKY4fzHYitIFi+wJkBO1hvPws9/5e+b+4/
         X8gKfhe3svRSvpeEQnlv8ZPxSIuzu6C74T6Wk/X/dJtaXvQ861ZYiFQ/RlN0Jo8n0v8s
         pF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sqa4wcFOzsK/w+xWWltjSkD10+sFhWH89avhZ7OYMBE=;
        b=IJDDdDT63wiyvDjyWWAh3OaTlb01MbLQFyR3XKIbs1I/ImTFyXJFZBD9CUW0XjfGJH
         UW5jDJoLFqYJkdMR+SOhdnyHT/NpivzrLFSLY2L1cl+1G6Bs5uaqj4/EnEjfljW7N6Ng
         8tAPsq7uR1T8F5HjxTM0TAJ4w7pfdoxnypXdrHkp9jBaw7epHN4ByNUmqiiif3oGew5u
         W9GWE2gKp3iLn6ckk7mvgb4t8foyF5b0+FSvdW2GgyEoTJDgPHJGYNUQw7qmlxZvtQBv
         niwalHjOpv575mBW/Ze4fKH6g4BvBTjB3vlYenCkuieoHcEoChultqcQe6dQih7FmEsk
         bBpw==
X-Gm-Message-State: AKGB3mK3/zDEtg35Rg0aCitw5oaiN4kX5O5SUATe4kAOFYqY5twqGwCf
        kWFZVBLO5WysVx5Ae7o+cKXl3g==
X-Google-Smtp-Source: ACJfBouzEb188PinczhHncIVV8ayr7oYC/HL+T/mJYBFlVWH56L1ex8erVJJXKdUTbUC5Tmu2MCTlQ==
X-Received: by 10.80.170.87 with SMTP id p23mr65544519edc.289.1514925828856;
        Tue, 02 Jan 2018 12:43:48 -0800 (PST)
Received: from [192.168.178.80] (D4CCACC7.cm-2.dynamic.ziggo.nl. [212.204.172.199])
        by smtp.gmail.com with ESMTPSA id g45sm41163858eda.88.2018.01.02.12.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 12:43:48 -0800 (PST)
Subject: Re: [PATCH 01/33] clk_ops: change round_rate() to return unsigned
 long
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-rpi-kernel@lists.infradead.org,
        patches@opensource.cirrus.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
 <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
 <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
 <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
 <20180102190159.GH7997@codeaurora.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <c2212d56-a8b5-cba5-46a7-c2c7f66e752b@nexus-software.ie>
Date:   Tue, 2 Jan 2018 20:43:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180102190159.GH7997@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <pure.logic@nexus-software.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pure.logic@nexus-software.ie
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

On 02/01/18 19:01, Stephen Boyd wrote:
> On 12/31, Bryan O'Donoghue wrote:
>> On 30/12/17 16:36, Mikko Perttunen wrote:
>>> FWIW, we had this problem some years ago with the Tegra CPU clock
>>> - then it was determined that a simpler solution was to have the
>>> determine_rate callback support unsigned long rates - so clock
>>> drivers that need to return rates higher than 2^31 can instead
>>> implement the determine_rate callback. That is what's currently
>>> implemented.
>>>
>>> Mikko
>>
>> Granted we could work around it but, having both zero and less than
>> zero indicate error means you can't support larger than LONG_MAX
>> which is I think worth fixing.
>>
> 
> Ok. But can you implement the determine_rate op instead of the
> round_rate op for your clk?

Don't know .

> It's not a work-around, it's the
> preferred solution. That would allow rates larger than 2^31 for
> the clk without pushing through a change to all the drivers to
> express zero as "error" and non-zero as the rounded rate.
> 
> I'm not entirely opposed to this approach, because we probably
> don't care to pass the particular error value from a clk provider
> to a clk consumer about what the error is.

Which was my thought. The return value of clk_ops->round_rate() appears 
not to get pushed up the stack, which is what the last patch in this 
series deals with.

[PATCH 33/33] clk: change handling of round_rate() such that only zero 
is an error

> It's actually what we
> proposed as the solution for clk_round_rate() to return values
> larger than LONG_MAX to consumers. But doing that consumer API
> change or this provider side change is going to require us to
> evaluate all the consumers of these clks to make sure they don't
> check for some error value that's less than zero. This series
> does half the work,

Do you mean users of clk_rounda_rate() ? I have a set of patches for 
that but wanted to separate that from clk_ops->round_rate() so as not to 
send ~70 patches out to LKML at once - even if they are in two blocks.

If so, I can publish that set too for reference.

AFAICT on clk_ops->round_rate the last patch #33 ought to cover the 
usage of the return value of clk_ops->round_rate().

Have I missed something ?

> by changing the provider side, while ignoring
> the consumer side and any potential fallout of the less than zero
> to zero return value change.
> 

Can you look at #33 ? I'm not sure if you saw that one.


---
bod

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 23:57:36 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:54506
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992724AbdJSV53B1jwL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 23:57:29 +0200
Received: by mail-wr0-x242.google.com with SMTP id o44so9693656wrf.11
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0i//BqYQeQr5pVdwAkO9/tDj0nZMaFydP+vJLYeVyY=;
        b=ct0wE3qcifAVy/xL+QmpH/G40d3bW0fpjlRmCVPJ58IQ2pgIWFIH8Mj35tSkv9CYM4
         n4YcL2DCbpUw8mubQNmrZYtf47WYoCyIy/0apNV9cLLRGC55HPuWr6wsAq6BgS6HepjE
         dDz8vWxigXaHo8o/FKlmP6K/sATyIVMlvocX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0i//BqYQeQr5pVdwAkO9/tDj0nZMaFydP+vJLYeVyY=;
        b=TCPihthY0/1aVkNPBQpwdmrB+Zzkk7LwD4R1y4QcLMs1JegdFOwh1PSA4aeWnqT+vt
         +1yztmYZXNAJghstvtZKRux08VK/593O70EGbg52gY6WDFP/jr/C/W9h5jIfWHT/ufkj
         wPKLt6R64zVxAWpW4z4z6kbph/j+FvXFHBDHLppCS8d29BZLqho/KSpAGEOMp5YA23Jw
         MoolUrQCNt7ZrJ/Egjg8KyFm15CHdzteGyrqgtfrTQiU7BETh9lWidL7dcfzMAH4Xo5L
         zGsOmjA/XWnuOYyXTjxnTpuE2vA21GhvxYaZPdYspW2HNoxbdR81PcwxfOK15iMnHvE8
         mq0A==
X-Gm-Message-State: AMCzsaVMh6OWY//SeCspmmGZ9IExUU3dvH4DH4mzjE4/1DmMbjwWydVO
        O9TuD9tJz4FNvaMSuRBAg/v4kA==
X-Google-Smtp-Source: ABhQp+TqJF7fyqCAx30vK0xMSAxzxcmzxBXM1bfRmDNQJdWariiUeWnu8vbCVXQucTsJq/wAtGIvgw==
X-Received: by 10.223.134.84 with SMTP id 20mr2978218wrw.60.1508450243500;
        Thu, 19 Oct 2017 14:57:23 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:701a:c0e8:2292:6730? ([2001:41d0:fe90:b800:701a:c0e8:2292:6730])
        by smtp.googlemail.com with ESMTPSA id w126sm2711180wme.25.2017.10.19.14.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 14:57:22 -0700 (PDT)
Subject: Re: [PATCH 2/3] clocksource/mips-gic-timer: Remove pointless
 irq_save,restore
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Matt Redfearn <matt.redfearn@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com>
 <1508414135-29123-2-git-send-email-matt.redfearn@mips.com>
 <c6502af9-cc33-da3e-a204-322c570e9cb4@linaro.org>
Message-ID: <1d30889c-54b4-1085-d324-79ffde776546@linaro.org>
Date:   Thu, 19 Oct 2017 23:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <c6502af9-cc33-da3e-a204-322c570e9cb4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 19/10/2017 15:23, Daniel Lezcano wrote:
> On 19/10/2017 13:55, Matt Redfearn wrote:
>> gic_next_event is always called with interrupts disabled, so the save /
>> restore is pointless - remove it.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
> 
> Applied for 4.15. I slightly changed the description and fixed:
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>

... and removed the unused variable 'flags' :/

https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=clockevents/4.15&id=7957b07b559175500b2a03e8a39738c1b4a832fe


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

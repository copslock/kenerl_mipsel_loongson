Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 15:23:50 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:51632
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992618AbdJSNXf3UnIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 15:23:35 +0200
Received: by mail-wr0-x242.google.com with SMTP id j14so8327142wre.8
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zN4BHSYDCmj3qbLYUmLeQg+Ng67N1JGW97+CX4zix98=;
        b=EujlpXHKWDhcJZOqCC+3BTM4G7lmgOkQiE5P97sQo/ATw3RI6xnzJ8RQwx5YUs1ohR
         oeJf2zd9VwxKO8Nmc1xhuM9oDkcxPk64GdTsGFLsR0Eey0RIOKs1pO8jh5f2fYuZS/o1
         eLPjmG8L8u3k1Lc+hp8cNwRX7vxG6+0es3/8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zN4BHSYDCmj3qbLYUmLeQg+Ng67N1JGW97+CX4zix98=;
        b=jCqbudAj8QSiIDDEJFWJwbVgdxRB7PsPYEOStXLWW9j83IkwS0gAF4olSmWPQLwZhq
         x75VgTpETCGcDQ18vu7j7SlelpSIJvfByVcWx+iOEazPIus5VbLJv/sYvodI/s0r95yU
         en2Z2834qXMAK/f49wCqxIRb18FGGuFMxV1nQO8brHO5Dka/LUiP1u8L6pG+s0iD95Hs
         IL7CJIs07crzdd3J6xNiTkvA+rEYU8V8FglAfXWEacqsvzD+Hn3d2SCI1Fq4ZLDTVXuG
         kDJFzdjwmVFKa2GlPSa0zaiGs3NHPoNyMMxiCPL0CuR9zj6n1XYMDSyeSwY1c1+VF+zI
         eJPg==
X-Gm-Message-State: AMCzsaUTFlUEJUOuKt/cFR485ucYBbXrsvFDYVw84qmDg/QyrVu5kD/a
        4f70O5HZyYT/kfFxnAyZ8HEbEQ==
X-Google-Smtp-Source: ABhQp+SFcnNlSeKRDnBxHM20P5eGOEytrGZRgBvd8+wl4lecLzznFJsnVMBMUOLSrKwUh3S7mRhGSQ==
X-Received: by 10.223.190.14 with SMTP id n14mr1590642wrh.18.1508419408223;
        Thu, 19 Oct 2017 06:23:28 -0700 (PDT)
Received: from ?IPv6:2a01:e35:879a:6cd0:3e97:eff:fe5b:1402? ([2a01:e35:879a:6cd0:3e97:eff:fe5b:1402])
        by smtp.googlemail.com with ESMTPSA id 38sm9662617wrl.76.2017.10.19.06.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 06:23:27 -0700 (PDT)
Subject: Re: [PATCH 2/3] clocksource/mips-gic-timer: Remove pointless
 irq_save,restore
To:     Matt Redfearn <matt.redfearn@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com>
 <1508414135-29123-2-git-send-email-matt.redfearn@mips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c6502af9-cc33-da3e-a204-322c570e9cb4@linaro.org>
Date:   Thu, 19 Oct 2017 15:23:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1508414135-29123-2-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60468
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

On 19/10/2017 13:55, Matt Redfearn wrote:
> gic_next_event is always called with interrupts disabled, so the save /
> restore is pointless - remove it.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied for 4.15. I slightly changed the description and fixed:

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks!

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

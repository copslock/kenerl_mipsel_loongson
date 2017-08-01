Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2017 14:19:42 +0200 (CEST)
Received: from mail-wm0-x231.google.com ([IPv6:2a00:1450:400c:c09::231]:38782
        "EHLO mail-wm0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994249AbdHAMT1xFCEm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Aug 2017 14:19:27 +0200
Received: by mail-wm0-x231.google.com with SMTP id m85so13037511wma.1
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2017 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DXldsEBBT9tYcZt2Ry5dOgqRuMO20/rAPNjAPkbSlgs=;
        b=bOV5zrsv7GUNNzE+ILUWBqh1yWVqADq3tcpKEHIKqL4M+B8NKSImnu7cemxo7r7zST
         nRKkfXbcr66xWwO6gR5YQdd0zdiZY1chYMauns+jbRUBgzRlFCGOZQ9gn2wcEKGOePK5
         T2a+Xz2/ZyxfZkDbq0Evt3GChkI7zr1Kgh84I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXldsEBBT9tYcZt2Ry5dOgqRuMO20/rAPNjAPkbSlgs=;
        b=Mc8aQd6aBxhYXPSBjb6HyiHe1TzwnxdUWAdof0Rj6muLBKSN3nFW9LBD4PfnXkAT5i
         xMYxY6Ep9GAnCuZEkCTUwmNiGFlrlzqWj2W+JJgCih48ZxEtCzdfYSiv9+CWFb83yaEr
         ET7o057/4soYupo2vIRz4Ox779SV0Q0b9fzBqqoHq/EHNhQF/2wHHme2uREpVUtmH9SH
         UM9rtYouxSTulm/68pJzmcLfsIo8jIINvYM1izk4WeZUQFTjcb8De4/6CPnSZF7+5Wgc
         Pq1ZoesR3ioy4mhM+iYZ6TcQtG3XE+2vWKfNQb9GD1h3Mbh7GRaK7vMfyLiLH9vbcx7x
         /q/Q==
X-Gm-Message-State: AIVw11030kPQpCqBRrrFV31+LutLYPC7svDFx9mo/jmcSdfurQ0FIZWu
        6Up6E72zxWeNbIJw
X-Received: by 10.28.55.193 with SMTP id e184mr1327832wma.75.1501589962220;
        Tue, 01 Aug 2017 05:19:22 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:54e1:923e:a595:aebf? ([2001:41d0:fe90:b800:54e1:923e:a595:aebf])
        by smtp.googlemail.com with ESMTPSA id 53sm1395766wry.31.2017.08.01.05.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 05:19:21 -0700 (PDT)
Subject: Re: [PATCH v2] CLOCKSOURCE: Fix CLKSRC_PISTACHIO dependencies
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mips@linux-mips.org, akpm@linux-foundation.org,
        kbuild-all@01.org, arnd@arndb.de, abbotti@mev.co.uk
References: <d5581fe0-2420-655b-3c3c-25c316f05576@mev.co.uk>
 <1500366339-2780-1-git-send-email-matt.redfearn@imgtec.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4591872d-71ee-7ff5-d381-83b4a072f775@linaro.org>
Date:   Tue, 1 Aug 2017 14:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1500366339-2780-1-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59311
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

On 18/07/2017 10:25, Matt Redfearn wrote:
> In v4.13, CLKSRC_PISTACHIO can select TIMER_OF on architectures without
> GENERIC_CLOCKEVENTS, resulting in a struct clock_event_device missing
> some required features and build breakage compiling timer_of.c. One of
> the symbols selecting TIMER_OF is CLKSRC_PISTACHIO, so add the
> dependency on GENERIC_CLOCKEVENTS.
> 
> Thanks to kbuild test robot for finding this error
> (https://lkml.org/lkml/2017/7/16/249)
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Suggested-by: Ian Abbott <abbotti@mev.co.uk>
> ---

Applied thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

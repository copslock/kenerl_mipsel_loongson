Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 05:12:43 +0200 (CEST)
Received: from mail-wm1-x341.google.com ([IPv6:2a00:1450:4864:20::341]:51952
        "EHLO mail-wm1-x341.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990396AbeIXDMhE2bfe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Sep 2018 05:12:37 +0200
Received: by mail-wm1-x341.google.com with SMTP id y25-v6so690404wmi.1
        for <linux-mips@linux-mips.org>; Sun, 23 Sep 2018 20:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+SNeM+3rEiB9AOJ7flDOpSJUnC15RRsbdFD5lT7uKC0=;
        b=SnqAMKCCGlWIo/gOYkuoAs6fkjlHU+/PYDwsByRhX8K9QEb0k+OOvp7jo0cYnz0VoJ
         gYfDgSLx7YBuZk5tL1/bvp/R+CYcS+ic+3Urbh28xnTHUWHPmUSnSFi47oIsT+OaVRP3
         Wdr13LB00WqD50k9N2Q7Wke0wOF97W/UopqT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+SNeM+3rEiB9AOJ7flDOpSJUnC15RRsbdFD5lT7uKC0=;
        b=FOL+Dh2grU3OzMwJGL8OWK4N0Bo5Sd0OgbEDZ7MoNHVLdYFjb+THjxFLRvFt5op1Fr
         UHmEoiMOQblwpmEjcf7tUIDXI00JCWElifHkPG99W1kXGG8QAN6z2k6kTEuud3kotdRH
         KTBCWO08sL4Li8OroO0G1ig7v6LScxl9UV7MNsa/MreAun8RZfanLpOtmsmiTjChLqGW
         YfCCKJUU+5UztTdjw1XMP1BIUXCN4guk8zuBWJx/82AgKSh5DOvE1cDivV7fb+okh+Po
         ma6cewrtCjNknwEFSCH9WdH961AtHm+hk6R/67dYD8y1DiF82SSvR78NR9ZAOKijlMaV
         Iy2w==
X-Gm-Message-State: ABuFfohg83TTrJuNsby6TRfmoAfPyioLhvHj+axpsrwLpy/ZCBoiPTUi
        ZI9K+RH/C60DplhjOAcSz+OQBw==
X-Google-Smtp-Source: ANB0Vdays2jX5iJ+DbdDiAqzMmKDj57HlI7Zx1ZrlnPZ6HnjXxnmIM3fgkhpedb1bS6kSJDV7g3VIA==
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr5661512wmi.35.1537758751389;
        Sun, 23 Sep 2018 20:12:31 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id k63-v6sm31067102wmd.46.2018.09.23.20.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 20:12:30 -0700 (PDT)
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-6-paul@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e0836866-552f-374b-d271-a4ea2d4953ac@linaro.org>
Date:   Mon, 24 Sep 2018 05:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821171635.22740-6-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66493
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

On 21/08/2018 19:16, Paul Cercueil wrote:
> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> with a clocksource and a sched_clock.
> 
> It also provides clocks and interrupt handling to client drivers.

Can you provide a much more complete description of the timer in order
to make my life easier for the review of this patch?

Thanks

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

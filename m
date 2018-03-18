Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 23:13:31 +0100 (CET)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:36377
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994697AbeCRWNZZ50MF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 23:13:25 +0100
Received: by mail-pl0-x244.google.com with SMTP id 61-v6so9083857plf.3
        for <linux-mips@linux-mips.org>; Sun, 18 Mar 2018 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPZsdqQ90By7rkmGcBHJhYiR6yf9SXC5gqS8gJnkmXg=;
        b=TyOxmMsPAEfKi6/h9HlcNoSe/eNtzMeZ+TkxSpiwTJ1aqFBIDQJ6vFZyzqRLyqPyh+
         if4JGm31HGBeEHxKmaAqgM9n2GvhiAnam2bQTdXLOxJYGWKqBd7c+Uoa+jo0rLRn67TN
         6moIULRspbQFz8pru4C4/9cxs2jtXGtLZPIs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPZsdqQ90By7rkmGcBHJhYiR6yf9SXC5gqS8gJnkmXg=;
        b=Muiq3vpL4xLHJ6XzNsZuN2tNVdiRFt6AhwesQktf93sjKUJFQnrAiq8P1CQoBlOvsc
         irurdMzgv6Hw35ZS/3EvW15nknO7Hi0DZY/t060fKGIIRJ492v+DizntdEkpEqNaV0qv
         hjOLXUz7YWuLK+E7Q2sUR3dsvoJ7ftPb4v275an7nLMPEVOOjKhWki3yQJHfze/zz5uk
         OltZOFMElFhyU4v50NkRbQE8BVhQbjXjYOL9lRcg0RETzvjgTtzGdzXxu+GxxGHJi3LN
         HkwOyHoll3wptaPWvWKyl/T0m0H4oN6vteyH+iX641Y/0zXsQgToUKe1bLKbtU8U9Z8M
         /8hw==
X-Gm-Message-State: AElRT7FqOYyGZQHsqxw+Yc6X9yOJChrGFKkT0xRqa+UuPdD1+mqecKT2
        +gXldhVfC856cBNDal8SDzfl5Q==
X-Google-Smtp-Source: AG47ELtRQUtlD6j/ltIY+IqoWcWfVTDLvAnjRU1gdQkFHzMsTZhgunhE/izCerQNWpJ+Y/kLoEM9EA==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22-v6mr10011123plo.169.1521411198616;
        Sun, 18 Mar 2018 15:13:18 -0700 (PDT)
Received: from [172.16.47.110] (165084180235.ctinets.com. [165.84.180.235])
        by smtp.googlemail.com with ESMTPSA id q13sm22662162pgr.52.2018.03.18.15.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 15:13:17 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Ingenic JZ47xx Timer/Counter Unit drivers
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aeb57b92-6932-9774-dc50-7563d30846bf@linaro.org>
Date:   Sun, 18 Mar 2018 23:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63039
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

On 18/03/2018 00:28, Paul Cercueil wrote:
> Hi,
> 
> This is the 4th version of my TCU patchset.
> 
> The major change is a greatly improved documentation, both in-code
> and as separate text files, to describe how the hardware works and
> how the devicetree bindings should be used.
> 
> There are also cosmetic changes in the irqchip driver, and the
> clocksource driver will now use as timers all TCU channels not
> requested by the TCU PWM driver.

Hi Paul,

I don't know why but you series appears in reply to [PATCH v3 2/9]. Not
sure if it is my mailer or how you are sending the patches but if it is
the latter can you in the future, when resending a new version, not use
the in-reply-to option. It will be easier to follow the versions.

Thanks.

 -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

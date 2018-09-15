Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:06:53 +0200 (CEST)
Received: from mail-pl1-x641.google.com ([IPv6:2607:f8b0:4864:20::641]:35768
        "EHLO mail-pl1-x641.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeIOVGtUIMEp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:06:49 +0200
Received: by mail-pl1-x641.google.com with SMTP id g2-v6so5691006plo.2;
        Sat, 15 Sep 2018 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+XkuEniWG8bSFclXKTX7622e8IxcVj+Pfp7AbtgPBFc=;
        b=fU09ZNARDuVgNUWguZqM7lyI+2OIkoKtJsTqp36DmHL1NMn90osQDmScHlF2B+GYCD
         +pFtJ8qGzZV66Rtf395WJ4GNoS1tG4lzFwswj+vch+yMoFWxchrRpo0bdM7jCBdt4uLG
         ZzVTNWA6gCB03wK/qyIS16myLJukxTI3KwJroFfFmfvIu12h6gpcq+M/r6EBMdW9NB4U
         y4pQPJUvrWNDY7H9/Wi8P6xv6uu1Y4cpYY8sYuaQC/rfXHvITn5NMzXvAVolpIIYLbFX
         p849Q+xSK+WNSY7VC0MTTW5vG4ZxVEoFrNLIS+GmunAag+SWH9hHYUqq8w15qY/nHVmY
         tt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+XkuEniWG8bSFclXKTX7622e8IxcVj+Pfp7AbtgPBFc=;
        b=JpMcBB7+cythqLheYoa2JXQ1LhToobP5CzU0KZmx9SZQaAQhHOTsz9jyXjo4T6pgaz
         9Z6fCZh3T+h42aA+0wlgElOnBIjWGhSSFxnEmZS4ERkJ6n+YAUpPWCOOQaI9TrLccdY8
         /TrfvzA5AzhXK1pUk2QnDMKDnJApz1rWD4IkGyFb+EawWcoN0Pd9pZis16FvKKbFZuQ5
         p+Ft5wYbZYrVXF6NlwPAtqxg6BRQNEKb1let8dXjbBWL+Y/RQYAz61/tuTU0qnNrgbwD
         SLrAwRHjnVRrnYULjzIDfTpUdi5lu3TG666xtBLQ6W1W3B9bDce3ENAA/hbuK40ydIrQ
         8cHA==
X-Gm-Message-State: APzg51CTdA+jdJ1BpvuGQT0c/SYqaweZ4Lw4zJk/EMGapp4mC9FdYEYA
        7vyJc5BregPCUdpCBKjS4so=
X-Google-Smtp-Source: ANB0VdYUUb6JmhTOIUiqWqgiI4pMmNGQCG8TGOYVRWjazbS947Yf02c2/mgSDTJ8f8SQQk9gk9W4uw==
X-Received: by 2002:a17:902:b902:: with SMTP id bf2-v6mr18248189plb.185.1537045602772;
        Sat, 15 Sep 2018 14:06:42 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v72-v6sm18942615pfj.22.2018.09.15.14.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:06:41 -0700 (PDT)
Subject: Re: [PATCH net-next v3 05/11] net: mscc: ocelot: simplify register
 access for PLL5 configuration
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <b09eb1026a2870c6cc882997ac69e25fdf7a96d8.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c44a927b-013d-caff-0689-24d361ca4406@gmail.com>
Date:   Fri, 14 Sep 2018 19:26:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b09eb1026a2870c6cc882997ac69e25fdf7a96d8.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 09/14/18 01:16, Quentin Schulz wrote:
> Since HSIO address space can be accessed by different drivers, let's
> simplify the register address definitions so that it can be easily used
> by all drivers and put the register address definition in the
> include/soc/mscc/ocelot_hsio.h header file.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

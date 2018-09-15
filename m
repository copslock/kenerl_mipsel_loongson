Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:05:01 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:44347
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeIOVE5JCl6p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:04:57 +0200
Received: by mail-pg1-x543.google.com with SMTP id r1-v6so5909863pgp.11;
        Sat, 15 Sep 2018 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aVCA8w0qTqnZepwGgnWk7wASGey8vBP05GMzK9vjJuA=;
        b=dLZj9q0oKvdIas2Db9+EhcW7RjPeN6YQ0Ssg1LB1/uNXv7/4nrsP1VEh6XoaopPeU4
         gVPpsy3YFFfpIFwHxxtGzRPjWcMdbVrIjIyLuSOISXpdufVVRQkTdcO8IOtl7DIVhKt2
         LaBAxiMBfVOpl0zqYk8j8jOWCw3bJw0CSO6xUjAXCu5G2hbZDUWC0zTJK6WKmuqv6N6i
         uOFwRiJ5UlacE1hKc1MYGEznFea4DkNWLi/Yti4lJoP32p3yhXYhvWi2IqPD+5lsPz/L
         d8xjLVIKlFga8foAQMyUUESgTzd5WRnBdffNVn+0Htwcz97cgLwsWRdEiCfyFNJhBktY
         eP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aVCA8w0qTqnZepwGgnWk7wASGey8vBP05GMzK9vjJuA=;
        b=fcdz38SWAz9Hd16rtwYtDEGk+eSKBBr1qrHaeG3DAq2XAfaP0wiBuT+tUSK9Yr3uCF
         dGnpcB8RnhDUwuakWkhqjEmVZzX31tfb09CC0TR3pfHAwUkrYwOkA99KKTzogmLkZ+aQ
         1zZojH8jz4ZPEomAPghwUzcZmLPaCISjXOG+DwojUhH7EPmS6qpOv2/K81tA3f0HAagI
         b18BSv3qAP3fMFLNWzabL8JnmFl4/nPO5BZLXUG25qD+cz9e7mKf1gl7W62RHG//qG91
         PCGxuQJWJqr1cKND5cdHXpJQV+bA9j6Zxrdn8qvpMkc83q+g91ZljQbdLs2ijXGmp8Ri
         KfTQ==
X-Gm-Message-State: APzg51Dt0gc+0JXB2mogSZ2QV4qBVauCip9ikOMW18tU7RTJXC17qsXm
        iMVeqsvgXZ0NiKLE4j0F9dQ=
X-Google-Smtp-Source: ANB0VdaEaXM+LYV0kPsHrVE/3wrP2Kwt9TH7aFO4yCrNCFE5qOIda8E8JY2rHrCuZFoP7VNN9Lmv0w==
X-Received: by 2002:a63:a112:: with SMTP id b18-v6mr14855061pgf.384.1537045490764;
        Sat, 15 Sep 2018 14:04:50 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id x24-v6sm13416824pfh.67.2018.09.15.14.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:04:49 -0700 (PDT)
Subject: Re: [PATCH net-next v3 04/11] net: mscc: ocelot: move the HSIO header
 to include/soc
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <45bc0a8bd6a1dfc35adcedc3581124879fdb5a07.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <17213365-dac5-1dc4-b5a6-96560455c426@gmail.com>
Date:   Fri, 14 Sep 2018 19:24:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <45bc0a8bd6a1dfc35adcedc3581124879fdb5a07.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66334
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
> Since HSIO address space can be used by different drivers (PLL, SerDes
> muxing, temperature sensor), let's move it somewhere it can be included
> by all drivers.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Nothing wrong with the patch, you likely would have wanted to use git
format-patch -M such that the diff would have been showing that the file
was renamed.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

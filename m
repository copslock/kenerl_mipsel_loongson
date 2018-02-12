Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 19:30:49 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:38250
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeBLSalV2oWS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 19:30:41 +0100
Received: by mail-qt0-x244.google.com with SMTP id k13so695159qtg.5
        for <linux-mips@linux-mips.org>; Mon, 12 Feb 2018 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9C3Rnf/ZRG4JXQPmmV/9ZW9JObqGOZLiVbs+rHG73kA=;
        b=JdODVO6ViBMdrIlEKaPaVPp9a5Ha9uRdTa4990aKF41M3luDu+TFobnyOMfXCXunGT
         HOeuGvJ/3J1h1oIpnZ4OZW2V3csaDVTbcxI1d+Pth3XIhMDA86looBv8BnqK4fc3JzAC
         mLpGlEFOuX5vgDR8Nm9t7vdqQlnm6fH3sxBLvLdbUzCKRPWP8vY2ENPr1PLMznQqxdYa
         vzVeNnELn9ItNHhXm5vz2OFTK2WW+vqY7XZmS4mWHwEkxrRJjWcIKmWRzAX4BfYfpNrK
         GBepRQcTrzWtR5vz31jFQIsOeJRp/AP+IaGrYjqd9apa7JFa1P+2iIsVvtmBO+8Pa7aQ
         MEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9C3Rnf/ZRG4JXQPmmV/9ZW9JObqGOZLiVbs+rHG73kA=;
        b=MLJ68tNwoQed68YMylh3VguWHU9BSoP6WoJaipMK+BNly8noq7FJn5DLrT1LrpfIw7
         bvmN2CdXXRtv2r7ILfR3OUlfCTwlKAOJrqqBxkF2kRa2rK4JdicrfEqCCu41fbOTpGd9
         aqIp6DURi1WKqy8xTrN6ht6EE1TBHBaqCVKspgY0vXbJ6/IMRuSIhw/ZSONytwRjlN/f
         ESqN65lUJZbiY/bsRVsowLolbdPOdfH0ozgon/GaTcEByVSFGnbPf+zXI1Jw/nTpv4Jz
         2SfpTXBn2Hf9vJLvTOHy59421BDsDYd51qcE8JrDtxgabjzQhAs3Ts3U/7XDj53sIhnk
         NG0A==
X-Gm-Message-State: APf1xPDec4iDWfRsoRmNVZQbNlHqx+A7F733YW+Pib7kxb8PjGQiVKDe
        b3m/u537LjWP4BjyWsq1WeE=
X-Google-Smtp-Source: AH8x225LhDvKsTISVkfPG4AMyU1+a//0RdzZTqoaRkOVZjfBBJAhWDwNqqSuXpMZREv+e0yyvsA8Lw==
X-Received: by 10.200.20.13 with SMTP id k13mr21137775qtj.137.1518460235070;
        Mon, 12 Feb 2018 10:30:35 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id j19sm6667106qtc.1.2018.02.12.10.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 10:30:33 -0800 (PST)
Subject: Re: [PATCH] irqchip: Remove hashed address printing
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180212021812.3882-1-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <20e9fd4b-ef57-effa-26b6-e0db2b584735@gmail.com>
Date:   Mon, 12 Feb 2018 10:30:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212021812.3882-1-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62505
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

On 02/11/2018 06:18 PM, Jaedon Shin wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers are being hashed when printed. Displaying the virtual memory at
> bootup time is not helpful. so delete the prints.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Jaedon!
-- 
Florian

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 19:04:45 +0100 (CET)
Received: from mail-pg0-x229.google.com ([IPv6:2607:f8b0:400e:c05::229]:54609
        "EHLO mail-pg0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdKBSEgNAqcY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 19:04:36 +0100
Received: by mail-pg0-x229.google.com with SMTP id l24so270817pgu.11;
        Thu, 02 Nov 2017 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gooj+JQGfJgm74p5cAaDjbQEy2lf4CJz7AomOsU37Pk=;
        b=entfQcmUHsqabcyG4rSVl4u4EHUcc6ki3u8GGGSE3kqFuENAGzIvt6m6jUVeyBXEUD
         1qkDnlhWaO4gNLHweD4nucC5rWATydO7QQdl+hrA4ZmWDoWj25eFede+TcqRkJsMFXwV
         fBTCZ23pjQaWpqARK5I9awUBZjMBjpfjOFJ9DufqwANn7sUPAGU6SRD0P0+5He/nokPR
         w9hvm5Pdh9x8ycOg7+j3K6iCEEdgPJct2eC1N9n16NVJM7cl7KFG+z1SCpoCBPnoB/zv
         6GjUY3vL4jm2tLsIvzj9XNhxkjGkRfCyvwqMV5V/OGxP8RCfaYBY6EIqRiWDDlzq1r5/
         WRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gooj+JQGfJgm74p5cAaDjbQEy2lf4CJz7AomOsU37Pk=;
        b=ZGrZHU/znjesOBj8lFUEZe4PNKu4tR8gXRPp9O51gceR70n96XNNRlw8n7eHmaKqtT
         YMNoXSdoMjxs3uSC2ojnR8Uwp0P/e9vIBimGAr5BtDFLZX0Jq929K0WpGRyuOFIEv88F
         Q1gRQ2+BHS3FHU7Cyhl0alIS/8sQoO4DQk0WuMCo8WlxORT/zynNhong9zdX2ooQrQSQ
         WWCFeqt+wHA5uRzHk0K/MI0cYNGKcADOs7vg982h4KC5L3OM0t/7iTy/2WqUYP9D5vA3
         90ZOu5sKsgB6AE6ke9YA5GM19ZK5wWh8wR8Ho48eRmnyoxAmyHL/q83HtXee1+x6Hc2J
         m1Fw==
X-Gm-Message-State: AMCzsaX6WiPBQkJYKxlecuJqwD2aaypDkVvsV5LBo7pNMXOmWI/ZFgoF
        qgPRvoEEAEuFA4B0/fSokNs=
X-Google-Smtp-Source: ABhQp+QnRqnpDm73T1VLA7YODC0+Smye1eO9XafszPUtm9fIXGUhggh78ErYlQEf2/3ODmw6rCAufw==
X-Received: by 10.84.234.198 with SMTP id i6mr4160226plt.410.1509645869338;
        Thu, 02 Nov 2017 11:04:29 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id l22sm7659971pfk.45.2017.11.02.11.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 11:04:28 -0700 (PDT)
Subject: Re: [PATCH 4/7] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
To:     David Daney <ddaney@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-5-david.daney@cavium.com>
 <d473b10c-ae5d-efa1-7329-de7b68152725@gmail.com>
 <fc2d71e2-cdd4-1cf8-13b0-ea462b5e7e75@caviumnetworks.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <70fa7ec2-3e6d-e420-ff57-b34dc7ec311e@gmail.com>
Date:   Thu, 2 Nov 2017 11:04:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <fc2d71e2-cdd4-1cf8-13b0-ea462b5e7e75@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60693
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

On 11/02/2017 09:27 AM, David Daney wrote:
> On 11/01/2017 08:29 PM, Florian Fainelli wrote:
>> Le 11/01/17 à 17:36, David Daney a écrit :
>>> From: Carlos Munoz <cmunoz@cavium.com>
>>>
>>>  From the hardware user manual: "The FPA is a unit that maintains
>>> pools of pointers to free L2/DRAM memory. To provide QoS, the pools
>>> are referenced indirectly through 1024 auras. Both core software
>>> and hardware units allocate and free pointers."
>>
>> This looks like a possibly similar implement to what
>> drivers/net/ethernet/marvell/mvneta_bm.c, can you see if you can make
>> any use of genpool_* and include/net/hwbm.h here as well?
> 
> Yikes!  Is it permitted to put function definitions that are not "static
> inline" in header files?

Meh well, this is not even ressembling what we initially discussed, so I
was hoping we could build more interesting features on top of this.

> 
> The driver currently doesn't use page fragments, so I don't think that
> the hwbm thing can be used.
> 
> Also the FPA unit is used to control RED and back pressure in the PKI
> (packet input processor), which are features that are features not
> considered in hwbm.
> 
> The OCTEON-III hardware also uses the FPA for non-packet-buffer memory
> allocations.  So for those, it seems that hwbm is also not a good fit.

OK, let me see if I understand how FPA works, can we say that this is
more or less a buffer tokenizer in that, you give it a buffer physical
address and it returns an unique identifier that the FPA uses for actual
packet passing, transmission and other manipulations?

There were a few funky things in the network driver, I will comment there.
--
Florian

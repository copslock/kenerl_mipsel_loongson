Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2018 21:11:05 +0100 (CET)
Received: from mail-qk0-x230.google.com ([IPv6:2607:f8b0:400d:c09::230]:36436
        "EHLO mail-qk0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994689AbeA2UK6ihLK1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2018 21:10:58 +0100
Received: by mail-qk0-x230.google.com with SMTP id d21so7206149qkj.3
        for <linux-mips@linux-mips.org>; Mon, 29 Jan 2018 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=06T5D2UXPFUAZkkj4Ja3N/Ib6t7CGd/vOUr0kgfa51Q=;
        b=kAMP1v/3pcryGh/t+1L+pT2yQ9P8nQ8H0i1x8WgCQj9x+crlBeqYUP82uVDN3yuJ4T
         SRPOT9cj1NK4ir9yLb2NDWgDTfz5oWFQC09HzICCIe1X3vvOTQg8F1qJ2HkLV6YaVtgS
         N5rj0rxsys3hXdAC1X8+USJy6HqJVSPYvuDu5gy6ohDo6qeQnYoWBETOcppdTArIWZyk
         3BW6y+kBAtxrNA8yOKsyaFoV6A9WVrcP+7JqOOVkmKE8wk9LINDtQgvuGUgloti8VUtf
         3dBsR9l+L3rHEuinCHs4NwKWSUlTKq4Q9dWxRWZfUdSkSM/OLBmzsr/KyNjFZ+ea5Gy9
         hLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06T5D2UXPFUAZkkj4Ja3N/Ib6t7CGd/vOUr0kgfa51Q=;
        b=JLX0jBsubtbQd//L0DlM71ABNh2FwEIpYLmUPSAx23lbOQp/hvRYt3lddia66yeAWa
         bne+qyOM1m73IX30K9tf2ONzoSnj2N+RS2p3TJJxYq+deDiTjl5YiIPZsUiVC1sq1Hyv
         Jh/d2EMbLLymbjngfV9e/uWf5VE5BlaUsqW5wGB21v/ryEAkLYEXlQ0Q//dqIsB8vLq+
         6hZ58no8LQZdOdAxE5LTItYBMM8dyKG6G3Qq+DnsZfJFB9muEOzEqRTo3UwXf/fjJkGO
         hUUacc2+LXGziWEta59CODtRvRBX0HOwuwUU5MJ3nHInipR0TqEDSEU1ntNJljJwD/Ee
         z47w==
X-Gm-Message-State: AKwxytd2OBrIuTk4hBOpOIeND8X5T98oJN32rIBOl04DzqAkRtExQSr1
        nAE7h6JhIhH5FXLi9lXeIoHDWBHU
X-Google-Smtp-Source: AH8x227BTCkUU4HkfgFBTgt+igJhLkK8zqzuBVaRZKI7z0sLiN3CDaiZb9uVtpWj4UP2+wJhW1VX3Q==
X-Received: by 10.55.60.200 with SMTP id j191mr3541060qka.340.1517256652694;
        Mon, 29 Jan 2018 12:10:52 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id u10sm3519426qka.35.2018.01.29.12.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 12:10:51 -0800 (PST)
Subject: Re: [PATCH RFC 0/6] MIPS: Broadcom eXtended KSEG0/1 support
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
 <47412287-76d7-3e39-5110-717a498e00a3@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3f3714af-b5de-1333-7b5d-30b499f90db6@gmail.com>
Date:   Mon, 29 Jan 2018 12:10:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <47412287-76d7-3e39-5110-717a498e00a3@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62363
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

On 01/26/2018 12:31 AM, Steven J. Hill wrote:
> On 01/23/2018 07:47 PM, Florian Fainelli wrote:
> 
> [...]
> 
>>
>> Florian Fainelli (6):
>>   MIPS: Allow board to override TLB initialization
>>   MIPS: Allow platforms to override mapping/unmapping coherent
>>   MIPS: BMIPS: Avoid referencing CKSEG1
>>   MIPS: Prepare for supporting eXtended KSEG0/1
>>   MIPS: BMIPS: Handshake with CFE
>>   MIPS: BMIPS: Add support for eXtended KSEG0/1 (XKS01)
>>
> I have tested these with your previous "MIPS: generic dma-coherence
> inclusion" patchset on our Octeon III platforms with PCIe and saw
> no issues. Thanks.

Good, thanks for testing, at least I did not intentionally break other
platforms, now if I could this to work on 4.15 or newer, that'd be great.
--
Florian

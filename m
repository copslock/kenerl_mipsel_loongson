Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 22:15:52 +0200 (CEST)
Received: from mail-qt1-x842.google.com ([IPv6:2607:f8b0:4864:20::842]:34187
        "EHLO mail-qt1-x842.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994612AbeJDUPq5kXie (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2018 22:15:46 +0200
Received: by mail-qt1-x842.google.com with SMTP id x23-v6so11410447qtr.1;
        Thu, 04 Oct 2018 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Q1go12HLtc90YPynS8xBT3ZaYwTO0tIWQ1i0fd/CeE=;
        b=JhzFmhQs0VGmeNCxRnMiM42bQLcPbVvcuKrv+i9NnI8kNRc3obx5Z0nRlldw8XYrFI
         UFwwWNfgV1fgPZT5Wh9sUw08/nsESixTzPHEvxvXqoSAVwNQh4th6ycbtSSnjlAaq+lI
         XhcDTXfFnhhd3lDp0Pxq/9DRntI+m+FEUheYR+tRd8/TU/EOyrG4qsnXff3gVn/kixip
         rMFGPW2Ed74LrrKZW7WpvIbU4wWbWxSiHWD9RP6kKbFqNKQOVjAB84aTSEuYbJJQNg5g
         Szf/zmp1eLtg/d9NtxesX9kgKLk/uZ8CVXrLVfwyG5WJ8CEf/49LQqLJlyQLzDFFl79G
         i7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1Q1go12HLtc90YPynS8xBT3ZaYwTO0tIWQ1i0fd/CeE=;
        b=McX4f/OnN+hJ/KgSyhq/0c4wI9vZ8Xs+2AfhlhQZHrVB29xDO3KtaDZ3DoXFcY3gGB
         dQ/D7DyCz4R+/JTFdQi9gOGUjvu3cGwwZyLTv4U7GkEABn5ix5d6tZsbwfEJGF8ydSvn
         a6e13gTaER6Wa21AhuXnPyQOzEftCzz0De2uq0RTXayve2aQAlkPtEhqzKDWfgpB0n5t
         qtLcTmgyBgr1WlT1ZMgfBa0vOO86Vb1hEGmAs+AMOGSMuVPG8ZsEu4/yYoT4dfUcIauh
         RG9vQJJn3n3faAHN03Hp7hb2wCLqQp9KjtVMJdTm8YG8oyqUsOrRTrPD3uc/4kY+eHHR
         LUFw==
X-Gm-Message-State: ABuFfoi+1BLpnCBVisURummno5Cup4MXFVl1OyB2l2396OR2xwuf1WZg
        4bEiUuklltORXPyiAk3FawE=
X-Google-Smtp-Source: ACcGV63VwoheWp495h3T6TfGS2QH8eI5rFMuo/No6NBTLgrVbdbzcNEnEKeTTOJXm355f2gxTb/aLw==
X-Received: by 2002:aed:2807:: with SMTP id r7-v6mr6752350qtd.68.1538684140686;
        Thu, 04 Oct 2018 13:15:40 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id e8-v6sm3200029qkj.0.2018.10.04.13.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 13:15:39 -0700 (PDT)
Subject: Re: [PATCH net-next v4 09/11] dt-bindings: add constants for
 Microsemi Ocelot SerDes driver
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
 <20181004122208.32272-10-quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <8529862a-1a68-509b-9512-1ef0f8cdbea0@gmail.com>
Date:   Thu, 4 Oct 2018 13:15:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004122208.32272-10-quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66697
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

On 10/04/2018 05:22 AM, Quentin Schulz wrote:
> The Microsemi Ocelot has multiple SerDes and requires that the SerDes be
> muxed accordingly to the hardware representation.
> 
> Let's add a constant for each SerDes available in the Microsemi Ocelot.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

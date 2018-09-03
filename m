Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 21:46:29 +0200 (CEST)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:36745
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994074AbeICTqXZLtO0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 21:46:23 +0200
Received: by mail-pg1-x541.google.com with SMTP id d1-v6so554318pgo.3
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2018 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sPSOc3cGAqeDubEBeCd8/QnYjIxeTQLyGkQyBM0xpY8=;
        b=TDgcKoX78pL5ns/L4zk0+sliXb9/7GXkxr5L4CNeekd7BWxXaz+JQ1pE04aRfGKpn4
         DqB0m0zceZqXuniQDetXIUmqTSCcUW+pT7gU839I7H82napnfLAzDZH9df/UTlvW4yl+
         Vh4bDPHAE0sL1S9GMusXoyzfX37AqfOaTjnN/zQQ62WVOYTk1dwWSy+X2E+k9yCTETKg
         vlG3458O5fuw4ARXeNiVD7Evt+RzG3v/ELFIewGzFoSeayxIzCqBSCsZMldYLE543FpB
         nsHso3VKa9JbMU254NF+riTkehknuy8h/2SFwqq0dTA22nnEgqeTcox3HBLNKaiQDvwj
         skZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sPSOc3cGAqeDubEBeCd8/QnYjIxeTQLyGkQyBM0xpY8=;
        b=YB22216avatARCig7nEszQcQ6PsFMbShHybPPb3dcbmSimczCZJKsY89vzX5FyEO5+
         I66iVT2ZTxWyexwTuMFowMhuZAKBjyzVXinxbZA/OVNiRG2rANGeiwiffn9crGlGWRw4
         jBfb6G/0RP0rgsz50qZfyFaC7VwqUwLcHhNOkWLrKCr834vRNQtHkmcXMd9Yni6WmQbb
         7kBsCGJpiFhei0dgwpbPkvxZ+4gXLjA/aUsIxc66mcs3bT6mk12Qa6dNcDAcVh5+u2S7
         0J76VDdz4ZBXwPwNo/G2k1zZorqAtUGUFtwztBLVeO4Tm2Lj5aEkmFZhrStv7/zJ3ixM
         VuSg==
X-Gm-Message-State: APzg51BU69SuuKrIfrX3HvdE8XBMtQSNH8fASb61+kjH1lq19ENHbx7v
        8Vpzj4F7aOE/FzY2dopItbw=
X-Google-Smtp-Source: ANB0VdZ+P3Vx5BBIwvg5Ht5q3a4zu1xmg9NNUPYHR0iPkSuQLYWDs/h6tuIpi6YJ05EAsAZRywjf4A==
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr27662334pgp.69.1536003976742;
        Mon, 03 Sep 2018 12:46:16 -0700 (PDT)
Received: from [10.10.115.170] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id b126-v6sm29045973pga.49.2018.09.03.12.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 12:46:15 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 4/7] dt-bindings: net: Add lantiq,xrx200-net
 DT bindings
To:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120407.9912-1-hauke@hauke-m.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5866e89f-ac9a-8c6c-bf53-3b1206171e31@gmail.com>
Date:   Mon, 3 Sep 2018 12:46:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180901120407.9912-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65918
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



On 9/1/2018 5:04 AM, Hauke Mehrtens wrote:
> This adds the binding for the PMAC core between the CPU and the GSWIP
> switch found on the xrx200 / VR9 Lantiq / Intel SoC.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: devicetree@vger.kernel.org
> ---
>   .../devicetree/bindings/net/lantiq,xrx200-net.txt   | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> new file mode 100644
> index 000000000000..8a2fe5200cdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> @@ -0,0 +1,21 @@
> +Lantiq xRX200 GSWIP PMAC Ethernet driver
> +==================================
> +
> +Required properties:
> +
> +- compatible	: "lantiq,xrx200-net" for the PMAC of the embedded
> +		: GSWIP in the xXR200
> +- reg		: memory range of the PMAC core inside of the GSWIP core
> +- interrupts	: TX and RX DMA interrupts. Use interrupt-names "tx" for
> +		: the TX interrupt and "rx" for the RX interrupt.

You would likely want to document that the order should be strict, that 
is TX interrupt first and RX interrupt second, but other than that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

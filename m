Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 20:53:14 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:36615
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994074AbeICSxLCp8AI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 20:53:11 +0200
Received: by mail-pg1-x544.google.com with SMTP id d1-v6so515357pgo.3
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2018 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3f0TOl5QNrF3e03UuEwpp3vHagFw9knzsvgdXkGf44=;
        b=fyzMPnww1xsINcsKq8M5QogaLmjXsaPQmXu81VRu0ZK8/TOjBHimSWz0U0LYOpWooG
         3sM0O+fjacrJAf0OYUvT9EjD+gNLYhOjQprjRXnpKmu7q5uxUgs/15yjbA25U/M4/A7f
         qwNUbn9IedEGbIikvKfI6EdgnFzKLndCpwekMg6/DPn5Px+8MiUcEwjmvuiHT/A/suE6
         /ezvpSmJI6nlbhc8Rw04/nti2L+vS/ozEhHWbN0x2XcjYfBhYTNeAnF9i46iIWgQ93eV
         Y3EdILlvewOdSoiyYCx3yRUXeUw2nQd1hC7BfwnHlfT3GgfClQgsuRERWQsduYDUtUMQ
         UJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3f0TOl5QNrF3e03UuEwpp3vHagFw9knzsvgdXkGf44=;
        b=hGmrwT/gnpL1mp5JISRn5PYGIDlJ6TAxI8MbHZrlVkJCr6jwJZvYDNUuaJlosgz+op
         Eq+oMXPDqiZt7uXucNWH/iqVKZJc9cL27ePOViTjk97yPpjSMSqyKXVACM3OxjZalLpA
         R7i4mMgr1MLeQsB9foz5lNV1X+h+bYpBLjhNWUyzbGUtCTNRsXTATwPnRbSZoiQS2R12
         lCTgXsQi5beeSkQNz2IhKy0dShu5RtE5kSOla3+7rWfA7mFiG0Hmn2CKfhYdNV88Ydgn
         7/n6HoapPid35GfVE3oX/Yz7YvfuSiwYoO4lpIPI0kXjTaT6LbCayJfWHyj36eiyggwY
         lkLQ==
X-Gm-Message-State: APzg51A34y8O+5K/TnD7rPzf1wiYtY2wdIe9s6YFuUmvIderqPG/MSJr
        7R44aKwAELmlIrBtUbFYKhM=
X-Google-Smtp-Source: ANB0VdZH/Cm9lbwPX52YeJ7516mn/tzKdrw8CCEOqZ3b3OjqzZpu8y6yVnfSrraYndOje9YM6ir+3g==
X-Received: by 2002:a63:2f45:: with SMTP id v66-v6mr27069936pgv.91.1536000784413;
        Mon, 03 Sep 2018 11:53:04 -0700 (PDT)
Received: from [10.10.115.170] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id q62-v6sm29375852pfi.185.2018.09.03.11.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:53:03 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 3/7] net: dsa: Add Lantiq / Intel GSWIP tag
 support
To:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120332.9792-1-hauke@hauke-m.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b13de4db-f115-e7d5-9efd-0af18f947978@gmail.com>
Date:   Mon, 3 Sep 2018 11:52:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180901120332.9792-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65916
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



On 9/1/2018 5:03 AM, Hauke Mehrtens wrote:
> This handles the tag added by the PMAC on the VRX200 SoC line.
> 
> The GSWIP uses internally a GSWIP special tag which is located after the
> Ethernet header. The PMAC which connects the GSWIP to the CPU converts
> this special tag used by the GSWIP into the PMAC special tag which is
> added in front of the Ethernet header.
> 
> This was tested with GSWIP 2.1 found in the VRX200 SoCs, other GSWIP
> versions use slightly different PMAC special tags.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Just one suggestion below, if you need to resubmit this:

[snip]

> +static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
> +				     struct net_device *dev,
> +				     struct packet_type *pt)
> +{
> +	int port;
> +	u8 *gswip_tag;
> +
> +	if (unlikely(!pskb_may_pull(skb, GSWIP_RX_HEADER_LEN)))
> +		return NULL;
> +
> +	gswip_tag = skb->data - ETH_HLEN;
> +	skb_pull_rcsum(skb, GSWIP_RX_HEADER_LEN);

I would be moving this after the port lookup was successful, that way if 
you are discarding a frame, you can do this as quickly as possible, this 
should not have a functional impact since you return a skb with the 
checksum updated past the return of that function.
-- 
Florian

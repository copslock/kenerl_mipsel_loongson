Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AACC43387
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 05:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1314E20855
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 05:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+oN++ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfARFHL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:07:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41936 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfARFHL (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 18 Jan 2019 00:07:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so5966671pfi.8;
        Thu, 17 Jan 2019 21:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EhlXj1o6YXXivGQBtxAXOr0/TI5jivAh3VUkr74TWgQ=;
        b=I+oN++ssgzFI1A5y5c6HxZ4J2ae6coAncH0FbOqvQQu+hcOnqSTgT+DweKR1lsOm/l
         AGc6L+zeXRfQQr1gyI0OIbn2t8B3v4I2532GiEYwuDieqQTk/d2JCmBon92e1EiaVCWF
         We9+lADIbfAh3ZQ7wYFDpR4Chd8x2Jo+dgPhvWS4JjBvjzBDic3cwbn339/kUtUzurJd
         V4exQaDD9I/TUL4n5jeltQ7mJ44U+f8PYh//HpFvGEeiqQAHWePTHpXYDXdqt0L032Hm
         pUSRlLS08+ofxhn9m+CH8Y9akaLVnQyxNxDAKQh22WYwUWLyrO1172YtUmMujkWBJ/zc
         2D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EhlXj1o6YXXivGQBtxAXOr0/TI5jivAh3VUkr74TWgQ=;
        b=cueBTx9LXHKLIhXRPHOfaez7nIMzVo7TyTkcacCxbV9x4265XinR0oDDSZj67J1JMm
         tmt3AZgyWHW4jTb+ibzKsGe5UYd19+u2HBhMnQEdkGPJBmDMOtLw2gGvjuJDQArCRGWX
         /IQOOCplM4lbuZ0UdQH9i2S9tEPiQSpi4H9bl3z9WbzdkLj+13sLIRPaZ8YaeRMVY4uA
         F6d4bIP/YBx6GeU41yt7vvJt27Mcj0L6ES82x3Q5TNxkLbyH/D8At2bTFncrqPrA0UtR
         s+PxLQv356H9C1jQmQnZcoln7EyJMKfABsZBzsKUhFuu1AmrUvvZEwbF5v7YFAxRPmE4
         OFTA==
X-Gm-Message-State: AJcUukcwUIFgPZ7zDnBT+4dek403u08sldYkx6wMkybLxv06muri1uB/
        1Nzs9rgAue8m+qLygE4YW8A=
X-Google-Smtp-Source: ALg8bN5lx5M7KLmDF9SzQbT33MnhSaOq6G57a+UxzML3jmPyEL9TL/WvtmXkOjBf1ZZEAanJIeyuQQ==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr16107968pgb.417.1547788029455;
        Thu, 17 Jan 2019 21:07:09 -0800 (PST)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id u186sm4872338pfu.51.2019.01.17.21.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 21:07:08 -0800 (PST)
Subject: Re: [PATCH net-next 0/8] net: mscc: PTP offloading support
To:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <d6ed760a-a236-189f-b3e9-8a668fdf371f@gmail.com>
Date:   Thu, 17 Jan 2019 21:07:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117100212.2336-1-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



On 1/17/2019 2:02 AM, Antoine Tenart wrote:
> Hi all,
> 
> This series adds support for the PTP offloading support in the Mscc
> Ocelot Ethernet switch driver. Both PTP 1-step and 2-step modes are
> supported.
> 
> In order to make use of the PTP offloading support, two new register
> banks were described in the Ocelot device tree. The use of those
> registers by the Mscc Ocelot Ethernet switch driver is made optional for
> dt compatibility reasons. For the same reason a new interrupt is
> described, and its use is also made optinal for compatibility reasons.
> All of this is done ine patches 1-5.
> 
> The PTP offloading support itself is added in patch 8.
> 
> While doing this support, a few reworks were done in the Ocelot switch
> driver, in patches 6-7.
> 
> Patches 2 and 4 should probably go through the MIPS tree.

Looks like you missed copying netdev on this patch series, do you mind
re-sending there as well?

> 
> Thanks!
> Antoine
> 
> Antoine Tenart (8):
>   Documentation/bindings: net: ocelot: document the VCAP and PTP banks
>   MIPS: dts: mscc: describe VCAP and PTP register ranges
>   Documentation/bindings: net: ocelot: document the PTP ready IRQ
>   MIPS: dts: mscc: describe the PTP ready interrupt
>   net: mscc: describe the VCAP and PTP register ranges
>   net: mscc: improve the frame header parsing readability
>   net: mscc: remove the frame_info cpuq member
>   net: mscc: PTP offloading support
> 
>  .../devicetree/bindings/net/mscc-ocelot.txt   |  22 +-
>  arch/mips/boot/dts/mscc/ocelot.dtsi           |  14 +-
>  drivers/net/ethernet/mscc/ocelot.c            | 509 +++++++++++++++++-
>  drivers/net/ethernet/mscc/ocelot.h            |  55 +-
>  drivers/net/ethernet/mscc/ocelot_board.c      | 150 +++++-
>  drivers/net/ethernet/mscc/ocelot_ptp.h        |  41 ++
>  drivers/net/ethernet/mscc/ocelot_regs.c       |  22 +
>  drivers/net/ethernet/mscc/ocelot_vcap.h       | 104 ++++
>  8 files changed, 877 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/net/ethernet/mscc/ocelot_ptp.h
>  create mode 100644 drivers/net/ethernet/mscc/ocelot_vcap.h
> 

-- 
Florian

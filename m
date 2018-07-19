Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2018 10:07:17 +0200 (CEST)
Received: from mail-lj1-x241.google.com ([IPv6:2a00:1450:4864:20::241]:43856
        "EHLO mail-lj1-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeGSIHLBLrVi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2018 10:07:11 +0200
Received: by mail-lj1-x241.google.com with SMTP id r13-v6so6422510ljg.10
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2018 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ygSA0TisS1G9yDz0tiDVeJGinlDq21hTl6agLHlX5Fk=;
        b=NEFJMDPShLPuXndEYWYWJ5HTiG4EMoG/o6Rohaus6oRguuoiqqKRTGF5O5pWK/zoLF
         DrbAuhydw7TTKWDfVK4uhluOYftAwQMwWJ+f61amMBYkftd6WxAr73+8IJyl5of0P2K6
         RSilifL/MOZQKGq/h2ZjzS5IjQAF7FTE2feKgFUui3qUMQ0aQ5ZIlVboW4FIGiM/5T5K
         KFsugZbdQdmrJwxMZNzqYjeyTuO0aw5SBAG6Fu0tCaNy4jZtbLLIpE1jlTLbUML7G5iM
         wuYFJoS/cBl0TB5uqDMAvfYWCfBkpJWBKNcKfYn3QdTRqxFNFGTwZWRrbqzQ8JCt+ljm
         a6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ygSA0TisS1G9yDz0tiDVeJGinlDq21hTl6agLHlX5Fk=;
        b=dcDJTPl0T6xkI4RCpS2xoNCld8KjlG6OtFT7WrXhZu2BRuiq2erA2ZWxsWvUUvsSPu
         jde1V9z1vHzuim/4vh3DsVKrFnhL7Tm/xM5Ne8Tz4OWn8CEjZBCwe3bg7dpd08qIHvw7
         LQjfOGE2dOIpkrpudZgRbERrRM4ZutfbWpSCenerZi+4fMrHplYRQARrMGN9gn2+Lash
         gq5JoWdS/QI6gFguVPrud8gMF590z16Fq29HGhFHTSzb1c06XSB4DJYfSihW+arRmIwk
         4gZ3Kb89EP6uyQiYvnH82MCIlzXRovjAfZ45UQLr4PftXRu/PW3uBetzhYQQWS79bro2
         6mmw==
X-Gm-Message-State: AOUpUlGM/KbEGq4jDJDXDqPXq0lwa3B5yrJesBDnQZz5WTxKzRtgQOUz
        yIE7U5bKbN/EGJCczSj9eKi4iWT8AkA=
X-Google-Smtp-Source: AAOMgpdQPgH91GP5mPyyFGWJplFK2ldUGq5XFaLqt+wTk+RpRfroBJCS3IZTwTx86D19/sZ1274wpw==
X-Received: by 2002:a2e:6c07:: with SMTP id h7-v6mr6684856ljc.81.1531987625446;
        Thu, 19 Jul 2018 01:07:05 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.106])
        by smtp.gmail.com with ESMTPSA id b87-v6sm859884lfh.33.2018.07.19.01.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:07:04 -0700 (PDT)
Subject: Re: [PATCH v2 16/17] MIPS: JZ4770: DTS: Add DMA nodes
To:     Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20180718182023.8182-1-paul@crapouillou.net>
 <20180718182023.8182-17-paul@crapouillou.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b25df80b-2314-8ed1-6fdf-5bb9b49ec994@cogentembedded.com>
Date:   Thu, 19 Jul 2018 11:06:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718182023.8182-17-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 7/18/2018 9:20 PM, Paul Cercueil wrote:

> Add the two devicetree nodes for the two DMA cores of the JZ4770 SoC,
> disabled by default, as currently there are no clients for the DMA
> driver (until the MMC driver and/or others get a devicetree node).
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/mips/boot/dts/ingenic/jz4770.dtsi | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
>   v2: No change
> 
> diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> index 7c2804f3f5f1..fda17beeb08b 100644
> --- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> @@ -196,6 +196,36 @@
>   		status = "disabled";
>   	};
>   
> +	dmac0: jz4770-dma@13420000 {

	dmac0: dma-controller@13420000 {

[...]

> +	dmac1: jz4770-dma@13420100 {

	dmac1: dma-controller@13420100 {

[...]

MBR, Sergei

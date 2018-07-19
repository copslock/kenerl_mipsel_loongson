Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2018 10:03:25 +0200 (CEST)
Received: from mail-lj1-x243.google.com ([IPv6:2a00:1450:4864:20::243]:33244
        "EHLO mail-lj1-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeGSIDRqqKti (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2018 10:03:17 +0200
Received: by mail-lj1-x243.google.com with SMTP id s12-v6so6418577ljj.0
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2018 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPZVd+fUq/bD+V2j984rZodY8nOpjk0ASaORDcPzYkE=;
        b=Zj5J2oqbg0bEuwCUifDAwAL9SFkKLo9Yx2FjIeu7mhbaWx7dTV6wsfcHhD2dUXHA67
         t3qCwZVGyGftAWTB6SV6IKhb2WJiS7iJdHLZaJAGwBZemkEkoaAkz+KTRSWPgR5VGNjX
         elMGtAHkERsCRNT/1GUxrGFcONMRhG8uLPnbMN91mbDjcI1i8JvCubYbAmzy6Z9pRjQk
         3uH93dBe/FhDDOjq9CEr1i1+3Du19iJskPfH/6AhADSQrG2rh/kufuDos9/714B9COlV
         DGm6GJHZDl2/X5m6NxaazRJvEsHy+54wtN2PgD48whaAdMsiyGgQ8Q/nZwk8LDj0dsro
         hncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPZVd+fUq/bD+V2j984rZodY8nOpjk0ASaORDcPzYkE=;
        b=jfBIXNHH3jUBSG0LkHnT3QO8ScwukrAelspOxbR2XuzjJZk258MU1JDdibWPAKPSin
         Qwahj1qKUq1bEG5IqTAAwEZ54wG0EvJ4XjhqojC6uDay2olwWW2X1x7RQzq+Ha+Qg+yz
         9I9+MsXSWlNbaadbENdq3DqGAMEBF09/lv1oMpccZjhOBDnxQ+iUeEnPyjBQrBZ5v8iv
         cmfen8/UPUwwJOhjNnVPTTW4So12NCcL1fyDm4doJkzMnqL0YzG5VrNbR4f1hcEzx88L
         yttnPqQVVSs7I4fAJGg0Ro9T4LGNe+c2Mpdli/BxNgqxqxwxzSx+pOuq2KWZLRovfl1y
         bCqw==
X-Gm-Message-State: AOUpUlG2q0wMrCsY5abZaH7r0bREy+BpaFL44x/vMIrsA579wal4ZLfp
        O4kmEX6O64/jYP8kYdGzR9jC3eKaKbQ=
X-Google-Smtp-Source: AAOMgpdaNqnBmXxvDnnsNDaZgzDzAI02E7JrbDz+UNenDs7ivFj9qvn4Fji4SvxtNd9HTBcbLvo/Ig==
X-Received: by 2002:a2e:4701:: with SMTP id u1-v6mr7207079lja.54.1531987392061;
        Thu, 19 Jul 2018 01:03:12 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.106])
        by smtp.gmail.com with ESMTPSA id g2-v6sm864599lfb.52.2018.07.19.01.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:03:11 -0700 (PDT)
Subject: Re: [PATCH v2 17/17] MIPS: JZ4740: DTS: Add DMA nodes
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
 <20180718182023.8182-18-paul@crapouillou.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d4a95b78-0fdf-a341-3fe9-91cb94ab164b@cogentembedded.com>
Date:   Thu, 19 Jul 2018 11:03:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718182023.8182-18-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64941
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

> Add the devicetree nodes for the DMA core of the JZ4740 SoC, disabled
> by default, as currently there are no clients for the DMA driver
> (until the MMC driver and/or others get a devicetree node).
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/mips/boot/dts/ingenic/jz4740.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
>   v2: New patch in this series
> 
> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index 26c6b561d6f7..47d93f2597af 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -154,6 +154,21 @@
>   		clock-names = "baud", "module";
>   	};
>   
> +	dmac: dma@13020000 {

    The node must be named "dma-controller@13020000" according to the DT spec.

[...]

MBR, Sergei

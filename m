Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:46:53 +0100 (CET)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:46344
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990498AbeCWVqqd-jyS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 22:46:46 +0100
Received: by mail-pl0-x243.google.com with SMTP id f5-v6so8210300plj.13
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8bM0GYxgq8TSBnSPVw63tG3ART5l5Iai3nIHM31YLNA=;
        b=qpt+SQvGyUYUH/9RYvE2zPBdQjiySAmQFunl1tq3WWeBG7HGVlUuEDgsvNiIlNATYw
         zAXliFE0voBx0VVu/EQLrIpAwBNXnGiWfuTBsv3Ph5hCwcrFrReilN8oCM3nntHEXtFI
         lEfhZuZIouTgwoclS2yp7gn8KQ56XHogn8O0kabGckFppkFOAP9Y5VgsF7wpHfNjv5ey
         YweGIHruBb00b5MOr/oCF1i92W+2BU+Zg+mexPpsScz0pakdYDCRG6yDbotdn1jiWNWT
         /w2Lcr0wo/7Qk7qSmxvEBz97J/WWUrOLQPf01Qzw1PLI0cBDqbGpEsgt68sjgm8Xu8zZ
         ODdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8bM0GYxgq8TSBnSPVw63tG3ART5l5Iai3nIHM31YLNA=;
        b=KgphC3Lxm96QXjr8qZ49ScJ/SByFNXeIM9zCvrgujCy512QgrIj42Y0tgZkidy8QCi
         8v2KPK3kAGbuHVB66SP9K1Ow0h1iX/xTZXDeiHlPVsRFmD7MiHFji1nPL+x7d+qHHA/s
         dOdLbBBE4ueC1dENGrB9IRTeySQoX0kDjeb9VdZfoHbfpQcg0yA3o0SRSJ6vya4Yz1Ew
         MJG4ZT8m/ZwFzQx0PHRhTd+J6kKw8ACLEa92BJzqhCjaMb+bl6JM3rvUYwscRkSqV89c
         DxNdahENXNvBzUqgZN3SJr8nnsW6jPEkA185ZYjHBSSuAHM+4PjvqySXKZMTKUsevAZa
         Kzpg==
X-Gm-Message-State: AElRT7GrKmIjN0PWZHHJaZExpsuol/kMJTSuKV1P51JeeIsVTcHAZneH
        dG7kB4QQS6vhxQqbBa6BMxw=
X-Google-Smtp-Source: AG47ELsAUJmrXGDsZvVTAwdTfqgCZY0bgPi8togDAx8ggqBdkKTaezOLQpic5xxbsOPxUQvcT1gkJw==
X-Received: by 2002:a17:902:7e09:: with SMTP id b9-v6mr30801053plm.223.1521841600387;
        Fri, 23 Mar 2018 14:46:40 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 2sm20771552pfo.70.2018.03.23.14.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:46:39 -0700 (PDT)
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: add DT bindings for
 Microsemi MIIM
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-3-alexandre.belloni@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6cb618e9-0aa0-ba54-b556-d7a6823913d7@gmail.com>
Date:   Fri, 23 Mar 2018 14:46:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63203
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

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> DT bindings for the Microsemi MII Management Controller found on Microsemi
> SoCs
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-miim.txt          | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-miim.txt b/Documentation/devicetree/bindings/net/mscc-miim.txt
> new file mode 100644
> index 000000000000..711ac9ab853c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-miim.txt
> @@ -0,0 +1,25 @@
> +Microsemi MII Management Controller (MIIM) / MDIO
> +=================================================
> +
> +Properties:
> +- compatible: must be "mscc,ocelot-miim"
> +- reg: The base address of the MDIO bus controller register bank. Optionally, a
> +  second register bank can be defined if there is an associated reset register
> +  for internal PHYs
> +- #address-cells: Must be <1>.
> +- #size-cells: Must be <0>.  MDIO addresses have no size component.

Missing interrupt property documentation (sorry), other than that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

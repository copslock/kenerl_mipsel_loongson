Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:25:18 +0200 (CEST)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:36737
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992907AbeIOVZPyjCEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:25:15 +0200
Received: by mail-pl1-x644.google.com with SMTP id p5-v6so5699119plk.3;
        Sat, 15 Sep 2018 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kFl9Cjy2i/loPmuSdollfntfpeDCnzDp1uMCB3FmhWA=;
        b=WQtEfwKvhU8xZbVQWhQY/Gpyb07BbGtQYL9k2OyVzniL4hvCTWXYhxb9D4vVahgstr
         eqDJooPtHILD0ZEcpJQiwXwW163NimOQXbbMZkbO+lVVPP+TLGCvl7OK5s0Q758XCJG7
         AzgooEQ2MosOVfNRBXRmAk1cK8veDnZyQafsITZW6Y8NarKideFopDnJg3T4Ga/TdY+g
         jqMcSLAQ1cQDDc+BYu59kOq+AwgrKW8fDUOX1MC3+hrhCHZu1WZpbudQx5mO19TyI+wl
         cb3xrhe77FDi14z/CACpim6Z6S5/P+5XP0HjUi2EGax5J+i7O8Ep7egZL3ybsp2pgpCx
         dQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFl9Cjy2i/loPmuSdollfntfpeDCnzDp1uMCB3FmhWA=;
        b=Y1ga0rM+J7fs7buvsBqZZ/+3u30RnsuGumvbZMOMgj16+uwcq2wwOlp/oztuVEnDyk
         ZIAoJLE2XG5awycaQJNtakcc73Ra2wlsq7XPymciL2ZRCNCbQnL0HthcCOOaGRCVFKvR
         gu6PU+eHP5jPyZ7ZtgwYNgPPCDKyB8/TJLw5VAIDfz1AzIEhQhN8v0cWvNPDO7bqGAC4
         HODCzKxM3HQFAFqXg/6yQbN8tPeDHeyPWOXD7daK5ozIEyl+80T5QtMKbQQ/AmOGQQlT
         xrapNBBOKJCCIbf35u7J3rDPjb364tzwgomTRVnJimTOZy+X8Km1JpsdYHcpm8DWK5GB
         R8Zw==
X-Gm-Message-State: APzg51BKc8oodTJApqPUeKzc57IJLjvtBIBNf07m22YGKlAm/d/5tVCx
        7eFBXeFnWyopggmMCMzthlg=
X-Google-Smtp-Source: ANB0Vdbz420PWUsoMp5WHJQA8X6uW9RIZKEn36i1lHhXPF43NvuMxRR2seUOadj5+28h4XHeLaWK5A==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7-v6mr18206004plv.37.1537046709385;
        Sat, 15 Sep 2018 14:25:09 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id t15-v6sm17857052pfa.158.2018.09.15.14.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:25:07 -0700 (PDT)
Subject: Re: [PATCH net-next v3 11/11] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <00989856964175eafbe1435a70862c2ac66cffc0.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0f762d63-a392-d2fe-a121-a013a13a8584@gmail.com>
Date:   Sat, 15 Sep 2018 14:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00989856964175eafbe1435a70862c2ac66cffc0.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66341
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



On 09/14/18 01:16, Quentin Schulz wrote:
> Previously, the SerDes muxing was hardcoded to a given mode in the MAC
> controller driver. Now, the SerDes muxing is configured within the
> Device Tree and is enforced in the MAC controller driver so we can have
> a lot of different SerDes configurations.
> 
> Make use of the SerDes PHYs in the MAC controller to set up the SerDes
> according to the SerDes<->switch port mapping and the communication mode
> with the Ethernet PHY.

This looks good, just a few comments below:

[snip]

> +		err = of_get_phy_mode(portnp);
> +		if (err < 0)
> +			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
> +		else
> +			ocelot->ports[port]->phy_mode = err;
> +
> +		switch (ocelot->ports[port]->phy_mode) {
> +		case PHY_INTERFACE_MODE_NA:
> +			continue;

Would not you want to issue a message indicating that the Device Tree
must be updated here? AFAICT with your patch series, this should no
longer be a condition that you will hit unless you kept the old DTB
around, right?

> +		case PHY_INTERFACE_MODE_SGMII:
> +			phy_mode = PHY_MODE_SGMII;
> +			break;
> +		case PHY_INTERFACE_MODE_QSGMII:
> +			phy_mode = PHY_MODE_QSGMII;
> +			break;
> +		default:
> +			dev_err(ocelot->dev,
> +				"invalid phy mode for port%d, (Q)SGMII only\n",
> +				port);
> +			return -EINVAL;
> +		}
> +
> +		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
> +		if (IS_ERR(serdes)) {
> +			err = PTR_ERR(serdes);
> +			if (err == -EPROBE_DEFER) {

This can be simplified into:

			if (err == -EPROBE_DEFER)
				dev_dbg();
			else
				dev_err();
			goto err_probe_ports;

> +				dev_dbg(ocelot->dev, "deferring probe\n");
> +				goto err_probe_ports;
> +			}
> +
> +			dev_err(ocelot->dev, "missing SerDes phys for port%d\n",
> +				port);
>  			goto err_probe_ports;
>  		}
> +
> +		ocelot->ports[port]->serdes = serdes;
>  	}
>  
>  	register_netdevice_notifier(&ocelot_netdevice_nb);
> 

-- 
Florian

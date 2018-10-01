Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 18:29:24 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:42218
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994561AbeJAQ3UiRhfe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 18:29:20 +0200
Received: by mail-pg1-x543.google.com with SMTP id i4-v6so9223232pgq.9;
        Mon, 01 Oct 2018 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8TF4IWy5uCszANSwOHyeP56CISUU3UvyLB1eGP0Zg0=;
        b=ZYknXN1ED5+wVNWHSbMpzTUukxG3MmFNSS3JSwS85dzPZx9Ee8mu6/FBK7c46LC6zG
         u5Y2KVNqBww9tdOTyDmIIuqh8Og1TbJSEmt5sS5sy3E9a3PapL+hx4RugDZbZFkUrrFZ
         xQYT73MjzqzkQqiuBBoptkqnd7EuSXnmsQBmPNv8dWgBAITZ45JtoXeFMoWdhYhmYxDI
         BbTiAC1Cng6+Nzx1cOcM80fyAFGLOCgrdJfq92jOtALbekD6Ubgzd32osjjltOrNgaRv
         BSfyNkvqgZ/nvwgxYcC1fmIUn0JNia+zWnI8l1n8d0Jk6OJoa+Ko6cp1UKiAPcFRSj5T
         i+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A8TF4IWy5uCszANSwOHyeP56CISUU3UvyLB1eGP0Zg0=;
        b=V1CPtSsYoXiTyBT3wWL9MrESyq4aqnS4n9qrZHgp2DU4UIsDfAzTMjcWu9bEtxMVNt
         9N5jKIy+8WhAuLF73m6Sx47XzphrGgjMckOtQqZZIhoJ8Ex+L8jR572P3kJhGQv87RgI
         C4S/syBaTcHLrpzpti/EoZhhz+Y2xinJOWYgxNFDM3AX1XXN4kyam/0j2aH892EZfDmZ
         83ejTIjQJPXGfBgcLk7m9qmWkoLYdwRmBcc3sIT1ysJQfckpz6+01aJBCsZWjOw0qKrL
         n7qnAVYcJuQkXC5C8xpSjacVEKH4wYQjbIkrRjq8rTKCQE4YgwUJxgPpsD2e/D5uZY1G
         jsCw==
X-Gm-Message-State: ABuFfoidw1jrhjSgCivHNpKNtb2bNnWTkuKIWGyZiqO3kuUV9d8ZbIHx
        sTG2SEBtJqkmZ4GcrPmQ+mk=
X-Google-Smtp-Source: ACcGV60J9WCxH/RgtEmPzIrJbMB99hwRuECLsKLaqW6KgtvrRH7Ggw7n11PNDEI927DEjc5aMpk0yQ==
X-Received: by 2002:a63:5d55:: with SMTP id o21-v6mr10713994pgm.349.1538411350663;
        Mon, 01 Oct 2018 09:29:10 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id e2-v6sm16123349pgv.25.2018.10.01.09.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:29:09 -0700 (PDT)
Subject: Re: [PATCH net-next v3 11/11] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <00989856964175eafbe1435a70862c2ac66cffc0.1536912834.git-series.quentin.schulz@bootlin.com>
 <0f762d63-a392-d2fe-a121-a013a13a8584@gmail.com>
 <20181001094245.cr4hdcechrqkjymq@qschulz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <228f9d74-be17-5157-9755-b265a6e234b8@gmail.com>
Date:   Mon, 1 Oct 2018 09:29:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001094245.cr4hdcechrqkjymq@qschulz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66652
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

On 10/01/2018 02:42 AM, Quentin Schulz wrote:
> Hi Florian,
> 
> On Sat, Sep 15, 2018 at 02:25:05PM -0700, Florian Fainelli wrote:
>>
>>
>> On 09/14/18 01:16, Quentin Schulz wrote:
>>> Previously, the SerDes muxing was hardcoded to a given mode in the MAC
>>> controller driver. Now, the SerDes muxing is configured within the
>>> Device Tree and is enforced in the MAC controller driver so we can have
>>> a lot of different SerDes configurations.
>>>
>>> Make use of the SerDes PHYs in the MAC controller to set up the SerDes
>>> according to the SerDes<->switch port mapping and the communication mode
>>> with the Ethernet PHY.
>>
>> This looks good, just a few comments below:
>>
>> [snip]
>>
>>> +		err = of_get_phy_mode(portnp);
>>> +		if (err < 0)
>>> +			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
>>> +		else
>>> +			ocelot->ports[port]->phy_mode = err;
>>> +
>>> +		switch (ocelot->ports[port]->phy_mode) {
>>> +		case PHY_INTERFACE_MODE_NA:
>>> +			continue;
>>
>> Would not you want to issue a message indicating that the Device Tree
>> must be updated here? AFAICT with your patch series, this should no
>> longer be a condition that you will hit unless you kept the old DTB
>> around, right?
>>
> 
> It'll occur for internal PHYs. On the PCB123[1], there are four of them,
> so we need to be able to give no mode in the DT for those. For the
> upcoming PCB120, there'll be 4 external PHYs that require a mode in the
> DT and 4 internal PHYs that do not require any mode. I could put a debug
> message that says this or that PHY is configured as an internal PHY but
> I wouldn't put a message that is printed with the default log level.
> 
> So I think we should keep it, shouldn't we?

Internal PHYs either use a standard connection internally (e.g: GMII) or
they are using a proprietary connection interface, in which case
phy-mode = "internal" is what we defined to represent those.

> 
> [1] https://elixir.bootlin.com/linux/latest/source/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> 
>>> +		case PHY_INTERFACE_MODE_SGMII:
>>> +			phy_mode = PHY_MODE_SGMII;
>>> +			break;
>>> +		case PHY_INTERFACE_MODE_QSGMII:
>>> +			phy_mode = PHY_MODE_QSGMII;
>>> +			break;
>>> +		default:
>>> +			dev_err(ocelot->dev,
>>> +				"invalid phy mode for port%d, (Q)SGMII only\n",
>>> +				port);
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
>>> +		if (IS_ERR(serdes)) {
>>> +			err = PTR_ERR(serdes);
>>> +			if (err == -EPROBE_DEFER) {
>>
>> This can be simplified into:
>>
>> 			if (err == -EPROBE_DEFER)
>> 				dev_dbg();
>> 			else
>> 				dev_err();
>> 			goto err_probe_ports;
>>
> 
> Indeed, good catch.
> 
> Thanks,
> Quentin
> 


-- 
Florian

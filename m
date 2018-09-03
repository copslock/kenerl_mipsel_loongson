Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 21:54:59 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:46958
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994074AbeICTyxIQZS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 21:54:53 +0200
Received: by mail-pg1-x542.google.com with SMTP id b129-v6so532074pga.13
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2018 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aCJ8krv/CniscCfWvuvXdGyUBMkPKUNGV45NFVLhlGA=;
        b=nkdALrI1g4MqTFzwfBOqVPQBvcseNaeCSPmh6eKvhDyfW3+NY5XTDtTMB0zxylLiJ6
         KVhCH/jJhNnwr/phqy3xndrKlVmJb8rlb0RdVyAfU42JuTWJ9+n+BW1Juj85AKJQroUb
         TVcI+9MLqpwjIks8Ggy2D9LDtYfIiUrx9UKpNfj1EnphHyvkjZOPZbS1fgPDwmVgRsOH
         dITFmMY2Oc71LXmXzQH/L59KE8mmRQdBw40u0OZNH6zayf0Ko68YSzWma5nZlE+PQHB4
         tOne9YGxAcQlBLWT0DxXUQ1OmHNDUML3eXEKU7lr57eEzsnEEPG7HnbGYz9cn2QEDoKc
         dcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aCJ8krv/CniscCfWvuvXdGyUBMkPKUNGV45NFVLhlGA=;
        b=HMDqWttplWbPlPIyjCO3d8B7mOVgDKxJwXg8CC/Z+iQ2OX0KcP4PqskBPAN8FAFRbz
         /KpRGBd8VOp0brW8l1kllyRssSWWqkj8s04EugP1Y4L6WtjipBF//0eEUVX/YAnKOC/c
         HxaWhqqHai0m9t+GBKSKUurzVys4m70IMt3NXzEatkYLIgEHfOZP8wUUomHjLJ4m6ucZ
         KqVds8Nf/rO62+wjqO/sypBPAZD62xpo95WFFlDW3IjliIGq+WcVxclRGkwJ+SFrqHAM
         oYq0DdwljJk/4VON9oysSbswyp0T1xb7jJJZ0zw5Y+7hBx1wxhRPlh1QZ5Bmu3UEw9lU
         l2bA==
X-Gm-Message-State: APzg51BJIvoVezDByyQH7qnkkFiTjEsHo+gZPWEg00cjmNRXwfUU9EpH
        R5g2uGY1BphOtQHTDMXq4DA=
X-Google-Smtp-Source: ANB0VdbX3FW3dUPM9dhD/Is4I5NhS88zOYPOFe/V12q58PdwgUR/uGt82vaHlGEX3C0Lw4Iw/vIzbg==
X-Received: by 2002:a62:cc41:: with SMTP id a62-v6mr30881790pfg.131.1536004486894;
        Mon, 03 Sep 2018 12:54:46 -0700 (PDT)
Received: from [10.10.115.170] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id e73-v6sm34288803pfb.153.2018.09.03.12.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 12:54:45 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 7/7] net: dsa: Add Lantiq / Intel DSA driver
 for vrx200
To:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120511.10112-1-hauke@hauke-m.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <eb5c0815-e80c-7fd7-a14a-ccc3f28a7c93@gmail.com>
Date:   Mon, 3 Sep 2018 12:54:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180901120511.10112-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65919
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



On 9/1/2018 5:05 AM, Hauke Mehrtens wrote:
> This adds the DSA driver for the GSWIP Switch found in the VRX200 SoC.
> This switch is integrated in the DSL SoC, this SoC uses a GSWIP version
> 2.1, there are other SoCs using different versions of this IP block, but
> this driver was only tested with the version found in the VRX200.
> Currently only the basic features are implemented which will forward all
> packages to the CPU and let the CPU do the forwarding. The hardware also
> support Layer 2 offloading which is not yet implemented in this driver.
> 
> The GPHY FW loaded is now done by this driver and not any more by the
> separate driver in drivers/soc/lantiq/gphy.c, I will remove this driver
> is a separate patch. to make use of the GPHY this switch driver is
> needed anyway. Other SoCs have more embedded GPHYs so this driver should
> support a variable number of GPHYs. After the firmware was loaded the
> GPHY can be probed on the MDIO bus and it behaves like an external GPHY,
> without the firmware it can not be probed on the MDIO bus.
> 
> Currently this depends on SOC_TYPE_XWAY because the SoC revision
> detection function ltq_soc_type() is used to load the correct GPHY
> firmware on the VRX200 SoCs.
> 
> The clock names in the sysctrl.c file have to be changed because the
> clocks are now used by a different driver. This should be cleaned up and
> a real common clock driver should provide the clocks instead.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Looks great, just a few suggestions below

[snip]

> +static void gswip_adjust_link(struct dsa_switch *ds, int port,
> +			      struct phy_device *phydev)
> +{
> +	struct gswip_priv *priv = ds->priv;
> +	u16 macconf = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
> +	u16 miirate = 0;
> +	u16 miimode;
> +	u16 lcl_adv = 0, rmt_adv = 0;
> +	u8 flowctrl;
> +
> +	/* do not run this for the CPU port */
> +	if (dsa_is_cpu_port(ds, port))
> +		return;

Typically we expect the adjust_link callback to run for fixed link 
ports, that is inter-switch links (between switches) or between the CPU 
port and the Ethernet MAC attached to the switch. Here you are running 
this for the user facing ports (IIRC), which should really not be 
necessary, most Ethernet switches will be able to look at their built-in 
PHY's state and configure the switch's port automatically. Maybe this is 
not possible here because you had to disable polling?

Can you consider implementing PHYLINK operations which would make the 
driver more future proof, should you consider newer generations of 
switches that support 10G PHY, SGMII, SFP/SFF and so on?

[snip]

> +	if (priv->ds->dst->cpu_dp->index != priv->hw_info->cpu_port) {
> +		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
> +			priv->hw_info->cpu_port);
> +		err = -EINVAL;
> +		goto mdio_bus;
> +	}

There are a number of switches (b53, qca8k, mt7530) that have this 
requirement, we should probably be moving this check down into the core 
DSA layer and allow either to continue but disable switch tagging, if it 
was requested. Andrew what do you think?
-- 
Florian

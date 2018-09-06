Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 23:37:17 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:34927
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994648AbeIFVhNmTOfw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 23:37:13 +0200
Received: by mail-wm0-x241.google.com with SMTP id o18-v6so12725827wmc.0
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2018 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dc38cfVKKU0Jwgy1NEcwnkUgQeVGAYICyUsiyZDxKN4=;
        b=Tt8SF3IpbPWF2asL4kuATL9UM+wZ46/ASf7EZAxQVij+ILa/rHae23n7EYy+qO4CVY
         5/+btLNNPIVNj5xQ4tnspAHlHSWw3bh4t/OZsex+3WT9KZIvS3md7pcis4gTNDjf26u2
         Io1NNRUibLdolZ6/RIaQtQ5cG9wgBIT4X68XdRhEY6nhtvOf6Dqzfo3gDZZU42Zj+2AS
         f/wRLNsNyS6op+1/ih3JuKerI8kevRTrJJEESjRrhJHdZd6Ky+KYB4dpKyHDc+8Y9iAi
         4DazXCm27fIzx9yu6BZakHBXTUVvwyRWYKR4zSaRHO/Qa13OHVM4CAo+XpAyOuwISIU2
         Tn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dc38cfVKKU0Jwgy1NEcwnkUgQeVGAYICyUsiyZDxKN4=;
        b=J72j+/KOZmRDEd/6LTllZct33EzDPXisNVJGFBjv5Vep+vodXLVtLQ4x6z5s7DEj1s
         1F7buNbbTReLe9/UpCUOhuDTj39jZN/N3js67mdkg89bBHriSTONnZzS1cbEyL+pLV6g
         8SvrG7nNdjCk5nMeoB2T4/b9vuZNral9AweGXxkdAbTir4HGmylVDJuFb6/TBShOOalM
         0WjAU/pURxRIpgSrIoX9Int33zH4zcuUJYfEoTjXWbrnmrspIFqx91XLbXAbxQgygezp
         GgC/YmXBtsVZzw8e/evM0L+d88bRTSV5gLbf79WdbTWtz4bO2Bv4orGJOdugwx9F1O4o
         hZAg==
X-Gm-Message-State: APzg51DSjaS7MUfXHDV1d4mx/Oypi4A+MdkfuRaoskRs8Lq8kQ+2EebJ
        EJ43xJXQrcmlr9CHZ/3sPmk=
X-Google-Smtp-Source: ANB0Vdbp4dui/fr9sDWYbQ4i1W+zAj2zPLIuS+jt4uief318RtUKFgUC4qBDmqhOfA0xQFmdJioDmA==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr3171304wmx.38.1536269828125;
        Thu, 06 Sep 2018 14:37:08 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id k5-v6sm14259081wrm.96.2018.09.06.14.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:37:07 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 7/7] net: dsa: Add Lantiq / Intel DSA driver
 for vrx200
To:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, john@phrozen.org,
        linux-mips@linux-mips.org, dev@kresin.me, hauke.mehrtens@intel.com,
        devicetree@vger.kernel.org
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120511.10112-1-hauke@hauke-m.de>
 <eb5c0815-e80c-7fd7-a14a-ccc3f28a7c93@gmail.com>
 <d0da3eb2-8adb-677a-0f88-b6fe7989ae45@hauke-m.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <d344e75f-92f8-cbf2-9f69-fb17007a01cf@gmail.com>
Date:   Thu, 6 Sep 2018 14:36:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d0da3eb2-8adb-677a-0f88-b6fe7989ae45@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66095
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

On 09/06/2018 02:11 PM, Hauke Mehrtens wrote:
> On 09/03/2018 09:54 PM, Florian Fainelli wrote:
>>
>>
>> On 9/1/2018 5:05 AM, Hauke Mehrtens wrote:
>>> This adds the DSA driver for the GSWIP Switch found in the VRX200 SoC.
>>> This switch is integrated in the DSL SoC, this SoC uses a GSWIP version
>>> 2.1, there are other SoCs using different versions of this IP block, but
>>> this driver was only tested with the version found in the VRX200.
>>> Currently only the basic features are implemented which will forward all
>>> packages to the CPU and let the CPU do the forwarding. The hardware also
>>> support Layer 2 offloading which is not yet implemented in this driver.
>>>
>>> The GPHY FW loaded is now done by this driver and not any more by the
>>> separate driver in drivers/soc/lantiq/gphy.c, I will remove this driver
>>> is a separate patch. to make use of the GPHY this switch driver is
>>> needed anyway. Other SoCs have more embedded GPHYs so this driver should
>>> support a variable number of GPHYs. After the firmware was loaded the
>>> GPHY can be probed on the MDIO bus and it behaves like an external GPHY,
>>> without the firmware it can not be probed on the MDIO bus.
>>>
>>> Currently this depends on SOC_TYPE_XWAY because the SoC revision
>>> detection function ltq_soc_type() is used to load the correct GPHY
>>> firmware on the VRX200 SoCs.
>>>
>>> The clock names in the sysctrl.c file have to be changed because the
>>> clocks are now used by a different driver. This should be cleaned up and
>>> a real common clock driver should provide the clocks instead.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>
>> Looks great, just a few suggestions below
>>
>> [snip]
>>
>>> +static void gswip_adjust_link(struct dsa_switch *ds, int port,
>>> +                  struct phy_device *phydev)
>>> +{
>>> +    struct gswip_priv *priv = ds->priv;
>>> +    u16 macconf = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
>>> +    u16 miirate = 0;
>>> +    u16 miimode;
>>> +    u16 lcl_adv = 0, rmt_adv = 0;
>>> +    u8 flowctrl;
>>> +
>>> +    /* do not run this for the CPU port */
>>> +    if (dsa_is_cpu_port(ds, port))
>>> +        return;
>>
>> Typically we expect the adjust_link callback to run for fixed link
>> ports, that is inter-switch links (between switches) or between the CPU
>> port and the Ethernet MAC attached to the switch. Here you are running
>> this for the user facing ports (IIRC), which should really not be
>> necessary, most Ethernet switches will be able to look at their built-in
>> PHY's state and configure the switch's port automatically. Maybe this is
>> not possible here because you had to disable polling?
> 
> I deactivated the PHY auto polling, I can activate it again. Some PHYs
> could also be external on the same MDIO bus as the internal PHYs.
> 
> The CPU facing fixed link is a special MAC in the switch, at least in
> this version of the switch IP which is embedded in the networking SoCs.
> The MAC is more or less integrated in the switch and the driver can not
> configure the link between the MAC and the switch.

OK

> 
>> Can you consider implementing PHYLINK operations which would make the
>> driver more future proof, should you consider newer generations of
>> switches that support 10G PHY, SGMII, SFP/SFF and so on?
> 
> I will have a look at this later. I just saw that you pushed some
> branches adding SFP support to b53. ;-)

I would really add PHYLINK callbacks now what you have is fairly simple
to extract into separate functions doing the MAC configuration, and then
setting link up/down, that's pretty much all you need. Once you start
adding SFP/SFF support, things can get a bit more complicated
configuration wise.

> 
> The next step will be adding layer 2 offload. This is planned for the
> next patch series after this was merged. The switch uses internal VLANs
> for the offloading, so you configure a VLAN in the hardware and then add
> ports to it. I saw that multiple switches use this model, but converting
> the not VLAN aware layer 2 offloading to it looks a little bit strange,
> is there a good practice?
> 

Not VLAN aware layer 2 offload is actually quite common, the switch must
accept all frames in that case (not checking VID). L2 offload is really
about the following use case create a bridge, enslave ports of the
switch into it, and you should now have the switch forward from/to/
port0/port1 without this traffic going all the way to the CPU. If it
does, then there is no point having a switch in the first place :)

>> [snip]
>>
>>> +    if (priv->ds->dst->cpu_dp->index != priv->hw_info->cpu_port) {
>>> +        dev_err(dev, "wrong CPU port defined, HW only supports port:
>>> %i",
>>> +            priv->hw_info->cpu_port);
>>> +        err = -EINVAL;
>>> +        goto mdio_bus;
>>> +    }
>>
>> There are a number of switches (b53, qca8k, mt7530) that have this
>> requirement, we should probably be moving this check down into the core
>> DSA layer and allow either to continue but disable switch tagging, if it
>> was requested. Andrew what do you think?
> 
> As the CPU port is a special port many registers are only available for
> the normal front facing Ethernet ports and not for the CPU port so I
> have to make sure the correct port was selected as CPU port, otherwise
> the driver will write to the wrong register offsets.

OK, my comment was mostly for Andrew, this is not the first switch that
has specific requirements on which port of the switch is the
"CPU/management" port. So we should probably add some core functionality
within DSA to say "here are the ports that I can accept for management",
if the port you connected your switch to any other than those, then you
just lose tagging.
-- 
Florian

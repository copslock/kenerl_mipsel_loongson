Return-Path: <SRS0=jk8E=VY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCFC7618B
	for <linux-mips@archiver.kernel.org>; Sat, 27 Jul 2019 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E793D2080C
	for <linux-mips@archiver.kernel.org>; Sat, 27 Jul 2019 08:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btNI/AFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfG0Imi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:42:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40805 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfG0Imi (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 27 Jul 2019 04:42:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so49472825wmj.5;
        Sat, 27 Jul 2019 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=38BpCYy2RZO+b6j6/wJgmt20KHM6GmaUjQ92jgpxCD8=;
        b=btNI/AFyTSCzeE9aTqGRaZ4DeDWPXmkYTJHe0bcNah3P28r/mxtPk1Rvi8nUyq4TIc
         iw6w7xLrUPPgqBOUHDDRItPAunzH4yCk3PChNiozLLzDUYrbopa3A5EC44LWqxiNWKgL
         9Z5abIWfTNGiEgUxCvy5cJ3vh1PZXroXmj5NdCH3YeOR3UVlmwTe/adw0lG/Hozv8yLu
         NQ2U1hclBnxVs+0iIH+Qab0dCgH3fRPxryP4+eYjmGkxXQlGGnCdXD9ZmX9ls3TmWUby
         meFHJj8854qfsNl0AQCMQZnD1neUihn4sqowgPymYI6OsGKUtLzpGycye5vGYEuZIMIh
         c1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=38BpCYy2RZO+b6j6/wJgmt20KHM6GmaUjQ92jgpxCD8=;
        b=qP5HobH/EjlPRRisQt/5r3VYSlYJ2cuwNePPsxnsOz8XodSQJj+CF88NtJOeH6HSGu
         WA9VjN75A8aOO/nOcbrSH4h2Ksqv+Dk7IHDQaWd23XHjlKRMsxHfFjFYc3Wx4SWNA6EO
         cdWM24Sa36LlbQ/AMCpsgfsWIT65O7ObKbYK8gFodLY9mYhYBOvruQ/KN8mhCNo46S0o
         qjM7Lw3xbQT+hH6mgGVKHXWFCHcssVbr2WQ/HfOviMFMD+SObm6UsrJXMQOiiQhTGW95
         CXW65XvQka9cXi+KCM8RO8vnfBQ7GM009MRzpa2iJXUlU7HpUfoj3cQ5xia6AiwnLc+p
         3D8Q==
X-Gm-Message-State: APjAAAWMl+TgkFgkd/JKLgKoRMeBo1xxYqeedxZ/+I8xtE2M36lJPctD
        tzFAibjg0IX7suOdmqH6qYbv6uzQ8cs=
X-Google-Smtp-Source: APXvYqy9h051MP3rbpm2e488j9OqZjXgCJUWdt1GVmqyblFSR74Q9VvUrZAXvtOWP/AHfhaZpLYKIw==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr49443614wmj.133.1564216955548;
        Sat, 27 Jul 2019 01:42:35 -0700 (PDT)
Received: from [10.230.35.19] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id c4sm43588140wrt.86.2019.07.27.01.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 01:42:34 -0700 (PDT)
Subject: Re: [PATCH net-next 3/3] net: dsa: mt7530: Add support for port 5
To:     =?UTF-8?Q?Ren=c3=a9_van_Dorst?= <opensource@vdorst.com>,
        netdev@vger.kernel.org
Cc:     frank-w@public-files.de, sean.wang@mediatek.com,
        linux@armlinux.org.uk, davem@davemloft.net, matthias.bgg@gmail.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, john@phrozen.org,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20190724192549.24615-1-opensource@vdorst.com>
 <20190724192549.24615-4-opensource@vdorst.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <f4a9e219-cd03-1512-874d-925c43e3c44f@gmail.com>
Date:   Sat, 27 Jul 2019 10:42:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724192549.24615-4-opensource@vdorst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



On 7/24/2019 9:25 PM, René van Dorst wrote:
> Adding support for port 5.
> 
> Port 5 can muxed/interface to:
> - internal 5th GMAC of the switch; can be used as 2nd CPU port or as
>   extra port with an external phy for a 6th ethernet port.
> - internal PHY of port 0 or 4; Used in most applications so that port 0
>   or 4 is the WAN port and interfaces with the 2nd GMAC of the SOC.
> 
> Signed-off-by: René van Dorst <opensource@vdorst.com>

[snip]

> +	/* Setup port 5 */
> +	priv->p5_intf_sel = P5_DISABLED;
> +	interface = PHY_INTERFACE_MODE_NA;
> +
> +	if (!dsa_is_unused_port(ds, 5)) {
> +		priv->p5_intf_sel = P5_INTF_SEL_GMAC5;
> +		interface = of_get_phy_mode(ds->ports[5].dn);
> +	} else {
> +		/* Scan the ethernet nodes. Look for GMAC1, Lookup used phy */
> +		for_each_child_of_node(dn, mac_np) {
> +			if (!of_device_is_compatible(mac_np,
> +						     "mediatek,eth-mac"))
> +				continue;
> +			_id = of_get_property(mac_np, "reg", NULL);
> +			if (be32_to_cpup(_id)  != 1)
> +				continue;
> +
> +			interface = of_get_phy_mode(mac_np);
> +			phy_node = of_parse_phandle(mac_np, "phy-handle", 0);
> +
> +			if (phy_node->parent == priv->dev->of_node->parent) {
> +				_id = of_get_property(phy_node, "reg", NULL);
> +				id = be32_to_cpup(_id);
> +				if (id == 0)
> +					priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
> +				if (id == 4)
> +					priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;

Can you use of_mdio_parse_addr() here?
-- 
Florian

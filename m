Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:08:45 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:39280
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990656AbeCWVIaXqLb1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 22:08:30 +0100
Received: by mail-wm0-x243.google.com with SMTP id f125so5804235wme.4
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bKXGAOLKTmuQ0F5+c875lFls7WwPfiOEJBXk8SF77xI=;
        b=iIfSW3YOaXl1stUOg/Jy2RQ6rbvDZVQBZC2zUD9pXg3a94Mp7ebqAaH2sCD4W+sTAp
         Lc6q9EK6YqaZD00PZlcARaw1r+c0MdTsym6ytWcoUOmXdIZRrbVwrUhj+gDKWCgev8WP
         urUhV+6f4DBVn2Vh6DToXQHuyAzYdIwZOREwWaC02ipqKVtneaNukryVCLqmJ5EAFRDy
         RDnMXD7/lZvOCsz/0Ak3qwDsHDOJUDQ+IrR/ijpp6VmS4RoIvLN7OKcTpwLGRYbHe4ag
         OQba6j1CYePBGof/ao2lYt1ANjyQ77M3/IWewzblZOIUFBSCTC2lvoUfFYYAAdhwww7w
         nESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bKXGAOLKTmuQ0F5+c875lFls7WwPfiOEJBXk8SF77xI=;
        b=Oh8zDEqC4OaND+IXCzg60bbTJENFjZ+9BUeLQNvPkDc9m5qgSSXEf3W3zuzqIVqv+o
         tIkkW+3grYvcOgoTtvWWcDiyTTVZVdijyicj+1P0/1I/dzkLDQ4qysUvoQ+5TNKhq7/H
         w+RGA3TxR5wY/2zTNDSRgYHleGXvSb5+yf9I7o5ahYa33ETsqaskoR+4h5hwKyYD3iae
         adGVyBqZggYLK6KEIzGj3bsiuLz8R2zNeCFSpv645WFDOOoFkVscotmAFbXv39Aj6SO+
         cLkieunECL8uXAFyaikURD7hyWkiUzyV3ODbrHNCak3xwXdDWDcrWHE+aRocHe9NTPxf
         rnBw==
X-Gm-Message-State: AElRT7EnZf6eRO8eCfjGyWVvBfItg9dtPnLV3AvSjlc1taFhbNatw2r5
        O8rbz6Xxx6cKQvfKpWducRs=
X-Google-Smtp-Source: AG47ELtr9rb8uYKXhRzknjnfeqAaBN9Q/MPDitzbxVe1C9b1gnVY5z0YkKoVhXLjr9bUSTvqb+SE/Q==
X-Received: by 10.80.240.81 with SMTP id u17mr19392665edl.276.1521839304793;
        Fri, 23 Mar 2018 14:08:24 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id z4sm6776695edm.44.2018.03.23.14.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:08:23 -0700 (PDT)
Subject: Re: [PATCH net-next 1/8] net: phy: Add initial support for Microsemi
 Ocelot internal PHYs.
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-2-alexandre.belloni@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1caa7359-9ca3-be22-fae0-475daf8b220f@gmail.com>
Date:   Fri, 23 Mar 2018 14:08:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63194
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
> Add Microsemi Ocelot internal PHY ids. For now, simply use the genphy
> functions but more features are available.
> 
> Cc: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/net/phy/mscc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 650c2667d523..e1ab3acd1cdb 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -91,6 +91,7 @@ enum rgmii_rx_clock_delay {
>  #define SECURE_ON_PASSWD_LEN_4		  0x4000
>  
>  /* Microsemi PHY ID's */
> +#define PHY_ID_OCELOT			  0x00070540
>  #define PHY_ID_VSC8530			  0x00070560
>  #define PHY_ID_VSC8531			  0x00070570
>  #define PHY_ID_VSC8540			  0x00070760
> @@ -658,6 +659,19 @@ static int vsc85xx_probe(struct phy_device *phydev)
>  
>  /* Microsemi VSC85xx PHYs */
>  static struct phy_driver vsc85xx_driver[] = {
> +{
> +	.phy_id		= PHY_ID_OCELOT,
> +	.name		= "Microsemi OCELOT",
> +	.phy_id_mask    = 0xfffffff0,
> +	.features	= PHY_GBIT_FEATURES,
> +	.soft_reset	= &genphy_soft_reset,
> +	.config_init	= &genphy_config_init,
> +	.config_aneg	= &genphy_config_aneg,
> +	.aneg_done	= &genphy_aneg_done,
> +	.read_status	= &genphy_read_status,
> +	.suspend	= &genphy_suspend,
> +	.resume		= &genphy_resume,

With the exception of config_init(), suspend and resume, everything else
is already the default when you don't provide a callback. To echo to
what Andrew wrote already, if the purpose is just to show a nice name,
and do nothing else, consider using the Generic PHY driver (default).
-- 
Florian

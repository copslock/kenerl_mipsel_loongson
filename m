Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 23:11:50 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:35572
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeCWWLnhJvTS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 23:11:43 +0100
Received: by mail-qk0-x242.google.com with SMTP id s188so14544682qkb.2
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QKjhMlZSHPNj2p90oY4KA/n09WWldWjnBhW7R3Y3ER4=;
        b=tw5gmihOLRsZwDU7roQK6d+7Xu973RmXi0MSrHXTk1C198sGscFKcZaMwwwOjTvCs0
         F9CqQz0A2zoCK9CG5gArlOf31pYfr6gdP7UnRKNrb5oaHrPk347xxgmxsNSCGunMrA2G
         614It0qZFJFXL7wQ9Lr+Wp8iPzWDF7ksEL9dVehH19yfdu6v5Haz9aES1qWA1L6yz1se
         154lTZ+8XPvbDmc5lw3aOq0A6/mRNYDm5Q4t7i0HUt192pnwhPeioztMMBntd/VB9hWw
         axgNpEzRm6UZZ/QptJLc77TuXm5NQ7q7EQTpse3KK2kPy4I2wCzZkvWBWXWliENspzno
         2eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QKjhMlZSHPNj2p90oY4KA/n09WWldWjnBhW7R3Y3ER4=;
        b=kZDhpzpgGZVhqXhm9KQwsfvnYBIPXt6wcz1Bad3pBoHgpFoHf0704/g4bSFj+OQFof
         TZMDbBrVisMvwJSEOBG0YvuKMnsLT4tb/dN+LJxowYsKjKfB+CI111QyyJd+VhgfSipC
         yNb5aWzp/yeVhx8D30zPUJ8L4wQYuP9yIqlZY4NStrpl8TbE3jMp9zSjjTDQeWaatSBH
         zrRDho4YdaDyfQNbWlKciETBqNe+nYH1kUk4Gunc0OAEtsY9gGbi165LBh0gcZhWucUO
         7cwNB82ZiJJHC23hhcEsN3YrciB9jsyTv3swe91R0vT9axeG6jSJK9+85iv9TBIZIzfQ
         iVWQ==
X-Gm-Message-State: AElRT7GPYWmG+FsWOfQj+QQCZINfahjOeq2D/R40kCw9/M4uqLGNhkuP
        HWXIxxkztPhpyGjegHhWjvc=
X-Google-Smtp-Source: AG47ELsWAr1y8MRgpQkuIq3ZvcX8VRW4uoDmBNNQHr4qpPZdoHY9Jkzf3f25U7Z7LvTM0Awp43rIyw==
X-Received: by 10.55.149.135 with SMTP id x129mr44178119qkd.279.1521843095876;
        Fri, 23 Mar 2018 15:11:35 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id d1sm2391218qtk.47.2018.03.23.15.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 15:11:34 -0700 (PDT)
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
 <20180323212230.GA12808@piout.net> <20180323213344.GV24361@lunn.ch>
 <dcac43b7-2eb7-d409-a77c-4f671a8cfc3d@gmail.com>
 <20180323220657.GY24361@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <171fb3db-70f4-4818-9390-8164fab5adca@gmail.com>
Date:   Fri, 23 Mar 2018 15:11:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323220657.GY24361@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63206
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

On 03/23/2018 03:06 PM, Andrew Lunn wrote:
>>> That is the trade off of having a standalone MDIO bus driver.  Maybe
>>> add a phandle to the internal MDIO bus? The switch driver could then
>>> follow the phandle, and direct connect the internal PHYs?
>>
>> This is more or less what patch 7 does, right?
> 
> Patch 7 does it in DT. I'm suggesting it could be done in C. It is
> hard wired, so there is no need to describe it in DT. Use the phandle
> to get the mdio bus, mdiobus_get_phy(, port) to get the phydev and
> then use phy_connect().

That does not sound like a great idea. And to go back to your example
about DSA, it is partially true, you will see some switch bindings
defining the internal PHYs (e.g: qca8k), and most not doing it (b53,
mv88e6xxx, etc.). In either case, this resolves to the same thing
though. Being able to parse a phy-handle property is a lot more
flexible, and if it does matter that the PHY truly is internal, then the
'phy-mode' property can help reflect that.
-- 
Florian

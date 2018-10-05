Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2018 23:39:32 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:43668 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994637AbeJEVj3iNjzG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2018 23:39:29 +0200
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98E3C13ADF961;
        Fri,  5 Oct 2018 14:39:25 -0700 (PDT)
Date:   Fri, 05 Oct 2018 14:39:24 -0700 (PDT)
Message-Id: <20181005.143924.1849227852256176976.davem@davemloft.net>
To:     quentin.schulz@bootlin.com
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v4 00/11] mscc: ocelot: add support for SerDes
 muxing configuration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181004122208.32272-1-quentin.schulz@bootlin.com>
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 14:39:26 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Quentin Schulz <quentin.schulz@bootlin.com>
Date: Thu,  4 Oct 2018 14:21:57 +0200

> The Ocelot switch has currently an hardcoded SerDes muxing that suits only
> a particular use case. Any other board setup will fail to work.
> 
> To prepare for upcoming boards' support that do not have the same muxing,
> create a PHY driver that will handle all possible cases.
> 
> A SerDes can work in SGMII, QSGMII or PCIe and is also muxed to use a
> given port depending on the selected mode or board design.
> 
> The SerDes configuration is in the middle of an address space (HSIO) that
> is used to configure some parts in the MAC controller driver, that is why
> we need to use a syscon so that we can write to the same address space from
> different drivers safely using regmap.
> 
> This breaks backward compatibility but it's fine because there's only one
> board at the moment that is using what's modified in this patch series.
> This will break git bisect.
> 
> Even though this patch series is about SerDes __muxing__ configuration, the
> DT node is named serdes for the simple reason that I couldn't find any
> mention to SerDes anywhere else from the address space handled by this
> driver.

Series applied to net-next, thanks.

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 19:31:54 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:53942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994558AbeJHRbvDj09O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2018 19:31:51 +0200
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::4572])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1949144DD4F7;
        Mon,  8 Oct 2018 10:31:46 -0700 (PDT)
Date:   Mon, 08 Oct 2018 10:31:46 -0700 (PDT)
Message-Id: <20181008.103146.1207267745006170466.davem@davemloft.net>
To:     quentin.schulz@bootlin.com
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [RESEND PATCH v2 0/5] net: phy: mscc: add support for VSC8584
 and VSC8574 Microsemi quad-port PHYs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181008101445.25946-1-quentin.schulz@bootlin.com>
References: <20181008101445.25946-1-quentin.schulz@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Oct 2018 10:31:47 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66729
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
Date: Mon,  8 Oct 2018 12:14:40 +0200

> RESEND: rebased on top of latest net-next and on top of latest version of
> "net: phy: mscc: various improvements to Microsemi PHY driver" patch
> series.

Patches 1-3 applied to net-next, thanks.

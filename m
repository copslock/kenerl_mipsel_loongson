Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2018 23:42:50 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:43740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994640AbeJEVmsA5jxG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2018 23:42:48 +0200
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87FA813ADF961;
        Fri,  5 Oct 2018 14:42:44 -0700 (PDT)
Date:   Fri, 05 Oct 2018 14:42:43 -0700 (PDT)
Message-Id: <20181005.144243.1971242720262167660.davem@davemloft.net>
To:     quentin.schulz@bootlin.com
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH v2 0/5] net: phy: mscc: add support for VSC8584 and
 VSC8574 Microsemi quad-port PHYs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181004131710.14978-1-quentin.schulz@bootlin.com>
References: <20181004131710.14978-1-quentin.schulz@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 14:42:45 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66706
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
Date: Thu,  4 Oct 2018 15:17:05 +0200

> I suggest patches 1 to 3 go through net tree and patches 4 and 5 go
> through MIPS tree. Patches going through net tree and those going through
> MIPS tree do not depend on one another.

Sounds like a good plan but patches 1-3 do not apply to net-next, please
respin.

Thank you.

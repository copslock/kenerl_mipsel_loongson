Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2018 17:15:14 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:46706 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994074AbeIMPPKAwI5R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2018 17:15:10 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 49F2F108D8F56;
        Thu, 13 Sep 2018 08:15:05 -0700 (PDT)
Date:   Thu, 13 Sep 2018 08:15:02 -0700 (PDT)
Message-Id: <20180913.081502.621496165436800090.davem@davemloft.net>
To:     hauke@hauke-m.de
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/6] Add support for Lantiq / Intel vrx200
 network
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180909201647.32727-1-hauke@hauke-m.de>
References: <20180909201647.32727-1-hauke@hauke-m.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Sep 2018 08:15:05 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66222
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

From: Hauke Mehrtens <hauke@hauke-m.de>
Date: Sun,  9 Sep 2018 22:16:41 +0200

> This adds basic support for the GSWIP (Gigabit Switch) found in the
> VRX200 SoC.
> There are different versions of this IP core used in different SoCs, but
> this driver was currently only tested on the VRX200 SoC line, for other
> SoCs this driver probably need some adoptions to work.
> 
> I also plan to add Layer 2 offloading to the DSA driver and later also
> layer 3 offloading which is supported by the PPE HW block.
> 
> All these patches should go through the net-next tree.
> 
> This depends on the patch "MIPS: lantiq: dma: add dev pointer" which 
> should go into 4.19.

Series applied to net-next, thanks.

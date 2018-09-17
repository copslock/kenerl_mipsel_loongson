Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2018 17:13:39 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:43032 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994002AbeIQPNgEOUuq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Sep 2018 17:13:36 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F3420144B43B9;
        Mon, 17 Sep 2018 08:13:30 -0700 (PDT)
Date:   Mon, 17 Sep 2018 08:13:30 -0700 (PDT)
Message-Id: <20180917.081330.921984316304814099.davem@davemloft.net>
To:     hauke@hauke-m.de
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net: lantiq: Minor fixes for vrx200 and
 gswip
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180915120849.24630-1-hauke@hauke-m.de>
References: <20180915120849.24630-1-hauke@hauke-m.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 08:13:31 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66368
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
Date: Sat, 15 Sep 2018 14:08:44 +0200

> These are mostly minor fixes to problems addresses in the latests round 
> of the review of the original series adding these driver, which were not 
> applied before the patches got merged into net-next.
> In addition it fixes a data bus error on poweroff.

Series applied.

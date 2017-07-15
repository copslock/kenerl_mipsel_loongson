Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jul 2017 23:30:32 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:58500 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993924AbdGOVaXKsiSK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Jul 2017 23:30:23 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A6889124ABB10;
        Sat, 15 Jul 2017 14:30:20 -0700 (PDT)
Date:   Sat, 15 Jul 2017 14:30:20 -0700 (PDT)
Message-Id: <20170715.143020.159307310638213706.davem@davemloft.net>
To:     Jason@zx2c4.com
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] ioc3-eth: store pointer to net_device for priviate area
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20170710120032.11173-1-Jason@zx2c4.com>
References: <20170710120032.11173-1-Jason@zx2c4.com>
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Jul 2017 14:30:20 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59113
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

From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 10 Jul 2017 14:00:32 +0200

> Computing the alignment manually for going from priv to pub is probably
> not such a good idea, and in general the assumption that going from priv
> to pub is possible trivially could change, so rather than relying on
> that, we change things to just store a pointer to pub. This was sugested
> by DaveM in [1].
> 
> [1] http://www.spinics.net/lists/netdev/msg443992.html
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Applied.

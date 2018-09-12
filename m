Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2018 08:34:02 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:54180 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992871AbeILGd6vXc9B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2018 08:33:58 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F1E5512DE57F3;
        Tue, 11 Sep 2018 23:33:54 -0700 (PDT)
Date:   Tue, 11 Sep 2018 23:33:54 -0700 (PDT)
Message-Id: <20180911.233354.1249400274643211300.davem@davemloft.net>
To:     hauke@hauke-m.de
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org,
        hauke.mehrtens@intel.com, paul.burton@mips.com
Subject: Re: [PATCH v2 net] MIPS: lantiq: dma: add dev pointer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180909192623.14998-1-hauke@hauke-m.de>
References: <20180909192623.14998-1-hauke@hauke-m.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 11 Sep 2018 23:33:55 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66214
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
Date: Sun,  9 Sep 2018 21:26:23 +0200

> dma_zalloc_coherent() now crashes if no dev pointer is given.
> Add a dev pointer to the ltq_dma_channel structure and fill it in the
> driver using it.
> 
> This fixes a bug introduced in kernel 4.19.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied, thank you.

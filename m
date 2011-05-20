Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 20:56:20 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:49613 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab1ETS4O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2011 20:56:14 +0200
Received: from localhost (nat-pool-rdu.redhat.com [66.187.233.202])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p4KIu4Av014848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 20 May 2011 11:56:08 -0700
Date:   Fri, 20 May 2011 14:56:04 -0400 (EDT)
Message-Id: <20110520.145604.330897605239664622.davem@davemloft.net>
To:     manuel.lauss@googlemail.com
Cc:     ralf@linux-mips.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] net: au1000_eth: add MACDMA to platform resource info.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1305916865-14038-1-git-send-email-manuel.lauss@googlemail.com>
References: <1305916865-14038-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Fri, 20 May 2011 11:56:09 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 20 May 2011 20:41:05 +0200

> This patch removes the last hardcoded base address from the au1000_eth
> driver:  The base of the MACDMA unit was derived from the
> platform device id; if someone registered the MACs in inverse order
> both would not work.
> Instead pass the base address of the DMA unit to the driver along with
> the other platform resource information.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Acked-by: David S. Miller <davem@davemloft.net>

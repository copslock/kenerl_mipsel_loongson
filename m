Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 03:55:59 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52892
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492003Ab0GFBzy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jul 2010 03:55:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 7B81724C113;
        Mon,  5 Jul 2010 18:56:06 -0700 (PDT)
Date:   Mon, 05 Jul 2010 18:56:06 -0700 (PDT)
Message-Id: <20100705.185606.115922440.davem@davemloft.net>
To:     ralf@linux-mips.org
Cc:     segooon@gmail.com, kernel-janitors@vger.kernel.org,
        jpirko@redhat.com, eric.dumazet@gmail.com, kaber@trash.net,
        adobriyan@gmail.com, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [NET] ioc3-eth: Use the instance of net_device_stats from
 net_device.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20100705125938.GB28849@linux-mips.org>
References: <20100705125938.GB28849@linux-mips.org>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>
Date: Mon, 5 Jul 2010 13:59:38 +0100

> Since net_device has an instance of net_device_stats, we can remove the
> instance of this from the adapter structure.
> 
> Based on original patch by Kulikov Vasiliy.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>

Applied.

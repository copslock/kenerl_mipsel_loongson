Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 07:39:38 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:51012 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeGXFjdkyV3w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2018 07:39:33 +0200
Received: from localhost (unknown [172.58.43.75])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E7386108CA124;
        Mon, 23 Jul 2018 22:39:28 -0700 (PDT)
Date:   Mon, 23 Jul 2018 22:39:25 -0700 (PDT)
Message-Id: <20180723.223925.421201399606552054.davem@davemloft.net>
To:     hauke@hauke-m.de
Cc:     paul.burton@mips.com, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 1/4] MIPS: lantiq: Do not enable IRQs in dma open
From:   David Miller <davem@davemloft.net>
In-Reply-To: <dd3980b2-b699-a988-3ecd-8261c782244f@hauke-m.de>
References: <20180721191358.13952-2-hauke@hauke-m.de>
        <20180724001923.d4y7eth7k3ng44lq@pburton-laptop>
        <dd3980b2-b699-a988-3ecd-8261c782244f@hauke-m.de>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Jul 2018 22:39:29 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65073
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
Date: Tue, 24 Jul 2018 07:32:27 +0200

> 
> 
> On 07/24/2018 02:19 AM, Paul Burton wrote:
>> Hi Hauke,
>> 
>> On Sat, Jul 21, 2018 at 09:13:55PM +0200, Hauke Mehrtens wrote:
>>> When a DMA channel is opened the IRQ should not get activated
>>> automatically, this allows it to pull data out manually without the help
>>> of interrupts. This is needed for a workaround in the vrx200 Ethernet
>>> driver.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>  arch/mips/lantiq/xway/dma.c        | 1 -
>>>  drivers/net/ethernet/lantiq_etop.c | 1 +
>>>  2 files changed, 1 insertion(+), 1 deletion(-)
>> 
>> If you'd like this to go via the netdev tree to keep it with the rest of
>> the series:
>> 
>>     Acked-by: Paul Burton <paul.burton@mips.com>
> 
> Thanks, I also prefer that this goes through netdev.

Please be sure to repost your series with Paul's ACK added.

Also, in the patch postings and cover letter, put "net-next" in
the Subject line so that the target tree is clear, like:

	Subject: [PATCH net-next 1/4] MIPS: ...


Thank you.

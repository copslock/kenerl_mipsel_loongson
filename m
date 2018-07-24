Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 07:32:41 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:19080 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990509AbeGXFciGKLjw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 07:32:38 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 7408747E2A;
        Tue, 24 Jul 2018 07:32:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id bzI-Tc3W4Kz0; Tue, 24 Jul 2018 07:32:31 +0200 (CEST)
Subject: Re: [PATCH 1/4] MIPS: lantiq: Do not enable IRQs in dma open
To:     Paul Burton <paul.burton@mips.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-2-hauke@hauke-m.de>
 <20180724001923.d4y7eth7k3ng44lq@pburton-laptop>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <dd3980b2-b699-a988-3ecd-8261c782244f@hauke-m.de>
Date:   Tue, 24 Jul 2018 07:32:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180724001923.d4y7eth7k3ng44lq@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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



On 07/24/2018 02:19 AM, Paul Burton wrote:
> Hi Hauke,
> 
> On Sat, Jul 21, 2018 at 09:13:55PM +0200, Hauke Mehrtens wrote:
>> When a DMA channel is opened the IRQ should not get activated
>> automatically, this allows it to pull data out manually without the help
>> of interrupts. This is needed for a workaround in the vrx200 Ethernet
>> driver.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  arch/mips/lantiq/xway/dma.c        | 1 -
>>  drivers/net/ethernet/lantiq_etop.c | 1 +
>>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> If you'd like this to go via the netdev tree to keep it with the rest of
> the series:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>

Thanks, I also prefer that this goes through netdev.

> Though I'd be happier if we didn't have DMA code seemingly used only by
> an ethernet driver in arch/mips/ :)

There are also some out of tree driver that use this DMA code. This
should probably be converted to a DMA channel driver but that is not
very high on my todo list.

Hauke

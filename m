Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 22:00:45 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:36050 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008048AbaICUAmvtTpq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Sep 2014 22:00:42 +0200
Received: from [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2] (unknown [IPv6:2001:470:7259:0:59c1:1a8e:a91d:7de2])
        by hauke-m.de (Postfix) with ESMTPSA id 9263F200F3;
        Wed,  3 Sep 2014 22:00:42 +0200 (CEST)
Message-ID: <54077369.60102@hauke-m.de>
Date:   Wed, 03 Sep 2014 22:00:41 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH][RFC][Ack req] MIPS: BCM47XX: Initialize bcma bus later
 (with mm available)
References: <1409658719-32110-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1409658719-32110-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42380
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

On 09/02/2014 01:51 PM, Rafał Miłecki wrote:
> Initializaion with memory allocator available will be much simpler, this
> will allow cleanup in the bcma code.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
> Hi Ralf,
> 
> As recently described in the e-mail thread
> "Booting bcm47xx (bcma & stuff), sharing code with bcm53xx"
> I plan to simplify bcma code for SoC booting.
> 
> This is one of my patches. As most of them touch "bcma" driver code, I
> wanted to push them through John's wireless-next tree. Of course this
> patch is not wireless related at all, so I'd need your Ack for it.
> 
> Could you review it and let me know if it looks OK for you? Is that
> acceptable for you to push this one patch using wireless-next git tree?
> 
> This patch already depends on two that were submitted to John:
> [PATCH 1/2] bcma: move bus struct setup into early part of host specific code
> [PATCH 2/2] bcma: use separated function to initialize bus on SoC
> 
> Hauke: could you review it as well, please?
> ---
>  arch/mips/bcm47xx/bcm47xx_private.h |  3 +++
>  arch/mips/bcm47xx/irq.c             |  8 ++++++++
>  arch/mips/bcm47xx/setup.c           | 33 +++++++++++++++++++++++++++------
>  3 files changed, 38 insertions(+), 6 deletions(-)
> 

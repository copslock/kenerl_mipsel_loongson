Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Sep 2014 22:05:39 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:39901 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008380AbaIGUFh3Ikqq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 7 Sep 2014 22:05:37 +0200
Received: from [IPv6:2001:470:7259:0:b952:7678:9bd5:1eb9] (unknown [IPv6:2001:470:7259:0:b952:7678:9bd5:1eb9])
        by hauke-m.de (Postfix) with ESMTPSA id 20742204B1;
        Sun,  7 Sep 2014 22:05:37 +0200 (CEST)
Message-ID: <540CBA8F.3050900@hauke-m.de>
Date:   Sun, 07 Sep 2014 22:05:35 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V3] MIPS: BCM47XX: Make ssb init NVRAM instead of bcm47xx
 polling it
References: <1409744065-24334-1-git-send-email-zajec5@gmail.com> <1409777985-2474-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1409777985-2474-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42465
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

On 09/03/2014 10:59 PM, Rafał Miłecki wrote:
> This makes NVRAM code less bcm47xx/ssb specific allowing it to become a
> standalone driver in the future. A similar patch for bcma will follow
> when it's ready.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
> This patch depends on
> [PATCH] MIPS: BCM47XX: Get rid of calls to KSEG1ADDR in nvram
> 
> V2: Typo in commit message s/bcma/ssb/
> 
> V3: Put function declaration in
>     arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
>     (why did I miss that earlier?! Thanks Hauke)
> ---
>  arch/mips/bcm47xx/nvram.c                          | 30 +++++++---------------
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |  1 +
>  drivers/ssb/driver_mipscore.c                      | 14 +++++++++-
>  3 files changed, 23 insertions(+), 22 deletions(-)
> 

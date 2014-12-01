Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 09:23:58 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:50896 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007788AbaLAIX5DQ0yG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Dec 2014 09:23:57 +0100
Received: from [IPv6:2001:470:7259:0:706e:1bb:5913:a42b] (unknown [IPv6:2001:470:7259:0:706e:1bb:5913:a42b])
        by hauke-m.de (Postfix) with ESMTPSA id 8D79C2002F;
        Mon,  1 Dec 2014 09:23:56 +0100 (CET)
Message-ID: <547C259B.6000405@hauke-m.de>
Date:   Mon, 01 Dec 2014 09:23:55 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH] MIPS: BCM47XX: Move NVRAM header to the include/linux/
References: <1417417098-8476-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1417417098-8476-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44524
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

On 12/01/2014 07:58 AM, Rafał Miłecki wrote:
> There are two reasons for having this header in the common place:
> 1) Simplifying drivers that read NVRAM entries. We will be able to
>    safely call bcm47xx_nvram_* functions without #ifdef-s.
> 2) Getting NVRAM driver out of MIPS arch code. This is needed to support
>    BCM5301X arch which also requires this NVRAM driver. Patch for that
>    will follow once we get is reviewed.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> Hi guys,
> 
> As recently discussed (thanks Paul!), we will try yet another (3rd) path for our
> NVRAM driver, this time it will be drivers/firmware/.
> However this will require some time as I want to give ppl chance to review it
> and probably we will need to discuss it too.
> 
> So meanwhile I'd like to move just a header file to the include/linux/. I
> believe it won't raise any/too many objections and it should strip down
> further discussions about bcm47xx_nvram.c.
> ---
>  arch/mips/bcm47xx/board.c                             |  2 +-
>  arch/mips/bcm47xx/nvram.c                             |  2 +-
>  arch/mips/bcm47xx/setup.c                             |  1 -
>  arch/mips/bcm47xx/sprom.c                             |  1 -
>  arch/mips/bcm47xx/time.c                              |  1 -
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h          |  1 +
>  drivers/bcma/driver_mips.c                            |  2 +-
>  drivers/net/ethernet/broadcom/b44.c                   |  2 +-
>  drivers/net/ethernet/broadcom/bgmac.c                 |  2 +-
>  drivers/ssb/driver_chipcommon_pmu.c                   |  2 +-
>  drivers/ssb/driver_mipscore.c                         |  2 +-
>  .../mach-bcm47xx => include/linux}/bcm47xx_nvram.h    | 19 ++++++++++++++++---
>  12 files changed, 24 insertions(+), 13 deletions(-)
>  rename {arch/mips/include/asm/mach-bcm47xx => include/linux}/bcm47xx_nvram.h (63%)

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

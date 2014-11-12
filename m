Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:34:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57189 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013346AbaKLJe45ph-- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:34:56 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 915F66301414D;
        Wed, 12 Nov 2014 09:34:49 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 12 Nov
 2014 09:34:50 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 12 Nov 2014 09:34:50 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 12 Nov 2014 09:34:49 +0000
Message-ID: <546329B1.5060406@imgtec.com>
Date:   Wed, 12 Nov 2014 09:34:41 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Hauke Mehrtens <hauke@hauke-m.de>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Move NVRAM driver to the drivers/misc/
References: <1415735146-31552-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1415735146-31552-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Hi,

On 11/11/14 19:45, Rafał Miłecki wrote:
> After Broadcom switched from MIPS to ARM for their home routers we need
> to have NVRAM driver in some common place (not arch/mips/).
> We were thinking about putting it in bus directory, however there are
> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
> won't fit there neither.
> This is why I would like to move this driver to the drivers/misc/
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
>  arch/mips/Kconfig                                  |   1 +
>  arch/mips/bcm47xx/Makefile                         |   2 +-
>  arch/mips/bcm47xx/board.c                          |   2 +-
>  arch/mips/bcm47xx/nvram.c                          | 228 --------------------
>  arch/mips/bcm47xx/setup.c                          |   1 -
>  arch/mips/bcm47xx/sprom.c                          |   1 -
>  arch/mips/bcm47xx/time.c                           |   1 -
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h       |   1 +
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |  21 --
>  drivers/bcma/driver_mips.c                         |   2 +-
>  drivers/misc/Kconfig                               |   9 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/bcm47xx_nvram.c                       | 230 +++++++++++++++++++++
>  drivers/net/ethernet/broadcom/b44.c                |   2 +-
>  drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
>  drivers/ssb/driver_chipcommon_pmu.c                |   2 +-
>  drivers/ssb/driver_mipscore.c                      |   2 +-
>  include/linux/bcm47xx_nvram.h                      |  18 ++
>  18 files changed, 267 insertions(+), 259 deletions(-)
>  delete mode 100644 arch/mips/bcm47xx/nvram.c
>  delete mode 100644 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
>  create mode 100644 drivers/misc/bcm47xx_nvram.c
>  create mode 100644 include/linux/bcm47xx_nvram.h

Using git format-patch -M should generate a review-able patch.
Especially for nvram.c

Regards
ZubairLK

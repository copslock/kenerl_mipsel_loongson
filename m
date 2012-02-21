Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2012 20:47:04 +0100 (CET)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:39460 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903730Ab2BUTq5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2012 20:46:57 +0100
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1Rzvfk-0000eT-J9; Tue, 21 Feb 2012 14:46:48 -0500
Received: from linville-8530p.local (linville-8530p.local [127.0.0.1])
        by linville-8530p.local (8.14.4/8.14.4) with ESMTP id q1LJbkJf027473;
        Tue, 21 Feb 2012 14:37:47 -0500
Received: (from linville@localhost)
        by linville-8530p.local (8.14.4/8.14.4/Submit) id q1LJbimR027471;
        Tue, 21 Feb 2012 14:37:44 -0500
Date:   Tue, 21 Feb 2012 14:37:44 -0500
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch
Subject: Re: [PATCH 00/11] ssb/bcma/BCM47XX: sprom fixes and extensions
Message-ID: <20120221193744.GB19354@tuxdriver.com>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Has Ralf seen the arch/mips patches?

On Sun, Feb 19, 2012 at 07:32:14PM +0100, Hauke Mehrtens wrote:
> This patch series fixes some errors in the sprom structures and extends 
> it to contain members for all sprom values for sprom version 1 to 9. 
> This was done by looking into the open source part of the Broadcom SDK. 
> This also adds a fallback sprom registration method to bcma.
> It also contains some small fixes for the bcma47xx arch code and a 
> rewrite of the code to provide the sprom from flash. It now also 
> provides sprom from flash for devices using bcma to control the system 
> bus.
> 
> This patch series is based on wireles-testing. I think it is the best 
> way to merge this through John's wireless tree as the changes in the 
> sprom struct should be used in further patches extending the pci sprom 
> parsing and the usage of struct sprom by the brcmsmac driver.
> 
> Hauke Mehrtens (11):
>   ssb: sprom fix some sizes / signedness
>   ssb: remove 5GHz antenna gain from sprom
>   ssb: fix per path sprom vars
>   ssb: add ccode
>   ssb: add some missing sprom attributes
>   bcma: export bcma_find_core
>   bcma: add support for sprom not found on the device.
>   MIPS: BCM47XX: return number of written bytes in nvram_getenv
>   MIPS: BCM47XX: fix signature of nvram_parse_macaddr
>   MIPS: BCM47XX: move and extend sprom parsing
>   MIPS: BCM47XX: provide sprom to bcma bus
> 
>  arch/mips/bcm47xx/Makefile                   |    2 +-
>  arch/mips/bcm47xx/nvram.c                    |    3 +-
>  arch/mips/bcm47xx/setup.c                    |  188 ++-------
>  arch/mips/bcm47xx/sprom.c                    |  618 ++++++++++++++++++++++++++
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    3 +
>  arch/mips/include/asm/mach-bcm47xx/nvram.h   |    2 +-
>  drivers/bcma/main.c                          |    3 +-
>  drivers/bcma/sprom.c                         |   75 +++-
>  drivers/net/wireless/b43legacy/phy.c         |    2 +-
>  drivers/ssb/pci.c                            |   40 +--
>  drivers/ssb/pcmcia.c                         |   12 +-
>  drivers/ssb/sdio.c                           |   12 +-
>  include/linux/bcma/bcma.h                    |    7 +
>  include/linux/ssb/ssb.h                      |  102 ++++-
>  14 files changed, 844 insertions(+), 225 deletions(-)
>  create mode 100644 arch/mips/bcm47xx/sprom.c
> 
> -- 
> 1.7.5.4
> 
> 

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.

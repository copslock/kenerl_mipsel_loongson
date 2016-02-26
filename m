Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 02:30:05 +0100 (CET)
Received: from mail.kmu-office.ch ([178.209.48.109]:57185 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006610AbcBZBaE6QxK6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 02:30:04 +0100
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5D6465C0009;
        Fri, 26 Feb 2016 02:29:52 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Feb 2016 17:27:23 -0800
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 00/52] mtd: rework ECC layout definition
In-Reply-To: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <d968b867f4d7f603581a0ff83e07c15c@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.1.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim; t=1456450192; bh=DF5tidBOUvGwI9K4Dny7OM6RlFxEfaypAKPb0LVPgYY=; h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID; b=fVt2APfqv/rqHVgGjimTBc+IutA1/wgbRvzK56rB5rwAAPzcjEnCU1ih8XOMBcbrVw0Um9Fk1Ri+vHskWJ+EVlzQcsjdNTEU/E7HuFqmfd+ccXDZJtH6IlLkXV/gvw0OtziZijqUJT2I0zxh3LFXOl5t0Ngg6C2DiIVdM50Zp9Y=
Return-Path: <stefan@agner.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan@agner.ch
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

Hi Boris,

On 2016-02-25 16:57, Boris Brezillon wrote:
> Hello,
> 
> This patchset aims at getting rid of the nand_ecclayout limitations.
> struct nand_ecclayout is defining fixed eccpos and oobfree arrays which
> can only be increased by modifying the MTD_MAX_ECCPOS_ENTRIES_LARGE and
> MTD_MAX_OOBFREE_ENTRIES_LARGE macros.
> This approach forces us to modify the macro values each time we add a
> new NAND chip with a bigger OOB area, and increasing these arrays also
> penalize all platforms, even those who only support small NAND devices
> (with small OOB area).
> 
> The idea to overcome this limitation, is to define the ECC/OOB layout
> by the mean of two functions: ->ecc() and ->free(), which will
> basically return the same information has those stored in the
> nand_ecclayout struct.
> 
> Another advantage of this solution is that ECC layouts are usually
> following a repetitive pattern (i.e. leave X bytes free and put Y bytes
> of ECC per ECC chunk), which allows one to implement the ->ecc()
> and ->free() functions with a simple logic that can be applied
> to any size of OOB.
> 
> Patches 1 to 4 are just cleanups or trivial fixes that can be taken
> independently.
> 
> Also note that the last two commits are removing the nand_ecclayout
> definition, thus preventing any new driver to use this structure.
> Of course, this step can be delayed if some of the previous patches
> are not accepted.

Is the patch set somewhere available to pull from?

Do I see things right that patch 21/52 contains the crucial function
nand_ooblayout_ecc_lp which calculate the ECC position? (for those who
do not provide mtd_ooblayout_ops anyway...)

--
Stefan

> 
> Best Regards,
> 
> Boris
> 
> Changes since v2:
> - fixed a few bugs in the core and driver implementations
> 
> Changes since v1:
> - unified the way of defining ECC and free bytes
> - fixed a few bugs in some ->ecc()/->free() implementations
> - added new helpers to ease ECC and free bytes manipulation
> - separated driver changes in different commits to ease review
> - dropped already applied patches
> 
> *** BLURB HERE ***
> 
> Boris Brezillon (52):
>   mtd: kill the ecclayout->oobavail field
>   mtd: create an mtd_oobavail() helper and make use of it
>   mtd: mtdswap: remove useless if (!mtd->ecclayout) test
>   mtd: nand: simplify nand_bch_init() usage
>   mtd: add mtd_ooblayout_xxx() helper functions
>   mtd: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: core: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: atmel: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: fsl_ifc: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: gpmi: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: lpc32xx: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: omap2: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: onenand: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: add mtd_set_ecclayout() helper function
>   mtd: use mtd_set_ecclayout() where appropriate
>   mtd: nand: use mtd_set_ecclayout() where appropriate
>   mtd: onenand: use mtd_set_ecclayout() where appropriate
>   mtd: docg3: use mtd_set_ecclayout() where appropriate
>   mtd: create an mtd_ooblayout_ops struct to ease ECC layout definition
>   mtd: docg3: switch to mtd_ooblayout_ops
>   mtd: nand: implement the default mtd_ooblayout_ops
>   mtd: nand: bch: switch to mtd_ooblayout_ops
>   mtd: nand: sharpsl: switch to mtd_ooblayout_ops
>   mtd: nand: jz4740: switch to mtd_ooblayout_ops
>   mtd: nand: atmel: switch to mtd_ooblayout_ops
>   mtd: nand: bf5xx: switch to mtd_ooblayout_ops
>   mtd: nand: brcm: switch to mtd_ooblayout_ops
>   mtd: nand: cafe: switch to mtd_ooblayout_ops
>   mtd: nand: davinci: switch to mtd_ooblayout_ops
>   mtd: nand: denali: switch to mtd_ooblayout_ops
>   mtd: nand: diskonchip: switch to mtd_ooblayout_ops
>   mtd: nand: docg4: switch to mtd_ooblayout_ops
>   mtd: nand: fsl_elbc: switch to mtd_ooblayout_ops
>   mtd: nand: fsl_ifc: switch to mtd_ooblayout_ops
>   mtd: nand: fsmc: switch to mtd_ooblayout_ops
>   mtd: nand: fsmc: get rid of the fsmc_nand_eccplace struct
>   mtd: nand: gpmi: switch to mtd_ooblayout_ops
>   mtd: nand: hisi504: switch to mtd_ooblayout_ops
>   mtd: nand: jz4780: switch to mtd_ooblayout_ops
>   mtd: nand: lpc32xx: switch to mtd_ooblayout_ops
>   mtd: nand: mxc: switch to mtd_ooblayout_ops
>   mtd: nand: omap2: switch to mtd_ooblayout_ops
>   mtd: nand: pxa3xx: switch to mtd_ooblayout_ops
>   mtd: nand: s3c2410: switch to mtd_ooblayout_ops
>   mtd: nand: sh_flctl: switch to mtd_ooblayout_ops
>   mtd: nand: sm_common: switch to mtd_ooblayout_ops
>   mtd: nand: sunxi: switch to mtd_ooblayout_ops
>   mtd: nand: vf610: switch to mtd_ooblayout_ops
>   mtd: onenand: switch to mtd_ooblayout_ops
>   staging: mt29f_spinand: switch to mtd_ooblayout_ops
>   mtd: nand: kill the ecc->layout field
>   mtd: kill the nand_ecclayout struct
> 
>  arch/arm/mach-pxa/spitz.c                       |  55 +++-
>  arch/mips/include/asm/mach-jz4740/jz4740_nand.h |   2 +-
>  arch/mips/jz4740/board-qi_lb60.c                |  87 +++---
>  drivers/mtd/devices/docg3.c                     |  51 +++-
>  drivers/mtd/mtdchar.c                           | 123 ++++++--
>  drivers/mtd/mtdconcat.c                         |   2 +-
>  drivers/mtd/mtdcore.c                           | 358 ++++++++++++++++++++++++
>  drivers/mtd/mtdpart.c                           |  28 +-
>  drivers/mtd/mtdswap.c                           |  24 +-
>  drivers/mtd/nand/atmel_nand.c                   | 130 ++++-----
>  drivers/mtd/nand/bf5xx_nand.c                   |  51 ++--
>  drivers/mtd/nand/brcmnand/brcmnand.c            | 262 ++++++++++-------
>  drivers/mtd/nand/cafe_nand.c                    |  45 ++-
>  drivers/mtd/nand/davinci_nand.c                 | 118 +++-----
>  drivers/mtd/nand/denali.c                       |  51 +++-
>  drivers/mtd/nand/diskonchip.c                   |  60 +++-
>  drivers/mtd/nand/docg4.c                        |  34 ++-
>  drivers/mtd/nand/fsl_elbc_nand.c                |  83 +++---
>  drivers/mtd/nand/fsl_ifc_nand.c                 | 245 +++++-----------
>  drivers/mtd/nand/fsmc_nand.c                    | 322 ++++++---------------
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c          |  61 ++--
>  drivers/mtd/nand/hisi504_nand.c                 |  27 +-
>  drivers/mtd/nand/jz4740_nand.c                  |   2 +-
>  drivers/mtd/nand/jz4780_nand.c                  |  19 +-
>  drivers/mtd/nand/lpc32xx_mlc.c                  |  50 ++--
>  drivers/mtd/nand/lpc32xx_slc.c                  |  58 +++-
>  drivers/mtd/nand/mxc_nand.c                     | 212 +++++++-------
>  drivers/mtd/nand/nand_base.c                    | 344 ++++++++++++-----------
>  drivers/mtd/nand/nand_bch.c                     |  46 ++-
>  drivers/mtd/nand/omap2.c                        | 241 +++++++++-------
>  drivers/mtd/nand/pxa3xx_nand.c                  | 104 ++++---
>  drivers/mtd/nand/s3c2410.c                      |  32 ++-
>  drivers/mtd/nand/sh_flctl.c                     |  87 ++++--
>  drivers/mtd/nand/sharpsl.c                      |   2 +-
>  drivers/mtd/nand/sm_common.c                    |  93 ++++--
>  drivers/mtd/nand/sunxi_nand.c                   | 114 ++++----
>  drivers/mtd/nand/vf610_nfc.c                    |  34 +--
>  drivers/mtd/onenand/onenand_base.c              | 262 ++++++++---------
>  drivers/mtd/tests/oobtest.c                     |  49 ++--
>  drivers/staging/mt29f_spinand/mt29f_spinand.c   |  49 ++--
>  fs/jffs2/wbuf.c                                 |   6 +-
>  include/linux/mtd/fsmc.h                        |  18 --
>  include/linux/mtd/mtd.h                         |  69 ++++-
>  include/linux/mtd/nand.h                        |   5 +-
>  include/linux/mtd/nand_bch.h                    |   8 +-
>  include/linux/mtd/onenand.h                     |   2 -
>  include/linux/mtd/sharpsl.h                     |   2 +-
>  include/uapi/mtd/mtd-abi.h                      |   2 +-
>  48 files changed, 2375 insertions(+), 1754 deletions(-)

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 18:30:58 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:43279 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025916AbcC3QUfZ8LmN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 18:20:35 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 88FE11812; Wed, 30 Mar 2016 18:20:29 +0200 (CEST)
Received: from bbrezillon (LMontsouris-657-1-184-87.w90-63.abo.wanadoo.fr [90.63.216.87])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 08F5E20;
        Wed, 30 Mar 2016 18:18:51 +0200 (CEST)
Date:   Wed, 30 Mar 2016 18:18:50 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Daniel Mack <daniel@zonque.org>,
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
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Archit Taneja <architt@codeaurora.org>,
        Han Xu <b45815@freescale.com>,
        Huang Shijie <shijie.huang@arm.com>
Subject: Re: [PATCH v5 00/52] mtd: rework ECC layout definition
Message-ID: <20160330181850.05717c8e@bbrezillon>
In-Reply-To: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Despite what's said in the subject, this series only contains 50
patches, not 52.

On Wed, 30 Mar 2016 18:14:15 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> Hopefully the last version of this patchset (but don't be sad, I'm not
> done bothering you with NAND related patches :-)).
> 
> If possible, I'd like to have as much Tested/Reviewed/Acked-by tags as
> possible, particularly on the changes done in arch/arm and arch/mips
> (since the last set of commits depends on those changes, I'd like to
> take them in my nand/next branch, even if this imply creating an
> immutable branch for the ARM and MIPS maintainers).
> 
> If nobody complains about this version, I'll merge it in 4.7.
> 
> Here comes the usual description:
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
> 
> All those changes are available here [1].
> 
> Best Regards,
> 
> Boris
> 
> [1]https://github.com/bbrezillon/linux-0day/tree/nand/ecclayout
> 
> Changes since v4:
> - dropped already applied patches
> - patch the recently merged qcom driver
> 
> Changes since v3:
> - fixed two bugs in mtd_ooblayout core implementation
> - use ecc->total instead of (ecc->steps * ecc->bytes) in NAND drivers
> 
> Changes since v2:
> - fixed a few bugs in the core and driver implementations
> 
> Changes since v1:
> - unified the way of defining ECC and free bytes
> - fixed a few bugs in some ->ecc()/->free() implementations
> 
> Boris Brezillon (50):
>   mtd: add mtd_ooblayout_xxx() helper functions
>   mtd: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: core: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: atmel: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: fsl_ifc: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: gpmi: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: lpc32xx: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: omap2: use mtd_ooblayout_xxx() helpers where appropriate
>   mtd: nand: qcom: use mtd_ooblayout_xxx() helpers where appropriate
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
>   mtd: nand: qcom: switch to mtd_ooblayout_ops
>   mtd: onenand: switch to mtd_ooblayout_ops
>   staging: mt29f_spinand: switch to mtd_ooblayout_ops
>   mtd: nand: kill the ecc->layout field
>   mtd: kill the nand_ecclayout struct
> 
>  arch/arm/mach-pxa/spitz.c                       |  55 +++-
>  arch/mips/include/asm/mach-jz4740/jz4740_nand.h |   2 +-
>  arch/mips/jz4740/board-qi_lb60.c                |  87 +++---
>  drivers/mtd/devices/docg3.c                     |  46 ++-
>  drivers/mtd/mtdchar.c                           | 123 ++++++--
>  drivers/mtd/mtdconcat.c                         |   2 +-
>  drivers/mtd/mtdcore.c                           | 360 ++++++++++++++++++++++++
>  drivers/mtd/mtdpart.c                           |  23 +-
>  drivers/mtd/nand/atmel_nand.c                   | 130 ++++-----
>  drivers/mtd/nand/bf5xx_nand.c                   |  51 ++--
>  drivers/mtd/nand/brcmnand/brcmnand.c            | 258 ++++++++++-------
>  drivers/mtd/nand/cafe_nand.c                    |  44 ++-
>  drivers/mtd/nand/davinci_nand.c                 | 118 +++-----
>  drivers/mtd/nand/denali.c                       |  50 +++-
>  drivers/mtd/nand/diskonchip.c                   |  60 +++-
>  drivers/mtd/nand/docg4.c                        |  33 ++-
>  drivers/mtd/nand/fsl_elbc_nand.c                |  83 +++---
>  drivers/mtd/nand/fsl_ifc_nand.c                 | 244 +++++-----------
>  drivers/mtd/nand/fsmc_nand.c                    | 322 ++++++---------------
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c          |  61 ++--
>  drivers/mtd/nand/hisi504_nand.c                 |  26 +-
>  drivers/mtd/nand/jz4740_nand.c                  |   2 +-
>  drivers/mtd/nand/jz4780_nand.c                  |  19 +-
>  drivers/mtd/nand/lpc32xx_mlc.c                  |  50 ++--
>  drivers/mtd/nand/lpc32xx_slc.c                  |  58 +++-
>  drivers/mtd/nand/mxc_nand.c                     | 212 +++++++-------
>  drivers/mtd/nand/nand_base.c                    | 340 +++++++++++-----------
>  drivers/mtd/nand/nand_bch.c                     |  27 +-
>  drivers/mtd/nand/omap2.c                        | 217 ++++++++------
>  drivers/mtd/nand/pxa3xx_nand.c                  | 104 ++++---
>  drivers/mtd/nand/qcom_nandc.c                   |  87 +++---
>  drivers/mtd/nand/s3c2410.c                      |  32 ++-
>  drivers/mtd/nand/sh_flctl.c                     |  87 ++++--
>  drivers/mtd/nand/sharpsl.c                      |   2 +-
>  drivers/mtd/nand/sm_common.c                    |  93 ++++--
>  drivers/mtd/nand/sunxi_nand.c                   | 114 ++++----
>  drivers/mtd/nand/vf610_nfc.c                    |  34 +--
>  drivers/mtd/onenand/onenand_base.c              | 235 ++++++++--------
>  drivers/staging/mt29f_spinand/mt29f_spinand.c   |  48 ++--
>  include/linux/mtd/fsmc.h                        |  18 --
>  include/linux/mtd/mtd.h                         |  63 ++++-
>  include/linux/mtd/nand.h                        |   5 +-
>  include/linux/mtd/onenand.h                     |   2 -
>  include/linux/mtd/sharpsl.h                     |   2 +-
>  include/uapi/mtd/mtd-abi.h                      |   2 +-
>  45 files changed, 2340 insertions(+), 1691 deletions(-)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

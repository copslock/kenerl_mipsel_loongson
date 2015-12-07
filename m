Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:26:52 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:55543 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013003AbbLGW0uSgV3g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:26:50 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id CD5DB323; Mon,  7 Dec 2015 23:26:42 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 9FB85223;
        Mon,  7 Dec 2015 23:26:40 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 00/23] mtd: rework ECC layout definition
Date:   Mon,  7 Dec 2015 23:25:55 +0100
Message-Id: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50379
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

Hello,

This patchset aims at getting rid of the nand_ecclayout limitations.
struct nand_ecclayout is defining fixed eccpos and oobfree arrays which
can only be increased by modifying the MTD_MAX_ECCPOS_ENTRIES_LARGE and
MTD_MAX_OOBFREE_ENTRIES_LARGE macros.
This approach forces us to modify the macro values each time we add a
new NAND chip with a bigger OOB area, and increasing these arrays also
penalize all platforms, even those who only support small NAND devices
(with small OOB area).

The idea to overcome this limitation, is to define the ECC/OOB layout
by the mean of two functions: ->eccpos() and ->oobfree(), which will
basically return the same information has those stored in the
nand_ecclayout struct.

Another advantage of this solution is that ECC layouts are usually
following a repetitive pattern (i.e. leave X bytes free and put Y bytes
of ECC per ECC chunk), which allows one to implement the ->eccpos()
and ->oobfree() functions with a simple logic that can be applied
to any size of OOB.

Patches 1 to 10 are just cleanups or trivial fixes that can be taken
independently.

Patch 19 is just an aggregate of several smaller commits (one per
driver), and has been submitted this way to limit the size of the
series. If everybody agrees on this approach, I'll resubmit the series
will those changes separated in different commits (as done here [1]).

Also note that the last two commits are removing the nand_ecclayout
definition, thus preventing any new driver to use this structure.
Of course, this step can be delayed if some of the previous patches
are not accepted.

Best Regards,

Boris

[1]https://github.com/bbrezillon/linux-sunxi/commits/nand/ecclayout2

Boris Brezillon (23):
  mtd: kill the ecclayout->oobavail field
  mtd: inftl: kill unused oobinfo field
  mtd: nftl: kill unused oobinfo field
  mtd: nand: s3c2410: kill the ->ecc_layout field
  mtd: nand: jz4770: kill the ->ecc_layout field
  mtd: nand: kill unused ->ecclayout field in platform_nand_chip struct
  staging: mt29f_spinand: kill unused ecclayout field
  mtd: nand: lpc32xx_mlc: fix ecc.size
  mtd: nand: vf610: remove useless mtd->ecclayout assignment
  mtd: nand: simplify nand_bch_init() usage
  mtd: add mtd_eccpos(), mtd_oobfree() and mtd_eccbytes() helper
    functions
  mtd: use mtd_eccpos() and mtd_oobfree() where appropriate
  mtd: add mtd_set_ecclayout() helper function
  mtd: use mtd_set_ecclayout() where appropriate
  mtd: create an mtd_ooblayout_ops struct to ease ECC layout definition
  mtd: docg3: switch to mtd_ooblayout_ops
  mtd: nand: implement the default mtd_ooblayout_ops
  mtd: nand: bch: switch to nand_ecclayout_pos
  mtd: nand: switch all drivers to mtd_ooblayout_ops
  mtd: onenand: switch to mtd_ooblayout_ops
  staging: mt29f_spinand: switch to mtd_ooblayout_ops
  mtd: nand: kill layout field
  mtd: kill the nand_ecclayout struct

 arch/arm/mach-pxa/spitz.c                       |  41 +++-
 arch/arm/plat-samsung/devs.c                    |   9 -
 arch/mips/include/asm/mach-jz4740/jz4740_nand.h |   4 +-
 arch/mips/jz4740/board-qi_lb60.c                |  83 ++++---
 drivers/mtd/devices/docg3.c                     |  39 +++-
 drivers/mtd/mtdchar.c                           |  95 +++++---
 drivers/mtd/mtdconcat.c                         |   2 +-
 drivers/mtd/mtdpart.c                           |  22 +-
 drivers/mtd/mtdswap.c                           |  20 +-
 drivers/mtd/nand/atmel_nand.c                   | 100 ++++----
 drivers/mtd/nand/bf5xx_nand.c                   |  47 ++--
 drivers/mtd/nand/brcmnand/brcmnand.c            | 258 ++++++++++++---------
 drivers/mtd/nand/cafe_nand.c                    |  42 +++-
 drivers/mtd/nand/davinci_nand.c                 | 114 ++++-----
 drivers/mtd/nand/denali.c                       |  48 ++--
 drivers/mtd/nand/diskonchip.c                   |  34 ++-
 drivers/mtd/nand/docg4.c                        |  30 ++-
 drivers/mtd/nand/fsl_elbc_nand.c                |  79 ++++---
 drivers/mtd/nand/fsl_ifc_nand.c                 | 226 +++++-------------
 drivers/mtd/nand/fsmc_nand.c                    | 294 +++++++-----------------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c          |  57 +++--
 drivers/mtd/nand/hisi504_nand.c                 |  27 ++-
 drivers/mtd/nand/jz4740_nand.c                  |   5 +-
 drivers/mtd/nand/lpc32xx_mlc.c                  |  51 ++--
 drivers/mtd/nand/lpc32xx_slc.c                  |  41 +++-
 drivers/mtd/nand/mxc_nand.c                     | 206 ++++++++---------
 drivers/mtd/nand/nand_base.c                    | 229 ++++++++++--------
 drivers/mtd/nand/nand_bch.c                     |  45 ++--
 drivers/mtd/nand/omap2.c                        | 219 ++++++++++--------
 drivers/mtd/nand/plat_nand.c                    |   1 -
 drivers/mtd/nand/pxa3xx_nand.c                  | 101 ++++----
 drivers/mtd/nand/s3c2410.c                      |  31 ++-
 drivers/mtd/nand/sh_flctl.c                     |  80 +++++--
 drivers/mtd/nand/sharpsl.c                      |   2 +-
 drivers/mtd/nand/sm_common.c                    |  88 +++++--
 drivers/mtd/nand/sunxi_nand.c                   | 112 ++++-----
 drivers/mtd/nand/vf610_nfc.c                    |  36 +--
 drivers/mtd/onenand/onenand_base.c              | 221 ++++++++++--------
 drivers/mtd/tests/oobtest.c                     |  49 ++--
 drivers/staging/mt29f_spinand/mt29f_spinand.c   |  45 ++--
 drivers/staging/mt29f_spinand/mt29f_spinand.h   |   1 -
 fs/jffs2/wbuf.c                                 |   6 +-
 include/linux/mtd/inftl.h                       |   1 -
 include/linux/mtd/mtd.h                         |  60 ++++-
 include/linux/mtd/nand.h                        |   6 +-
 include/linux/mtd/nand_bch.h                    |   8 +-
 include/linux/mtd/nftl.h                        |   1 -
 include/linux/mtd/onenand.h                     |   2 -
 include/linux/mtd/sharpsl.h                     |   2 +-
 include/linux/platform_data/mtd-nand-s3c2410.h  |   1 -
 include/uapi/mtd/mtd-abi.h                      |   2 +-
 51 files changed, 1763 insertions(+), 1560 deletions(-)

-- 
2.1.4

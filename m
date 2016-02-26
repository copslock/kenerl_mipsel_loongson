Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 15:35:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10357 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006804AbcBZOfQQERU5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 15:35:16 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 447E4AE21A41D;
        Fri, 26 Feb 2016 14:35:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 26 Feb 2016 14:35:09 +0000
Received: from [192.168.154.40] (192.168.154.40) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 26 Feb
 2016 14:35:08 +0000
Subject: Re: [PATCH v3 07/52] mtd: nand: core: use mtd_ooblayout_xxx() helpers
 where appropriate
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
 <1456448280-27788-8-git-send-email-boris.brezillon@free-electrons.com>
CC:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Kukjin Kim" <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>,
        "Nicolas Ferre" <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-sunxi@googlegroups.com>,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "punnaiah choudary kalluri" <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        "Kamal Dasu" <kdasu.kdev@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-api@vger.kernel.org>
From:   Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <56D0629C.9080805@imgtec.com>
Date:   Fri, 26 Feb 2016 14:35:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1456448280-27788-8-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.40]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

On 26/02/16 00:57, Boris Brezillon wrote:
> The mtd_ooblayout_xxx() helper functions have been added to avoid direct
> accesses to the ecclayout field, and thus ease for future reworks.
> Use these helpers in all places where the oobfree[] and eccpos[] arrays
> where directly accessed.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>   drivers/mtd/nand/nand_base.c | 183 +++++++++++++++++++------------------------
>   drivers/mtd/nand/nand_bch.c  |   3 +-
>   2 files changed, 82 insertions(+), 104 deletions(-)
>
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 91672bf..17504f2 100644
[...]

I just pulled your nand/ecclayout branch from github and tested out your 
latest patchset "mtd: rework ECC layout definition" on a Ci20 
(jz4780_{nand,bch}) and noticed that my board was failing to boot.

I bisected to this patch, here is the kernel's output during boot:

479556d ("mtd: nand: core: use mtd_ooblayout_xxx() helpers where 
appropriate"):

[ 0.256349] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x88
[ 0.262860] nand: Micron MT29F64G08CBAAAWP
[ 0.266970] nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 8192, 
OOB size: 448
[ 0.274856] jz4780-nand 1b000000.nand-controller: using hardware BCH 
(strength 24, size 1024, bytes 42)
[ 0.288982] Bad block table not found for chip 0
[ 0.297673] Bad block table not found for chip 0
[ 0.302328] Scanning device for bad blocks
[ 0.320135] Bad eraseblock 90 at 0x00000b400000
[ 0.324829] Bad eraseblock 91 at 0x00000b600000
[ 0.931085] Bad eraseblock 4092 at 0x0001ff800000
[ 0.935947] Bad eraseblock 4093 at 0x0001ffa00000
[ 0.944878] nand_bbt: error while writing bad block table -34
[ 0.950666] jz4780-nand: probe of 1b000000.nand-controller failed with 
error -34
[ 0.958302] UBI error: cannot open mtd 3, error -19
[ 0.963002] UBI error: cannot open mtd 4, error -19[ 0.970419] clk: Not 
disabling unused clocks
[ 0.975011] UBIFS error (pid: 1): cannot open "ubi1:root", error -19VFS: 
Cannot open root device "ubi1:root" or unknown-block(0,0): error -19
[ 0.987810] Please append a correct "root=" boot option; here are the 
available partitions:
[ 0.996210] Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)
[ 1.004498] Rebooting in 10 seconds..

6625d32 ("mtd: use mtd_ooblayout_xxx() helpers where appropriate"):

[ 0.256232] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x88
[ 0.262745] nand: Micron MT29F64G08CBAAAWP
[ 0.266854] nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 8192, 
OOB size: 448
[ 0.274739] jz4780-nand 1b000000.nand-controller: using hardware BCH 
(strength 24, size 1024, bytes 42)
[ 0.285993] Bad block table found at page 1048320, version 0x01
[ 0.294353] Bad block table found at page 1048064, version 0x01
[ 0.301523] nand_read_bbt: bad block at 0x00000b400000
[ 0.306677] nand_read_bbt: bad block at 0x00000b600000
[ 0.312289] 5 ofpart partitions found on MTD device 
1b000000.nand-controller.1
[ 0.319553] Creating 5 MTD partitions on "1b000000.nand-controller.1":
[ 0.326098] 0x000000000000-0x000000800000 : "u-boot-spl"
[ 0.331757] 0x000000800000-0x000000a00000 : "u-boot"
[ 0.337185] 0x000000a00000-0x000000c00000 : "u-boot-env"
[ 0.342903] 0x000000c00000-0x000004c00000 : "boot"
[ 0.348109] 0x000004c00000-0x000200000000 : "system"
[ 0.354284] ubi0 error: ubi_attach_mtd_dev: More than 64 PEBs are needed 
for fastmap, sorry.
[...]

I'll look into this more later today, but wanted to run it by you in 
case you have any thoughts.

Thanks,

Harvey

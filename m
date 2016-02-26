Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 19:33:44 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:34647 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014928AbcBZSdnIA531 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 19:33:43 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 4DC45228; Fri, 26 Feb 2016 19:33:36 +0100 (CET)
Received: from bbrezillon (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 7D7651B9;
        Fri, 26 Feb 2016 19:33:29 +0100 (CET)
Date:   Fri, 26 Feb 2016 19:33:25 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <linux-mtd@lists.infradead.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        "Krzysztof Kozlowski" <k.kozlowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
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
Subject: Re: [PATCH v3 07/52] mtd: nand: core: use mtd_ooblayout_xxx()
 helpers where appropriate
Message-ID: <20160226193325.2d84a8c8@bbrezillon>
In-Reply-To: <56D06C88.9080608@imgtec.com>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
        <1456448280-27788-8-git-send-email-boris.brezillon@free-electrons.com>
        <56D0629C.9080805@imgtec.com>
        <20160226161054.3477cd4b@bbrezillon>
        <56D06C88.9080608@imgtec.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52345
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

Hi Harvey,

On Fri, 26 Feb 2016 15:17:28 +0000
Harvey Hunt <harvey.hunt@imgtec.com> wrote:

> Hi Boris,
> 
> On 26/02/16 15:10, Boris Brezillon wrote:
> > Hi Harvey,
> >
> > On Fri, 26 Feb 2016 14:35:08 +0000
> > Harvey Hunt <harvey.hunt@imgtec.com> wrote:
> >
> >> [...]
> >> I'll look into this more later today, but wanted to run it by you in
> >> case you have any thoughts.
> >
> > Can you apply this patch [1], and let me know if you see the additional
> > trace?
> 
> I applied the patch, the following is the (unchanged) output:
> 
> [    0.256375] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x88
> [    0.262887] nand: Micron MT29F64G08CBAAAWP
> [    0.266995] nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 
> 8192, OOB size: 448
> [    0.274881] jz4780-nand 1b000000.nand-controller: using hardware BCH 
> (strength 24, size 1024, bytes 42)
> [    0.289046] Bad block table not found for chip 0
> [    0.297769] Bad block table not found for chip 0
> [    0.302425] Scanning device for bad blocks
> [    0.320239] Bad eraseblock 90 at 0x00000b400000
> [    0.324934] Bad eraseblock 91 at 0x00000b600000
> [    0.931054] Bad eraseblock 4092 at 0x0001ff800000
> [    0.935917] Bad eraseblock 4093 at 0x0001ffa00000
> [    0.944660] nand_bbt: error while writing bad block table -34
> [    0.950448] jz4780-nand: probe of 1b000000.nand-controller failed 
> with error -34
> [    0.958079] UBI error: cannot open mtd 3, error -19
> [    0.962788] UBI error: cannot open mtd 4, error -19[    0.970229] 
> clk: Not disabling unused clocks
> 

Can you test with this one [1]?

[1]http://code.bulix.org/36oytz-91960


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

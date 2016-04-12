Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2016 00:32:07 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:48730 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008252AbcDLWcD71eJL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2016 00:32:03 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 4872F22A; Wed, 13 Apr 2016 00:31:58 +0200 (CEST)
Received: from bbrezillon (LFbn-1-2159-240.w90-76.abo.wanadoo.fr [90.76.216.240])
        by mail.free-electrons.com (Postfix) with ESMTPSA id E8CBD214;
        Wed, 13 Apr 2016 00:31:46 +0200 (CEST)
Date:   Wed, 13 Apr 2016 00:31:46 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Han Xu <han.xu@nxp.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Richard Weinberger" <richard@nod.at>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Kukjin Kim" <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        "Archit Taneja" <architt@codeaurora.org>,
        "b45815@freescale.com" <b45815@freescale.com>,
        Huang Shijie <shijie.huang@arm.com>
Subject: Re: [PATCH v5 34/50] mtd: nand: gpmi: switch to mtd_ooblayout_ops
Message-ID: <20160413003146.4deb6017@bbrezillon>
In-Reply-To: <DB5PR0401MB1845A6EE26FD2734CDBBE20F97950@DB5PR0401MB1845.eurprd04.prod.outlook.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
        <1459354505-32551-35-git-send-email-boris.brezillon@free-electrons.com>
        <DB5PR0401MB1845A6EE26FD2734CDBBE20F97950@DB5PR0401MB1845.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52967
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

On Tue, 12 Apr 2016 22:27:58 +0000
Han Xu <han.xu@nxp.com> wrote:

> 
> I am fine with all gpmi patch set and tested on i.MX6Q, just found another issue in gpmi driver.
> The patch was sent, refer to https://patchwork.ozlabs.org/patch/609755/

Oh, was it related to the changes introduced by this series?

> 
> 
> Acked-by: Han Xu <han.xu@nxp.com>
> Tested-by: Han Xu <han.xu@nxp.com>
> --
> 2.5.0
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 03:49:45 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:42034 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014891AbcBZCtnpmSnQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 03:49:43 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 4DB2E1895; Fri, 26 Feb 2016 03:49:36 +0100 (CET)
Received: from bbrezillon (unknown [208.66.31.210])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 2832B46B;
        Fri, 26 Feb 2016 03:16:04 +0100 (CET)
Date:   Fri, 26 Feb 2016 03:16:00 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Stefan Agner <stefan@agner.ch>
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
Message-ID: <20160226031600.15ad27ba@bbrezillon>
In-Reply-To: <d968b867f4d7f603581a0ff83e07c15c@agner.ch>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
        <d968b867f4d7f603581a0ff83e07c15c@agner.ch>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52328
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

On Thu, 25 Feb 2016 17:27:23 -0800
Stefan Agner <stefan@agner.ch> wrote:

> Hi Boris,
> 
> On 2016-02-25 16:57, Boris Brezillon wrote:
> > Hello,
> > 
> > This patchset aims at getting rid of the nand_ecclayout limitations.
> > struct nand_ecclayout is defining fixed eccpos and oobfree arrays which
> > can only be increased by modifying the MTD_MAX_ECCPOS_ENTRIES_LARGE and
> > MTD_MAX_OOBFREE_ENTRIES_LARGE macros.
> > This approach forces us to modify the macro values each time we add a
> > new NAND chip with a bigger OOB area, and increasing these arrays also
> > penalize all platforms, even those who only support small NAND devices
> > (with small OOB area).
> > 
> > The idea to overcome this limitation, is to define the ECC/OOB layout
> > by the mean of two functions: ->ecc() and ->free(), which will
> > basically return the same information has those stored in the
> > nand_ecclayout struct.
> > 
> > Another advantage of this solution is that ECC layouts are usually
> > following a repetitive pattern (i.e. leave X bytes free and put Y bytes
> > of ECC per ECC chunk), which allows one to implement the ->ecc()
> > and ->free() functions with a simple logic that can be applied
> > to any size of OOB.
> > 
> > Patches 1 to 4 are just cleanups or trivial fixes that can be taken
> > independently.
> > 
> > Also note that the last two commits are removing the nand_ecclayout
> > definition, thus preventing any new driver to use this structure.
> > Of course, this step can be delayed if some of the previous patches
> > are not accepted.
> 
> Is the patch set somewhere available to pull from?

Yes, it's here [1].

> 
> Do I see things right that patch 21/52 contains the crucial function
> nand_ooblayout_ecc_lp which calculate the ECC position? (for those who
> do not provide mtd_ooblayout_ops anyway...)

You're correct. This implementation is here for NAND controller drivers
relying on the linux default ECC layout (the one used when soft ECC is
selected, or when not layout is specified). This layout is just putting
all ECC bytes at the end of the OOB area.

[1]https://github.com/bbrezillon/linux-0day/tree/nand/ecclayout

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

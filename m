Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2016 10:01:16 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:41410 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006623AbcCEJBOp8t0d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Mar 2016 10:01:14 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id E50B33DE; Sat,  5 Mar 2016 10:01:08 +0100 (CET)
Received: from bbrezillon (AToulouse-657-1-1120-33.w92-156.abo.wanadoo.fr [92.156.34.33])
        by mail.free-electrons.com (Postfix) with ESMTPSA id D2A7F25E;
        Sat,  5 Mar 2016 10:01:07 +0100 (CET)
Date:   Sat, 5 Mar 2016 10:01:07 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
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
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 16/52] mtd: nand: use mtd_set_ecclayout() where
 appropriate
Message-ID: <20160305100107.5d582bee@bbrezillon>
In-Reply-To: <20160305095337.4a9e50fe@bbrezillon>
References: <1456448280-27788-1-git-send-email-boris.brezillon@free-electrons.com>
        <1456448280-27788-17-git-send-email-boris.brezillon@free-electrons.com>
        <20160305022621.GN55664@google.com>
        <20160305095337.4a9e50fe@bbrezillon>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52464
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

On Sat, 5 Mar 2016 09:53:37 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Brian,
> 
> On Fri, 4 Mar 2016 18:26:21 -0800
> Brian Norris <computersforpeace@gmail.com> wrote:
> 
> > On Fri, Feb 26, 2016 at 01:57:24AM +0100, Boris Brezillon wrote:
> > > Use the mtd_set_ecclayout() helper instead of directly assigning the
> > > mtd->ecclayout field.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  drivers/mtd/nand/nand_base.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> > > index 17504f2..5093a3c 100644
> > > --- a/drivers/mtd/nand/nand_base.c
> > > +++ b/drivers/mtd/nand/nand_base.c
> > > @@ -4288,7 +4288,7 @@ int nand_scan_tail(struct mtd_info *mtd)
> > >  		ecc->write_oob_raw = ecc->write_oob;
> > >  
> > >  	/* propagate ecc info to mtd_info */
> > > -	mtd->ecclayout = ecc->layout;
> > > +	mtd_set_ecclayout(mtd, ecc->layout);
> > 
> > I'm having trouble applying this one. For the life of me, I can't figure
> > out where you got this context from. This block only appears much later
> > in nand_scan_tail()...
> > 
> 
> Patch 7 has moved this section upper in the function to avoid problems
> when calculating the number of available/free OOB bytes.
> 
> > Do you think you could post a git tree with your intended changes? I may
> > just try to pull something in like that instead.
> 
> Yep, it's there [1].

Forgot to paste the link.

> Note that this branch contains the two fixes I
> talked about with Harvey and Stephan. I also made a few changes to use
> ecc->total instead of calculating (ecc->steps * ecc->bytes).

I'll probably also send a v4 with the fixes squashed in patch 5 and 7,
just for the record.

> 
> > 
> > BTW, I'm not sure the OMAP refactorings are going to come in time, but I
> > was planning to pull those directly from the TI folks (i.e., they won't
> > be rebased on l2-mtd.git), since there's some intermingling of platform
> > changes there. I think I can fix the conflicts fine, but FYI.
> 
> Okay, then I'll let you deal with those conflicts. I can check your
> conflict resolution if you're unsure.
> 
> Thanks,
> 
> Boris
> 
> 

[1]https://github.com/bbrezillon/linux-0day/tree/nand/ecclayout


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

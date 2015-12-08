Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 09:44:13 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:36786 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006833AbbLHIoKuWlp9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 09:44:10 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 75FA72FA; Tue,  8 Dec 2015 09:44:04 +0100 (CET)
Received: from bbrezillon (AToulouse-657-1-5-91.w83-193.abo.wanadoo.fr [83.193.130.91])
        by mail.free-electrons.com (Postfix) with ESMTPSA id A1D332BE;
        Tue,  8 Dec 2015 09:44:03 +0100 (CET)
Date:   Tue, 8 Dec 2015 09:43:58 +0100
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        punnaiah choudary kalluri <punnaia@xilinx.com>
Subject: Re: [linux-sunxi] [PATCH 21/23] staging: mt29f_spinand: switch to
 mtd_ooblayout_ops
Message-ID: <20151208094358.2be0f191@bbrezillon>
In-Reply-To: <CAGRGNgV09JJ7+hDVJwZcp89nEsgNS6r2Mo1_R+EEAT9=aR-Z_g@mail.gmail.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
        <1449527178-5930-22-git-send-email-boris.brezillon@free-electrons.com>
        <CAGRGNgV09JJ7+hDVJwZcp89nEsgNS6r2Mo1_R+EEAT9=aR-Z_g@mail.gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.27; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50413
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

Hi Julian,

On Tue, 8 Dec 2015 10:59:53 +1100
Julian Calaby <julian.calaby@gmail.com> wrote:

> Hi Boris,
> 
> On Tue, Dec 8, 2015 at 9:26 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/staging/mt29f_spinand/mt29f_spinand.c | 44 ++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> > index cb9d5ab..967d50a 100644
> > --- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> > +++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> > @@ -42,23 +42,29 @@ static inline struct spinand_state *mtd_to_state(struct mtd_info *mtd)
> >  static int enable_hw_ecc;
> >  static int enable_read_hw_ecc;
> >
> > -static struct nand_ecclayout spinand_oob_64 = {
> > -       .eccbytes = 24,
> > -       .eccpos = {
> > -               1, 2, 3, 4, 5, 6,
> > -               17, 18, 19, 20, 21, 22,
> > -               33, 34, 35, 36, 37, 38,
> > -               49, 50, 51, 52, 53, 54, },
> > -       .oobfree = {
> > -               {.offset = 8,
> > -                       .length = 8},
> > -               {.offset = 24,
> > -                       .length = 8},
> > -               {.offset = 40,
> > -                       .length = 8},
> > -               {.offset = 56,
> > -                       .length = 8},
> > -       }
> > +static int spinand_oob_64_eccpos(struct mtd_info *mtd, int eccbyte)
> > +{
> > +       if (eccbyte > 23)
> > +               return -ERANGE;
> > +
> > +       return ((eccbyte / 6) * 16) + 1;
> 
> Are you sure this is correct? My reading of this is that we'd get 1
> for eccbytes 0 through 5.
> 
> Would
> 
> ((eccbyte / 6) * 16) + (eccbyte % 6) + 1
> 
> be more correct?

Absolutely. I'll fix that.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

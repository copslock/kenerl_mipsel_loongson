Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 23:00:26 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:51256 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990757AbeGIVASaQ9AO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 23:00:18 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0F09920733; Mon,  9 Jul 2018 23:00:13 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id AFE39206F3;
        Mon,  9 Jul 2018 23:00:12 +0200 (CEST)
Date:   Mon, 9 Jul 2018 23:00:11 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 11/24] mtd: rawnand: sunxi: Make sure ret is
 initialized in sunxi_nfc_read_byte()
Message-ID: <20180709230011.1ca3f9ce@bbrezillon>
In-Reply-To: <CAK8P3a1Ndys3MMxLqL-hTFVDSZGm5ASEnQ7K+8dScvFrp=RTdA@mail.gmail.com>
References: <20180709200945.30116-1-boris.brezillon@bootlin.com>
        <20180709200945.30116-12-boris.brezillon@bootlin.com>
        <CAK8P3a1Ndys3MMxLqL-hTFVDSZGm5ASEnQ7K+8dScvFrp=RTdA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

On Mon, 9 Jul 2018 22:35:56 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Mon, Jul 9, 2018 at 10:09 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > Fixes the following smatch warning:
> >
> > drivers/mtd/nand/raw/sunxi_nand.c:551 sunxi_nfc_read_byte() error: uninitialized symbol 'ret'.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> >  drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> > index 99043c3a4fa7..4b11cd4a79be 100644
> > --- a/drivers/mtd/nand/raw/sunxi_nand.c
> > +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> > @@ -544,7 +544,7 @@ static void sunxi_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
> >
> >  static uint8_t sunxi_nfc_read_byte(struct mtd_info *mtd)
> >  {
> > -       uint8_t ret;
> > +       uint8_t ret = 0;
> >
> >         sunxi_nfc_read_buf(mtd, &ret, 1);
> >  
> 
> Should there perhaps be a warning when no data was returned after a timeout?

We're planning to move this driver to ->exec_op() soon, and with
->exec_op() errors are properly propagated to the core. I guess we can
live with this lack of dev_warn() for a bit longer :-).

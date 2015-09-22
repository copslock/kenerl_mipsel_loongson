Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 10:08:59 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:37752 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006735AbbIVIIz60sx7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Sep 2015 10:08:55 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 0CB00A31; Tue, 22 Sep 2015 10:08:48 +0200 (CEST)
Received: from bbrezillon (AMarseille-656-1-641-211.w92-150.abo.wanadoo.fr [92.150.186.211])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 7E7912E3;
        Tue, 22 Sep 2015 10:08:38 +0200 (CEST)
Date:   Tue, 22 Sep 2015 10:08:37 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, Andrea Scian <rnd4@dave-tech.it>,
        Richard Weinberger <richard@nod.at>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RESEND PATCH v3 5/5] mtd: nand: remove custom 'erased check'
 implementation
Message-ID: <20150922100837.0410c3f8@bbrezillon>
In-Reply-To: <20150921232832.GG31505@google.com>
References: <1441296222-14989-1-git-send-email-boris.brezillon@free-electrons.com>
        <1441296222-14989-6-git-send-email-boris.brezillon@free-electrons.com>
        <20150921232832.GG31505@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49266
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

Hi Brian,

On Mon, 21 Sep 2015 16:28:32 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> + others
> 
> On Thu, Sep 03, 2015 at 06:03:42PM +0200, Boris Brezillon wrote:
> > Some drivers are manually checking for 'erased pages' while correcting
> > ECC bytes.
> > This logic is now done by the core infrastructure, and can thus be removed
> > from those drivers.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/mtd/nand/davinci_nand.c |  8 --------
> >  drivers/mtd/nand/diskonchip.c   | 32 ++------------------------------
> >  drivers/mtd/nand/jz4740_nand.c  | 18 ------------------
> >  3 files changed, 2 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
> > index 816ef53..0d6adbe 100644
> > --- a/drivers/mtd/nand/davinci_nand.c
> > +++ b/drivers/mtd/nand/davinci_nand.c
> > @@ -316,14 +316,6 @@ static int nand_davinci_correct_4bit(struct mtd_info *mtd,
> >  	unsigned num_errors, corrected;
> >  	unsigned long timeo;
> >  
> > -	/* All bytes 0xff?  It's an erased page; ignore its ECC. */
> > -	for (i = 0; i < 10; i++) {
> > -		if (ecc_code[i] != 0xff)
> > -			goto compare;
> > -	}
> > -	return 0;
> > -
> > -compare:
> >  	/* Unpack ten bytes into eight 10 bit values.  We know we're
> >  	 * little-endian, and use type punning for less shifting/masking.
> >  	 */
> > diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
> > index 7da266a..eb65769 100644
> > --- a/drivers/mtd/nand/diskonchip.c
> > +++ b/drivers/mtd/nand/diskonchip.c
> > @@ -936,37 +936,9 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
> >  				calc_ecc[i] = ReadDOC_(docptr, DoC_Mplus_ECCSyndrome0 + i);
> >  			else
> >  				calc_ecc[i] = ReadDOC_(docptr, DoC_ECCSyndrome0 + i);
> > -			if (calc_ecc[i] != empty_read_syndrome[i])
> > -				emptymatch = 0;
> >  		}
> > -		/* If emptymatch=1, the read syndrome is consistent with an
> > -		   all-0xff data and stored ecc block.  Check the stored ecc. */
> > -		if (emptymatch) {
> > -			for (i = 0; i < 6; i++) {
> > -				if (read_ecc[i] == 0xff)
> > -					continue;
> > -				emptymatch = 0;
> > -				break;
> > -			}
> > -		}
> > -		/* If emptymatch still =1, check the data block. */
> > -		if (emptymatch) {
> > -			/* Note: this somewhat expensive test should not be triggered
> > -			   often.  It could be optimized away by examining the data in
> > -			   the readbuf routine, and remembering the result. */
> > -			for (i = 0; i < 512; i++) {
> > -				if (dat[i] == 0xff)
> > -					continue;
> > -				emptymatch = 0;
> > -				break;
> > -			}
> > -		}
> > -		/* If emptymatch still =1, this is almost certainly a freshly-
> > -		   erased block, in which case the ECC will not come out right.
> > -		   We'll suppress the error and tell the caller everything's
> > -		   OK.  Because it is. */
> > -		if (!emptymatch)
> > -			ret = doc_ecc_decode(rs_decoder, dat, calc_ecc);
> > +
> > +		ret = doc_ecc_decode(rs_decoder, dat, calc_ecc);
> >  		if (ret > 0)
> >  			printk(KERN_ERR "doc200x_correct_data corrected %d errors\n", ret);
> >  	}
> 
> I see new warnings:
> 
> drivers/mtd/nand/diskonchip.c: At top level:
> drivers/mtd/nand/diskonchip.c: In function ‘doc200x_correct_data’:
> drivers/mtd/nand/diskonchip.c:915:6: warning: unused variable ‘emptymatch’ [-Wunused-variable]
>   int emptymatch = 1;
>       ^
> drivers/mtd/nand/diskonchip.c:79:15: warning: ‘empty_read_syndrome’ defined but not used [-Wunused-variable]
>  static u_char empty_read_syndrome[6] = { 0x26, 0xff, 0x6d, 0x47, 0x73, 0x7a };
>                ^

Oops, I'll fix those warnings.

> 
> I'd also like test results for these drivers before doing this. And I'm
> not sure how to find good testers for these drivers, even it users still
> exist.

Yep, the goal of this patch was to let people owning boards embedding
those chips test the changes.
If we don't get anyone to test it, maybe we should leave those drivers
unchanged at the expense of doing twice the test in case of bitflips in
erased pages or uncorrectable bitflips (which is really unlikely).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

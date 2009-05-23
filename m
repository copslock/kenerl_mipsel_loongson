Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 08:12:38 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:42267 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021740AbZEWHMT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 May 2009 08:12:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 7677C340BC;
	Sat, 23 May 2009 15:07:15 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zrFCSND66orc; Sat, 23 May 2009 15:06:55 +0800 (CST)
Received: from [172.16.2.17] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 70B89340BB;
	Sat, 23 May 2009 15:06:54 +0800 (CST)
Subject: Re: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	IDE/ATA development list <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <200905222032.55869.bzolnier@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <a998340033c8f89ec028b354ebe2956239144049.1242855716.git.wuzhangjin@gmail.com>
	 <200905222032.55869.bzolnier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:	Sat, 23 May 2009 15:11:42 +0800
Message-Id: <1243062702.8509.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-22五的 20:32 +0200，Bartlomiej Zolnierkiewicz写道：
> On Thursday 21 May 2009 00:12:46 wuzhangjin@gmail.com wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This is originally from the to-mips branch from
> > http://dev.lemote.com/code/linux_loongson
> 
> Sadly, the patch description lacks all the important information.
> 
> What is the original problem that this fixup tries to address?
> 
> Is it limited to amd74xx controllers?

In loongson2f yeeloong machines, the ide controller is AMD cs5536, or
say  amd74xx, and the hard drives is Fujistu. 
While debuging the hard disk suspned and resume, the ide irq can not be
cleared. I guess this is a fake interrupt, hence the clear irq action
can not be finished. 
This patch is to fix this issue. Maybe other controller and drives also
have this issue, but I am not sure.

Thanks for your reply.  
> 
> [ We are generalizing quirk_drives handling currently... ]
> 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  drivers/ide/amd74xx.c |   19 +++++++++++++++++++
> >  1 files changed, 19 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
> > index 77267c8..8f488b8 100644
> > --- a/drivers/ide/amd74xx.c
> > +++ b/drivers/ide/amd74xx.c
> > @@ -23,6 +23,11 @@
> >  
> >  #define DRV_NAME "amd74xx"
> >  
> > +static const char *am74xx_quirk_drives[] = {
> > +	"FUJITSU MHZ2160BH G2",
> > +	NULL
> > +};
> > +
> >  enum {
> >  	AMD_IDE_CONFIG		= 0x41,
> >  	AMD_CABLE_DETECT	= 0x42,
> > @@ -112,6 +117,19 @@ static void amd_set_pio_mode(ide_drive_t *drive, const u8 pio)
> >  	amd_set_drive(drive, XFER_PIO_0 + pio);
> >  }
> >  
> > +static void amd_quirkproc(ide_drive_t *drive)
> > +{
> > +	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
> > +
> > +	for (list = am74xx_quirk_drives; *list != NULL; list++)
> > +			if (strstr(m, *list) != NULL) {
> > +				drive->quirk_list = 2;
> > +				return;
> > +			}
> > +
> > +	drive->quirk_list = 0;
> > +}
> > +
> >  static void amd7409_cable_detect(struct pci_dev *dev)
> >  {
> >  	/* no host side cable detection */
> > @@ -194,6 +212,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
> >  static const struct ide_port_ops amd_port_ops = {
> >  	.set_pio_mode		= amd_set_pio_mode,
> >  	.set_dma_mode		= amd_set_drive,
> > +	.quirkproc		= amd_quirkproc,
> >  	.cable_detect		= amd_cable_detect,
> >  };
> 

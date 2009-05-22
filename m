Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 19:55:58 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:38160 "EHLO
	mail-fx0-f175.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022352AbZEVSzu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2009 19:55:50 +0100
Received: by fxm23 with SMTP id 23so1941923fxm.0
        for <multiple recipients>; Fri, 22 May 2009 11:55:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=nSx3uVvRBQCjFzyuGLS2BeUo5yKEoN7Xl3LVJYyJndk=;
        b=rSt/4oPRWHRmwCYwpbtFEt8ACV+cqa4ZtsXXFlF5uOD+pbzdE7rkUMLTnyXpgLznSf
         Il5Sj0QhTijq9/xA6DMqllNdQa4W0p13Xl9N4rk2OYCL1CsfzwKbhWZi+vPXy4CwCFh1
         Tu5FY6N4U5n9WwPMjQFnUNYV79G9GVOrqCuqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=s9nkAtPSXKBtPKPlwRhyOdnVm24AKjodtGmUc9QZjQhdqaV+GKR4dHeDuks5Oo5/iE
         qFX3mN68LfkCnOObmGaxDDswMeIj28Ha5TlpBAkCdgbqMJehL5zJX0TB9YvRC3DhTUSk
         oqrkr9AQkOKT1/1LmY8R33IEBvivU0EzHQ7T4=
Received: by 10.103.161.16 with SMTP id n16mr2159193muo.79.1243018544704;
        Fri, 22 May 2009 11:55:44 -0700 (PDT)
Received: from localhost.localdomain (chello089077051219.chello.pl [89.77.51.219])
        by mx.google.com with ESMTPS id 25sm1343408mul.29.2009.05.22.11.55.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 11:55:42 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	wuzhangjin@gmail.com
Subject: Re: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
Date:	Fri, 22 May 2009 20:32:54 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.30-rc6-next-20090518-05332-g0707b5a; KDE/4.2.3; i686; ; )
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	"IDE/ATA development list" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-scsi" <linux-scsi@vger.kernel.org>,
	Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com> <a998340033c8f89ec028b354ebe2956239144049.1242855716.git.wuzhangjin@gmail.com>
In-Reply-To: <a998340033c8f89ec028b354ebe2956239144049.1242855716.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200905222032.55869.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 21 May 2009 00:12:46 wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This is originally from the to-mips branch from
> http://dev.lemote.com/code/linux_loongson

Sadly, the patch description lacks all the important information.

What is the original problem that this fixup tries to address?

Is it limited to amd74xx controllers?

[ We are generalizing quirk_drives handling currently... ]

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  drivers/ide/amd74xx.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
> index 77267c8..8f488b8 100644
> --- a/drivers/ide/amd74xx.c
> +++ b/drivers/ide/amd74xx.c
> @@ -23,6 +23,11 @@
>  
>  #define DRV_NAME "amd74xx"
>  
> +static const char *am74xx_quirk_drives[] = {
> +	"FUJITSU MHZ2160BH G2",
> +	NULL
> +};
> +
>  enum {
>  	AMD_IDE_CONFIG		= 0x41,
>  	AMD_CABLE_DETECT	= 0x42,
> @@ -112,6 +117,19 @@ static void amd_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  	amd_set_drive(drive, XFER_PIO_0 + pio);
>  }
>  
> +static void amd_quirkproc(ide_drive_t *drive)
> +{
> +	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
> +
> +	for (list = am74xx_quirk_drives; *list != NULL; list++)
> +			if (strstr(m, *list) != NULL) {
> +				drive->quirk_list = 2;
> +				return;
> +			}
> +
> +	drive->quirk_list = 0;
> +}
> +
>  static void amd7409_cable_detect(struct pci_dev *dev)
>  {
>  	/* no host side cable detection */
> @@ -194,6 +212,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
>  static const struct ide_port_ops amd_port_ops = {
>  	.set_pio_mode		= amd_set_pio_mode,
>  	.set_dma_mode		= amd_set_drive,
> +	.quirkproc		= amd_quirkproc,
>  	.cable_detect		= amd_cable_detect,
>  };

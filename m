Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 06:46:19 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:42200 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022447AbZEYFqN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 May 2009 06:46:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 3C2C6341DF;
	Mon, 25 May 2009 13:41:05 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrDn4NNskm4M; Mon, 25 May 2009 13:40:48 +0800 (CST)
Received: from [172.16.2.17] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id B7888341E5;
	Mon, 25 May 2009 13:40:47 +0800 (CST)
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
In-Reply-To: <200905231347.34717.bzolnier@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <200905222032.55869.bzolnier@gmail.com>
	 <1243062702.8509.7.camel@localhost.localdomain>
	 <200905231347.34717.bzolnier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:	Mon, 25 May 2009 13:45:39 +0800
Message-Id: <1243230339.9819.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-23六的 13:47 +0200，Bartlomiej Zolnierkiewicz写道：
> On Saturday 23 May 2009 09:11:42 yanh wrote:
> > 在 2009-05-22五的 20:32 +0200，Bartlomiej Zolnierkiewicz写道：
> > > On Thursday 21 May 2009 00:12:46 wuzhangjin@gmail.com wrote:
> > > > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > > > 
> > > > This is originally from the to-mips branch from
> > > > http://dev.lemote.com/code/linux_loongson
> > > 
> > > Sadly, the patch description lacks all the important information.
> > > 
> > > What is the original problem that this fixup tries to address?
> > > 
> > > Is it limited to amd74xx controllers?
> > 
> > In loongson2f yeeloong machines, the ide controller is AMD cs5536, or
> > say  amd74xx, and the hard drives is Fujistu. 
> 
> Then it should use the new & shiny :) native cs5536 IDE host driver
> instead of legacy support in amd74xx...
> 
> > While debuging the hard disk suspned and resume, the ide irq can not be
> > cleared. I guess this is a fake interrupt, hence the clear irq action
> > can not be finished. 
> 
> AFAICS the only change that the fixup would cause for suspend/resume paths
> is the one in ide_config_drive_speed() which is called during resume to set
> transfer mode on the drive:
> 
>        tp_ops->write_devctl(hwif, ATA_NIEN | ATA_DEVCTL_OBS);
> 
>         memset(&tf, 0, sizeof(tf));
>         tf.feature = SETFEATURES_XFER;
>         tf.nsect   = speed;
> 
>         tp_ops->tf_load(drive, &tf, IDE_VALID_FEATURE | IDE_VALID_NSECT);
> 
>         tp_ops->exec_command(hwif, ATA_CMD_SET_FEATURES);
> --->
>         if (drive->quirk_list == 2)
>                 tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);

> --->
>         error = __ide_wait_stat(drive, drive->ready_stat,
>                                 ATA_BUSY | ATA_DRQ | ATA_ERR,
>                                 WAIT_CMD, &stat);
> 
> Please tell me I if understand the issue correctly: if the above quirk is
> not executed we end up with spurious IRQs, right?
right.
> 
> > This patch is to fix this issue. Maybe other controller and drives also
> > have this issue, but I am not sure.
> 
> Probably moving it to a generic quirk_drives list later will be useful...
> 
> Anyway this fixup needs to be ported to / verified with cs5536 first.
the cs5536 pata driver have some geode platform dependent codes. We can
just ignore it, but the performance is poor(using hdparm to test it),
which only get 22+ MB/s. we find it only use udma2. However if using
amd74xx driver, it can set udma5, and the speed can reach to 50+ MB/s. 

we will test whether this driver is working well without this patch.

Anyway, thanks your advice.
> 
> Thanks.
> Bart
> 

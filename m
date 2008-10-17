Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2008 17:50:25 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.144]:3204 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S21728116AbYJQQuW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Oct 2008 17:50:22 +0100
Received: by ey-out-1920.google.com with SMTP id 4so314862eyg.54
        for <linux-mips@linux-mips.org>; Fri, 17 Oct 2008 09:50:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=uiWn5KFpmCKKG0qXd/vQHVhYyNUEYWCOKy3xGOi3nHU=;
        b=q+gTYAjMfAlGGe/0DTO4kMm6MuhW96XtV+jr9p8y7/EnGoM61CIBn5B1yLk2701zut
         dRsmVfCKzkOIT1Pwb8oFlMDgiTgmADIKKKZxzZOAqZOFgKtCZcK/GTdFLo6/W7f/fIGa
         AtSTqqAcaM1R8WypFdGVtblsjzL16KLZ9yu1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=N4d34wOOjd9guHy62GMmdaVTtuonDVYoHtIEDrweg2wu8BfcpDie77kA84Uedt0+X3
         SZTachWEX0lZfZnXwvmhWlXfXBpHkIJ3IfaylbbMauYKNiB4/pMfWHN4BYQytJXYfMTK
         l46YZUKAIL+DBpGbfwxdMC6rFwqo26k3hNHYg=
Received: by 10.103.249.19 with SMTP id b19mr2325886mus.50.1224262221414;
        Fri, 17 Oct 2008 09:50:21 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id j10sm6713139muh.1.2008.10.17.09.50.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 09:50:20 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Date:	Fri, 17 Oct 2008 18:46:34 +0200
User-Agent: KMail/1.9.10
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp> <20081017141310.GA14999@linux-mips.org>
In-Reply-To: <20081017141310.GA14999@linux-mips.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810171846.35109.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Friday 17 October 2008, Ralf Baechle wrote:
> On Fri, Oct 17, 2008 at 11:08:25PM +0900, Atsushi Nemoto wrote:
> 
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> > 
> > This controller has standard ATA taskfile registers and DMA
> > command/status registers, but the register layout is swapped on big
> > endian.  There are some other endian issue and some special registers
> > which requires many custom dma_ops/tp_ops routines and build_dmatable.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > ---
> > This patch is against current linux-mips tree.
> > 
> > Changes since v3:
> > * more consistent symbol naming
> > * handle only DMA mode in set_dma_mode
> > * rename tx4939ide_read_and_clear_dma_status to tx4939ide_clear_dma_status
> > * use standard ide_read_sff_dma_status in LE mode
> > * remove CS5530 workaround from tx4939ide_build_dmatable
> > * use ide_host_alloc/ide_host_register instead of ide_host_alloc
> > * fold tx4939ide_insw_swap into tx4939ide_input_data_swap
> > * more informative printk
> > * whitespace cleanups and spelling fixes
> > 
> >  drivers/ide/Kconfig          |    6 +
> >  drivers/ide/mips/Makefile    |    1 +
> >  drivers/ide/mips/tx4939ide.c |  755 ++++++++++++++++++++++++++++++++++++++++++
> 
> Btw, I don't think architecture specific subdirectories in subsystems are
> generally usefull.  Just as in this example this IDE controller happens
> only to be in use on a particular MIPS-based SOC but there is nothing
> really architecture specific in most such devices.

I fully agree with you.

I was going to remove arch/bus specific subdirs in .29 but since the change
should be really straightforward and we're ahead of the merge schedule for
.28 I think we may as well do it now...

I'll prepare corresponding IDE git pull request next week.

Thanks,
Bart

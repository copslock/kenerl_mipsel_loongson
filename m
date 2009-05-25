Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 15:51:56 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.158]:15269 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023615AbZEYOvt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2009 15:51:49 +0100
Received: by fg-out-1718.google.com with SMTP id 22so1279997fge.9
        for <multiple recipients>; Mon, 25 May 2009 07:51:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=kLXLhhZLxY5nfSUHktxeLZZJ5PVEjH7AZwEPLF2WmhE=;
        b=azerfz9DvpbS3fllRqK/XWqyAtqbs87PCtDl+UMA/0w/TZN1LBHJ9koVoBV0bxxIbw
         Oo8vbekQCaMyfWlDa7VebkLObJpSrBluVEhoTtWb67HvgWBRoYk3x6T+R9DunLtkDz3T
         xjYIqkbm3pAV+Bxn5WWk7u67NoYIL2+NcKpQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=FfUybMFO0FVN26R9MbIAFVQsv+VYFDylfM1eLDZWAFUI4CeqAT8XbzLwg9Y6+noUqL
         y7sxGtgwGRfP0kA/8ow6/X19taLlu3Lw+OMbNVlSsULM0Z+TTKUYn5LPZ6qfOWFl3iZE
         wGpuHkMjEfS4C5V3cfASRi7PYJ/aci87frPM0=
Received: by 10.86.79.5 with SMTP id c5mr5812006fgb.20.1243263108089;
        Mon, 25 May 2009 07:51:48 -0700 (PDT)
Received: from localhost.localdomain (netdev9.wne.uw.edu.pl [193.0.77.10])
        by mx.google.com with ESMTPS id 3sm600205fge.4.2009.05.25.07.51.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 07:51:46 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	=?utf-8?q?=E8=83=A1=E6=B4=AA=E5=85=B5?= <huhb@lemote.com>
Subject: Re: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
Date:	Mon, 25 May 2009 16:56:24 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.30-rc6-next-20090522-05935-g4d19128; KDE/4.2.3; i686; ; )
Cc:	yanh@lemote.com, wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	"IDE/ATA development list" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-scsi" <linux-scsi@vger.kernel.org>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com> <1243230339.9819.18.camel@localhost.localdomain> <4A1A4A54.6090401@lemote.com>
In-Reply-To: <4A1A4A54.6090401@lemote.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200905251656.25357.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Monday 25 May 2009 09:35:48 胡洪兵 wrote:
> yanh 写道:

[...]

> > the cs5536 pata driver have some geode platform dependent codes. We can
> > just ignore it, but the performance is poor(using hdparm to test it),
> > which only get 22+ MB/s. we find it only use udma2. However if using
> > amd74xx driver, it can set udma5, and the speed can reach to 50+ MB/s. 
> >
> > we will test whether this driver is working well without this patch.
> >
> > Anyway, thanks your advice.
> >   
> Use the driver drivers/ata/pata_cs5536.c, unfortunately it also have the 
> same issue.

Both drivers (pata_cs5536 & cs5536) should handle UDMA5.

Could you please explain the issue with platform specific code a bit more?

Is it related to a cable detection by any chance?

Thanks.
Bart

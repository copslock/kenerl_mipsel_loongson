Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 20:04:41 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:49513 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20023725AbZEYTEe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 May 2009 20:04:34 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 266023ED0; Mon, 25 May 2009 12:04:26 -0700 (PDT)
Message-ID: <4A1AEBF7.7040402@ru.mvista.com>
Date:	Mon, 25 May 2009 23:05:27 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	=?UTF-8?B?6IOh5rSq5YW1?= <huhb@lemote.com>, yanh@lemote.com,
	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
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
Subject: Re: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
References: <cover.1242855716.git.wuzhangjin@gmail.com> <1243230339.9819.18.camel@localhost.localdomain> <4A1A4A54.6090401@lemote.com> <200905251656.25357.bzolnier@gmail.com>
In-Reply-To: <200905251656.25357.bzolnier@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Bartlomiej Zolnierkiewicz wrote:

>>yanh 写道:

> [...]

>>>the cs5536 pata driver have some geode platform dependent codes. We can
>>>just ignore it, but the performance is poor(using hdparm to test it),
>>>which only get 22+ MB/s. we find it only use udma2. However if using
>>>amd74xx driver, it can set udma5, and the speed can reach to 50+ MB/s. 

>>>we will test whether this driver is working well without this patch.

>>>Anyway, thanks your advice.

>>Use the driver drivers/ata/pata_cs5536.c, unfortunately it also have the 
>>same issue.

> Both drivers (pata_cs5536 & cs5536) should handle UDMA5.

> Could you please explain the issue with platform specific code a bit more?

> Is it related to a cable detection by any chance?

    I guess it's rdmsr()/wrmsr()...

> Thanks.
> Bart

MBR, Sergei

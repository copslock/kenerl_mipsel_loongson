Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 02:22:12 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:50109 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023798AbZEZBWF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 May 2009 02:22:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 35D8012C0ED;
	Tue, 26 May 2009 09:16:54 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vF4D3qXs+RAA; Tue, 26 May 2009 09:16:39 +0800 (CST)
Received: from [172.16.2.17] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id ABB0034077;
	Tue, 26 May 2009 09:16:38 +0800 (CST)
Subject: Re: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	=?gb2312?Q?=BA=FA=BA=E9=B1=F8?= <huhb@lemote.com>,
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
In-Reply-To: <yq1tz39dmmn.fsf@sermon.lab.mkp.net>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <1243230339.9819.18.camel@localhost.localdomain>
	 <4A1A4A54.6090401@lemote.com> <200905251656.25357.bzolnier@gmail.com>
	 <4A1AEBF7.7040402@ru.mvista.com>  <yq1tz39dmmn.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset="UTF-8"
Date:	Tue, 26 May 2009 09:21:30 +0800
Message-Id: <1243300890.9819.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-25一的 15:10 -0400，Martin K. Petersen写道：
> >>>>> "Sergei" == Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:
> 
> >> Could you please explain the issue with platform specific code a bit
> >> more?
> 
> >> Is it related to a cable detection by any chance?
> 
> Sergei>    I guess it's rdmsr()/wrmsr()...
currently, we just commented out the rdmsr/wrmsr.
and we use pci VSA to access it. 
> 
> Those are only used when the driver is explicitly loaded with
> use_msr=1.  The default is to use PCI config space/VSA.
> 
> In any case I have yet to see a CS5536 system whose BIOS sets the cable
> detection bit.  If that's the problem I guess we could add a quirk flag
> to override the (lack of) BIOS setting.
> 
This may be the cause that udma5 cannot be set.

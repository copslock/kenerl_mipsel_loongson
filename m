Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 15:40:15 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:32833 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024034AbZEZOkI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 May 2009 15:40:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 4A4123C0CA;
	Tue, 26 May 2009 22:34:55 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5WS-dpOGRhl; Tue, 26 May 2009 22:34:40 +0800 (CST)
Received: from [172.16.2.17] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 26D963C0C9;
	Tue, 26 May 2009 22:34:40 +0800 (CST)
Subject: Re: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
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
In-Reply-To: <20090526085605.014d0087@lxorguk.ukuu.org.uk>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	 <1243230339.9819.18.camel@localhost.localdomain>
	 <4A1A4A54.6090401@lemote.com> <200905251656.25357.bzolnier@gmail.com>
	 <4A1AEBF7.7040402@ru.mvista.com> <yq1tz39dmmn.fsf@sermon.lab.mkp.net>
	 <1243300890.9819.40.camel@localhost.localdomain>
	 <20090526085605.014d0087@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Date:	Tue, 26 May 2009 22:39:32 +0800
Message-Id: <1243348772.9819.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-26二的 08:56 +0100，Alan Cox写道：
> > > In any case I have yet to see a CS5536 system whose BIOS sets the cable
> > > detection bit.  If that's the problem I guess we could add a quirk flag
> > > to override the (lack of) BIOS setting.
> > > 
> > This may be the cause that udma5 cannot be set.
> 
> 
> If the system doesn't have working BIOS cable detect as per the
> documentation for the chip then just return the "unknown" cable type and
> libata will do device side cable detect.

After force cable type as 80 wire, udma5 can be set OK now. 
after some raw test, the legacy and native driver have no obvious
difference in performance.

Remain issue: this native driver still have suspend/resume issue.

 
> 
> Alan

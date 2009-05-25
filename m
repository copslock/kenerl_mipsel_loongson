Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 20:16:30 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:49673 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20023727AbZEYTQW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 May 2009 20:16:22 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3A8B33ED1; Mon, 25 May 2009 12:16:15 -0700 (PDT)
Message-ID: <4A1AEEBC.2080108@ru.mvista.com>
Date:	Mon, 25 May 2009 23:17:16 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	=?UTF-8?B?6IOh5rSq5YW1?= <huhb@lemote.com>, yanh@lemote.com,
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
References: <cover.1242855716.git.wuzhangjin@gmail.com>	<1243230339.9819.18.camel@localhost.localdomain>	<4A1A4A54.6090401@lemote.com> <200905251656.25357.bzolnier@gmail.com>	<4A1AEBF7.7040402@ru.mvista.com> <yq1tz39dmmn.fsf@sermon.lab.mkp.net>
In-Reply-To: <yq1tz39dmmn.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Martin K. Petersen wrote:

>>>Could you please explain the issue with platform specific code a bit
>>>more?

>>>Is it related to a cable detection by any chance?

> Sergei>    I guess it's rdmsr()/wrmsr()...

> Those are only used when the driver is explicitly loaded with
> use_msr=1.  The default is to use PCI config space/VSA.

    But you need them defined for the driver to build...

MBR, Sergei

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 20:11:20 +0100 (BST)
Received: from rcsinet12.oracle.com ([148.87.113.124]:31578 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023671AbZEYTLN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 May 2009 20:11:13 +0100
Received: from rgminet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by rgminet12.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4PJAd7W013479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 25 May 2009 19:10:40 GMT
Received: from abhmt008.oracle.com (abhmt008.oracle.com [141.146.116.17])
	by rgminet15.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4PJAnS4028309;
	Mon, 25 May 2009 19:10:49 GMT
Received: from groovelator.mkp.net (/209.217.122.111)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 25 May 2009 12:10:44 -0700
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	=?utf-8?B?6IOh5rSq?= =?utf-8?B?5YW1?= <huhb@lemote.com>,
	yanh@lemote.com, wuzhangjin@gmail.com, linux-mips@linux-mips.org,
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
From:	"Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
References: <cover.1242855716.git.wuzhangjin@gmail.com>
	<1243230339.9819.18.camel@localhost.localdomain>
	<4A1A4A54.6090401@lemote.com> <200905251656.25357.bzolnier@gmail.com>
	<4A1AEBF7.7040402@ru.mvista.com>
Date:	Mon, 25 May 2009 15:10:40 -0400
In-Reply-To: <4A1AEBF7.7040402@ru.mvista.com> (Sergei Shtylyov's message of
	"Mon, 25 May 2009 23:05:27 +0400")
Message-ID: <yq1tz39dmmn.fsf@sermon.lab.mkp.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Source-IP: abhmt008.oracle.com [141.146.116.17]
X-Auth-Type: Internal IP
X-CT-RefId: str=0001.0A010207.4A1AED37.01CB:SCFSTAT5015188,ss=1,fgs=0
Return-Path: <martin.petersen@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.petersen@oracle.com
Precedence: bulk
X-list: linux-mips

>>>>> "Sergei" == Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:

>> Could you please explain the issue with platform specific code a bit
>> more?

>> Is it related to a cable detection by any chance?

Sergei>    I guess it's rdmsr()/wrmsr()...

Those are only used when the driver is explicitly loaded with
use_msr=1.  The default is to use PCI config space/VSA.

In any case I have yet to see a CS5536 system whose BIOS sets the cable
detection bit.  If that's the problem I guess we could add a quirk flag
to override the (lack of) BIOS setting.

-- 
Martin K. Petersen	Oracle Linux Engineering

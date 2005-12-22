Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 00:46:02 +0000 (GMT)
Received: from webmail.ict.ac.cn ([159.226.39.7]:43721 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S3466995AbVLVApo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Dec 2005 00:45:44 +0000
Received: (qmail 18693 invoked by uid 507); 22 Dec 2005 00:22:01 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 22 Dec 2005 00:22:01 -0000
Message-ID: <43A9F76A.4080305@ict.ac.cn>
Date:	Thu, 22 Dec 2005 08:46:34 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To:	Srinivas Kommu <kommu@hotmail.com>
CC:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Preempted interrupt handler
References: <43A6F155.7080402@avilinks.com> <20051220131829.GB3376@linux-mips.org> <20051221193906.GB1456@sjc-xdm-007.cisco.com>
In-Reply-To: <20051221193906.GB1456@sjc-xdm-007.cisco.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips


> Is it normal for the modules to be loaded at 0xc0000000 (this is
> highmem, isn't it)? I see the same on my bcm1250 box. I've been wondering
> why they can't be loaded in kseg0. Or is it because of bad
> modutils/compiler flags?
It is not necessary highmem. 0xc0000000 is a MAPPED(i.e. use TLB) kernel
segment,
used by vmalloc to allocate a large virtually continous memory area for
modules. Use kseg0 you have to get a large physically continuous area,
and that is difficult unless you reserve some memory.
> 
> thanks
> srini
> 
>>   Ralf
> 

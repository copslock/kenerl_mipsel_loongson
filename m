Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2009 01:38:13 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:63691 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28574658AbZCZBiH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2009 01:38:07 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n2Q1bwiC023642;
	Wed, 25 Mar 2009 18:37:58 -0700 (PDT)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 25 Mar 2009 18:37:57 -0700
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 26 Mar 2009 02:37:55 +0100
Message-ID: <49CADD9A.5030508@windriver.com>
Date:	Thu, 26 Mar 2009 09:42:50 +0800
From:	"tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	Alan Wu <alan.wu@mstarsemi.com>
CC:	linux-mips@linux-mips.org
Subject: Re: VPE loader support on 34K
References: <B34CE01D80AD4D309E259934BA1361AA@mstarsemi.com.tw>
In-Reply-To: <B34CE01D80AD4D309E259934BA1361AA@mstarsemi.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Mar 2009 01:37:55.0517 (UTC) FILETIME=[7C6EFED0:01C9ADB3]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

Alan Wu wrote:
> Hello,
> 
> I'm porting 2.6.26 Linux on the platform of MIPS 34K. Currently, the uni-processor 
> kernel model(1 VPE) and SMP model (2 VPE) are up and work perfectly.
> 
> Now, I need to port the AP/SP model on a normal Linux uniprocessor kernel model. 
> I'd like to load an application program (ELF ?) into kernel space where this 
> application will run on a Secondary VPE undisturbed by the Linux kernel.
> 
> After I enabled the MIPS_VPE_LOADER [=y] in .config , the kernel is up without
> any error/warning message.
> 
> Please help :
> 
> 1. How to load the application into VPE1 from VPE0 ? (cat XYZapp >/dev/vpe1 ?)

Exactly.

> 2. Is there any sample "Hello World" application for this ? 
> 3. Any specific tool chain needed ?

I recommend you refer to the file, MIPS® SDE Programmers' Guide (.pdf).
http://www.mips.com/products/product-materials/processor/software/

It's easy to build the sample with SDE. And ever I program a sample to output
some messages from UART to validate AP/AP. I think even you can implement the
same to display something from the LED.

Best Regards
Tiejun

> 
> Thanks.
> 
> 
> 
> 
> 
> 

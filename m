Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Apr 2009 19:36:53 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:50139 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S23039304AbYKCLRV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Nov 2008 11:17:21 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mA3BHEvZ010161;
	Mon, 3 Nov 2008 03:17:14 -0800 (PST)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Nov 2008 03:17:14 -0800
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Nov 2008 12:17:11 +0100
Message-ID: <490EDDF8.2050901@windriver.com>
Date:	Mon, 03 Nov 2008 19:18:16 +0800
From:	"tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	"tiejun.chen" <tiejun.chen@windriver.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Reserve stack/heap area for RP program
References: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com> <1225365345-15635-2-git-send-email-tiejun.chen@windriver.com> <20081030121707.GJ26256@linux-mips.org> <490A6298.8080002@windriver.com>
In-Reply-To: <490A6298.8080002@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2008 11:17:11.0777 (UTC) FILETIME=[B7B52510:01C93DA5]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

tiejun.chen wrote:
> Ralf Baechle wrote:
>> On Thu, Oct 30, 2008 at 07:15:45PM +0800, Tiejun Chen wrote:
>>
>>> When you want to run a program on RP it's necessary to reserve
>>> corresponding stack/heap area of that program.
>> The official method is to pass a mem= argument when booting the kernel and
>> adjust by the amount required.  Which certainly is more flexible than
>> having to hack a constant deeply hidden in the kernel code as in your
>> proposed patch.
>>
> 
> This issue is not related to pass "mem= " if enable CONFIG_MIPS_VPE_LOADER_TOM.
> That way is only load RP on the hidden memory to run. Anyway we still not
> reserve necessary memory for stack/heap of RP which may be overwrite by AP such
> as linux so you will found kernel crash.

Ralf,

Can you give me some suggestions?

Best Regards
Tiejun

> 
>>   Ralf
>>
> 
> 
> 

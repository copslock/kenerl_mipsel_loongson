Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2008 01:42:15 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:61173 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S22780355AbYJaBmE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 01:42:04 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9V1fph4012262;
	Thu, 30 Oct 2008 18:41:52 -0700 (PDT)
Received: from ism-mail02.corp.ad.wrs.com ([128.224.200.19]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 30 Oct 2008 18:41:50 -0700
Received: from [128.224.162.71] ([128.224.162.71]) by ism-mail02.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 31 Oct 2008 02:41:47 +0100
Message-ID: <490A6298.8080002@windriver.com>
Date:	Fri, 31 Oct 2008 09:42:48 +0800
From:	"tiejun.chen" <tiejun.chen@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Reserve stack/heap area for RP program
References: <1225365345-15635-1-git-send-email-tiejun.chen@windriver.com> <1225365345-15635-2-git-send-email-tiejun.chen@windriver.com> <20081030121707.GJ26256@linux-mips.org>
In-Reply-To: <20081030121707.GJ26256@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2008 01:41:47.0728 (UTC) FILETIME=[D6881500:01C93AF9]
Return-Path: <Tiejun.Chen@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@windriver.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Oct 30, 2008 at 07:15:45PM +0800, Tiejun Chen wrote:
> 
>> When you want to run a program on RP it's necessary to reserve
>> corresponding stack/heap area of that program.
> 
> The official method is to pass a mem= argument when booting the kernel and
> adjust by the amount required.  Which certainly is more flexible than
> having to hack a constant deeply hidden in the kernel code as in your
> proposed patch.
> 

This issue is not related to pass "mem= " if enable CONFIG_MIPS_VPE_LOADER_TOM.
That way is only load RP on the hidden memory to run. Anyway we still not
reserve necessary memory for stack/heap of RP which may be overwrite by AP such
as linux so you will found kernel crash.

>   Ralf
> 

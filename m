Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 17:39:19 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:50530 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023466AbZERQjM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 17:39:12 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a118dc10001>; Mon, 18 May 2009 12:33:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 May 2009 09:25:12 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 May 2009 09:25:12 -0700
Message-ID: <4A118BE8.50201@caviumnetworks.com>
Date:	Mon, 18 May 2009 09:25:12 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>, ralf@linux-mips.org
CC:	David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't branch to eret in TLB refill.
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com> <20090513002337.GA12536@cuplxvomd02.corp.sa.net> <4A0A1E6B.6050908@caviumnetworks.com> <alpine.LFD.1.10.0905160706300.12158@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0905160706300.12158@ftp.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 May 2009 16:25:12.0638 (UTC) FILETIME=[381FBDE0:01C9D7D5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 12 May 2009, David Daney wrote:
> 
>>>> +			/*
>>>> +			 * Find the split point.
>>>> +			 */
>>>> +			if (uasm_insn_has_bdelay(relocs, split - 1))
>>>> +				split--;
>>>> +		}
>>> The code itself makes sense. Does this case actually happen much, or was
>>> this just an itch?
>>>
>> For my CPU it was happening 100% of the time when I add the soon to be
>> submitted hugeTLBfs support patch.  Although I have not measured it, this code
>> is so hot that keeping the normal case fitting on a single cache line should
>> be a big win.
> 
>  Rather than this hack,

I don't really know what to say about that comment.

* We are synthesizing optimized TLB refill handlers, even small 
improvements yield big gains in system performance.

* The optimization you suggest below, although a good one, is somewhat 
different and would make a good follow on patch.

* I am trying to make forward progress and not have The perfect be the 
enemy of the good.

> I'd suggest microoptimising the code by shuffling 
> it such that unless the handler fits in 128 bytes entirely (I'm not sure 
> if that ever happens for XTLB refill) the part built by 
> build_get_pgd_vmalloc64() is placed in the TLB handler slot, saving an 
> unnecessary unconditional branch there.  This way the problem of an 
> unconditional branch to ERET will solve automagically as a side-effect.  
> Unless the vmalloc part does not fit in 128 bytes, that is, in which case 
> it would have to overflow back to the XTLB slot.  It should be pretty 
> straightforward to code. ;)
> 
>   Maciej
> 

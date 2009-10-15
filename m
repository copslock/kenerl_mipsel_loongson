Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 22:11:26 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15468 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493830AbZJOULS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 22:11:18 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad781d50002>; Thu, 15 Oct 2009 13:11:01 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Oct 2009 13:11:01 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Oct 2009 13:11:01 -0700
Message-ID: <4AD781D3.60503@caviumnetworks.com>
Date:	Thu, 15 Oct 2009 13:10:59 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Put PGD in C0_CONTEXT for 64-bit R2 processors.
References: <4AD62353.2080603@caviumnetworks.com> <1255547816-7544-2-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.2.00.0910152104020.20490@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.0910152104020.20490@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2009 20:11:01.0469 (UTC) FILETIME=[9DD1C8D0:01CA4DD3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 14 Oct 2009, David Daney wrote:
> 
>> @@ -1406,6 +1424,7 @@ void __cpuinit build_tlb_refill_handler(void)
>>  	case CPU_TX3912:
>>  	case CPU_TX3922:
>>  	case CPU_TX3927:
>> +#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
>>  		build_r3000_tlb_refill_handler();
>>  		if (!run_once) {
>>  			build_r3000_tlb_load_handler();
>> @@ -1413,6 +1432,9 @@ void __cpuinit build_tlb_refill_handler(void)
>>  			build_r3000_tlb_modify_handler();
>>  			run_once++;
>>  		}
>> +#else
>> +		panic("No R3000 TLB refill handler");
>> +#endif
>>  		break;
>>  
>>  	case CPU_R6000:
> 
>  Shouldn't this be #error or suchlike instead?
> 

I don't think so.  It is a runtime check.  The kernel was configured in 
such a manner that those CPUs cannot be supported.  By the time the 
problem is detected, the preprocessor (and compiler in general) have 
already been run.

David Daney


>   Maciej
> 

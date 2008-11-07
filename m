Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 00:05:59 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:52414 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23305027AbYKGAF5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Nov 2008 00:05:57 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B491386510000>; Thu, 06 Nov 2008 19:05:37 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 16:05:36 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 16:05:36 -0800
Message-ID: <49138650.1060901@caviumnetworks.com>
Date:	Thu, 06 Nov 2008 16:05:36 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 18/29] MIPS: Add SMP_ICACHE_FLUSH for the Cavium CPU family.
References: <491358F5.7040002@caviumnetworks.com> <1226004875-27654-18-git-send-email-ddaney@caviumnetworks.com> <49137EEE.5040004@ru.mvista.com>
In-Reply-To: <49137EEE.5040004@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2008 00:05:36.0742 (UTC) FILETIME=[8FA5C060:01C9406C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
> 
> David Daney wrote:
> 
>> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
>> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  arch/mips/include/asm/smp.h |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
>> index 0ff5b52..e6f419f 100644
>> --- a/arch/mips/include/asm/smp.h
>> +++ b/arch/mips/include/asm/smp.h
>> @@ -37,6 +37,9 @@ extern int __cpu_logical_map[NR_CPUS];
>>  
>>  #define SMP_RESCHEDULE_YOURSELF    0x1    /* XXX braindead */
>>  #define SMP_CALL_FUNCTION    0x2
>> +/* Octeon - Tell another core to flush its icache */
>> +#define SMP_ICACHE_FLUSH    0x4
>> +
>>   
> 
>   Sigh, again new macro without users...

The users are in 01/29 and 04/29, perhaps you missed them.

David Daney

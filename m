Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 17:59:12 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:59946 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23354333AbYKGR7J (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2008 17:59:09 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EF4273ECD; Fri,  7 Nov 2008 09:59:06 -0800 (PST)
Message-ID: <491481E9.1090203@ru.mvista.com>
Date:	Fri, 07 Nov 2008 20:59:05 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 18/29] MIPS: Add SMP_ICACHE_FLUSH for the Cavium CPU family.
References: <491358F5.7040002@caviumnetworks.com> <1226004875-27654-18-git-send-email-ddaney@caviumnetworks.com> <49137EEE.5040004@ru.mvista.com> <49138650.1060901@caviumnetworks.com> <49146C7F.9010903@ru.mvista.com> <491479FD.9020402@caviumnetworks.com>
In-Reply-To: <491479FD.9020402@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

>>>>> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
>>>>> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
>>>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

>>>>> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
>>>>> index 0ff5b52..e6f419f 100644
>>>>> --- a/arch/mips/include/asm/smp.h
>>>>> +++ b/arch/mips/include/asm/smp.h
>>>>> @@ -37,6 +37,9 @@ extern int __cpu_logical_map[NR_CPUS];
>>>>>  
>>>>>  #define SMP_RESCHEDULE_YOURSELF    0x1    /* XXX braindead */
>>>>>  #define SMP_CALL_FUNCTION    0x2
>>>>> +/* Octeon - Tell another core to flush its icache */
>>>>> +#define SMP_ICACHE_FLUSH    0x4
>>>>> +

>>>>   Sigh, again new macro without users...

>>> The users are in 01/29 and 04/29, perhaps you missed them.

>>    Using before defining? Cool. :-]

> We are currently touching 82 files.  I think the patch set is bisectable 
> for non-octeon targets.

> If you would like me to move the Kconfig patch to the end, I can do 
> that.  That way you wouldn't have any breakage for octeon if you were to 
> only apply a subset of the patches.  Other than that, there are 
> currently no plans to restructure this patch set to try to maintain 
> rigorous define before use ordering.

    Maybe it's just me, but IMHO first using the macro and then, 15 patches 
after that, having a patch that just adds that macro, is going against the 
common sense...

> David Daney

WBR, Sergei

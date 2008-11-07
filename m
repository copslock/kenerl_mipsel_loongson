Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 16:27:52 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:54310 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23348779AbYKGQ1t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2008 16:27:49 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D35C63ECC; Fri,  7 Nov 2008 08:27:45 -0800 (PST)
Message-ID: <49146C7F.9010903@ru.mvista.com>
Date:	Fri, 07 Nov 2008 19:27:43 +0300
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
References: <491358F5.7040002@caviumnetworks.com> <1226004875-27654-18-git-send-email-ddaney@caviumnetworks.com> <49137EEE.5040004@ru.mvista.com> <49138650.1060901@caviumnetworks.com>
In-Reply-To: <49138650.1060901@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

David Daney wrote:

>>> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
>>> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>>> ---
>>>  arch/mips/include/asm/smp.h |    3 +++
>>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
>>> index 0ff5b52..e6f419f 100644
>>> --- a/arch/mips/include/asm/smp.h
>>> +++ b/arch/mips/include/asm/smp.h
>>> @@ -37,6 +37,9 @@ extern int __cpu_logical_map[NR_CPUS];
>>>  
>>>  #define SMP_RESCHEDULE_YOURSELF    0x1    /* XXX braindead */
>>>  #define SMP_CALL_FUNCTION    0x2
>>> +/* Octeon - Tell another core to flush its icache */
>>> +#define SMP_ICACHE_FLUSH    0x4
>>> +

>>   Sigh, again new macro without users...

> The users are in 01/29 and 04/29, perhaps you missed them.

    Using before defining? Cool. :-]

> David Daney

WBR, Sergei

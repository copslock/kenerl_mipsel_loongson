Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 15:55:06 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:5838 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8226122AbVDSOyv>; Tue, 19 Apr 2005 15:54:51 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 19 Apr 2005 10:50:06 -0400
Message-ID: <42651BB9.4050609@timesys.com>
Date:	Tue, 19 Apr 2005 10:54:49 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	sjhill@realitydiluted.com
CC:	linux-mips@linux-mips.org
Subject: Re: sysv ipc msg functions
References: <E1DNu4q-0000da-T3@real.realitydiluted.com>
In-Reply-To: <E1DNu4q-0000da-T3@real.realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2005 14:50:06.0312 (UTC) FILETIME=[1363FE80:01C544EF]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

sjhill@realitydiluted.com wrote:

>[ Charset ISO-8859-1 unsupported, converting... ]
>  
>
>>I needed this glibc patch to get the sysv ipc msgctl functions to work 
>>correctly. This looks a bit hackish to me, so I wanted to run it past 
>>everybody here before filing it with glibc.
>>
>>    
>>
>Perhaps is ignorance on my part, but I thought the compiler would
>handle the endianness with regards to the structure members. Did
>you have problems with big and little endian such that you had to
>do all of the ugly #ifdef'ing? 
>  
>
yes. Take a look at the kernel structure it is mapping to.

in
asm-mips/msgbuf.h

struct msqid64_ds

Greg Weeks

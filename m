Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2005 20:01:50 +0000 (GMT)
Received: from mailfe04.swip.net ([IPv6:::ffff:212.247.154.97]:2298 "EHLO
	swip.net") by linux-mips.org with ESMTP id <S8224833AbVCFUBf>;
	Sun, 6 Mar 2005 20:01:35 +0000
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
Received: from [83.177.235.13] (HELO [192.168.0.32])
  by mailfe04.swip.net (CommuniGate Pro SMTP 4.2.9)
  with ESMTP id 313604262; Sun, 06 Mar 2005 21:01:29 +0100
Message-ID: <422B6192.2080801@astek.fr>
Date:	Sun, 06 Mar 2005 21:01:22 +0100
From:	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
CC:	linux-mips@linux-mips.org
Subject: Re: SGI IP32 and 2.6.11
References: <422B3C74.9090706@laposte.net> <422B5676.7090207@total-knowledge.com>
In-Reply-To: <422B5676.7090207@total-knowledge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ftemporelli@astek.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ftemporelli@astek.fr
Precedence: bulk
X-list: linux-mips

Hello Ilya,

yep, following my mail I just try to rebuild the kernel with more 
drivers and reboot on this kernel failed.
Now, same kernel but without the 64MB dimms, boot on this kernel is 
working fine.

thanks !!!

for information, 64 MB dimms are "transtec" with s/n DRA0SM1 (nothing 
about them on google :-( ).
These dimms where installed on an other IP32 (I just add them in my O2)
and hinv was reporting 320MB with all dimms installed (6*32MB + these 2 
dimms)


Best regards

Frederic


Ilya A. Volynets-Evenbakh a écrit :

> There is no such thing as 64M DIMM for O2. Put correct memory into 
> your machine and
> both of these problems will be solved.
>
> Frederic TEMPORELLI wrote:
>
>> Hello,
>>
>> I've just been able to start 2.6.11 from my own compilation on IP32.
>>
>> Can I have some help about following problems/comments ?
>>
>> 1/ It was really difficult because kernel was falling in breakpoint 
>> call (BUG macro) in free_bootmem_core.
>> => I've successfully try to comment this BUG macro in 
>> free_bootmem_core (bootmem.c)
>> Of course, I'm thinking this is really sad... but I've a really poor 
>> knowledge in kernel development...
>> may someone can explain how to solve such issue in a better way ?
>> This breakpoint was boring me since 2.6.10...
>>
>> 2/ There's also a problem with ip32-memory.c, which isn't able to 
>> detect 64MB dimm.
>> Yet, not enough knowledge for processing bankctl (prom_meminit) in 
>> the nice way for detecting 64MB dimms...
>> (All memory slots are used on my O2: slots 1 to 6 with 32MB dimms and 
>> slots 7 & 8 with  64MB dimms) .
>>
>> Best regards
>>
>> Frederic TEMPORELLI
>>
>>
>>
>
>

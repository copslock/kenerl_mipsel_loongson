Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 14:19:39 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:26556 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20022608AbZDBNTV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 14:19:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 6621334100;
	Thu,  2 Apr 2009 21:16:40 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XgXNNsGUpaeG; Thu,  2 Apr 2009 21:16:35 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 0FB8B340FB;
	Thu,  2 Apr 2009 21:16:35 +0800 (CST)
Received: from 222.92.8.142
        (SquirrelMail authenticated user wuzj@lemote.com)
        by mail.lemote.com with HTTP;
        Thu, 2 Apr 2009 21:16:35 +0800 (CST)
Message-ID: <26244.222.92.8.142.1238678195.squirrel@mail.lemote.com>
Date:	Thu, 2 Apr 2009 21:16:35 +0800 (CST)
Subject: Re: [PATCH] added Loongson cpu-feature-overrides.h
From:	=?gb2312?Q?=CE=E2=D5=C2=BD=F0?= <wuzj@lemote.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, "Zhang Le" <r0bertz@gentoo.org>
User-Agent: SquirrelMail/1.4.11
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <wuzj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzj@lemote.com
Precedence: bulk
X-list: linux-mips


> On Thu, Apr 02, 2009 at 06:56:13PM +0800, Zhang Le wrote:
>
>> On 15:41 Thu 02 Apr     , Zhang Le wrote:
>> > diff --git a/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
>> b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
>> > new file mode 100644
>> > index 0000000..550a10d
>> > --- /dev/null
>> > +++ b/arch/mips/include/asm/mach-lemote/cpu-feature-overrides.h
>>
>> [snip]
>>
>> > +#define cpu_icache_snoops_remote_store	1
>>
>> This maybe should not exist here, since this only matters on SMP.
>> It exists in Wu's version. Maybe Wu could explain it. Maybe it is just a
>> typo.

ooh, sorry, when i firstly edit this file, I really only need cpu_has_llsc
there, so the other options are copied from another mips board and only
be checked via the "loongson2f user manual" and "cat /proc/cpuinfo" with a
modified cpu_showinfo function.

>>
>> Pulling him in.
>
> This simply doesn't matter on a uniprocessor system.
>
>   Ralf
>

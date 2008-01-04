Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 19:24:01 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:24836 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S20025523AbYADTXh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2008 19:23:37 +0000
Received: from [192.168.32.225] ([192.168.32.225]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 4 Jan 2008 14:23:31 -0500
Message-ID: <477E87AF.6010404@raritan.com>
Date:	Fri, 04 Jan 2008 14:23:27 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <477E6296.7090605@raritan.com> <20080104172136.GD22809@networkno.de> <477E7DAE.2080005@raritan.com> <20080104185130.GB6532@paradigm.rfc822.org>
In-Reply-To: <20080104185130.GB6532@paradigm.rfc822.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2008 19:23:31.0603 (UTC) FILETIME=[4AA93E30:01C84F07]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:
> On Fri, Jan 04, 2008 at 01:40:46PM -0500, Gregor Waltz wrote:
>   
>> CRC Check passed
>> Image Started At Address 0x80020000.
>> Image Length = 3424394 (0x34408a).
>> Exception! EPC=80056eb4 CAUSE=30000008(TLBL)
>> 80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc
>>     
>
> The exception comes from PMON too - Did you look up the EPC in your
> System.map file ?
>
>   
>> Further, the exception gets printed immediately after "Image Length = 
>> 3424394 (0x34408a)." The exception happens so soon that I doubt that the 
>> kernel does very much beforehand.
>>     
>
> The kernel seems to be initializing and steps upon an virtual address
> and triggers an TLB exception which as the kernel is not yet ready
> to handle it itself, thus PMONs exception handler gets triggered.
>
> My first guess is that you are catching a NULL Pointer exception
> somewhere.
>
> FLo
>   
Linux 2.6.23.9:
80056eb4 T kernel_execve

My coworker built Linux 2.6.23.12 and got:
EPC=80056ee0 which does not correspond to anything in his System.map.

With a different set of tools, I also built 2.6.21.7 and got:
EPC=80056eb8 which also does not correspond to anything in the 
corresponding System.map.

If this does not ring any bells, do you have any suggestions for how I 
could debug this issue?


Thanks

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 17:53:22 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17638 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492995AbZKFQxQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 17:53:16 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4af454680001>; Fri, 06 Nov 2009 08:53:01 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Nov 2009 08:44:30 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Nov 2009 08:44:30 -0800
Message-ID: <4AF4526B.3020502@caviumnetworks.com>
Date:	Fri, 06 Nov 2009 08:44:27 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: COMMAND_LINE_SIZE and CONFIG_FRAME_WARN
References: <20091107.010839.246840249.anemo@mba.ocn.ne.jp>	 <90edad820911060822g40233a8ft28001d68186b989e@mail.gmail.com> <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
In-Reply-To: <90edad820911060834t5c14aa30t847c3b75bf7e36e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2009 16:44:30.0023 (UTC) FILETIME=[6907AD70:01CA5F00]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Dmitri Vorobiev wrote:
> On Fri, Nov 6, 2009 at 6:22 PM, Dmitri Vorobiev
> <dmitri.vorobiev@gmail.com> wrote:
>> On Fri, Nov 6, 2009 at 6:08 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>>> Recently COMMAND_LINE_SIZE (CL_SIZE) was extended to 4096 from 512.
>>> (commit 22242681 "MIPS: Extend COMMAND_LINE_SIZE")
>>>
>>> This cause warning if something like buf[CL_SIZE] was declared as a
>>> local variable, for example in prom_init_cmdline() on some platforms.
>>>
>>> And since many Makefiles in arch/mips enables -Werror, this cause
>>> build failure.
>>>
>>> How can we avoid this error?
>>>
>>> - do not use local array? (but dynamic allocation cannot be used in
>>>  such an early stage.  static array?)
>> Maybe a static array marked with __initdata?
> 
> Also, I just thought that maybe it's possible to use a c99
> variable-length array here? Like this:
> 
> int n = COMMAND_LINE_SIZE;
> char buf[n];
> 
> This way, we don't put yet another variable in the .init.data section,
> unlike with the static array solution.
> 
> However, this is totally untested, just a thought...
> 

It depends on your concerns.  You are still using 4096 bytes of stack, 
but you are trying to trick the compiler into not warning.

If you think the warning is bogus, you should remove it for all code, 
not just this file.  If you think the warning is valid, then you should 
fix the code so that it doesn't use as much stack space.

David Daney

Received:  by oss.sgi.com id <S553752AbRAHNdG>;
	Mon, 8 Jan 2001 05:33:06 -0800
Received: from [194.90.113.98] ([194.90.113.98]:9221 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S553748AbRAHNcx>;
	Mon, 8 Jan 2001 05:32:53 -0800
Received: from jungo.com (kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id QAA23718;
	Mon, 8 Jan 2001 16:35:48 +0200
Message-ID: <3A59C0FB.62E52EF0@jungo.com>
Date:   Mon, 08 Jan 2001 15:30:35 +0200
From:   Michael Shmulevich <michaels@jungo.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Carsten Langgaard <carstenl@mips.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: User applications
References: <3A598AFC.83204F56@mips.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Carsten Langgaard wrote:

> I have a few questions about user applications.
>
> When a new user process is started will its user space be cleared by the
> kernel or is there a potential leak from an older user process ?

Usually it is defied by the loader. If the data section contents is set to
LOAD, then the contents of the section will be loaded from disk (no leak),
if not -- whatever values left i nmemory will be there, or exactly, the
virtual page of some other proccess that was swapped out or ended.

> What about the registers values, are they cleared for each new user
> application or will it simply contain the current value it got when the
> user application is started ?

It depends on the context switch algorithm of the processor, I think.

> How can you flush the data and instruction cashes from a user
> application ?
>

As far as I understand, ASID must take care of it. It contains unique IDs
per process virtual space, so that even
though virtual addresses may be found in TLB, their ASID will be different,
causing TLB miss and probably page fault.

>
> /Carsten
>
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com

Michael.

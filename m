Received:  by oss.sgi.com id <S553815AbRAJIJW>;
	Wed, 10 Jan 2001 00:09:22 -0800
Received: from mx.mips.com ([206.31.31.226]:65510 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553812AbRAJIIw>;
	Wed, 10 Jan 2001 00:08:52 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA07632;
	Wed, 10 Jan 2001 00:08:47 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA28625;
	Wed, 10 Jan 2001 00:08:44 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id JAA18451;
	Wed, 10 Jan 2001 09:08:09 +0100 (MET)
Message-ID: <3A5C1868.A6B54E57@mips.com>
Date:   Wed, 10 Jan 2001 09:08:08 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     carlson@sibyte.com
CC:     linux-mips@oss.sgi.com
Subject: Re: _clear_page semantics
References: <01010917590106.07691@plugh.sibyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Justin Carlson wrote:

> Looking at the existing clear_page implementations for r4xx0, rm7k, and mips32
> in the mips/ tree, I see everyone issuing cache op 0xd for the address range of
> the page being cleared.
>
> I'm wondering what the purpose is of these cache flushes...given a physically
> tagged dcache, my understanding of the semantics of clear_page are that it just
> zeros the page, in which case the cache ops are pointless overhead.
>
> Especially in the mips32 case, which uses cache op 0xd, which is undefined
> implementation dependent according to my mips32 spec.

You are absolutely right, it is implementation dependent.
I just tend to use the mips32 implementation for my R4000s as well, and here as
Ralf mention it is performance improving.
Actually we have included a CPU option flag (MIPS_CPU_CACHE_CDEX), what tells us
if the CPU has the Create_Dirty_Exclusive CACHE operation available.
So we should probably use it, now it is here :-)

Thanks.

>
> Am I missing something here?
>
> Thanks,
> Justin

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com

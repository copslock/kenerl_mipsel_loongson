Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2003 15:11:29 +0100 (BST)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:2492 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225307AbTHEOL0>; Tue, 5 Aug 2003 15:11:26 +0100
Received: (qmail 16125 invoked from network); 5 Aug 2003 14:08:01 -0000
Received: from antipov.dev.rtsoft.ru (HELO mail.ru) (192.168.1.213)
  by mail.dev.rtsoft.ru with SMTP; 5 Aug 2003 14:08:01 -0000
Message-ID: <3F2FB360.9040005@mail.ru>
Date: Tue, 05 Aug 2003 17:38:40 +0400
From: Dmitry Antipov <dmitry.antipov@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: IT8172G on-board timers 
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dmitry.antipov@mail.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.antipov@mail.ru
Precedence: bulk
X-list: linux-mips

Hello all,

 I'm working with IT8172-based MIPS board and want to use one of (or may 
be both) on-board timers.
For my purposes, it's required to generate irq from timer rarely, for 
example, each 1 sec, or each 5 sec
or so. (The usage of Linux timer interface (init_timer() etc...) is 
forbidden, and I don't want to touch
system timer to avoid the potential damage for basic timekeeping, 
scheduling, etc.). I have two problems:
- timer backward counter is 16-bit wide and reaches zero too fast, even 
starting from 0xffff;
- timer input clock may be one of CPU clock, CPU clock /4, CPU clock/8 
or CPU  clock /16, which looks
   very fast too
So, the minimum interrupt frequency from both timers is 96 ints/HZ (with 
TCR0.PST0 is 0 and
TCVR0 is 0xffff) and the maximum is around 150000 ints/HZ. Even the 
minimum is too large for me...

It seems this question is much more about h/w than about Linux, but I 
hope someone has an experience
with this arch :-) Is it possible to program on-board timer to generate 
interrupts with less frequency ?

Thanks,
Dmitry

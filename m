Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 02:29:40 +0100 (BST)
Received: from mproxy.gmail.com ([IPv6:::ffff:216.239.56.251]:38020 "EHLO
	mproxy.gmail.com") by linux-mips.org with ESMTP id <S8225339AbUJOB3f>;
	Fri, 15 Oct 2004 02:29:35 +0100
Received: by mproxy.gmail.com with SMTP id x71so245870cwb
        for <linux-mips@linux-mips.org>; Thu, 14 Oct 2004 18:29:23 -0700 (PDT)
Received: by 10.11.98.44 with SMTP id v44mr22946cwb;
        Thu, 14 Oct 2004 18:29:23 -0700 (PDT)
Received: by 10.11.98.17 with HTTP; Thu, 14 Oct 2004 18:29:23 -0700 (PDT)
Message-ID: <8498a8b0041014182933ca742a@mail.gmail.com>
Date: Thu, 14 Oct 2004 21:29:23 -0400
From: Kang <huangyk@gmail.com>
Reply-To: Kang <huangyk@gmail.com>
To: linux-mips@linux-mips.org
Subject: Problem caused by forcing interrupt vector location to 0x91xx0200 instead of 0x80000200
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <huangyk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: huangyk@gmail.com
Precedence: bulk
X-list: linux-mips

Hello buddies,

I am working on a MIPS4Kc based reference design board. For some
reason, I need to force the interrupt vector location to address
0x91xx0200 instead of 0x80000200 in arch/mips/kernel/traps.c. The
kernel was loaded into 0x91xxxxxx space as well.

The kernel hung just after the interrupt was first time opened, after
sti(), before calibrate_delay() in init/main.c. It was weird that I
didn't see any problem if I put interrupt vector to location
0x80000200 while all other exception vectors to 0x91xxxxxx.

Was interrupt vector location hardcode to the address 0x80000200? Or
some other place I need to change to walk around it. Any idea?

Thanks a bunch for your help.

Leo

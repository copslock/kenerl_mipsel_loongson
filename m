Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Dec 2003 12:48:58 +0000 (GMT)
Received: from law10-f52.law10.hotmail.com ([IPv6:::ffff:64.4.15.52]:48649
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225301AbTLHMsz>; Mon, 8 Dec 2003 12:48:55 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 8 Dec 2003 04:48:45 -0800
Received: from 63.121.54.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 08 Dec 2003 12:48:44 GMT
X-Originating-IP: [63.121.54.5]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: dan@debian.org
Cc: linux-mips@linux-mips.org
Subject: Re: cross debugging r3912 cpu with gdb
Date: Mon, 08 Dec 2003 12:48:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW10-F527kP31wEf2X00017cd3@hotmail.com>
X-OriginalArrivalTime: 08 Dec 2003 12:48:45.0362 (UTC) FILETIME=[9DE3B120:01C3BD89]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Daniel

>
>Then what ARE you using on the target?
>

I have a kernel, busybox (for init and sh) and kaffe+associated files.  
These have all been cross compiled from i386 for mipsel-linux using gcc 
(2.95 or 3.0).

>You have to connect to some particular debug stub.  That determines
>what protocol to use.
>


I wanted to test starting the whole thing up and connecting with gdb before 
trying to actually debug anything.  So, I haven't begun to worry about debug 
stubs.

Frankly, I'm confused as to where they'd go.  It seems to me I want to let 
the kernel start up on the pda and then use gdb to tell it to start running 
kaffe.  If that's true, I need debug stubs in kaffe.  Am I completely wrong 
with this idea?

Mark

>--
>Daniel Jacobowitz
>MontaVista Software                         Debian GNU/Linux Developer

_________________________________________________________________
Browse styles for all ages, from the latest looks to cozy weekend wear at 
MSN Shopping.  And check out the beauty products! http://shopping.msn.com

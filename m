Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 09:51:51 +0100 (BST)
Received: from bay15-f25.bay15.hotmail.com ([IPv6:::ffff:65.54.185.25]:16908
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224791AbUHTIvr>; Fri, 20 Aug 2004 09:51:47 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 20 Aug 2004 01:51:39 -0700
Received: from 220.247.240.49 by by15fd.bay15.hotmail.msn.com with HTTP;
	Fri, 20 Aug 2004 08:51:39 GMT
X-Originating-IP: [220.247.240.49]
X-Originating-Email: [safiudeen@hotmail.com]
X-Sender: safiudeen@hotmail.com
From: "safiudeen Ts" <safiudeen@hotmail.com>
To: michael.stickel@4g-systems.biz, linux-mips@linux-mips.org
Subject: Re: PCMCIA genric sreail or modem support for db1100 bord
Date: Fri, 20 Aug 2004 08:51:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY15-F253abTd9QkTD0002f560@hotmail.com>
X-OriginalArrivalTime: 20 Aug 2004 08:51:39.0980 (UTC) FILETIME=[E8A6A8C0:01C48692]
Return-Path: <safiudeen@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: safiudeen@hotmail.com
Precedence: bulk
X-list: linux-mips

built in serial ports are working fine in DB1100 with linux-2.4.20 kernel
When we use a pcmcia serial card or modem, for most of the card, cardmaneger 
load serial_cs.o (actualy it uses the serial.o  fetures for registering the 
module).
This method work fine in my laptop.
same think hepens in db1100 bord also. I gues serial.o in bord db110 does'nt 
support well for serial_cs
.
If there is a stand alon serial_cs.o module for this board It may work 
without any problem.
if it is os where  can I get the seria_cs or any generic serial pcmcia 
driver for db1100 bord, or  otherwise is any serial.c available for db1100 
that can support pcmcia and inbuild serial as it works in labtop.

There is important think, when we connected in the laptop this pcmcia serial 
card detect is detected as 65550A but in the board it detected as 65550. I 
checked the serial.c code of db1100 there is no entry for this 65550A.

if any one worked with this DB1100 please help me to solve this problem


thanx
safiudeen

&gt;From: Michael Stickel &lt;michael.stickel@4g-systems.biz&gt;
&gt;To: &quot;safiudeen Ts&quot; &lt;safiudeen@hotmail.com&gt;
&gt;Subject: Re: PCMCIA genric sreail or modem support for db1100 bord
&gt;Date: Fri, 20 Aug 2004 10:07:40 +0200
&gt;
&gt;
&gt;Do you use the buildin serial ports?
&gt;
&gt;My last information is that the au1x00-serial module does not work
&gt;in parallel with the serial module because au1x00-serial.c is just a
&gt;modified copy of serial.c.
&gt;
&gt;Michael
&gt;

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

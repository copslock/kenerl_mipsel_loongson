Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Dec 2003 22:28:43 +0000 (GMT)
Received: from law10-f17.law10.hotmail.com ([IPv6:::ffff:64.4.15.17]:33804
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225346AbTLGW2m>; Sun, 7 Dec 2003 22:28:42 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sun, 7 Dec 2003 14:28:33 -0800
Received: from 24.209.41.112 by lw10fd.law10.hotmail.msn.com with HTTP;
	Sun, 07 Dec 2003 22:28:33 GMT
X-Originating-IP: [24.209.41.112]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: linux-mips@linux-mips.org
Subject: cross debugging r3912 cpu with gdb
Date: Sun, 07 Dec 2003 22:28:33 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F17iieCGDqfgx00015870@hotmail.com>
X-OriginalArrivalTime: 07 Dec 2003 22:28:33.0772 (UTC) FILETIME=[72FC0AC0:01C3BD11]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi folks

I'm trying to track down a SIGSEGV generated by kaffe on the Helio pda.  It 
uses a  Phillips R3912 cpu.

The gdb 6.0 docs say configure as follows:  configure 
--target=mips-idt-ecoff.  I did and mips shows up as an available target.

Unfortunately, when I try to connect to the pda via a USB serial connection, 
I get:

(gdb) set debug remote 2
(gdb) target mips /dev/ttyUSB0
Expected "<IDT>", got "": FAIL
Expected "<IDT>", got "": FAIL
Expected "<IDT>", got "": FAIL
Failed to initialize.
Ending remote MIPS debugging.
You can't do that without a process to debug

Further research shows there is supposed to be a target named r3900.  It 
doesn't show up under my available targets and

(gdb) target r3900 /dev/ttyUSB0

gives and error saying there is no target named r3900.

Can anyone out there give me advice about gdb and mips cross debugging?

Mark

_________________________________________________________________
Shop online for kids� toys by age group, price range, and toy category at 
MSN Shopping. No waiting for a clerk to help you! http://shopping.msn.com

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA62376 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 12:00:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA31139
	for linux-list;
	Tue, 16 Feb 1999 11:59:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA21062
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Feb 1999 11:59:04 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from aw.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA06481
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Feb 1999 11:59:03 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port22.koeln.ivm.de [195.247.239.22])
	by aw.ivm.net (8.8.8/8.8.8) with ESMTP id UAA20330;
	Tue, 16 Feb 1999 20:58:48 +0100
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990216210107.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <19990216202555.A1673@alpha.franken.de>
Date: Tue, 16 Feb 1999 21:01:07 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: problem booting sgi linux
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com,
        Eric Melville <m_thrope@rigelfore.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

On 16-Feb-99 Thomas Bogendoerfer wrote:
> On Tue, Feb 16, 1999 at 04:38:50AM -0800, Eric Melville wrote:
>> CPU: MIPS R4400 Processor Chip Revision: 6.0
> [..]
>> any ideas as to why every kernel i've tried hangs when it tries to free
>> unused kernel memory? thanks...
> 
> looks like we have still a problem with R4400. Ralf ?

Sorry for stepping in here, guys. This isn't strictly SGI related, but...

[root@localhost /root]# cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : R4400SC V4.0
system type             : Digital DECstation 5000/2x0
BogoMIPS                : 59.90
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : yes
VCED exceptions         : 5244
VCEI exceptions         : 17100    

OTOH there may be significant differences between V4.0 and V6.0, but maybe
this helps.

---
Regards,
Harald

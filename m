Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA07441 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 04:42:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA74510
	for linux-list;
	Tue, 16 Feb 1999 04:41:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA71791
	for <linux@engr.sgi.com>;
	Tue, 16 Feb 1999 04:41:24 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id EAA02401
	for <linux@engr.sgi.com>; Tue, 16 Feb 1999 04:41:24 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 7061 invoked from network); 16 Feb 1999 12:50:43 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 16 Feb 1999 12:50:43 -0000
Message-ID: <36C966DA.C7F506BA@rigelfore.com>
Date: Tue, 16 Feb 1999 04:38:50 -0800
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: problem booting sgi linux
References: <36C76479.62B097D2@rigelfore.com> <19990215013527.B2910@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

hinv of my indy:

Iris Audio Processor: version A2 revision 4.1.0
1 200 MHZ IP22 Processor
FPU: MIPS R4010 Floating Point Chip Revision: 0.0
CPU: MIPS R4400 Processor Chip Revision: 6.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte
Main memory size: 64 Mbytes
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: version WD33C93B, revision D
Disk drive: unit 2 on SCSI controller 0
Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 24-bit
Vino video: unit 0, revision 0, IndyCam not connected

any ideas as to why every kernel i've tried hangs when it tries to free
unused kernel memory? thanks...

-E

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA81109 for <linux-archive@neteng.engr.sgi.com>; Mon, 15 Feb 1999 10:14:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA93786
	for linux-list;
	Mon, 15 Feb 1999 10:14:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA27624
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 15 Feb 1999 10:14:06 -0800 (PST)
	mail_from (tor@spacetec.no)
Received: from pallas.spacetec.no (pallas.spacetec.no [192.51.5.92]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA05751
	for <linux@cthulhu.engr.sgi.com>; Mon, 15 Feb 1999 10:14:04 -0800 (PST)
	mail_from (tor@spacetec.no)
Received: (from tor@localhost)
	by pallas.spacetec.no (8.9.1a/8.9.1) id TAA04358;
	Mon, 15 Feb 1999 19:13:56 +0100
Message-Id: <199902151813.TAA04358@pallas.spacetec.no>
From: tor@spacetec.no (Tor Arntsen)
Date: Mon, 15 Feb 1999 19:13:53 +0100
In-Reply-To: Eric Melville <m_thrope@rigelfore.com>
       "Re: problem booting sgi linux" (Feb 15, 19:10)
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: Eric Melville <m_thrope@rigelfore.com>
Subject: Re: problem booting sgi linux
Cc: linux@cthulhu.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Feb 15, 19:10, Eric Melville wrote:
>uhm... what's a hinv?

Just log in (in IRIX) and enter 'hinv'.  Thomas was interested in the output.  
As an example, here's how it looks like on an Indy I just logged in to:

>hinv
Iris Audio Processor: version A2 revision 4.1.0
1 132 MHZ IP22 Processor
FPU: MIPS R4610 Floating Point Chip Revision: 2.0
CPU: MIPS R4600 Processor Chip Revision: 2.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Secondary unified instruction/data cache size: 512 Kbytes
Main memory size: 32 Mbytes
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 8-bit
Vino video: unit 0, revision 0, IndyCam not connected

- Tor

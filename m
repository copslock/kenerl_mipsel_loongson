Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id XAA46275 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Mar 1999 23:44:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA20162
	for linux-list;
	Thu, 11 Mar 1999 23:44:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA12594
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 11 Mar 1999 23:44:16 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from penguin.wise.edt.ericsson.se (penguin-ext.wise.edt.ericsson.se [194.237.142.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA04116
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Mar 1999 02:44:14 -0500 (EST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from eede.ericsson.se (eede.eede.ericsson.se [164.48.127.16])
	by penguin.wise.edt.ericsson.se (8.9.0/8.9.0/WIREfire-1.2) with SMTP id IAA12284;
	Fri, 12 Mar 1999 08:43:59 +0100 (MET)
Received: from sun168.eu (sun168.eede.ericsson.se) by eede.ericsson.se (4.1/SMI-4.1)
	id AA26153; Fri, 12 Mar 99 08:44:05 +0100
Received: by sun168.eu (SMI-8.6/SMI-SVR4)
	id IAA28993; Fri, 12 Mar 1999 08:44:06 +0100
Date: Fri, 12 Mar 1999 08:44:06 +0100
Message-Id: <199903120744.IAA28993@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tom Woelfel <eedthwo@eede.ericsson.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: eedthwo@eede.ericsson.se, linux@cthulhu.engr.sgi.com
Subject: Re: Illegal f_magic number while install-procedure
In-Reply-To: <19990311002713.A368@alpha.franken.de>
References: <199903081247.NAA02741@sun168.eu>
	<19990309000234.A2804@alpha.franken.de>
	<199903100920.KAA01213@sun168.eu>
	<19990311002713.A368@alpha.franken.de>
X-Mailer: VM 6.31 under 20.2 XEmacs Lucid
Reply-To: eedthwo@eede.ericsson.se
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thomas Bogendoerfer writes:
 > On Wed, Mar 10, 1999 at 10:20:19AM +0100, Tom Woelfel wrote:
 > > Then nothing happens anymore. I think the next thing to come should be 
 > > the 'init' process (init doesn't need to be an ECOFF - exec ?).
 > 
 > no elf is perfect. Could you please send a hinv output ? I suspect this
 > another SC processor. 

$ hinv
1 100 MHZ IP22 Processor
FPU: MIPS R4010 Floating Point Chip Revision: 0.0
CPU: MIPS R4000 Processor Chip Revision: 3.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 8 Kbytes
Instruction cache size: 8 Kbytes
Main memory size: 96 Mbytes
Integral Ethernet: ec0, version 1
Disk drive: unit 1 on SCSI controller 0
Integral SCSI controller 0: Version WD33C93B, revision D
Iris Audio Processor: version A2 revision 4.1.0
Graphics board: Indy 8-bit
Vino video: unit 0, revision 0, Indycam connected

Does this help youu ?

//Tom

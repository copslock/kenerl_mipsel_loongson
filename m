Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAU9EOd31817
	for linux-mips-outgoing; Fri, 30 Nov 2001 01:14:24 -0800
Received: from mail1.infineon.com (mail1.infineon.com [192.35.17.229])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAU9ELo31811
	for <linux-mips@oss.sgi.com>; Fri, 30 Nov 2001 01:14:22 -0800
X-Envelope-Sender-Is: Andre.Messerschmidt@infineon.com (at relayer mail1.infineon.com)
Received: from mchb0b1w.muc.infineon.com ([172.31.102.53])
	by mail1.infineon.com (8.11.1/8.11.1) with ESMTP id fAU8EIj14332
	for <linux-mips@oss.sgi.com>; Fri, 30 Nov 2001 09:14:19 +0100 (MET)
Received: from mchb0b5w.muc.infineon.com ([172.31.102.49]) by mchb0b1w.muc.infineon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id X580R8F0; Fri, 30 Nov 2001 09:14:18 +0100
Received: from 172.29.128.3 by mchb0b5w.muc.infineon.com (InterScan E-Mail VirusWall NT); Fri, 30 Nov 2001 09:14:17 +0100
Received: by dlfw003a.dus.infineon.com with Internet Mail Service (5.5.2653.19)
	id <WR91WCN7>; Fri, 30 Nov 2001 09:13:42 +0100
Message-ID: <86048F07C015D311864100902760F1DD01B5E463@dlfw003a.dus.infineon.com>
From: Andre.Messerschmidt@infineon.com
To: linux-mips@oss.sgi.com
Subject: Bug in Dwarf support?
Date: Fri, 30 Nov 2001 09:13:41 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi.

When I compile kernel 2.4.3 with dwarf debug support (using H.J.Lu's gcc
2.96 binaries) I get no path information for source files. 
I did a hexdump of .debug_sfnames with readelf and the path is there but
separated from the filename by a 0x00. For include files the path is ok.
(i.e. the 0x00 is missing) 

Is this a bug or standard? I believe this prevents my debugger from
recognizing the source tree structure.

best regards
Andre Messerschmidt

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA320306 for <linux-archive@neteng.engr.sgi.com>; Mon, 2 Mar 1998 15:38:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA143663 for linux-list; Mon, 2 Mar 1998 15:37:07 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA145318 for <linux@cthulhu.engr.sgi.com>; Mon, 2 Mar 1998 15:37:04 -0800 (PST)
Received: from hp817.speedware.com (hp817.speedware.com [192.197.116.3]) by sgi.sgi.com (980205.SGI.8.8.8/980301.SGI-antispam) via ESMTP id PAA10620
	for <linux@cthulhu.engr.sgi.com>; Mon, 2 Mar 1998 15:37:03 -0800 (PST)
	env-from (chrisr@hp817.speedware.com)
Received: (from chrisr@localhost)
	by hp817.speedware.com (8.8.5/8.8.5) id SAA07626
	for linux@cthulhu.engr.sgi.com; Mon, 2 Mar 1998 18:37:02 -0500 (EST)
From: "Chris. Rupnik" <chrisr@hp817.speedware.com>
Message-Id: <199803022337.SAA07626@hp817.speedware.com>
Subject: Netbooting Questions
To: linux@cthulhu.engr.sgi.com
Date: Mon, 2 Mar 98 18:37:01 EST
Mailer: Elm [revision: 70.85.2.1]
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi All,
 I am attempting to netboot my MIPS machine. I have bfs running, now i am 
 just looking for something to boot!

 This is what i get on the serial console. Note that the machine is in
 big endian mode.

 Rx4230 MIPS Monitor: Version 5.60 OPT-EB Wed Jun 17 11:23:28 PDT 1992 root

 now, from the instructions that Paul Antoine wrote about a year ago,
 the correct command to boot would be 


 boot -f bfs()_filename_

 ok, so here we go

 >> boot -f bfs()coco       
 No server for coco                                                             
 couldn't load bfs()coco                                                        
 >> 


 That is cool , as there is nothing in the directory called coco

 but, i need a first stage loader, i believe, like the SASH that is 
 installed by RISC/OS. I have access to an SGI Webforce, but it does not
 have any sash on the machine. I also cannot mount the IRIX install cd in
 any other machine. The CD is not in CD9660 format, it appears.

 So , i am looking for a little advice on getting to the next step. If anyone
 has any ideas, please let me know!

 Chris

Received:  by oss.sgi.com id <S305167AbQDPV1H>;
	Sun, 16 Apr 2000 14:27:07 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:58981 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQDPV04>;
	Sun, 16 Apr 2000 14:26:56 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA06720; Sun, 16 Apr 2000 14:22:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA25487
	for linux-list;
	Sun, 16 Apr 2000 14:07:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA79520
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 16 Apr 2000 14:07:39 -0700 (PDT)
	mail_from (engel@math.uni-siegen.de)
Received: from jordan.numerik.math.uni-siegen.de (jordan.numerik.math.uni-siegen.de [141.99.112.9]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02627
	for <linux@cthulhu.engr.sgi.com>; Sun, 16 Apr 2000 14:07:38 -0700 (PDT)
	mail_from (engel@math.uni-siegen.de)
Received: (from engel@localhost) by jordan.numerik.math.uni-siegen.de (Mailhost) id XAA02036 for linux@cthulhu.engr.sgi.com; Sun, 16 Apr 2000 23:12:02 +0200 (MET DST)
From:   Michael Engel <engel@math.uni-siegen.de>
Message-Id: <200004162112.XAA02036@jordan.numerik.math.uni-siegen.de>
Subject: Indigo R3000 PROM calls /
To:     linux@cthulhu.engr.sgi.com
Date:   Sun, 16 Apr 2000 23:12:02 +0200 (MET DST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,

I had some time over the weekend and started to hack on Linux for my
good old R3000 Indigo (oh yeah, I should better try to write drivers
for the PMAG-F and the FDDI adapter in my DECstations but Indigo 
hacking seemed to be more fun ;-)). I can load the kernel from sash 
and it actually starts at kernel_entry (whow) and - no wonder - crashes 
somewhere in init_arch (because I didn't change anything there ...).

Now, it would of course be nice to have some kind of debugging output
early on. Does anyone know if the R3k Indigo has the same ARCS console 
semantics as the Indy ? I.e. there is a PROMBLOCK struct at address 
0xa0001000 (as defined in include/asm-mips/sgiarcs.h) which points to 
romvec which I can then use to dereference PROM functions ? Or is it 
something completely different ? 

Of course, if someone unexpectedly finds some Indigo R3k hardware docs 
somewhere, I'd appreciate it ;).

Best regards,
	Michael Engel	(engel@unix-ag.org)

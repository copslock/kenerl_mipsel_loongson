Received:  by oss.sgi.com id <S305167AbQCBMsq>;
	Thu, 2 Mar 2000 04:48:46 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:6175 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305162AbQCBMs3>;
	Thu, 2 Mar 2000 04:48:29 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA10225; Thu, 2 Mar 2000 04:43:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id EAA51894; Thu, 2 Mar 2000 04:48:27 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA59081
	for linux-list;
	Thu, 2 Mar 2000 04:35:29 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA20606
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 2 Mar 2000 04:35:26 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be ([193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA01495
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Mar 2000 04:35:24 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA28440
	for <linux@cthulhu.engr.sgi.com>; Thu, 2 Mar 2000 13:35:09 +0100 (MET)
Date:   Thu, 2 Mar 2000 13:35:09 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     linux@cthulhu.engr.sgi.com
Subject: get_unaligned
Message-ID: <Pine.GSO.4.10.10003021333520.15323-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


When trying to compile the current CVS kernel, I get (for drivers/usb/hid.c):

| mipsel-linux-gcc -D__KERNEL__ -I/usr/people/geert.nba/linux-mips-20000302/includ e -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r8000 -mips2 -pipe  -mlong-calls -DMODULE   -c -o hid.o hid.c
| {standard input}: Assembler messages:
| {standard input}:4523: Error: opcode requires -mips3 or greater `uld'
| {standard input}:4628: Error: opcode requires -mips3 or greater `uld'

Seems to be caused by get_unaligned() in include/asm-mips/unaligned.h.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

Received:  by oss.sgi.com id <S305167AbQCOPSm>;
	Wed, 15 Mar 2000 07:18:42 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:18759 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCOPSW>; Wed, 15 Mar 2000 07:18:22 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA08676; Wed, 15 Mar 2000 07:21:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA55011
	for linux-list;
	Wed, 15 Mar 2000 07:08:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA73825
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Mar 2000 07:08:48 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA08215
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Mar 2000 07:08:35 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA29813
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Mar 2000 16:08:08 +0100 (MET)
Date:   Wed, 15 Mar 2000 16:08:08 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Error: Branch out of range
Message-ID: <Pine.GSO.4.10.10003151603070.20855-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


I'm trying to compile lmbench on Linux/MIPS(EL). Gcc (egcs-2.90.27 980315
(egcs-1.0.2 release)) complains about

../bin/linux/lat_ctx.s: Assembler messages:
../bin/linux/lat_ctx.s:4293: Error: Branch out of range
../bin/linux/lat_ctx.s:40459: Error: Branch out of range

At line 4293 it jumps to line 40460 using `j', which is obviously further then
32K instructions apart (and incompatible with -KPIC, which is always[*] used).

How can I fix this?

Gr{oetje,eeting}s,

						Geert

[*] Why is MIPS code always compiled PIC?
--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA2606796 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 11:17:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA6466385
	for linux-list;
	Wed, 1 Apr 1998 11:16:40 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA6579907
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 11:16:37 -0800 (PST)
Received: from smtp2.cerf.net (smtp2.cerf.net [192.102.249.31]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id LAA11476
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 11:16:37 -0800 (PST)
	mail_from (bellis@cerf.net)
Received: from maelstrom (maelstrom.cerf.net [198.137.140.16]) by smtp2.cerf.net (8.8.8/8.6.10) with SMTP id LAA01277 for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 11:16:29 -0800 (PST)
Message-ID: <35229292.742E@cerf.net>
Date: Wed, 01 Apr 1998 11:16:34 -0800
From: William Ellis <bellis@cerf.net>
Organization: TCG - CERFNet
X-Mailer: Mozilla 3.01 (X11; I; SunOS 5.5.1 sun4m)
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Challenge-S series, again.
References: <19980401195424.58369@uni-koblenz.de> <Pine.LNX.3.96.980401202424.31891B-100000@web.aec.at> <19980401202840.22363@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I was mucking around trying to get the Challenge S booting
about 2 months ago.  There were problems then since this
machine doesn't have a graphics card.  Just got several
of the latest compiled kernels and still no luck.  Anyone
have a kernel which boots on these machines?  
TIA.  Cheers, Bill


-Looks like it is still probing for graphics.
(output from the 2.1.90 compile -patched)

sash: boot -f /vmlinux
1153264+115552 entry: 0x8800250c

Exception: <vector=Normal>
Status register: 0x10004803<CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0xc000<CE=0,IP8,IP7,EXC=INT>
Exception PC: 0x880ea3c0, Exception RA: 0x880ea730
Interrupt exception
GIO Timeout Interrupt
GIO parity error register: 0x400<TIME>
GIO bus error: address: 0x80000000
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: a8740000 ffffffff 25 2
  tmp: a8740000 0 88009fb0 88107240 88107244 91fffc0c 91fdf390 91fad900
  sve: a8740000 0 0 0 0 0 0 0
  t8 a8740000 t9 0 at 0 v0 0 v1 0 k1 10004801
  gp a8740000 fp 0 sp 0 ra 0

PANIC: Unexpected exception

[Press reset or ENTER to restart.]


^^ At least it catches the error now and doesn't
have to be hard booted.  ;p

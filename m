Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA90566 for <linux-archive@neteng.engr.sgi.com>; Thu, 8 Oct 1998 03:01:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA18631
	for linux-list;
	Thu, 8 Oct 1998 03:00:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA22510
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 8 Oct 1998 02:59:58 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from ruvild.bun.falkenberg.se ([194.236.80.7]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA02737
	for <linux@cthulhu.engr.sgi.com>; Thu, 8 Oct 1998 02:59:56 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (really [130.244.184.3]) by bun.falkenberg.se
	via in.smtpd with smtp (ident grim using rfc1413)
	id <m0zRCvo-002vJBC@ruvild.bun.falkenberg.se> (Debian Smail3.2.0.101)
	for <linux@cthulhu.engr.sgi.com>; Thu, 8 Oct 1998 12:04:24 +0200 (CEST) 
Date: Thu, 8 Oct 1998 12:01:12 +0200 (CEST)
From: Ulf Carlsson <grim@zigzegv.ml.org>
X-Sender: grim@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: R4600PC upgrade
Message-ID: <Pine.LNX.3.96.981008115329.995B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I received a R4600PC today (thanks Lukas), and I happily went to my Indy
and plugged it in instead of my R4000SC. It failed on the diagnostics test
though. 

Exception: <vector=Normal>
Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x4000<CE=0,IP7,EXC=INT>
Exception PC: 0xbfc0b598
Interrupt exception
CPU Parity Error Interrupt
Local I/O interrupt register 1: 0x80 <VR/GIO2>
CPU parity error register: 0x80b<B0,B1,B3,SYSAD_PAR>
CPU parity error: address: 0x1fc0b598
NESTED EXCEPTION #1 at EPC: 9fc3df00; first exception at PC: bfc0b598

I don't have a clue at the moment.

- Ulf

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA15742 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Mar 1999 04:48:01 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA37431
	for linux-list;
	Mon, 8 Mar 1999 04:47:18 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA55575
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 8 Mar 1999 04:47:17 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from penguin.wise.edt.ericsson.se (penguin-ext.wise.edt.ericsson.se [194.237.142.5]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA09338
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Mar 1999 04:47:13 -0800 (PST)
	mail_from (eedthwo@eede.ericsson.se)
Received: from eede.ericsson.se (eede.eede.ericsson.se [164.48.127.16])
	by penguin.wise.edt.ericsson.se (8.9.0/8.9.0/WIREfire-1.2) with SMTP id NAA26671
	for <linux@cthulhu.engr.sgi.com>; Mon, 8 Mar 1999 13:46:57 +0100 (MET)
Received: from sun168.eu (sun168.eede.ericsson.se) by eede.ericsson.se (4.1/SMI-4.1)
	id AA01176; Mon, 8 Mar 99 13:47:03 +0100
Received: by sun168.eu (SMI-8.6/SMI-SVR4)
	id NAA02741; Mon, 8 Mar 1999 13:47:03 +0100
Date: Mon, 8 Mar 1999 13:47:03 +0100
Message-Id: <199903081247.NAA02741@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Tom Woelfel <eedthwo@eede.ericsson.se>
To: "linux@cthulhu.engr.sgi.com Subject":Illegal.f_magic.number.while.install-procedure@eede.ericsson.se
X-Mailer: VM 6.31 under 20.2 XEmacs Lucid
Reply-To: eedthwo@eede.ericsson.se
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

on the last weekend I've started to install linux on my good ol' Indy
(System: IP22; Processor: 100MHz R4000, with FPU). After setting up
bootp/tftp and creating a file-system I was finally ready to boot linux 
over the network. After loading the kernel the system is giving me
these messages:

============================================================
>> boot bootp()/vmlinux
73264+592+11520+331680+27848d+3628+5792 entry: 0x8df9a960
Setting $netaddres to 192.168.1.5 (from server deadmoon)
Obtaining /vmlinux from server deadmoon

Cannot load bootp()/vmlinux
Illegal f_magic number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC.

Exception: <vector=UTLB MISS>
....<More Information>.....
============================================================

Then a message that <return> is rebooting the system appears at the
bottom of the screen.

On server deadmoon I can see:

============================================================
bootp():found 192.168.1.5(sgi)
bootp():bootfile=/export/mipseb/vmlinux
bootp():vendor magic field is 0.0.0.0
bootp():sending reply..

============================================================

I have tried this with the vmlinuv that comes with hardhat, and with
several newer (prebuild) kernels (2.1.131, 990212). The result was
always the same. I guess that this has something todo with magic
numbers ? Is there anyone out there who has seen this before?

(System Configuration: Server running kernel 2.2.2 - connected with
internal net via 10Mbit-Hub).

Any hints welcome,
Tom

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id CAA1167635 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Dec 1997 02:08:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA05351 for linux-list; Fri, 12 Dec 1997 02:07:36 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA05344 for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 02:07:30 -0800
Received: from otto.artcom.de (schleuse-inx-bt.artcom.de [195.21.176.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id CAA04833
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Dec 1997 02:07:28 -0800
	env-from (NOSPAMkaro@artcom.net)
Received: from artcom.net by otto.artcom.de with smtp
	id m0xgRxV-00AbvbC; Fri, 12 Dec 97 11:04 MET
Message-ID: <34910C34.DFF48AD3@artcom.net>
Date: Fri, 12 Dec 1997 11:04:37 +0100
From: Benjamin Pannier <NOSPAMkaro@artcom.net>
Reply-To: karo@artcom.net
Organization: ART+COM
X-Mailer: Mozilla 4.04 [en] (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: ralf@uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Indy crash during bootup
References: <19971208150602.52582@brian.uni-koblenz.de> <ralf@uni-koblenz.de> <9712091934.ZM3116@mdhill.interlog.com> <19971210040210.27443@uni-koblenz.de> <9712110612.ZM1219@mdhill.interlog.com> <19971212033448.01867@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de wrote:
 
> Hmm...  I just noticed in Benjamin's startup messages that his machine
> doesn't print a message (``Enabling R4600 SCACHE'') about activating the
> second level cache.  I bet both your and Benjamin's machines don't have
> second level caches.  Could you check the hinv output, please?

yes, that's right. That machine do not have a second level chache:

Iris Audio Processor: version A2 revision 4.1.0
1 133 MHZ IP22 Processor
FPU: MIPS R4600 Floating Point Coprocessor Revision: 2.0
CPU: MIPS R4600 Processor Chip Revision: 2.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Main memory size: 128 Mbytes
Vino video: unit 0, revision 0, IndyCam connected
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
  Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 24-bit

-ben


-- 
  __/__/__/\ Benjamin Pannier,ART+COM GmbH,BudapesterStr44,D-10787Berlin
 __/__/__/\/ Tel:(+49-30)25417-3 Fax:(+49-30)25417-555
__/__/__/\/ Email:karo@artcom.net WWW:http://www.artcom.net/~karo/ 
__\__\__\/ Email:karo@artcom.org me@karo.org i.am@ka.ro karo@artcom.de

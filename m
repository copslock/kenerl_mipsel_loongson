Received:  by oss.sgi.com id <S305188AbQAEUBv>;
	Wed, 5 Jan 2000 12:01:51 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:4718 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305186AbQAEUBb>;
	Wed, 5 Jan 2000 12:01:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09736; Wed, 5 Jan 2000 12:01:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA27411
	for linux-list;
	Wed, 5 Jan 2000 11:25:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA09856
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Jan 2000 11:25:32 -0800 (PST)
	mail_from (lsmith@systemdynamix.com)
Received: from pcnet1.pcnet.com (pcnet1.pcnet.com [204.213.232.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA06253
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 11:25:25 -0800 (PST)
	mail_from (lsmith@systemdynamix.com)
Received: from sgi320 (pm3-pt26.pcnet.net [206.105.29.100])
	by pcnet1.pcnet.com (8.8.7/PCNet) with SMTP id OAA20072
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 14:23:56 -0500 (EST)
From:   "Len Smith" <lsmith@systemdynamix.com>
To:     <linux@cthulhu.engr.sgi.com>
Subject: SGI320/Linux - Zip Drive and COM port.
Date:   Wed, 5 Jan 2000 14:25:07 -0500
Message-ID: <LOBBKIACINGIEBKLGDKHMEIKCEAA.lsmith@systemdynamix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I am attempting to deal with several issues with RH 6.0 Linux (2.2.10) on
the SGI Visual Workstation that I am unable to resolve.  I am sure that the
resolutions are quite simple, but I have tried the HOWTO route and asked
others without success.  Normally I am reluctant to seek help, opting to
work the problem out for myself, but I seem unable to do so in this case.

First, I recently installed an SGI supplied IOMEGA ZIP-100 into floppy bay
#2 on the VWS.  It installed easily and it works correctly under NT.  It is
recognized by Linux as "hdd" on the third probe during boot.  I am unable to
mount the device.  The HOWTOs reference SCSI drives (this is an IDE, I
believe) or parallel-attached devices.  So I can't find support assistance
for internal drives.  Do you have any guidance in this area?

Also, I am having difficulty accessing COM1 on the VWS.  I get an error on
"setserial -g /dev/ttys0" or "/dev/cua0" under root.  Both devices are
present and seem to be correct.  The port works correctly under NT.  If I
try "setserial auto_irq skip_test autoconfig" I receive a "device not found"
error.  If you have guidance here I would be grateful as well.

I thank your for your time.

Regards,

Len Smith
lsmith@systemdynamix.com

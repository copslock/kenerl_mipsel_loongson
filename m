Received:  by oss.sgi.com id <S305190AbQAFLzv>;
	Thu, 6 Jan 2000 03:55:51 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:51488 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305189AbQAFLza>;
	Thu, 6 Jan 2000 03:55:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA12998; Thu, 6 Jan 2000 03:51:57 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA22261
	for linux-list;
	Thu, 6 Jan 2000 03:42:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA36250
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Jan 2000 03:42:48 -0800 (PST)
	mail_from (lsmith@systemdynamix.com)
Received: from pcnet1.pcnet.com (pcnet1.pcnet.com [204.213.232.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA08051
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Jan 2000 03:42:47 -0800 (PST)
	mail_from (lsmith@systemdynamix.com)
Received: from sgi320 (pm3-pt79.pcnet.net [206.105.29.153])
	by pcnet1.pcnet.com (8.8.7/PCNet) with SMTP id GAA14006;
	Thu, 6 Jan 2000 06:42:41 -0500 (EST)
From:   "Len Smith" <lsmith@systemdynamix.com>
To:     <linux@cthulhu.engr.sgi.com>
Cc:     <david@cantrell.org.uk>
Subject: RE: SGI320/Linux - Zip Drive and COM port.
Date:   Thu, 6 Jan 2000 06:43:52 -0500
Message-ID: <LOBBKIACINGIEBKLGDKHCEJBCEAA.lsmith@systemdynamix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <LOBBKIACINGIEBKLGDKHMEIKCEAA.lsmith@systemdynamix.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I'd like to thank all of you for your support, especially David Cantrell
(who is at home).

The solution was pretty apparent; I just didn't take advantage of it.  The
SGI320 VWS has proprietary hardware and while the base Red Hat 6.0 will work
with the kernel obtained from the SGI Linux (www.linux.sgi.com) site it also
requires that the 2.2.5-xx source be patched and rebuilt.  The patch
corrects issues with the sound, COM ports and if you enable it SCSI
emulation for the internal IDE ZIP Drive.  So, I:

1. Downloaded the 2.2.10 tarball
2. Downloaded the VWS patch from the SGI Linux Intel site
3. Created duplicate directories under /usr/src named linux.2210 and
linux.2210.vw, both containing exact copies of 2.2.10.
4. Ran the patch "patch -p0 < visws_2210_28jul99.patch from /usr/src
5. Visually verified that the directory linux.2210 was updated (look at what
the patch does, then look for the changes)
6. make dep
7. make clean
8. make menuconfig (or whatever config your prefer)
9. Be sure to use at least the settings from the SGI site for the kernel -
otherwise danger lurks
10. Make sure the SGI Sound is on
11. SCSI emulation
12. make vmlinux (that's right, not zImage)
13. make modules
14. make modules_install
15. ln -s /usr/src/linux.2210 /usr/src/linux
16. ln -s /usr/src/linux.2210/System.map /boot/System.map
17. Copy the vmlinux image to your SGI FAT boot partition.
18. Make a new boot selection to point to the new kernel.
19. Boot and Enjoy.

The corrected the COM issue and the SCSI emulation found the ZIP as hdd4 and
everything works okay! Thanks again for everyone's help.

-----Original Message-----
From: Len Smith [mailto:lsmith@systemdynamix.com]
Sent: Wednesday, January 05, 2000 2:25 PM
To: linux@cthulhu.engr.sgi.com
Subject: SGI320/Linux - Zip Drive and COM port.

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

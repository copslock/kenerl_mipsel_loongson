Received:  by oss.sgi.com id <S305188AbQAEVGN>;
	Wed, 5 Jan 2000 13:06:13 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32102 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305186AbQAEVF5>; Wed, 5 Jan 2000 13:05:57 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA03310; Wed, 5 Jan 2000 13:08:51 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA82354
	for linux-list;
	Wed, 5 Jan 2000 12:58:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA57044
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Jan 2000 12:57:56 -0800 (PST)
	mail_from (bercovic@swi.psy.uva.nl)
Received: from swi.psy.uva.nl (swi.psy.uva.nl [145.18.114.14]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06619
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 12:56:53 -0800 (PST)
	mail_from (bercovic@swi.psy.uva.nl)
Received: from localhost (bercovic@localhost)
	by swi.psy.uva.nl (8.9.3/8.9.3) with ESMTP id VAA02332;
	Wed, 5 Jan 2000 21:56:22 +0100 (MET)
Date:   Wed, 5 Jan 2000 21:56:22 +0100 (MET)
From:   Avi Bercovich <bercovic@swi.psy.uva.nl>
X-Sender: bercovic@swi
To:     Len Smith <lsmith@systemdynamix.com>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: SGI320/Linux - Zip Drive and COM port.
In-Reply-To: <LOBBKIACINGIEBKLGDKHMEIKCEAA.lsmith@systemdynamix.com>
Message-ID: <Pine.GSO.4.05.10001052151240.2274-100000@swi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi Len,

With regard to your ZIP trouble, you might want to try and mounting a
_partition_ on the zip drive, not the whole drive itself...

If the zip is formatted with winXX you might want to try the following as
root:

mount -t vfat /dev/hdd4 /mnt

this will mount the vfat formatted partition nr 4 on the currently loaded
zip-disk on the /mnt directory entry. For some reason, winXX formatted
disks are set to partition 4.

hope this helps,

avi bercovich

--------------------------------------------------------------------------
Avi Bercovich                                      bercovic@swi.psy.uva.nl
Sinjeur Semeynsstraat 9          Dept. of Social Science Informatics (SWI)
1183LD Amstelveen                                  University of Amsterdam     

On Wed, 5 Jan 2000, Len Smith wrote:

> I am attempting to deal with several issues with RH 6.0 Linux (2.2.10) on
> the SGI Visual Workstation that I am unable to resolve.  I am sure that the
> resolutions are quite simple, but I have tried the HOWTO route and asked
> others without success.  Normally I am reluctant to seek help, opting to
> work the problem out for myself, but I seem unable to do so in this case.
> 
> First, I recently installed an SGI supplied IOMEGA ZIP-100 into floppy bay
> #2 on the VWS.  It installed easily and it works correctly under NT.  It is
> recognized by Linux as "hdd" on the third probe during boot.  I am unable to
> mount the device.  The HOWTOs reference SCSI drives (this is an IDE, I
> believe) or parallel-attached devices.  So I can't find support assistance
> for internal drives.  Do you have any guidance in this area?
> 
> Also, I am having difficulty accessing COM1 on the VWS.  I get an error on
> "setserial -g /dev/ttys0" or "/dev/cua0" under root.  Both devices are
> present and seem to be correct.  The port works correctly under NT.  If I
> try "setserial auto_irq skip_test autoconfig" I receive a "device not found"
> error.  If you have guidance here I would be grateful as well.
> 
> I thank your for your time.
> 
> Regards,
> 
> Len Smith
> lsmith@systemdynamix.com
> 
> 
> 

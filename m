Received:  by oss.sgi.com id <S305158AbPK3T51>;
	Tue, 30 Nov 1999 11:57:27 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4668 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbPK3T5P>; Tue, 30 Nov 1999 11:57:15 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA05205; Tue, 30 Nov 1999 12:05:32 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA65463
	for linux-list;
	Tue, 30 Nov 1999 11:52:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA66544
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 Nov 1999 11:52:34 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from the-village.bc.nu (lightning.swansea.uk.linux.org [194.168.151.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA00452
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 Nov 1999 11:52:32 -0800 (PST)
	mail_from (alan@lxorguk.ukuu.org.uk)
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 11stJm-0007Bd-00; Tue, 30 Nov 1999 19:52:06 +0000
Subject: Re: EXT2 fs error
To:     marc@mucom.co.il (Marc Esipovich)
Date:   Tue, 30 Nov 1999 19:52:04 +0000 (GMT)
Cc:     e1097757@ceng.metu.edu.tr, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.4.10.9911291959150.2898-100000@moose.roadkill.com> from "Marc Esipovich" at Nov 29, 99 08:03:06 pm
Content-Type: text
Message-Id: <E11stJm-0007Bd-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> Hardware problem, probably your disk, it's called a bad-sector ;)

If there is a scsi error before the ext2fs error then yes probably so
You are looking for a "media error" probably.

> > 	SCSI bus is being reset for 0 channel 0.
> > 	scsi0 reset. sending SDTR
> 
> SCSI reset is due to repeated attempts to read a block, or I might be
> wrong and it it's due to a malfunction of the controller on your HD.

You can get it off some working sane hardware if you try and ask for stupid
block numbers. It is worth doing a full fsck on the drive before assuming
hardware. Also check the cabling seems sound and is well attached and that
parity is enabled on the controller if the bios sets it.

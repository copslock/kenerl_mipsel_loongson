Received:  by oss.sgi.com id <S305156AbPK3S0g>;
	Tue, 30 Nov 1999 10:26:36 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:13090 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbPK3S0O>;
	Tue, 30 Nov 1999 10:26:14 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA16167; Tue, 30 Nov 1999 10:28:51 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA77980
	for linux-list;
	Tue, 30 Nov 1999 10:03:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA31303
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 Nov 1999 10:03:32 -0800 (PST)
	mail_from (marc@mucom.co.il)
Received: from MaX.ibm.net.il (MaX.IbM.NeT.iL [192.115.72.170]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00890
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 Nov 1999 10:03:28 -0800 (PST)
	mail_from (marc@mucom.co.il)
Received: from host13.mucom.co.il (IDENT:marc@host13.mucom.co.il [192.115.216.45])
	by MaX.ibm.net.il (8.9.3/8.9.1) with ESMTP id UAA127172;
	Tue, 30 Nov 1999 20:03:07 +0200
Date:   Mon, 29 Nov 1999 20:03:06 +0200 (IST)
From:   Marc Esipovich <marc@mucom.co.il>
X-Sender: marc@moose.roadkill.com
To:     SERTKAYA BARIS <e1097757@ceng.metu.edu.tr>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: EXT2 fs error
In-Reply-To: <199911301637.SAA17580@mendelson.ceng.metu.edu.tr>
Message-ID: <Pine.LNX.4.10.9911291959150.2898-100000@moose.roadkill.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> 
> 	Hi,

Hi.

> 	While running updatedb from crontab, my Indy crashed with the 
> 	following errors.It became OK when I booted it.What can be the
> 	reason?
> 

Hardware problem, probably your disk, it's called a bad-sector ;)

> 	...
> 	EXT2-fs error (device 08:11) ext2_free blocks: Freeing blocks not in
> 	datazone - block = ...., count=1
> 	EXT2-fs error (device 08:11): ext2_readdir: bad entry in directory
> 	#... :directory entry across blocks - ...
> 	scsi0 channel 0 : resetting for second half of entries.
> 	SCSI bus is being reset for 0 channel 0.
> 	scsi0 reset. sending SDTR
> 

SCSI reset is due to repeated attempts to read a block, or I might be
wrong and it it's due to a malfunction of the controller on your HD.

> 	thanx in advance,
> 	           baris.
> 

Get some newer hardware,  I'd suggest running the 'badblocks' utility.


        Marc Esipovich.

--
root is only a few clicks away...

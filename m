Received:  by oss.sgi.com id <S305156AbPLCNAJ>;
	Fri, 3 Dec 1999 05:00:09 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:16456 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305157AbPLCM7t>;
	Fri, 3 Dec 1999 04:59:49 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA06548; Fri, 3 Dec 1999 05:06:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA44699
	for linux-list;
	Fri, 3 Dec 1999 04:55:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA87336
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Dec 1999 04:55:06 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00696
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Dec 1999 04:54:47 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLCMup>;
	Fri, 3 Dec 1999 10:50:45 -0200
Date:   Fri, 3 Dec 1999 10:50:45 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     Marc Esipovich <marc@mucom.co.il>, e1097757@ceng.metu.edu.tr,
        linux@cthulhu.engr.sgi.com
Subject: Re: EXT2 fs error
Message-ID: <19991203105045.B982@uni-koblenz.de>
References: <Pine.LNX.4.10.9911291959150.2898-100000@moose.roadkill.com> <E11stJm-0007Bd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <E11stJm-0007Bd-00@the-village.bc.nu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Nov 30, 1999 at 07:52:04PM +0000, Alan Cox wrote:

> If there is a scsi error before the ext2fs error then yes probably so
> You are looking for a "media error" probably.
> 
> > > 	SCSI bus is being reset for 0 channel 0.
> > > 	scsi0 reset. sending SDTR
> > 
> > SCSI reset is due to repeated attempts to read a block, or I might be
> > wrong and it it's due to a malfunction of the controller on your HD.
> 
> You can get it off some working sane hardware if you try and ask for stupid
> block numbers. It is worth doing a full fsck on the drive before assuming
> hardware. Also check the cabling seems sound and is well attached and that
> parity is enabled on the controller if the bios sets it.

I've seen this happening on my Indy as well like once every month or even
more rarely.  It only happens very rarely but it happens.  I think the
hardware of my Indy is fine as all my attempts to reduce the problems I'm
experiencing during my development to a hardware problem have failed.

  Ralf

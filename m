Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA80386 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 22:48:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA56322
	for linux-list;
	Tue, 16 Feb 1999 22:46:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA95588
	for <linux@engr.sgi.com>;
	Tue, 16 Feb 1999 22:46:32 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id WAA04560
	for <linux@engr.sgi.com>; Tue, 16 Feb 1999 22:46:32 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 7876 invoked from network); 17 Feb 1999 06:56:28 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 17 Feb 1999 06:56:28 -0000
Message-ID: <36CA652D.5A165E86@rigelfore.com>
Date: Tue, 16 Feb 1999 22:43:57 -0800
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <199902170627.WAA09135@kilimanjaro.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

drats... that's the kernel (er, one of the kernels) that hangs on
"freeing unused kernel memory" for me :(

-E

> So, I've had an old Indy in my office, waiting for me to try installing
> Linux on in my spare time, and today I finally got around to it. Lucky
> for me I didn't try before today, because the kernel that finally worked
> was the very latest, vmlinux-indy-990212.
> 
> After the one in the big hardhat tar.gz file didn't work (no R4400SC
> support) I hit the mailing list archive, found the pointer to
> vmlinux-2.1.131 (which didn't work because it didn't have NFS), noticed
> also vmlinux-sc-indy-2.1.116 (also didn't work, probably also no NFS),
> and tried a couple of others while going through the archive.
> vmlinux-indy-990205 got a little farther, but complained it couldn't
> make a device node in the ram disk or some such thing.
> 
> Anyway, vmlinux-indy-990212 was the winner: it booted up into the
> installer, I was able to do a complete install (ignoring swap, as web
> page says), and it's up and running. I'm sending this out to let those
> who've been having trouble with Indy/R4400SC know that it can be done
> now!

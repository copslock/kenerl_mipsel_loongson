Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA37273 for <linux-archive@neteng.engr.sgi.com>; Sat, 20 Feb 1999 02:10:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA18621
	for linux-list;
	Sat, 20 Feb 1999 02:10:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA43951
	for <linux@engr.sgi.com>;
	Sat, 20 Feb 1999 02:10:40 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id CAA00596
	for <linux@engr.sgi.com>; Sat, 20 Feb 1999 02:10:39 -0800 (PST)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 10426 invoked from network); 20 Feb 1999 10:23:10 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 20 Feb 1999 10:23:10 -0000
Message-ID: <36CE8980.47C9A6A0@rigelfore.com>
Date: Sat, 20 Feb 1999 02:08:00 -0800
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: able to bootp/NFS-install/reboot R4400SC Indy
References: <199902170714.XAA09589@kilimanjaro.engr.sgi.com> <36CBB931.D552C44@rigelfore.com> <19990220015251.A3878@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

the file system came straight from hardhat. it all appears to be normal,
and the indy appears to mount the nfs root just fine. the system
exporting nfs is an x86 linux box.

-E

> I doubt, that your problem is clock rate related. What does your
> NFS root look like. Are you using the HardHat root filesystem ?
> What type of NFS box are you using ?

Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id VAA11929
	for <pstadt@stud.fh-heilbronn.de>; Sun, 18 Jul 1999 21:32:44 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA05626; Sun, 18 Jul 1999 12:28:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA74071
	for linux-list;
	Sun, 18 Jul 1999 12:22:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA76424
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 18 Jul 1999 12:22:31 -0700 (PDT)
	mail_from (m_thrope@rigelfore.com)
Received: from slug.rigelfore.com (c69494-a.plstn1.sfba.home.com [24.2.21.88]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id MAA05027
	for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jul 1999 12:22:30 -0700 (PDT)
	mail_from (m_thrope@rigelfore.com)
Received: (qmail 13651 invoked from network); 18 Jul 1999 19:35:29 -0000
Received: from unknown (HELO rigelfore.com) (192.168.42.2)
  by 192.168.42.1 with SMTP; 18 Jul 1999 19:35:29 -0000
Message-ID: <37922879.C3136AE3@rigelfore.com>
Date: Sun, 18 Jul 1999 12:18:17 -0700
From: Eric Melville <m_thrope@rigelfore.com>
Organization: iLL
X-Mailer: Mozilla 4.5 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: sgi <linux@cthulhu.engr.sgi.com>
Subject: Re: 200mhz indy
References: <3773BD69.DF77FC27@rigelfore.com> <19990628131216.C735@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

ok, this morning i successfully booted my r4400 rev. 6.0 indy! thanks
for the help... but now i've got a problem installing it. i'm a little
low on disk space for the whole hardhat archive. i was thinking i could
dump the rpms to a cd and then hook me external scsi cdrom to the indy,
however the root fs for hardhat setup seems to be missing mount, plus i
don't know if the redhat installer can be "tricked" like that (i have NO
redhat experience).

-E

> > i have an r4400 revision 6 200mhz indy. i tried to get linux working at
> > about the time the 2.2.1 kernel was released, but it wouldn't go. any
> > chance i'd have better luck now?
> 
> Yes, we've fixed a bug freeing memory used by the PROMs and I'm almost
> certain that this bug caused your 6.0 machine to freeze.
> 
> Iff that still doesn't help, could you do some experiment for me?  I want
> to know if the problem is really related to the CPU version 6.0 and you
> seem to have multiple Indys.  Could just try and put the R4400 6.0 module
> into the Indy which seems to be fine with Linux and report your findings?

Received:  by oss.sgi.com id <S305162AbQAZPkr>;
	Wed, 26 Jan 2000 07:40:47 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:1383 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbQAZPkS>;
	Wed, 26 Jan 2000 07:40:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA24557; Wed, 26 Jan 2000 07:38:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA41634
	for linux-list;
	Wed, 26 Jan 2000 07:30:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA93447
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 26 Jan 2000 07:30:29 -0800 (PST)
	mail_from (MMartin@Consorta.com)
Received: from mercury.consorta.com (mail.consorta.com [12.19.168.147]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA04083
	for <linux@cthulhu.engr.sgi.com>; Wed, 26 Jan 2000 07:30:19 -0800 (PST)
	mail_from (MMartin@Consorta.com)
Received: by mercury.consorta.com with Internet Mail Service (5.5.2448.0)
	id <D4TQA995>; Wed, 26 Jan 2000 09:29:58 -0600
Message-ID: <5765516FA06ED211881200A0C9D91D9535BEF5@mercury.consorta.com>
From:   "Martin, Mark" <MMartin@consorta.com>
To:     "Mips linux email address (E-mail)" <linux@cthulhu.engr.sgi.com>
Subject: ec3 and the wd33c95 controllers
Date:   Wed, 26 Jan 2000 09:29:58 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

It's probably been asked enough to be a FAQ, but I'm interested in running
linux on my challenge-s.  I do have an Indy, but would rather host
development (if I'm able to contribute any) off of my sparc or i386 linux
boxen.  I'd set up a network boot for the challenge-s, but it's useless to
me without the wide scsi or ec3 support.  I, of course, don't have the
development tools for Irix, which is why I'm so intent on getting linux
running on the challenge-s (to get gcc/egcs and a decent dev environ).
 
So my question?  Where can I begin?  Checking cvs, there isn't any start to
the wd33c95 controller, and I've no idear where to start with that.  I
haven't looked for the start of an ec3 driver, but I suspect that's also a
no go.  I'd like to contribute as much as I can, with the limited knowledge
I have of hardware programming.  I'm sure I can fake it if I need to, though
(#^).
 
 

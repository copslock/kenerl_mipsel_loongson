Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA83261 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 May 1999 04:03:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA56900
	for linux-list;
	Thu, 27 May 1999 04:01:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA88782
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 May 1999 04:01:29 -0700 (PDT)
	mail_from (pete@alien.bt.co.uk)
Received: from mail.alien.bt.co.uk (orb.alien.bt.co.uk [132.146.196.84]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id EAA09136
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 04:01:28 -0700 (PDT)
	mail_from (pete@alien.bt.co.uk)
Received: from cornfed(really [132.146.196.81]) by mail.alien.bt.co.uk
	via sendmail with smtp
	id <m10mxoK-001kwNC@mail.alien.bt.co.uk>
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 11:54:52 +0100 (BST)
	(Smail-3.2 1996-Jul-4 #3 built 1998-May-29)
Message-Id: <m10mxoK-001kwNC@mail.alien.bt.co.uk>
Date: Thu, 27 May 1999 11:55:32 +0100 (BST)
From: Pete Young <pete@alien.bt.co.uk>
Reply-To: Pete Young <pete@alien.bt.co.uk>
Subject: X server update, observations on a successful installation
To: linux@cthulhu.engr.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: eAjbW/JLKWO8/RPbUS2JLw==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 i86pc i386 
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Dear gurus,

I'd like to report a successful installation from the 5.1 distribution on a
Indy with 2 disks, building Linux on the second disk with no swap,
using the 2.2.1 version of the kernel dated 29 March 1999 from the test
directory.

Since we don't have bootp working (don't ask!) I put the vmlinux file on
the Irix file system and booted that from the sash prompt, using an
intel linux machine as an nfs server for the distribution.

Everything was fine once I used the ip kernel option to turn off
autoconfig. There's nothing about this in the notes but I figured it
out with some help from my colleagues. 

Something I note is that two routes were set up to the local subnet:
(at least according to the output of netstat -r)
Apparently you no longer need to do this by hand with kernels version 2.2.*
- this appears to happen in /etc/sysconfig/network-scripts/ifup .

Also, the default installation for portmap and ypbind starts them up in 
the wrong order: I gather this is a standard RedHat error?

Anyway, these are minor gripes not related to the HardHat distribution,
and the box rocks. However, not having an X-server is a bit painful.
I'm a bit confused about what is actually available: there seem to be
lots of x applications, XFree86 and so on in the RPMS directory, so
what's missing? A frame buffer?

Can anyone reading this give me an update on the likely availability of
the XServer? I'm not savvy enough to contribute to the code,
but I can now volunteer to beta-test it.

If you're still with me, I'd like to congratulate everyone involved in
the porting effort on doing an excellent job. Nice one!

Kind regards,

Pete


  ____________________________________________________________________
  Pete Young          pete@alien.bt.co.uk        Phone +44 1473 642740
      "Just another crouton, floating on the bouillabaisse of life"

Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id JAA09154
	for linuxmips-outgoing; Tue, 26 Oct 1999 09:56:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id JAA09150
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 09:56:26 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA4615067
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 10:00:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA17345
	for linux-list;
	Tue, 26 Oct 1999 09:35:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA28600
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Oct 1999 09:35:25 -0700 (PDT)
	mail_from (pete@alien.bt.co.uk)
Received: from mail.alien.bt.co.uk (orb.alien.bt.co.uk [132.146.196.84]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id JAA4512841
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Oct 1999 09:35:01 -0700 (PDT)
	mail_from (pete@alien.bt.co.uk)
Received: from cornfed(really [132.146.196.81]) by mail.alien.bt.co.uk
	via sendmail with smtp
	id <m11g9Yj-001kxeC@mail.alien.bt.co.uk>
	for <linux@cthulhu.engr.sgi.com>; Tue, 26 Oct 1999 17:34:53 +0100 (BST)
	(Smail-3.2 1996-Jul-4 #4 built 1999-Oct-11)
Message-Id: <m11g9Yj-001kxeC@mail.alien.bt.co.uk>
Date: Tue, 26 Oct 1999 17:31:37 +0100 (BST)
From: Pete Young <pete@alien.bt.co.uk>
Reply-To: Pete Young <pete@alien.bt.co.uk>
Subject: Hardhat 5.1, wu-ftpd problems
To: linux@cthulhu.engr.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: ZTYNFHK72hVnG6yqou6ekw==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 i86pc i386 
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

Having proved that I have a stable-ish Indy with Hardhat 5.1, kernel
version 2.2.1 , i thought I might put it to work as an ftp server
for part of our internal mirror system.

Installed the rpms for anonftp and wu-ftpd from our mirror of the
latest distribution, but found we got some odd behavior from the
ftp daemon: it was quite happy for people using the Solaris 2.6
client, but using the BSD client or the netscape client I see no
files or directories (although it is possible to move about
the directory structure if you know what the subdirectories are
called).

I also built a more-up-to-date version of wu-ftpd (version 2.5.0
with QUOTAS disabled) but the same thing seems to be happening.

Is this a known problem, and if so is there a fix?

Kind regards,

Pete

  ____________________________________________________________________
  Pete Young          pete@alien.bt.co.uk        Phone +44 1473 642740
      "Just another crouton, floating on the bouillabaisse of life"

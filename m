Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA62435 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Jun 1998 10:24:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA51950
	for linux-list;
	Sun, 14 Jun 1998 10:24:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA97209
	for <linux@engr.sgi.com>;
	Sun, 14 Jun 1998 10:24:17 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id KAA21484
	for <linux@engr.sgi.com>; Sun, 14 Jun 1998 10:23:57 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-29.uni-koblenz.de [141.26.249.29])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id TAA07605
	for <linux@engr.sgi.com>; Sun, 14 Jun 1998 19:23:51 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA07563;
	Sun, 14 Jun 1998 19:23:46 +0200
Message-ID: <19980614192346.B7551@uni-koblenz.de>
Date: Sun, 14 Jun 1998 19:23:46 +0200
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: ssh binaries
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I've uploaded ssh binaries, both big endian and little endian,
international and us-damaged (read: rsaref) versions to
ftp.replay.com:/pub/crypto/incoming/.  The binaries are probably
somewhen going to be moved to their final place.

  Ralf

-rw-r--r--   1 usura    crypto      75619 Jun 14 16:39 ssh-1.2.25-1i.mipseb.rpm
-rw-r--r--   1 usura    crypto     169412 Jun 14 17:00 ssh-1.2.25-1i.mipsel.rpm
-rw-r--r--   1 usura    crypto      75499 Jun 14 17:02 ssh-1.2.25-1us.mipseb.rpm-rw-------   1 usura    crypto     169216 Jun 14 17:13 ssh-1.2.25-1us.mipsel.rpm-rw-r--r--   1 usura    crypto     237156 Jun 14 16:41 ssh-clients-1.2.25-1i.mipseb.rpm
-rw-r--r--   1 usura    crypto     237981 Jun 14 17:04 ssh-clients-1.2.25-1i.mipsel.rpm
-rw-r--r--   1 usura    crypto     246165 Jun 14 17:03 ssh-clients-1.2.25-1us.mipseb.rpm
-rw-------   1 usura    crypto     246256 Jun 14 17:16 ssh-clients-1.2.25-1us.mipsel.rpm
-rw-r--r--   1 usura    crypto      20327 Jun 14 16:41 ssh-extras-1.2.25-1i.mipseb.rpm
-rw-r--r--   1 usura    crypto      22981 Jun 14 17:04 ssh-extras-1.2.25-1i.mipsel.rpm
-rw-r--r--   1 usura    crypto      20361 Jun 14 17:04 ssh-extras-1.2.25-1us.mipseb.rpm
-rw-r--r--   1 usura    crypto      20361 Jun 14 17:04 ssh-extras-1.2.25-1us.mipseb.rpm
-rw-------   1 usura    crypto      23147 Jun 14 17:16 ssh-extras-1.2.25-1us.mipsel.rpm
-rw-r--r--   1 usura    crypto     123987 Jun 14 16:42 ssh-server-1.2.25-1i.mipseb.rpm
-rw-------   1 usura    crypto     126500 Jun 14 17:09 ssh-server-1.2.25-1i.mipsel.rpm
-rw-r--r--   1 usura    crypto     129127 Jun 14 17:05 ssh-server-1.2.25-1us.mipseb.rpm
-rw-------   1 usura    crypto     131265 Jun 14 17:17 ssh-server-1.2.25-1us.mipsel.rpm

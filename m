Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA31602
	for <pstadt@stud.fh-heilbronn.de>; Mon, 28 Jun 1999 23:46:21 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02278; Mon, 28 Jun 1999 14:42:48 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA12930
	for linux-list;
	Mon, 28 Jun 1999 14:39:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA38143
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Jun 1999 14:39:03 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01518
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Jun 1999 14:39:01 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-26.uni-koblenz.de [141.26.131.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA20491
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Jun 1999 23:38:50 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id NAA00876;
	Mon, 28 Jun 1999 13:12:16 +0200
Date: Mon, 28 Jun 1999 13:12:16 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Eric Melville <m_thrope@rigelfore.com>
Cc: sgi <linux@cthulhu.engr.sgi.com>
Subject: Re: 200mhz indy
Message-ID: <19990628131216.C735@uni-koblenz.de>
References: <3773BD69.DF77FC27@rigelfore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3773BD69.DF77FC27@rigelfore.com>; from Eric Melville on Fri, Jun 25, 1999 at 10:33:29AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 25, 1999 at 10:33:29AM -0700, Eric Melville wrote:

> i have an r4400 revision 6 200mhz indy. i tried to get linux working at
> about the time the 2.2.1 kernel was released, but it wouldn't go. any
> chance i'd have better luck now?

Yes, we've fixed a bug freeing memory used by the PROMs and I'm almost
certain that this bug caused your 6.0 machine to freeze.

Iff that still doesn't help, could you do some experiment for me?  I want
to know if the problem is really related to the CPU version 6.0 and you
seem to have multiple Indys.  Could just try and put the R4400 6.0 module
into the Indy which seems to be fine with Linux and report your findings?

(Swapping a CPU module is easy with Indys, SGI did nice work on that.)

  Ralf

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA87189 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 03:36:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA31059
	for linux-list;
	Fri, 26 Jun 1998 03:35:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA33296
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 03:35:31 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id DAA21402
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 03:35:27 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA16709
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 12:35:18 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id MAA02309;
	Fri, 26 Jun 1998 12:35:08 +0200
Message-ID: <19980626123507.B570@uni-koblenz.de>
Date: Fri, 26 Jun 1998 12:35:07 +0200
To: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>,
        linux@cthulhu.engr.sgi.com
Subject: Re: ssh binaries
References: <19980614192346.B7551@uni-koblenz.de> <19980627015217.A454@helix.life.nthu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980627015217.A454@helix.life.nthu.edu.tw>; from Francis M. J. Hsieh on Sat, Jun 27, 1998 at 01:52:17AM +0800
X-Mutt-References: <19980627015217.A454@helix.life.nthu.edu.tw>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jun 27, 1998 at 01:52:17AM +0800, Francis M. J. Hsieh wrote:

> On Sun, Jun 14, 1998 at 07:23:46PM +0200, ralf@uni-koblenz.de wrote:
> > I've uploaded ssh binaries, both big endian and little endian,
> > international and us-damaged (read: rsaref) versions to
> > ftp.replay.com:/pub/crypto/incoming/.  The binaries are probably
> > somewhen going to be moved to their final place.
> 
>   I am sorry if it was discussed before. I can't install the client
> and server, rpm told me "libz.so.1" needed even if I downloaded the
> actual file libz.so.1 from ftp.linux.sgi.com.
> 
> How can I fix it up? Thanx for your help.

Just dowloading the libz.so.1 file won't do the job, you should get the
zlib package and install it, it's apparently missing from your system.

  Ralf

Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA04982
	for <pstadt@stud.fh-heilbronn.de>; Fri, 1 Oct 1999 23:45:23 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA04144; Fri, 1 Oct 1999 14:43:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA05991
	for linux-list;
	Fri, 1 Oct 1999 14:35:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA05405
	for <linux@engr.sgi.com>;
	Fri, 1 Oct 1999 14:35:13 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA4838393
	for <linux@engr.sgi.com>; Fri, 1 Oct 1999 14:35:08 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-25.uni-koblenz.de [141.26.131.25])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA21209
	for <linux@engr.sgi.com>; Fri, 1 Oct 1999 23:35:03 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA01638;
	Fri, 1 Oct 1999 23:33:21 +0200
Date: Fri, 1 Oct 1999 23:33:21 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Dave Airlie <airlied@csn.ul.ie>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: CVS move finished
Message-ID: <19991001233321.B1231@uni-koblenz.de>
References: <19991001032401.B28857@uni-koblenz.de> <Pine.LNX.4.10.9910011512560.8512-100000@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.10.9910011512560.8512-100000@skynet.csn.ul.ie>; from Dave Airlie on Fri, Oct 01, 1999 at 03:13:38PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Oct 01, 1999 at 03:13:38PM +0100, Dave Airlie wrote:

> I've also noticed that the old cvs server didn't let me do a cvs diff,
> which I consider useful, was this because of chroot pserver or something?

Probably.  Even though I had installed the necessary binaries in the
chroot environment.

> and will the new one let me do diffs?

It is supposed to.

  Ralf

Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA31698
	for <pstadt@stud.fh-heilbronn.de>; Mon, 28 Jun 1999 23:48:14 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05396; Mon, 28 Jun 1999 14:42:48 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA22408
	for linux-list;
	Mon, 28 Jun 1999 14:40:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA77984
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Jun 1999 14:40:49 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02694
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Jun 1999 14:40:47 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-26.uni-koblenz.de [141.26.131.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA20601
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Jun 1999 23:40:27 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id LAA00746;
	Mon, 28 Jun 1999 11:34:54 +0200
Date: Mon, 28 Jun 1999 11:34:54 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andrew Linfoot <andy@derfel99.freeserve.co.uk>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: File corruption
Message-ID: <19990628113454.A735@uni-koblenz.de>
References: <19990622032859.B6955@thepuffingroup.com> <19990622152145.A1059@uni-koblenz.de> <19990623014923.A8953@thepuffingroup.com> <19990625002853.D17220@uni-koblenz.de> <002701bebf17$cd9e4fd0$0a02030a@snafu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <002701bebf17$cd9e4fd0$0a02030a@snafu>; from Andrew Linfoot on Fri, Jun 25, 1999 at 03:34:15PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 25, 1999 at 03:34:15PM +0100, Andrew Linfoot wrote:

> I have been running 2.2.1 on my indy for about 3 weeks now and have
> encountered problems like this,
> in fact i am surprised at how stable the box is, i have been doing some
> quite large builds of qt, kde and the like too. If this is reproducible then
> i would be prepared to experiment on one of my boxes.
> 
> The only gripe i have is that the scsi driver breaks when i attach external
> devices, any ideas?

There is nothings special with external devices, so if they result in
crashes you should double check that cabeling and termination are ok.

  Ralf

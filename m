Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA20803 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Oct 1998 16:01:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA76539
	for linux-list;
	Sun, 4 Oct 1998 16:00:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA63837
	for <linux@engr.sgi.com>;
	Sun, 4 Oct 1998 16:00:39 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03319
	for <linux@engr.sgi.com>; Sun, 4 Oct 1998 16:00:37 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-14.uni-koblenz.de [141.26.249.14])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA10789
	for <linux@engr.sgi.com>; Mon, 5 Oct 1998 01:00:34 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA01016;
	Mon, 5 Oct 1998 00:59:46 +0200
Message-ID: <19981005005946.G409@uni-koblenz.de>
Date: Mon, 5 Oct 1998 00:59:46 +0200
From: ralf@uni-koblenz.de
To: Andries.Brouwer@cwi.nl, ANeuper@guug.de, jj@sunsite.ms.mff.cuni.cz
Cc: LeBlanc@mcc.ac.uk, fasten@informatik.uni-bonn.de,
        linux@cthulhu.engr.sgi.com, shaver@netscape.com
Subject: Re: SGI partitions / fdisk
References: <UTC199810042124.XAA67442.aeb@texel.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <UTC199810042124.XAA67442.aeb@texel.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Oct 04, 1998 at 11:24:18PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Oct 04, 1998 at 11:24:18PM +0200, Andries.Brouwer@cwi.nl wrote:

> > I've got some more fdisk patches around which make fdisk work correctly
> > with PC style partitions on big endian machines.
> 
> They are welcome, although it may well be that I have done
> this same work already. Have you looked at a recent fdisk?

No.  My work is based on whatever is shipping with RedHat 5.1.  Where can
I get the latest and hottest release of linux-utils?

> Btw - there will soon be a new release of util-linux,
> including fdisk etc, so this is a good moment to dig up
> all fdisk patches you may have.

Yes, it would be.  Actually since fdisk has been hacked up so badly I
think a major cleanup wouldn't be bad.

(Any followups please to ralf@bofh.de, not ralf@uni-koblenz.de.  The later
address will from tomorrow on be unreachable for as much as several days.)

  Ralf

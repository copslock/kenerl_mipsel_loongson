Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA37602 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Feb 1999 18:15:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA89746
	for linux-list;
	Sun, 14 Feb 1999 18:14:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA97404
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 14 Feb 1999 18:14:36 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02670
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 Feb 1999 18:14:35 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-15.uni-koblenz.de [141.26.131.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA18860
	for <linux@cthulhu.engr.sgi.com>; Mon, 15 Feb 1999 03:14:31 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id CAA22237;
	Mon, 15 Feb 1999 02:05:17 +0100
Message-ID: <19990215020511.E644@uni-koblenz.de>
Date: Mon, 15 Feb 1999 02:05:11 +0100
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Memory corruption on Indy
References: <19990215002746.C644@uni-koblenz.de> <19990215013210.A2910@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19990215013210.A2910@alpha.franken.de>; from Thomas Bogendoerfer on Mon, Feb 15, 1999 at 01:32:10AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Feb 15, 1999 at 01:32:10AM +0100, Thomas Bogendoerfer wrote:

> On Mon, Feb 15, 1999 at 12:27:46AM +0100, ralf@uni-koblenz.de wrote:
> >   find / -fstype ext2 -type f | xargs md5sym
> > 
> > several times and compare the obtained output.  Do they differ in any
> > unexplainable way?
> 
> do you want, that everybody crash their Indys ? 
> 
> Everybody, who wants to run the find, should umount /proc before doing it.
> Otherwise the kernel will crash, when the md5sum /proc/kcore happens.

That's what the -fstype ext2 is supposed to take care of :-)

  Ralf

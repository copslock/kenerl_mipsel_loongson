Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA56576 for <linux-archive@neteng.engr.sgi.com>; Sat, 23 Jan 1999 17:53:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA68708
	for linux-list;
	Sat, 23 Jan 1999 17:52:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA84585
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 23 Jan 1999 17:52:38 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA03300
	for <linux@cthulhu.engr.sgi.com>; Sat, 23 Jan 1999 20:52:36 -0500 (EST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA00624
	for <linux@cthulhu.engr.sgi.com>; Sun, 24 Jan 1999 02:52:33 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id CAA08014;
	Sun, 24 Jan 1999 02:50:54 +0100
Message-ID: <19990124025052.D6388@uni-koblenz.de>
Date: Sun, 24 Jan 1999 02:50:52 +0100
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Precompiled 2.1.131 binaries.
References: <Pine.LNX.3.96.990123203759.16452A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990123203759.16452A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, Jan 23, 1999 at 08:39:42PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jan 23, 1999 at 08:39:42PM -0500, Alex deVries wrote:

> I've put prebuilt Linux binaries for the Indy in:
> ftp://linus.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.1.131.tar.gz
> 
> This is the first prebuilt kernel that includes modules, although I think
> there are still problems with modutils.

Use modutils directly from vger.  See

  ftp://vger.rutgers.edu/pub/linux/README.CVS

for how to access vger's CVS.

  Ralf

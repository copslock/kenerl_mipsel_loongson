Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id FAA81947 for <linux-archive@neteng.engr.sgi.com>; Sat, 27 Jun 1998 05:00:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA99852
	for linux-list;
	Sat, 27 Jun 1998 04:59:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA55557
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 27 Jun 1998 04:59:40 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA23593
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 Jun 1998 04:59:39 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id NAA27349
	for <linux@cthulhu.engr.sgi.com>; Sat, 27 Jun 1998 13:59:31 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id NAA01043;
	Sat, 27 Jun 1998 13:59:03 +0200
Message-ID: <19980627135902.A484@uni-koblenz.de>
Date: Sat, 27 Jun 1998 13:59:02 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>,
        "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: /dev/mouse ?
References: <19980626074948.06850@life.nthu.edu.tw> <Pine.LNX.3.95.980626224406.19185C-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980626224406.19185C-100000@lager.engsoc.carleton.ca>; from Alex deVries on Fri, Jun 26, 1998 at 10:44:45PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 26, 1998 at 10:44:45PM -0400, Alex deVries wrote:

> On Fri, 26 Jun 1998, Francis M.J. Hsieh wrote:
> > Dear SGI/Linuxer:
> > Do anybody know which device should the /dev/mouse linked to?
> 
> /dev/psaux, I would think, but seeing as the psaux driver isn't working,
> it'll go nowhere.
> 
> Hm.  Someone should look at that.

Looks like a job for me.  But first I have to exterminate a couple of RISC/os
installations.

  Ralf

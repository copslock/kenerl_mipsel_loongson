Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA80122 for <linux-archive@neteng.engr.sgi.com>; Fri, 8 May 1998 06:47:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA22063154
	for linux-list;
	Fri, 8 May 1998 06:45:56 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA22171872
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 8 May 1998 06:45:53 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id GAA10172
	for <linux@cthulhu.engr.sgi.com>; Fri, 8 May 1998 06:45:52 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id JAA24426;
	Fri, 8 May 1998 09:45:49 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 8 May 1998 09:45:49 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Leon Verrall <leon@reading.sgi.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: More idiocy....
In-Reply-To: <Pine.SGI.3.96.980508142150.4555A-100000@wintermute.reading.sgi.com>
Message-ID: <Pine.LNX.3.95.980508094423.20848J-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 8 May 1998, Leon Verrall wrote:
> OK, wher are the non customer RPMS for big endian MIPS/noarch i.e. things
> like initfiles, inetd etc...

ftp://ftp.linux.sgi.com/pub/redhat/redhat-5.0/RPMS

Make sure you choose mipseb and noarch.

Let me know how it goes.  You may want to make excessive use of '--nodeps'
and '--force'.

- Alex

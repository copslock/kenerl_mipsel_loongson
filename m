Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id UAA174673 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Jan 1998 20:05:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA26146 for linux-list; Thu, 22 Jan 1998 20:02:02 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA26141 for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 20:02:00 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA05711
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jan 1998 20:01:58 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-25.uni-koblenz.de [141.26.249.25])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA02675
	for <linux@cthulhu.engr.sgi.com>; Fri, 23 Jan 1998 05:01:56 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA08502;
	Fri, 23 Jan 1998 04:57:25 +0100
Message-ID: <19980123045725.54480@uni-koblenz.de>
Date: Fri, 23 Jan 1998 04:57:25 +0100
To: Oliver Frommel <oliver@aec.at>
Cc: Mike Shaver <shaver@netscape.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
References: <34C6E304.680D7541@netscape.com> <Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980122130326.18071A-100000@web.aec.at>; from Oliver Frommel on Thu, Jan 22, 1998 at 01:04:30PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jan 22, 1998 at 01:04:30PM +0100, Oliver Frommel wrote:

> > Could we not modify sash to know about ext2?
> > I thought I read somewhere that we could get sash sources/info, which
> > would help a lot.
> > 
> 
> sash is located in the volumen header afaik(?)
> wouldn't it be possible to replace sash by another (possibly free) bootloader?

Basically we could Milo for the Indy also.  Milo even has the required
features to be built as ECOFF executable thus supporting old machines
where the ARC proms can't load ELF.

Q: What filesystem types are supported directly by the ARC firmware in the
ROMs?

  Ralf

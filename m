Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA3619881 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 May 1998 12:14:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA19406346
	for linux-list;
	Sat, 2 May 1998 12:12:42 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA17658594
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 2 May 1998 12:12:40 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA14895
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 12:12:36 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA24093
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 15:12:30 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 2 May 1998 15:12:30 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: RedHat 5.0 updated RPMS for SGI/Linux
Message-ID: <Pine.LNX.3.95.980502145754.4130B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The result of a week of rebooting my machine and avoiding kerne problems
is almost all the appropriate update RedHat 5.0 RPMs being ported.  The
ones that have changed are:

May 02  4:00  AdV  Caught up with RedHat updates for 5.0

   Xconfigurator-3.26-1.mipseb.rpm
   amd-920824upl102-11.mipseb.rpm
   autofs-0.3.14-2.mipseb.rpm
   bind-utils-4.9.6-7.mipseb.rpm
   bind-4.9.6-7.mipseb.rpm
   dump-0.3-11.mipseb.rpm   
   elm-2.4.25-11.mipseb.rpm
   findutils-4.1-21.mipseb.rpm
   gated-3.5.8-1.mipseb.rpm
   gtk-devel-0.99.970925-3.mipseb.rpm  
   gtk-0.99.970925-3.mipseb.rpm
   gzip-1.2.4-10.mipseb.rpm
   imap-4.1.BETA-9.mipseb.rpm
   initscripts-3.32-1.mipseb.rpm
   info-3.12-1.mipseb.rpm
   kbd-0.94-6.mipseb.rpm
   ld.so-1.9.5-2.mipseb.rpm
   lpr-0.31-1.mipseb.rpm
   lynx-2.8-1.mipseb.rpm
   mh-6.8.4-6.mipseb.rpm
   ncftp-2.4.3-1.mipseb.rpm
   procps-X11-1.2.7-1.mipseb.rpm
   procps-1.2.7-1.mipseb.rpm
   portmap-4.0-8.mipseb.rpm
   perl-5.004-4.mipseb.rpm
   pine-3.96-7.mipseb.rpm
   quota-1.55-7.mipseb.rpm
   rmt-0.3-11.mipseb.rpm
   rpm-devel-2.4.109-1.mipseb.rpm
   rpm-2.4.109-1.mipseb.rpm
   shadow-utils-970616-11.mipseb.rpm
   texinfo-3.12-1.mipseb.rpm
   textutils-1.22-5.mipseb.rpm
   tmpwatch-1.5-1.mipseb.rpm
   tcp_wrappers-7.6-2.mipseb.rpm
   transfig-3.2-3.mipseb.rpm
   trn-3.6-11.mipseb.rpm
   usernet-1.0.6-1.mipseb.rpm
   vixie-cron-3.0.1-20.mipseb.rpm
   wu-ftpd-2.4.2b15-6.mipseb.rpm
   xserver-wrapper-1.1-1.mipseb.rpm
   yppasswd-0.9-3.mipseb.rpm
   ypbind-3.3-3.mipseb.rpm

The ones I still haven't sorted out are:
ld.so
kaffe
smbfs
util-linux
mars-nwe
ppp
ncpfs

Now, all of this should eventually be sorted out, and I haven't looked
through Alan's entire source patches. Most of the work in all of this is
actually organizing things.

Please, if you modify the contents of the RPMs directory on linus, keep
the log in README.txt.

- Alex

-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www..engsoc.carleton.ca/~adevries/ .

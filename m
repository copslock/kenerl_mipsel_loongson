Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2150831 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Apr 1998 14:33:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA15108068
	for linux-list;
	Wed, 22 Apr 1998 14:32:40 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA14971588
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Apr 1998 14:32:38 -0700 (PDT)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id OAA14474
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 14:32:35 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id RAA27636; Wed, 22 Apr 1998 17:33:52 -0400
Date: Wed, 22 Apr 1998 17:48:21 -0400
Message-Id: <199804222148.RAA21473@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
In-Reply-To: <Pine.LNX.3.95.980422171156.31583B-100000@lager.engsoc.carleton.ca>
References: <199804222119.RAA20883@pluto.npiww.com>
	<Pine.LNX.3.95.980422171156.31583B-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > You can get a functional glibc RPM from the mustang directory (4.9.1 IIRC)
 > on ftp.linux.sgi.com.
 > 
 > Now, in return, can you point me to a tarball or RPM of a natively built
 > gcc and binutils?
 > 

I'm using glibc from mustang, apparently the pthread support is broken.
(I have checked that all the __lib_xxx symbols are there in i386 version).

The gcc and binutils I also got from mustang directory.

Dong.

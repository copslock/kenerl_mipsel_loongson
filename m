Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA3159731 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 14:32:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA18130936
	for linux-list;
	Wed, 29 Apr 1998 14:29:59 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA17896061
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 14:29:57 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id OAA15918
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 14:29:56 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA31413
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 17:29:55 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 29 Apr 1998 17:29:55 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Could mounting sdc instead of sdc1 have solved my panics?
Message-ID: <Pine.LNX.3.95.980429172646.16310M-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I redid my entire sdc because all my files were trashed on it anyway (with
weird things like .h files having random data partway through...).  This
time I partitioned using fx on Irix.

I didn't partition it the first time because I was lazy, and din't want to
have to go through the weirdo fx tool thing.

Could this have been cause for my kernel panics? I've been doing a fair
amount of work, and things seem really stable.  No panics so far.  Should
/dev/sdc work just as a block device the way /dev/sdc1 would?

- Alex

-- 
Alex deVries
"romantic engsoc guy who runs marathons" - csilcock@chat.carleton.ca
http://www.engsoc.carleton.ca/~adevries/ .

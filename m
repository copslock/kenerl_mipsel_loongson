Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA23455; Mon, 17 Jun 1996 15:28:36 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA20651 for linux-list; Mon, 17 Jun 1996 22:27:38 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA20641 for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jun 1996 15:27:37 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id PAA23297; Mon, 17 Jun 1996 15:27:36 -0700
Message-Id: <199606172227.PAA23297@neteng.engr.sgi.com>
To: wje@fir.esd.sgi.com (William J. Earl)
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: linux@neteng.engr.sgi.com
Subject: Re: strace project 
Date: Mon, 17 Jun 1996 15:27:36 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:        If by strace you mean tracing system call arguments and results,
: try using par(1).  (It does not help if you want to decode argument structures,
: however.)  Here is a sample:

He needs to decode args.  The idea was that strace groks most of the ioctls
in most OS's.  If we ever want to run little endian binaries on a big
endian kernel (which would be kinda cool) we need the arg decode.  David
wanted it for something else too.

--lm

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id IAA01834 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 08:41:04 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA15893 for linux-list; Wed, 14 Jan 1998 08:40:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA15887 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 08:40:35 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id IAA02026
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 08:40:28 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id LAA07933;
	Wed, 14 Jan 1998 11:42:56 -0500
Date: Wed, 14 Jan 1998 11:42:55 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: Oliver Frommel <oliver@aec.at>, SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: The world's worst RPM
In-Reply-To: <19980114145820.04564@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980114114012.2369E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 14 Jan 1998 ralf@uni-koblenz.de wrote:
> As I understand Alex's words he only made fdisk running but it still doesn't
> support IRIX style disklabels.  How about that?

That's correct. It should be able to modify partition tables of disks, but
Irix won't recognize it. That's no problem if you have no intention of
using Irix once your machine is running smoothly, like me.

- Alex

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id JAA02264 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 09:06:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA22706 for linux-list; Wed, 14 Jan 1998 09:04:23 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA22625 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 09:04:12 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA09070
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 09:04:09 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA09163
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 12:07:15 -0500
Date: Wed, 14 Jan 1998 12:07:15 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: 2.1.72 precompiled with no L2
In-Reply-To: <Pine.LNX.3.95.980114111306.2369C-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.95.980114120233.2369F-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


ftp://ftp.linux.sgi.com/pub/test/vmlinux-indy-noL2-2.1.72.tar.gz
is available for your usage and testing.  

This is for machines with no L2 cache.  I can't test it myself, since my
machine does have that cache.

Should L2 cache perhaps be a compiling option? Is it possible for the
kernel to auto-detect if there's cache or not?

- Alex

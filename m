Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA2232083 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Apr 1998 16:10:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id QAA15333870
	for linux-list;
	Wed, 22 Apr 1998 16:08:50 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA15283836
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Apr 1998 16:08:48 -0700 (PDT)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id QAA01824
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 16:08:47 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id TAA16419 for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 19:10:11 -0400
Date: Wed, 22 Apr 1998 19:24:40 -0400
Message-Id: <199804222324.TAA26717@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This what I found out:

The library verion from the root filesystem on ftp.linux.sgi.com

libc 2.0.4  libpthread  0.6

The version og glibc RPM from redhat 4.9.1

libc 2.0.6 libpthread 0.7

If I use libc-2.0.6 and libpthread-0.7, ld complains some missing
symbols, if I use libc-2.0.6 and libpthread-0.6, I get Segmentation
Fault:=(.

Dong.

BTW, is there a X server for sgi-linux?

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA01195 for <linux-archive@neteng.engr.sgi.com>; Tue, 9 Feb 1999 14:59:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA29817
	for linux-list;
	Tue, 9 Feb 1999 14:58:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from kilimanjaro.engr.sgi.com (kilimanjaro.engr.sgi.com [150.166.49.139])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA38104
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 9 Feb 1999 14:58:35 -0800 (PST)
	mail_from (owner-linux@kilimanjaro.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1]) by kilimanjaro.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id OAA92704 for <linux>; Tue, 9 Feb 1999 14:58:33 -0800 (PST)
Message-Id: <199902092258.OAA92704@kilimanjaro.engr.sgi.com>
To: linux@kilimanjaro.engr.sgi.com
Subject: glibc SRPM
Date: Tue, 09 Feb 99 14:58:32 -0800
From: Joan Eslinger <wombat@kilimanjaro.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi. I'm trying to unpack one of the glibc SRPMS from HardHat and am
getting the error

  % rpm -i glibc-2.0.6.src.rpm
  unpacking of archive failed on file glibc-2.0.6.tar.gz: 1: Success
  error: glibc-2.0.6-3.src.rpm cannot be installed
 
I'm trying to run rpm on an Intel box running Linux, and maybe that's
the problem. Is there someone out there who can un-rpm a MIPS glibc SRPM
and point me at the resulting tar.gz file?

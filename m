Received:  by oss.sgi.com id <S553790AbQJZO4J>;
	Thu, 26 Oct 2000 07:56:09 -0700
Received: from [166.70.178.116] ([166.70.178.116]:16135 "EHLO home.knm.org")
	by oss.sgi.com with ESMTP id <S553785AbQJZO4E>;
	Thu, 26 Oct 2000 07:56:04 -0700
Received: (from mark@localhost)
	by home.knm.org (8.9.3/8.9.3) id IAA05015;
	Thu, 26 Oct 2000 08:55:42 -0600
Date:   Thu, 26 Oct 2000 08:55:42 -0600
Message-Id: <200010261455.IAA05015@home.knm.org>
X-Authentication-Warning: home.knm.org: mark set sender to mark@home.knm.org using -f
From:   Mark Lehrer <mark@knm.org>
To:     linux-mips@oss.sgi.com
Subject: Threads on mips
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hello!  I am just getting started with one of the MIPS embedded
platforms, the NEC VR4122.  I downloaded the kernel & ramdisk from the
linux-vr web pages.

Some of the apps I'm trying to port over use pthreads; however, the
pthread library that is included doesn't appear to work - the process
that tries to create a thread just waits forever until I hit ctrl-c.

Is anyone using threads with the mips embedded platforms?  If so, what
kernel, libc, and pthreads library are you using?

If not, has anyone thought about what it might take to get threads to
work?

Thanks,
Mark Lehrer

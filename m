Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1JGS4318548
	for linux-mips-outgoing; Tue, 19 Feb 2002 08:28:04 -0800
Received: from moshier.net (moshier.ne.mediaone.net [65.96.130.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1JGS2918545
	for <linux-mips@oss.sgi.com>; Tue, 19 Feb 2002 08:28:02 -0800
Received: from moshier.ne.mediaone.net (moshier.ne.mediaone.net [65.96.130.103])
	by moshier.net (8.9.3/8.9.3) with ESMTP id KAA26179;
	Tue, 19 Feb 2002 10:27:52 -0500
Date: Tue, 19 Feb 2002 10:27:52 -0500 (EST)
From: Stephen L Moshier <steve@moshier.net>
Reply-To: steve@moshier.net
To: Zhang Fuxin <fxzhang@ict.ac.cn>
cc: linux-mips@oss.sgi.com, <libc-alpha@sources.redhat.com>
Subject: Re: endless loop in remainder() on mips
Message-ID: <Pine.LNX.4.44.0202191023460.26177-100000@moshier.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> t-remainder.c

This code does not look like the current version of
  sysdeps/ieee754/dbl-64/e_remainder.c

IBM fixed the bug, and I thought there was acknowledgment
here that the fix worked on a MIPS.  The change was installed
December 5, 2001 and it seems to be in glibc-2.2.5.

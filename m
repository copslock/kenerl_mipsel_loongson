Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f791RLP19613
	for linux-mips-outgoing; Wed, 8 Aug 2001 18:27:21 -0700
Received: from smtp.WPI.EDU (root@smtp.WPI.EDU [130.215.24.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f791RKV19610
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 18:27:20 -0700
Received: from grover.wpi.edu (ian@grover.WPI.EDU [130.215.25.67])
	by smtp.WPI.EDU (8.12.0.Beta17/8.12.0.Beta17) with ESMTP id f791RHFd023746;
	Wed, 8 Aug 2001 21:27:17 -0400 (EDT)
Date: Wed, 8 Aug 2001 21:27:17 -0400 (EDT)
From: Ian <ian@WPI.EDU>
To: Guido Guenther <guido.guenther@gmx.net>
cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: HELP can't boot
In-Reply-To: <20010808223940.B12550@galadriel.physik.uni-konstanz.de>
Message-ID: <Pine.OSF.4.33.0108082125510.29716-100000@grover.WPI.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Try just "bootp():". The prom is clever enough to figure out the rest.

Doesn't work.  It complains that Sash is missing.

> I doubt that. You can't compile a recent glibc with that outdated toolchain.

You can.  You just build glibc and gcc with the old gcc (2.7.8?), and then
you chroot into the newly-built environment and rebuild it again with the
new gcc.

--
Ian Cooper
ian@wpi.edu

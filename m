Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6J49uf28203
	for linux-mips-outgoing; Wed, 18 Jul 2001 21:09:56 -0700
Received: from b0rked.dhs.org (postfix@b0rked.dhs.org [216.99.196.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6J49sV28199
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 21:09:54 -0700
Received: by b0rked.dhs.org (Postfix, from userid 500)
	id 7B9EF21EE; Wed, 18 Jul 2001 21:09:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by b0rked.dhs.org (Postfix) with ESMTP
	id 7759621ED; Wed, 18 Jul 2001 21:09:42 -0700 (PDT)
Date: Wed, 18 Jul 2001 21:09:42 -0700 (PDT)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
To: <linux-mips@oss.sgi.com>, <linux-mips-kernel@lists.sourceforge.net>
Subject: Patches to support 48M IBM Workpad z50?
Message-ID: <Pine.LNX.4.31.0107182100140.9246-100000@b0rked.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Since I can't seem to find any information about this anywhere else, I
figured this would be the appropriate place to ask.

I'm using a moderately hacked 2.4.0-test9 kernel from the linux-vr
repository (the only complete kernel, excluding NetBSD, that I've found
which runs on CE devices at the moment), and it doesn't want to recognize
all 48M of RAM in the device, only the 1st 16. The memory is mapped as
such:

0M  - 16M:	On-board memory
16M - 32M:	Unmapped region
32M - 64M:	Memory expansion card

When the first 16M is checked, the memory immediately after that is found
to be non-existant.

Does anyone have a patch (other than the hack I tossed together to turn
the 32M-64M chunk into an MTD device) that would be useful to work past
the memory hole?

TIA

Chris

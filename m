Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2P5gVK18486
	for linux-mips-outgoing; Sun, 24 Mar 2002 21:42:31 -0800
Received: from vasquez.zip.com.au (vasquez.zip.com.au [203.12.97.41])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2P5gSq18483
	for <linux-mips@oss.sgi.com>; Sun, 24 Mar 2002 21:42:28 -0800
Received: from zip.com.au (root@zipperii.zip.com.au [61.8.0.87])
	by vasquez.zip.com.au (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id QAA30542;
	Mon, 25 Mar 2002 16:44:42 +1100
X-Authentication-Warning: vasquez.zip.com.au: Host root@zipperii.zip.com.au [61.8.0.87] claimed to be zip.com.au
Message-ID: <3C9EB8F6.247C7C3B@zip.com.au>
Date: Sun, 24 Mar 2002 21:43:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   linux kernel <linux-kernel@vger.kernel.org>,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
References: <20020323140728.A4306@lucon.org> <3C9D1C1D.E30B9B4B@zip.com.au> <20020323221627.A10953@lucon.org> <3C9D7A42.B106C62D@zip.com.au> <20020324012819.A13155@lucon.org> <20020325003159.A2340@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Theodore Tso wrote:
> 
> And just to be clear ---- although in the past I've been really
> annoyed when glibc has made what I've considered to be arbitrary
> changes which have screwed ABI, compile-time, or link-time
> compatibility, and have spoken out against it --- in this particular
> case, I consider the fault to be purely the fault of the kernel
> developers, so there's no need having the glibc folks get all
> defensive....

So... Does the kernel need fixing? If so, what would you
recommend?

-

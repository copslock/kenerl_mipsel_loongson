Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7T3f4u11774
	for linux-mips-outgoing; Tue, 28 Aug 2001 20:41:04 -0700
Received: from dea.linux-mips.net (u-95-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.95])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7T3erd11769
	for <linux-mips@oss.sgi.com>; Tue, 28 Aug 2001 20:40:53 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7T3bmA22603;
	Wed, 29 Aug 2001 05:37:48 +0200
Date: Wed, 29 Aug 2001 05:37:48 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Tom Appermont <tea@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: shared memory
Message-ID: <20010829053748.A16170@dea.linux-mips.net>
References: <20010828191725.A1221@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010828191725.A1221@sonycom.com>; from tea@sonycom.com on Tue, Aug 28, 2001 at 07:17:25PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 28, 2001 at 07:17:25PM +0200, Tom Appermont wrote:

> While this works as expected on PC, it does not at all work as
> expected on my mips platform (R5231): What is written in user
> space is not immediately visible in kernel space. This is with
> very recent kernel sources (2.4.8) but the same problem exists
> with an older (2.4.5) kernel.
> 
> There have been a few mails about mmap() problems in the last 
> couple of months, but with very little interesting response. Is 
> this a known problem or am I stupidly overlooking something?

This is a different problem - and it's one caused by your code.  You're
missing the necessary cache flushes in the kernel code.  Using
_CACHE_UNCACHED is slow and breaks SMP.

 Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g162Zbe05324
	for linux-mips-outgoing; Tue, 5 Feb 2002 18:35:37 -0800
Received: from dea.linux-mips.net (a1as11-p112.stg.tli.de [195.252.190.112])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g162ZXA05321
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 18:35:33 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g162Xkf11663;
	Wed, 6 Feb 2002 03:33:46 +0100
Date: Wed, 6 Feb 2002 03:33:46 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
Message-ID: <20020206033346.A7298@dea.linux-mips.net>
References: <3C600D4C.43CBA784@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C600D4C.43CBA784@cotw.com>; from sjhill@cotw.com on Tue, Feb 05, 2002 at 10:50:20AM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 10:50:20AM -0600, Steven J. Hill wrote:

> I am just trying to fill in some more MIPS knowledge here. With a 32-bit
> MIPS processor, we are forever limited to a userspace of 2GB in size thanks
> to the kuser region. kseg0/1 map the same 512MB of physical memory. kseg2
> is 1GB in size and hence it could address another 1GB of RAM. So, is the

2gb virtual memory per process.  In theory physical memory is limited by
the size of the address bus with highmem; the practical limit for highmem
should be in the range of 16-32gb RAM.

  Ralf

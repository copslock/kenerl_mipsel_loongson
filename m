Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E8wE703251
	for linux-mips-outgoing; Tue, 14 Aug 2001 01:58:14 -0700
Received: from dea.waldorf-gmbh.de (u-198-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.198])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E8w5j03238
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 01:58:06 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7E8nfU06453;
	Tue, 14 Aug 2001 10:49:41 +0200
Date: Tue, 14 Aug 2001 10:49:41 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: SysV IPC shared memory and virtual alising
Message-ID: <20010814104941.F5928@bacchus.dhis.org>
References: <20010806164452D.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010806164452D.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Mon, Aug 06, 2001 at 04:44:52PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 04:44:52PM +0900, Atsushi Nemoto wrote:

> Here is an patch to fix virtual aliasing problem with SysV IPC shared
> memory.  I tested this patch on a r4k cpu with 32Kb D-cache.
> 
> If D-cache is smaller than PAGE_SIZE this patch is not needed at all,
> but I think it is not so bad unconditionally forcing alignment to
> SHMLBA.

It's wasting huge amounts of address space.  That can be prohibitive if
you want to run something such as electric fence.  Technically the worst
case of any CPU that's required is 32kb on R4000 / R4400 SC and MC
versions, so I don't want to go beyond that.

What does this patch have to do with SysV shared mem?  Shmat(2) does
proper alignment checking and aligning and doesn't call
arch_get_unmapped_area.

We do have an alignment problem with mmap(2); somebody already has a
correct patch for this already pending to be merged by Alan and Linus
as it affects all architectures.  I assume your patch was actually
intended to fix this problem; it' doesn't correctly properly deal with
anonymous mappings which have no extra alignment constraints nor
correctly factor in the file offset so with just two mmap calls I can
still create aliases.

  Ralf

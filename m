Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AEnkO14645
	for linux-mips-outgoing; Fri, 10 Aug 2001 07:49:46 -0700
Received: from dea.waldorf-gmbh.de (u-65-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AEnbV14624;
	Fri, 10 Aug 2001 07:49:38 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7AEm7e24931;
	Fri, 10 Aug 2001 16:48:07 +0200
Date: Fri, 10 Aug 2001 16:48:07 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steve Lord <lord@sgi.com>
Cc: Seth Mos <knuffie@xs4all.nl>, Brandon Barker <bebarker@meginc.com>,
   linux-mips@oss.sgi.com, linux-xfs@oss.sgi.com
Subject: Re: XFS installer
Message-ID: <20010810164807.A24889@bacchus.dhis.org>
References: <ralf@oss.sgi.com> <200108101346.f7ADkQ307720@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108101346.f7ADkQ307720@jen.americas.sgi.com>; from lord@sgi.com on Fri, Aug 10, 2001 at 08:46:26AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 08:46:26AM -0500, Steve Lord wrote:

> The page size == block size will get fixed, we need to do that, but it
> may take a while. Block size less than pagesize will come first, blocksize
> greater than pagesize needs PAGE_CACHE_SIZE to be bumped, which appears to
> be on the cards for 2.5.
> 
> V1 directories mostly work in Linux, but there are glibc getdents issues
> with them. The glibc code which lseeks backwards in a directory is the issue,
> if you have control over your glibc it can be fixed by using the 64 bit
> version of lseek in this code. This is all because the directory offset in
> V1 is a 64 bit hash value, not a 32 bit signed number.

So in other words that means using kernel 2.4 / glibc 2.2 and for 32-bit
systems building applications with the large file API.

  Ralf

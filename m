Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TLRinC031150
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 14:27:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TLRi2Q031149
	for linux-mips-outgoing; Wed, 29 May 2002 14:27:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TLRfnC031146
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 14:27:41 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4TLStu01350;
	Wed, 29 May 2002 14:28:55 -0700
Date: Wed, 29 May 2002 14:28:55 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Justin Carlson <justinca@cs.cmu.edu>, linux-mips@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
Message-ID: <20020529142855.C888@dea.linux-mips.net>
References: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com> <1022700389.7644.155.camel@ldt-sj3-022.sj.broadcom.com> <01cb01c20754$4c14e400$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <01cb01c20754$4c14e400$10eca8c0@grendel>; from kevink@mips.com on Wed, May 29, 2002 at 11:03:20PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 29, 2002 at 11:03:20PM +0200, Kevin D. Kissell wrote:

> While trampolines, breakpointing and JITing are the main 
> uses of user-mode cache manipulation (drivers are a whole 
> 'nother story), we really should have distinct capabilities for 
> I-stream modification and for explicit synchronizations of 
> the data storage hierarchy, for non-coherent multiprocessors
> and user-manipulated DMA buffers.  As to whether
> those capabilities should be distinguished by system
> call (sysmips vs. cacheflush) or by parameter to the
> same system call, I don't have enough data to form
> an opinion at this point.

It should clearly be cacheflush(2); sysmips(2) is too coarse, too ugly
interface.  Another thing we'll still have to implement is the
cachectl(2) syscall; for certain systems and applications fine control
of the caching mode use for a memory mapping may result in major performance
improvments.

  Ralf

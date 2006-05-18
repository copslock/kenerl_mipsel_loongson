Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 22:24:05 +0200 (CEST)
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12230 "HELO
	fed1rmmtao02.cox.net") by ftp.linux-mips.org with SMTP
	id S8133922AbWERUX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 May 2006 22:23:56 +0200
Received: from liberty.homelinux.org ([70.190.160.125])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518202348.CJGL15447.fed1rmmtao02.cox.net@liberty.homelinux.org>;
          Thu, 18 May 2006 16:23:48 -0400
Received: from liberty.homelinux.org (mmporter@localhost [127.0.0.1])
	by liberty.homelinux.org (8.13.5/8.13.5/Debian-3) with ESMTP id k4IKNb8v019117;
	Thu, 18 May 2006 13:23:38 -0700
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.13.5/8.13.5/Submit) id k4IKNZO9019115;
	Thu, 18 May 2006 13:23:36 -0700
Date:	Thu, 18 May 2006 13:23:35 -0700
From:	Matt Porter <mporter@kernel.crashing.org>
To:	Chad Reese <kreese@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Any examples / docs for getting SPARSEMEM to work?
Message-ID: <20060518132335.C18826@cox.net>
References: <446CB5D8.107@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <446CB5D8.107@caviumnetworks.com>; from kreese@caviumnetworks.com on Thu, May 18, 2006 at 10:58:48AM -0700
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, May 18, 2006 at 10:58:48AM -0700, Chad Reese wrote:
> Hello All,
> 
> I've spent the last few days trying to get SPARSEMEM to work on a 64bit Mips 
> kernel. The processor I'm using has large wholes in its memory map.
> 
> Memory layout:
> 0 - 0x10000000			First 256MB
> 0x410000000 - 0x420000000 	Second 256MB
> 0x20000000 - ? 			The rest of memory
> 
> Up until now I've used the flat memory model and not mapped the 2nd 256MB. This 
> is rather wasteful for boards with 512MB of memory. SPARSEMEM look like what I 
Yep, SPARSEMEM is what you want. BTW, doublecheck your line wrap
settings on your mailer...they're messed up.

> need, but I've been unable to get it working. My attempts to configure it always
> end with sparse_index_alloc calling alloc_bootmem_node which fails to allocate 
> 4KB. In prom_init I've added memory using add_memory_region.

But where have you added everything else? Where are you registering the
sparsemem and initializing it? It sounds like you are either getting
an invalid node passed into the alloc_bootmem_node or you are calling
the bootmem allocator much later and it is failing. 

> Are there any reasonably easy to follow implementations of sparsemem? I figure 
None that I know of, excpet for the i386, ia64, and powerpc
implementations. i386 is fairly straightforward except for all
the EFI magic.

> I'm missing something very basic, but perusal of Mips and the other 
> architectures haven't helped much.
> 
> My baseline is linux-mips 2.6.14.
> 
> Any help would be appreciated,

I suggest working back from your bootmem allocation failure to
understand why that is failing.

-Matt

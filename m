Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g531DEnC020271
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 2 Jun 2002 18:13:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g531DEbt020270
	for linux-mips-outgoing; Sun, 2 Jun 2002 18:13:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g531D9nC020267
	for <linux-mips@oss.sgi.com>; Sun, 2 Jun 2002 18:13:09 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g531EIQ16964;
	Sun, 2 Jun 2002 18:14:18 -0700
Date: Sun, 2 Jun 2002 18:14:18 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Raymond Lo <lo@broadon.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: virtual coherency issues with 4Kc ?
Message-ID: <20020602181417.A959@dea.linux-mips.net>
References: <3CF7F7B1.50300@broadon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CF7F7B1.50300@broadon.com>; from lo@broadon.com on Fri, May 31, 2002 at 03:22:41PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 31, 2002 at 03:22:41PM -0700, Raymond Lo wrote:

> I'm evaluting the MIPS 4Kc core.   One thing I'm trying to find out is 
> how does linux deal with virtual aliasing in the cache for 4Kc.  
> 
> The cache of 4Kc is virtually-indexed and it has no hardware support to 
> suppress virtual aliasing.   The cachetlb.txt under linux/Documentation 
> indicates that two things need to be done in software to handle virtual 
> aliasing in D-cache.
> 
> The first is to handle virtual aliasing in user address spaces.  Shared 
> pages are mmaped at virtual addresses that are multiples of the cache 
> size.   That has already been taked care of in  include/asm-mips/shmparam.h.
> 
> The second is to handle virtual aliasing between kernel virtual address 
> space and user virtual address space by providing a number of functions 
> to flush the cache at various points in the kernel.   The old interface 
> is flush_page_to_ram.   The new ones are
>   copy_user_page,
>   clear_user_page,
>   flush_dcache_page.
> 
> I'm surprised to find out that flush_dcache_page is a macro defined to 
> be  do {} while (0) in linux/asm-mips/pgtable.h.  The source code I 
> looked is the web CVS on oss.sgi.com and 2.4.18.

We simply haven't converted to use the new interfaces yet.

> Apparently the necessary flushing hasn't been done from the mm and fs 
> code for any MIPS port.  I know this is not necessary for R4000 with 
> virtual coherency execptions.

It's still a good idea to not rely on the virtual coherency exception
mechanism which can result in a very significant overhead.

> P.S.   The link http://oss.sgi.com/mips/archive/ is stale.  

  Ralf

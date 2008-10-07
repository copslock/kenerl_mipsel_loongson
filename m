Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2008 01:33:33 +0100 (BST)
Received: from web51404.mail.re2.yahoo.com ([206.190.38.183]:19851 "HELO
	web51404.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20766933AbYJGAd3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Oct 2008 01:33:29 +0100
Received: (qmail 38362 invoked by uid 60001); 7 Oct 2008 00:33:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=zpEUlzkSyWm/mLLxFXDC8RKOygQjxhUN9emhi9X356k8/WD6YZt0oDYBBdjabo4cNmTDn3UehmzcLp0dtFJk4b7iD9wLsKUy8xnVBQvdUmhV1bOPTkpyxebYntrrhalxpvl5lFyzbeBgtUGyzWUtVleT9cLYmeXCO+fTGbWn8Tw=;
X-YMail-OSG: v0e1rDQVM1lSsJe7v1dt_Gy5up7DsJv6dbuPeoL.ji70PYyuKBb2Qpqa.MkdS2vQ5w--
Received: from [75.62.122.2] by web51404.mail.re2.yahoo.com via HTTP; Mon, 06 Oct 2008 17:33:19 PDT
X-Mailer: YahooMailWebService/0.7.218.2
Date:	Mon, 6 Oct 2008 17:33:19 -0700 (PDT)
From:	John <me94043@yahoo.com>
Reply-To: me94043@yahoo.com
Subject: Re: Have ever checked in your mips sparsemem code into mips-linux tree?
To:	Andy Whitcroft <apw@shadowen.org>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, "VomLehn, David" <dvomlehn@cisco.com>,
	C Michael Sundius <Michael.sundius@sciatl.com>
In-Reply-To: <48EA71F5.1040200@sciatl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <800696.38003.qm@web51404.mail.re2.yahoo.com>
Return-Path: <me94043@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: me94043@yahoo.com
Precedence: bulk
X-list: linux-mips

Thank you Michael! I will try it out, and will post results later, but not next couple of days, since I have some stuff on hands approaching the deadline.

John

--- On Mon, 10/6/08, C Michael Sundius <Michael.sundius@sciatl.com> wrote:

> From: C Michael Sundius <Michael.sundius@sciatl.com>
> Subject: Re: Have ever checked in your mips sparsemem code into mips-linux tree?
> To: "Andy Whitcroft" <apw@shadowen.org>, "Dave Hansen" <dave@linux.vnet.ibm.com>, linux-mm@kvack.org, linux-mips@linux-mips.org, "VomLehn, David" <dvomlehn@cisco.com>, me94043@yahoo.com
> Date: Monday, October 6, 2008, 1:15 PM
> adding patch 2  containing Documentation:
> 
> 
> 
> 
>      - - - - -                              Cisco          
>                  - - - - -         
> This e-mail and any attachments may contain information
> which is confidential, 
> proprietary, privileged or otherwise protected by law. The
> information is solely 
> intended for the named addressee (or a person responsible
> for delivering it to 
> the addressee). If you are not the intended recipient of
> this message, you are 
> not authorized to read, print, retain, copy or disseminate
> this message or any 
> part of it. If you have received this e-mail in error,
> please notify the sender 
> immediately by return e-mail and delete it from your
> computer.From e01ad377b29c0e5c39289bece382e1f78f6e7e2c Mon
> Sep 17 00:00:00 2001
> From: Sundis <sundism@CUPLXSUNDISM01.corp.sa.net>
> Date: Mon, 6 Oct 2008 10:31:08 -0700
> Subject: [PATCH] mips sparsemem howto
> 
> ---
>  Documentation/sparsemem.txt |   92
> +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 92 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/sparsemem.txt
> 
> diff --git a/Documentation/sparsemem.txt
> b/Documentation/sparsemem.txt
> new file mode 100644
> index 0000000..0b36412
> --- /dev/null
> +++ b/Documentation/sparsemem.txt
> @@ -0,0 +1,92 @@
> +Sparsemem divides up physical memory in your system into N
> sections of M
> +bytes. Page tables are created for only those sections
> that
> +actually exist (as far as the sparsemem code is
> concerned). This allows
> +for holes in the physical memory without having to waste
> space by
> +creating page descriptors for those pages that do not
> exist.
> +When page_to_pfn() or pfn_to_page() are called there is a
> bit of overhead to
> +look up the proper memory section to get to the
> page_table, but this
> +is small compared to the memory you are likely to save.
> So, it's not the
> +default, but should be used if you have big holes in
> physical memory.
> +
> +Note that discontiguous memory is more closely related to
> NUMA machines
> +and if you are a single CPU system use sparsemem and not
> discontig. 
> +It's much simpler. 
> +
> +1) CALL MEMORY_PRESENT()
> +Existing sections are recorded once the bootmem allocator
> is up and running by
> +calling the sparsemem function "memory_present(node,
> pfn_start, pfn_end)" for each
> +block of memory that exists in your physical address
> space. The
> +memory_present() function records valid sections in a data
> structure called
> +mem_section[].
> +
> +2) DETERMINE AND SET THE SIZE OF SECTIONS AND PHYSMEM
> +The size of N and M above depend upon your architecture
> +and your platform and are specified in the file:
> +
> +      include/asm-<your_arch>/sparsemem.h
> +
> +and you should create the following lines similar to
> below: 
> +
> +	#ifdef CONFIG_YOUR_PLATFORM
> +	 #define SECTION_SIZE_BITS       27	/* 128 MiB */
> +	#endif
> +	#define MAX_PHYSMEM_BITS        31	/* 2 GiB   */
> +
> +if they don't already exist, where: 
> +
> + * SECTION_SIZE_BITS            2^M: how big each section
> will be
> + * MAX_PHYSMEM_BITS             2^N: how much memory we
> can have in that
> +                                     space
> +
> +3) INITIALIZE SPARSE MEMORY
> +You should make sure that you initialize the sparse memory
> code by calling 
> +
> +	bootmem_init();
> +  +	sparse_init();
> +	paging_init();
> +
> +just before you call paging_init() and after the
> bootmem_allocator is
> +turned on in your setup_arch() code.  
> +
> +4) ENABLE SPARSEMEM IN KCONFIG
> +Add a line like this:
> +
> +	select ARCH_SPARSEMEM_ENABLE
> +
> +into the config for your platform in
> arch/<your_arch>/Kconfig. This will
> +ensure that turning on sparsemem is enabled for your
> platform. 
> +
> +5) CONFIG
> +Run make *config, as you like, and turn on the sparsemem
> +memory model under the "Kernel Type" -->
> "Memory Model" and then build your
> +kernel.
> +
> +
> +6) Gotchas
> +
> +One trick that I encountered when I was turning this on
> for MIPS was that there
> +was some code in mem_init() that set the
> "reserved" flag for pages that were not
> +valid RAM. This caused my kernel to crash when I enabled
> sparsemem since those
> +pages (and page descriptors) didn't actually exist. I
> changed my code by adding
> +lines like below:
> +
> +
> +	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
> +		struct page *page = pfn_to_page(tmp);
> +
> +   +		if (!pfn_valid(tmp))
> +   +			continue;
> +   +
> +		if (!page_is_ram(tmp)) {
> +			SetPageReserved(page);
> +			continue;
> +		}
> +		ClearPageReserved(page);
> +		init_page_count(page);
> +		__free_page(page);
> +		physmem_record(PFN_PHYS(tmp), PAGE_SIZE,
> physmem_highmem);
> +		totalhigh_pages++;
> +	}
> +
> +
> +Once I got that straight, it worked!!!! I saved 10MiB of
> memory.  
> -- 
> 1.5.4.1


      

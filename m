Received:  by oss.sgi.com id <S305166AbQBBBaM>;
	Tue, 1 Feb 2000 17:30:12 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:8797 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305160AbQBBB34>;
	Tue, 1 Feb 2000 17:29:56 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA28937; Tue, 1 Feb 2000 17:28:30 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA52656
	for linux-list;
	Tue, 1 Feb 2000 17:18:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA50954
	for <linux@engr.sgi.com>;
	Tue, 1 Feb 2000 17:18:27 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA08705
	for <linux@engr.sgi.com>; Tue, 1 Feb 2000 17:18:25 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-13.uni-koblenz.de (cacc-13.uni-koblenz.de [141.26.131.13])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id CAA25946;
	Wed, 2 Feb 2000 02:17:45 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407893AbQBBBRB>;
	Wed, 2 Feb 2000 02:17:01 +0100
Date:   Wed, 2 Feb 2000 02:17:01 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Question concerning memory configuration variables
Message-ID: <20000202021701.A22003@uni-koblenz.de>
References: <38970DA5.165EDA0F@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <38970DA5.165EDA0F@ti.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Feb 01, 2000 at 09:45:25AM -0700, Jeff Harrell wrote:

> I have been looking at 2.2.23 and noticed that a few things concerning
> memory paging has changed.  I wonder if anybody could give me a definition
> of a couple of the variables that are defined.  The first is the
> max_low_pfn variable.  It looks like the first time that I see this called
> is during the paging_init() function and passed to free_area_init().  The
> memory map size is determined from this variable.  It memory map will
> extend to the end of physical memory (what used to be mips_memory_ upper).
> Do I determine the max_low_pfn by calculating the available memory and
> subtract the size of the kernel?  How does the variable "start" play into
> this equation?  Are they the same?  Any help would be greatly appreciated.

The max_low_pfn variable is the number of `normal' memory pages.  Normal
as opposed to high memory which we don't currently don't support on MIPS.
That is for contiguous memory starting at physical address zero it's
value equals available_memory / PAGE_SIZE.

The value of max_low_pfn is set by a call to init_bootmem.  A typical
setup could look like below.  Mb in this example is the number of
available megabytes of memory.  You may simplify this somewhat more,
it's derived from the Origin code.

        free_start = PFN_ALIGN(&_end) - PAGE_OFFSET;
        free_end = PAGE_OFFSET + (mb << 20);
        start_pfn = PFN_UP((unsigned long)&_end - PAGE_OFFSET);

        /* Register all the contiguous memory with the bootmem allocator
           and free it.  Be careful about the bootmem freemap.  */
        bootmap_size = init_bootmem(start_pfn, mb << (20 - PAGE_SHIFT));

	/* Free the entire available memory after the _end symbol.  */
        free_bootmem(__pa(free_start), (mb << 20) - __pa(free_start));

	/* We also did free the memory where the bootmap is stored,
	   reserve it again. */
        reserve_bootmem(__pa(free_start), bootmap_size);

        printk("Found %ldmb of memory.\n", mb);

  Ralf

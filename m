Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 16:27:10 +0000 (GMT)
Received: from [213.189.19.80] ([213.189.19.80]:65293 "EHLO mail.kpsws.com")
	by ftp.linux-mips.org with ESMTP id S8133489AbWBIQ1A (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2006 16:27:00 +0000
Received: (qmail 35518 invoked by uid 89); 9 Feb 2006 16:32:36 -0000
Received: from unknown (HELO mail.kpsws.com) (127.0.0.1)
  by localhost with SMTP; 9 Feb 2006 16:32:36 -0000
Received: from 194.171.252.101
        (SquirrelMail authenticated user pulsar@kpsws.com)
        by mail.kpsws.com with HTTP;
        Thu, 9 Feb 2006 17:32:36 +0100 (CET)
Message-ID: <13126.194.171.252.101.1139502756.squirrel@mail.kpsws.com>
In-Reply-To: <20060210.005104.63742308.anemo@mba.ocn.ne.jp>
References: <20060210.005104.63742308.anemo@mba.ocn.ne.jp>
Date:	Thu, 9 Feb 2006 17:32:36 +0100 (CET)
Subject: changing the page properties to cached/uncached
From:	"Niels Sterrenburg" <pulsar@kpsws.com>
To:	linux-mips@linux-mips.org
Reply-To: pulsar@kpsws.com
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Return-Path: <pulsar@kpsws.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pulsar@kpsws.com
Precedence: bulk
X-list: linux-mips

Dear list members,

Sorry for the long mail, but we're trying some exiting things
on which we need help....

----------------------

What we want:

----------------------

We have a multiprocessor system containing one MIPS r4k and
one DSP (alike) processor.

We are porting our Inter Processor Communication software to
do communication by the use of
interrupts between MIPS and DSP and
via a shared memory area in RAM for the data transfer.



SDRAM memory map:



0x00000000-0x03000000: MIPS with Linux:	48 MB

0x03000000-0x04000000: DSP software:    16 MB

0x04000000-0x08000000: Shared memory:   64 MB



We want to make this shared memory available to userspace applications so
that they can use it
without having a copy over the kernel boundary.



Besides that we want to set the shared memory cache coherancy to cached
copy-back !!!



----------------------

Our strategy:

----------------------

- Do not use swapping in the system

- Limit Linux memory usage via the mem= option in the kernel command line.

- From MIPS user space: do a mmap for the shared memory area.

- From MIPS user space: call (our selfwritten) shmemipc driver with the
request to set the mapped pages to cached (by passing virtual address and
length).

- From kernel space: find the vma for the supplied virtual address range
and change cache properties of all pages in that virtual range.



At this point the userspace application should have a cached view to
shared memory.

For flushing and invalidate we intend to use the same shmemipc driver
(e.g. to delegate the job to kernel space).



E.g.

userapp wants to read shared memory: call shmemipc driver to invalidate a
certain virtual range (before the read)

userapp wants to write shared memory: call shmemipc driver to flush a
certain virtual range (after the write)

etc.



----------------------

What we tried:

----------------------

We exported the cache flush routines in the kernel so that we can use them
in a loadable module.

We exported the tlb flush routines in the kernel so that we can use them
in a loadable module.

We succesfully do an mmap of the shared memory:

- As we mmap outside the kernel sdram (<48MB), mmap creates new pages
which are initialized to uncached, e.g. it assumes I/O)



In the driver we can find a valid vma for the memory mapped range.



We (try to) change the cache porperties of the page(s) in the vma by:

- adapting the vma->vm_page_prot and set cache properties to cached.

- for this we created the following inline derived from pgprot_noncached:

static inline pgprot_t pgprot_cached(pgprot_t _prot)

{

    unsigned long prot = pgprot_val(_prot);



    prot = (prot & ~_CACHE_MASK) | _CACHE_CACHABLE_NONCOHERENT;



    return __pgprot(prot);

}

- this inline we use as follows:

vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);

- After this we do a local_flush_tlb_page or local_flush_tlb_all in order
to get the hardware TLB updated by the adapted oine in the page table.



----------------------

Open issues:

----------------------

We use dump_tlb_all to see if the cache properties of the page has
changed, which is not the case.
We use a multiprocessor test to check if the shared memory view from MIPS
is cached, which is not the case.



What are we missing here ?

What are the exact steps for adapting page properties in the kernel (for
MIPS) ?

We looked at remap_pfn_range but this sets pages to be IO and reserved....



Any help is very much appreciated.

regards,

Niels Sterrenburg

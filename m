Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 10:27:49 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:8270 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225192AbTBRK1s>;
	Tue, 18 Feb 2003 10:27:48 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 3CCF1CF6B; Tue, 18 Feb 2003 11:27:23 +0100 (CET)
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: weirdness in bootmem_init(), arch/mips64/kernel/setup.c
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030218065427.GA915@pureza.melbourne.sgi.com> (Andrew
 Clausen's message of "Tue, 18 Feb 2003 17:54:27 +1100")
References: <20030218065427.GA915@pureza.melbourne.sgi.com>
Date: Tue, 18 Feb 2003 11:27:23 +0100
Message-ID: <86ptpplw8k.fsf@trasno.mitica>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2.93
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "andrew" == Andrew Clausen <clausen@melbourne.sgi.com> writes:

andrew> Hi all,
andrew> This code isn't really relevant to what I'm working on (it isn't compiled
andrew> in to kernels for the ip27), but I just noticed it, and it looks broken:

andrew> /* Find the highest page frame number we have available.  */
andrew> max_pfn = 0;
andrew> for (i = 0; i < boot_mem_map.nr_map; i++) {
andrew> unsigned long start, end;

andrew> if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
andrew> continue;

andrew> *****           start = PFN_UP(boot_mem_map.map[i].addr);
andrew> *****           end = PFN_DOWN(boot_mem_map.map[i].addr
andrew> + boot_mem_map.map[i].size);

andrew> *****           if (start >= end)
andrew> continue;
andrew> if (end > max_pfn)
andrew> max_pfn = end;
andrew> }


andrew> That test looks like it will always succeed... and it looks like the
andrew> author wanted it to be a sanity check.

andrew> Why all this business with PFN_UP and PFN_DOWN?  (They are bit
andrew> shifts... PFN_UP shifts left, PFN_DOWN shifts right)

Not completely sure, but I think that it is related with the weird
discontig memory that Origins (and I think other MIPS machines) have.

(Just having put the file where that thing are, will have saved me a
grep :)

1st- Looking at the code, both of them shift right:

#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)

PFN_UP -> page frame of next page
PFN_DOWN -> page frame of this page

2nd - if the region is empty (size = 0), start will be == end, which
      means that we don't considerd that area for checking what memory
      are available.

Standard disclaimer: That is my reading/things that I remind about
   that, any resemblance with reality can be pure coincidence :p  I am
   not an expert in SGI machines lowlevel details but any mean.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16DHri20298
	for linux-mips-outgoing; Wed, 6 Feb 2002 05:17:53 -0800
Received: from holomorphy (mail@holomorphy.com [216.36.33.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16DHmA20295;
	Wed, 6 Feb 2002 05:17:48 -0800
Received: from wli by holomorphy with local (Exim 3.33 #1 (Debian))
	id 16YRx7-0002tw-00; Wed, 06 Feb 2002 05:17:33 -0800
Date: Wed, 6 Feb 2002 05:17:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
Message-ID: <20020206131733.GF744@holomorphy.com>
References: <3C600D4C.43CBA784@cotw.com> <20020206033346.A7298@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020206033346.A7298@dea.linux-mips.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 05, 2002 at 10:50:20AM -0600, Steven J. Hill wrote:
>> I am just trying to fill in some more MIPS knowledge here. With a 32-bit
>> MIPS processor, we are forever limited to a userspace of 2GB in size thanks
>> to the kuser region. kseg0/1 map the same 512MB of physical memory. kseg2
>> is 1GB in size and hence it could address another 1GB of RAM. So, is the

On Wed, Feb 06, 2002 at 03:33:46AM +0100, Ralf Baechle wrote:
> 2gb virtual memory per process.  In theory physical memory is limited by
> the size of the address bus with highmem; the practical limit for highmem
> should be in the range of 16-32gb RAM.

I'm aware that some of those issues have to do with boot-time allocations
proportional to memory size filling the direct-mapped portion of the kernel
virtual address space. Do you have in mind others? I'm just generally
curious.


Thanks,
Bill

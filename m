Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Apr 2006 10:41:27 +0100 (BST)
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:51838 "HELO
	web25806.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133470AbWD2JlR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 29 Apr 2006 10:41:17 +0100
Received: (qmail 90845 invoked by uid 60001); 29 Apr 2006 09:41:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=jtGm1STmeudxbeHrdFce8+l3T/esLw8IXTF/N/yfHGJ7K4rpPJ5gqWUkmkIcKp1OM/1DodkoFUzbovcBezywirmRSJcTNnFQeA3NB8Rw3YOueeb6LVuFPzOQ/89zTQ2pgJPZJ2UM3Wlb3/s4nhipEgWKeeh8ZAXGLPIxE2YoXJA=  ;
Message-ID: <20060429094101.90843.qmail@web25806.mail.ukl.yahoo.com>
Date:	Sat, 29 Apr 2006 11:41:01 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : module allocation
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

On Fri, Apr 28, 2006 at 01:04:17PM +0000, moreau francis wrote:

> Maybe a silly question...why do we use mapped memory (allocated by
> vmalloc) for inserting a module into the kernel ?
> 

Ok, to sum up things:

Pros:
  - allocation granularity is a page size  where as GFP allocations is a power
    of two...
  - better chance for the module to get loaded into fragmented memory.

Cons:
  - it consumes TLB entries, (usually one ?)
  - it needs to generate the module with "-mlong-calls" switch which generates
    larger and less efficient code.
  - there will be a refill exception overhead each time the module code will be
    executed and it's not mapped through TLB.

maybe that would make sense to do some benchmarks ?

Thanks

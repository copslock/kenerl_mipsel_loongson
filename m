Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 21:03:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57750 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133504AbWD1UDJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2006 21:03:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3SK38dD018383;
	Fri, 28 Apr 2006 21:03:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3SK379u018382;
	Fri, 28 Apr 2006 21:03:07 +0100
Date:	Fri, 28 Apr 2006 21:03:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: module allocation
Message-ID: <20060428200307.GA17705@linux-mips.org>
References: <20060428130417.71285.qmail@web25813.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428130417.71285.qmail@web25813.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 28, 2006 at 01:04:17PM +0000, moreau francis wrote:

> Maybe a silly question...why do we use mapped memory (allocated by
> vmalloc) for inserting a module into the kernel ?
> 
> I can see only drawbacks:
> 
>   - It consumes TLB entries,
> 
>   - When accessing to the module's code, we use TLB entries which can
>     be bad for interrupt latencies. For instance: if the module has an
>     interrupt handler and the module's code in still not mapped in the
>     TLB, we got a page fault...

Not quite.  There will be a TLB reload exception but that it's.  These
TLB entries are all marked global, dirty and valid so the overhead is
as big as in the best case for user pages.

>   - Modules are usually loaded at startup, at this time the memory
>     should not be fragmented.

Usually but not always and we need to guarantee that things are working
under all circumstances.

There is another reason against putting modules into mapped space and
that's the need for -mlong-calls which generates larger, less efficient
code.

One disadvantage of using GFP allocations would be that they're rounding up
the memory allocations to the next power of two, so a 40k module for
example would actually allocate 64k ...

  Ralf

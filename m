Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2003 12:05:39 +0000 (GMT)
Received: from p508B6F73.dip.t-dialin.net ([IPv6:::ffff:80.139.111.115]:54949
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTCTMFi>; Thu, 20 Mar 2003 12:05:38 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2KC5TL16122;
	Thu, 20 Mar 2003 13:05:29 +0100
Date: Thu, 20 Mar 2003 13:05:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: linux-mips@linux-mips.org
Subject: Re: Cache code changes
Message-ID: <20030320130528.A15475@linux-mips.org>
References: <20030320111625.A13219@linux-mips.org> <3E79A121.6000409@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E79A121.6000409@ict.ac.cn>; from fxzhang@ict.ac.cn on Thu, Mar 20, 2003 at 07:08:17PM +0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 20, 2003 at 07:08:17PM +0800, Fuxin Zhang wrote:

> I am very glad to see this happens:)


> Currently linux/mips is really far from efficient,I've some data for 
> this declaration:
>    For most SPEC CPU 2000 programs we run on a 4-way superscalar CPU 
> simulator
> ,we get <0.20 IPC in kernel mode,while the IPCs for the whole execution 
> are often much
> higher(0.5-1.5). We believe this has something to do with the overly 
> used cache flushes.

What type of cache are you using in this simulation?  Virtual/physical
indexing/tagging, what associativity?

Linux/MIPS's handling of virtually indexed data caches isn't as good as
it should be but that's what I'm working on.

> BTW, for 2.4.17,it seems this path is still not safe for cache aliases:
>     copy_cow_page for newly forked process, we use kernel virtual address
> to do the copy,but without flush first.
> add a flush_page_to_ram before the copy fix the errors.
> 
> but i am not sure whether i am missing something

The functions clear_user_page and copy_user_page are supposed to take care
of aliases in this case.  That's what the little patch did in my previous
mail did, just in a rather inefficient way.

  Ralf

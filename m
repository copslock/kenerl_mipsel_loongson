Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 15:58:59 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:25622 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225304AbVCKP6p>; Fri, 11 Mar 2005 15:58:45 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2BFwPxn009257;
	Fri, 11 Mar 2005 15:58:25 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2BFwOpp009255;
	Fri, 11 Mar 2005 15:58:24 GMT
Date:	Fri, 11 Mar 2005 15:58:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rishabh@soc-soft.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Memory Management HAndling
Message-ID: <20050311155823.GC5958@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C61E22B@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C61E22B@soc-mail.soc-soft.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 11, 2005 at 10:55:43AM +0530, Rishabh@soc-soft.com wrote:

> I have been working on MMU of Linux Port of 2.4.20 kernel for MIPS Port.

You may want to change to a kernel that has less than 52 months worth of
bugs and security holes.

> I have found that MACROS like
> 
> #define __pa(x)		((unsigned long) (x) - PAGE_OFFSET)
> #define __va(x)		((void *)((unsigned long) (x) + PAGE_OFFSET))
> #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
> 
> 
> These macros can handle memory pages in KSEG0. Any suggestions on how
> can they be changed for addressing memory present in HIGHMEM. Since VA
> will not be in linear relation with mem_map.

That's normal for highmem.  These macros will only work for lowmem.

  Ralf

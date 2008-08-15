Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 16:49:01 +0100 (BST)
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2269 "EHLO e2.ny.us.ibm.com")
	by ftp.linux-mips.org with ESMTP id S28575434AbYHOPsy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2008 16:48:54 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7FFmhBR028282
	for <linux-mips@linux-mips.org>; Fri, 15 Aug 2008 11:48:43 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7FFmLVZ187942
	for <linux-mips@linux-mips.org>; Fri, 15 Aug 2008 11:48:22 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7FFmLtF023568
	for <linux-mips@linux-mips.org>; Fri, 15 Aug 2008 11:48:21 -0400
Received: from [9.48.113.232] (sig-9-48-113-232.mts.ibm.com [9.48.113.232])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m7FFmJHD023499;
	Fri, 15 Aug 2008 11:48:20 -0400
Subject: Re: sparsemem support for mips with highmem
From:	Dave Hansen <dave@linux.vnet.ibm.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	C Michael Sundius <Michael.sundius@sciatl.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, jfraser@broadcom.com,
	Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20080815080331.GA6689@alpha.franken.de>
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz>
	 <48A4C542.5000308@sciatl.com>  <20080815080331.GA6689@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8
Date:	Fri, 15 Aug 2008 08:48:19 -0700
Message-Id: <1218815299.23641.80.camel@nimitz>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
Content-Transfer-Encoding: 8bit
Return-Path: <dave@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips

On Fri, 2008-08-15 at 10:03 +0200, Thomas Bogendoerfer wrote:
> On Thu, Aug 14, 2008 at 04:52:34PM -0700, C Michael Sundius wrote:
> > +
> > +#ifndef CONFIG_64BIT
> > +#define SECTION_SIZE_BITS       27	/* 128 MiB */
> > +#define MAX_PHYSMEM_BITS        31	/* 2 GiB   */
> > +#else
> >  #define SECTION_SIZE_BITS       28
> >  #define MAX_PHYSMEM_BITS        35
> > +#endif
> 
> why is this needed ?

I'm sure Michael can speak to the specifics.  But, in general, making
SECTION_SIZE_BITS smaller is good if you have lots of small holes in
memory.  It does this at the cost if increasing the size of the
mem_section[] array.

MAX_PHYSMEM_BITS should be as as small as possible, but not so small
that it restricts the amount of RAM that your systems
support.  ﻿Increasing it has the effect of increasing the size of the
mem_section[] array.

My guess would be that Michael knew that his 32-bit MIPS platform only
ever has 2GB of memory.  He also knew that its holes (or RAM) come in
128MB sections.  This configuration lets him save the most amount of
memory with SPARSEMEM.

Michael, I *guess* you could also include a wee bit on how you chose
your numbers in the documentation.  Not a big deal, though.

-- Dave

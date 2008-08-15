Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 18:38:41 +0100 (BST)
Received: from e3.ny.us.ibm.com ([32.97.182.143]:4034 "EHLO e3.ny.us.ibm.com")
	by ftp.linux-mips.org with ESMTP id S28576116AbYHORic (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Aug 2008 18:38:32 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7FHcCW8011504
	for <linux-mips@linux-mips.org>; Fri, 15 Aug 2008 13:38:12 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7FHc2tq171412
	for <linux-mips@linux-mips.org>; Fri, 15 Aug 2008 13:38:02 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7FHc1Zm019249
	for <linux-mips@linux-mips.org>; Fri, 15 Aug 2008 13:38:02 -0400
Received: from [9.48.113.232] (sig-9-48-113-232.mts.ibm.com [9.48.113.232])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m7FHc02h019174;
	Fri, 15 Aug 2008 13:38:00 -0400
Subject: Re: sparsemem support for mips with highmem
From:	Dave Hansen <dave@linux.vnet.ibm.com>
To:	C Michael Sundius <Michael.sundius@sciatl.com>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <48A5B9F1.3080201@sciatl.com>
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz>
	 <48A4C542.5000308@sciatl.com> <20080815080331.GA6689@alpha.franken.de>
	 <1218815299.23641.80.camel@nimitz> <48A5AADE.1050808@sciatl.com>
	 <20080815163302.GA9846@alpha.franken.de>  <48A5B9F1.3080201@sciatl.com>
Content-Type: text/plain; charset=UTF-8
Date:	Fri, 15 Aug 2008 10:37:55 -0700
Message-Id: <1218821875.23641.103.camel@nimitz>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
Content-Transfer-Encoding: 8bit
Return-Path: <dave@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips

On Fri, 2008-08-15 at 10:16 -0700, C Michael Sundius wrote:
> Ah, your right. thanks.  "but it's not necessar*il*y a good idea".
> That 
> is to say, we don't put
> memory above 2 GiB. No need to make the mem_section[] array bigger
> than 
> need be.
> 
> This gives further credence for it to be a configurable in Kconfig as
> well.

I definitely don't want it to be something that users see.  It is never
enough overhead to really care.  On a 16TB system with 16MB sections,
the mem_section[] array is still only 16MB!!

So, I'd say to just make it as big as the arch needs in the worst case
(smallest SECTION_SIZE_BITS and largest MAX_PHYSMEM_BITS) and leave it.
We might even want to merge the 32 and 64-bit versions.

For your 32-bit version, we now use:
8 bytes (2 32-bit words) for each mem_section[]
2GB/128MB sections = 16
So, that's only 512 bytes.

﻿For the 64-bit version, we now use:
16 bytes (2 64-bit words) for each mem_section[]
32GB/256MB sections = 128
So, that's only 2048 bytes.

If we were to merge the 32 and 64-bit versions to:
#define SECTION_SIZE_BITS       27
#define MAX_PHYSMEM_BITS        35

Your 32-bit version would go to 2048 bytes, and the 64-bit version would
go to 4096 bytes.  The 32-bit version would we able to address more
memory, and the 64-bit version would be able to handle smaller memory
holes more efficiently. 

-- Dave

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2008 22:25:23 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:4317 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S28579921AbYHRVZP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Aug 2008 22:25:15 +0100
Received: from [127.0.0.1] ([38.98.147.130])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7ILOn6K006343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Aug 2008 14:24:50 -0700
Message-ID: <48A9E89C.4020408@linux-foundation.org>
Date:	Mon, 18 Aug 2008 16:24:44 -0500
From:	Christoph Lameter <cl@linux-foundation.org>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Randy Dunlap <rdunlap@xenotime.net>
CC:	C Michael Sundius <Michael.sundius@sciatl.com>,
	Dave Hansen <dave@linux.vnet.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>	<48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>	<1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>	<20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>	<1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com> <20080818094412.09086445.rdunlap@xenotime.net>
In-Reply-To: <20080818094412.09086445.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <cl@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cl@linux-foundation.org
Precedence: bulk
X-list: linux-mips

Randy Dunlap wrote:

> +Sparsemem divides up physical memory in your system into N section of M
> 
>                                                             sections
> 
> +bytes. Page descriptors are created for only those sections that
> +actually exist (as far as the sparsemem code is concerned). This allows
> +for holes in the physical memory without having to waste space by
> +creating page discriptors for those pages that do not exist.
> 
>                descriptors
> 
> +When page_to_pfn() or pfn_to_page() are called there is a bit of overhead to
> +look up the proper memory section to get to the descriptors, but this
> +is small compared to the memory you are likely to save. So, it's not the
> +default, but should be used if you have big holes in physical memory.

This overhead can be avoided by configuring sparsemem to use a virtual vmemmap
(CONFIG_SPARSEMEM_VMEMMAP). In that case it can be used for non NUMA since the
overhead is less than even FLATMEM.

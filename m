Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2008 22:33:56 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:9351 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S28579505AbYHRVdt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Aug 2008 22:33:49 +0100
Received: from [127.0.0.1] ([38.98.147.130])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7ILXYa5007189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Aug 2008 14:33:36 -0700
Message-ID: <48A9EAA9.1080909@linux-foundation.org>
Date:	Mon, 18 Aug 2008 16:33:29 -0500
From:	Christoph Lameter <cl@linux-foundation.org>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Dave Hansen <dave@linux.vnet.ibm.com>
CC:	Randy Dunlap <rdunlap@xenotime.net>,
	C Michael Sundius <Michael.sundius@sciatl.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>	 <48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>	 <1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>	 <20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>	 <1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com>	 <20080818094412.09086445.rdunlap@xenotime.net>	 <48A9E89C.4020408@linux-foundation.org> <1219094865.23641.118.camel@nimitz>
In-Reply-To: <1219094865.23641.118.camel@nimitz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <cl@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cl@linux-foundation.org
Precedence: bulk
X-list: linux-mips

Dave Hansen wrote:
> On Mon, 2008-08-18 at 16:24 -0500, Christoph Lameter wrote:
>> This overhead can be avoided by configuring sparsemem to use a virtual vmemmap
>> (CONFIG_SPARSEMEM_VMEMMAP). In that case it can be used for non NUMA since the
>> overhead is less than even FLATMEM.
> 
> Is that all it takes these days, or do you need some other arch-specific
> code to help out?

Some information is in mm/sparse-vmemmap.c. Simplest configuration is to use
vmalloc for the populate function. Otherwise the arch can do what it wants to
reduce the overhead of virtual mappings (in the x86 case we use a 2M TLB
entry, and since 2M TLBs are also used for the 1-1 physical mapping the
overhead is the same as for 1-1 mappings).

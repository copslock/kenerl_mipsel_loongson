Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2008 22:28:06 +0100 (BST)
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33427 "EHLO e1.ny.us.ibm.com")
	by ftp.linux-mips.org with ESMTP id S28579679AbYHRV17 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2008 22:27:59 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7ILRmKt028071
	for <linux-mips@linux-mips.org>; Mon, 18 Aug 2008 17:27:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7ILRmsG189244
	for <linux-mips@linux-mips.org>; Mon, 18 Aug 2008 17:27:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7ILRlR2013779
	for <linux-mips@linux-mips.org>; Mon, 18 Aug 2008 17:27:47 -0400
Received: from [9.48.114.35] (sig-9-48-114-35.mts.ibm.com [9.48.114.35])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m7ILRjC4013714;
	Mon, 18 Aug 2008 17:27:46 -0400
Subject: Re: sparsemem support for mips with highmem
From:	Dave Hansen <dave@linux.vnet.ibm.com>
To:	Christoph Lameter <cl@linux-foundation.org>
Cc:	Randy Dunlap <rdunlap@xenotime.net>,
	C Michael Sundius <Michael.sundius@sciatl.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <48A9E89C.4020408@linux-foundation.org>
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>
	 <48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>
	 <1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>
	 <20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>
	 <1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com>
	 <20080818094412.09086445.rdunlap@xenotime.net>
	 <48A9E89C.4020408@linux-foundation.org>
Content-Type: text/plain
Date:	Mon, 18 Aug 2008 14:27:45 -0700
Message-Id: <1219094865.23641.118.camel@nimitz>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
Content-Transfer-Encoding: 7bit
Return-Path: <dave@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips

On Mon, 2008-08-18 at 16:24 -0500, Christoph Lameter wrote:
> 
> This overhead can be avoided by configuring sparsemem to use a virtual vmemmap
> (CONFIG_SPARSEMEM_VMEMMAP). In that case it can be used for non NUMA since the
> overhead is less than even FLATMEM.

Is that all it takes these days, or do you need some other arch-specific
code to help out?

-- Dave

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 19:12:40 +0100 (BST)
Received: from e3.ny.us.ibm.com ([32.97.182.143]:6338 "EHLO e3.ny.us.ibm.com")
	by ftp.linux-mips.org with ESMTP id S20036135AbYFMSMi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2008 19:12:38 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5DICKqc023697
	for <linux-mips@linux-mips.org>; Fri, 13 Jun 2008 14:12:20 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5DICAMK208862
	for <linux-mips@linux-mips.org>; Fri, 13 Jun 2008 14:12:10 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5DIC9LT024039
	for <linux-mips@linux-mips.org>; Fri, 13 Jun 2008 14:12:09 -0400
Received: from [9.76.91.124] (sig-9-76-91-124.mts.ibm.com [9.76.91.124])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m5DIC8Fg024009;
	Fri, 13 Jun 2008 14:12:08 -0400
Subject: Re: [RFC PATCH 2/2] Update defconfigs for CONFIG_HUGETLB
From:	Adam Litke <agl@us.ibm.com>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	linux-mm <linux-mm@kvack.org>, npiggin@suse.de, nacc@us.ibm.com,
	mel@csn.ul.ie, Eric B Munson <ebmunson@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-mips@linux-mips.org
In-Reply-To: <20080612193638.GB17231@cs181133002.pp.htv.fi>
References: <1213296540.17108.8.camel@localhost.localdomain>
	 <1213296945.17108.13.camel@localhost.localdomain>
	 <20080612193638.GB17231@cs181133002.pp.htv.fi>
Content-Type: text/plain
Organization: IBM
Date:	Fri, 13 Jun 2008 14:12:08 -0400
Message-Id: <1213380728.15016.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
Content-Transfer-Encoding: 7bit
Return-Path: <agl@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agl@us.ibm.com
Precedence: bulk
X-list: linux-mips

On Thu, 2008-06-12 at 22:36 +0300, Adrian Bunk wrote:
> On Thu, Jun 12, 2008 at 02:55:45PM -0400, Adam Litke wrote:
> > Update all defconfigs that specify a default configuration for hugetlbfs.
> > There is now only one option: CONFIG_HUGETLB.  Replace the old
> > CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS options with the new one.  I found no
> > cases where CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE had different values so
> > this patch is large but completely mechanical:
> >...
> >  335 files changed, 335 insertions(+), 385 deletions(-)
> >...
> 
> Please don't do this kind of patches - it doesn't bring any advantage 
> but can create tons of patch conflicts.
> 
> The next time a defconfig gets updated it will anyway automatically be 
> fixed, and for defconfigs that aren't updated it doesn't create any 
> problems to keep them as they are today until they might one day get 
> updated.

Thanks for taking a look.  I am not sure if I have ever seen a defconfig
patch hit the mailing list before and I was wondering how those changes
happen.  In any case I am perfectly happy to drop this huge patch and
stick with just the first one.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

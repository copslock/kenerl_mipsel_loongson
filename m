Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 20:37:52 +0100 (BST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:27279 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28580364AbYFLThu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 20:37:50 +0100
Received: from cs181133002.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 4C1B85BC042;
	Thu, 12 Jun 2008 22:37:47 +0300 (EEST)
Date:	Thu, 12 Jun 2008 22:36:40 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Adam Litke <agl@us.ibm.com>
Cc:	linux-mm <linux-mm@kvack.org>, npiggin@suse.de, nacc@us.ibm.com,
	mel@csn.ul.ie, Eric B Munson <ebmunson@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 2/2] Update defconfigs for CONFIG_HUGETLB
Message-ID: <20080612193638.GB17231@cs181133002.pp.htv.fi>
References: <1213296540.17108.8.camel@localhost.localdomain> <1213296945.17108.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1213296945.17108.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 02:55:45PM -0400, Adam Litke wrote:
> Update all defconfigs that specify a default configuration for hugetlbfs.
> There is now only one option: CONFIG_HUGETLB.  Replace the old
> CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS options with the new one.  I found no
> cases where CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE had different values so
> this patch is large but completely mechanical:
>...
>  335 files changed, 335 insertions(+), 385 deletions(-)
>...

Please don't do this kind of patches - it doesn't bring any advantage 
but can create tons of patch conflicts.

The next time a defconfig gets updated it will anyway automatically be 
fixed, and for defconfigs that aren't updated it doesn't create any 
problems to keep them as they are today until they might one day get 
updated.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

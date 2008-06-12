Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 19:49:18 +0100 (BST)
Received: from e5.ny.us.ibm.com ([32.97.182.145]:63420 "EHLO e5.ny.us.ibm.com")
	by ftp.linux-mips.org with ESMTP id S28580284AbYFLStP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 19:49:15 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CIn6PA018545
	for <linux-mips@linux-mips.org>; Thu, 12 Jun 2008 14:49:06 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5CIn2FM208448
	for <linux-mips@linux-mips.org>; Thu, 12 Jun 2008 14:49:02 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5CIn1SZ017962
	for <linux-mips@linux-mips.org>; Thu, 12 Jun 2008 14:49:02 -0400
Received: from [9.76.32.101] (sig-9-76-32-101.mts.ibm.com [9.76.32.101])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m5CIn0ER017843;
	Thu, 12 Jun 2008 14:49:01 -0400
Subject: [RFC PATCH 0/2] Merge HUGETLB_PAGE and HUGETLBFS Kconfig options
From:	Adam Litke <agl@us.ibm.com>
To:	linux-mm <linux-mm@kvack.org>
Cc:	agl@us.ibm.com, npiggin@suse.de, nacc@us.ibm.com, mel@csn.ul.ie,
	Eric B Munson <ebmunson@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: IBM
Date:	Thu, 12 Jun 2008 14:49:00 -0400
Message-Id: <1213296540.17108.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
Content-Transfer-Encoding: 7bit
Return-Path: <agl@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agl@us.ibm.com
Precedence: bulk
X-list: linux-mips

There are currently two global Kconfig options that enable/disable the
hugetlb code: CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS.  This may have
made sense before hugetlbfs became ubiquitous but now the pair of
options are redundant.  Merging these two options into one will simplify
the code slightly and will, more importantly, avoid confusion and
questions like: Which hugetlbfs CONFIG option should my code depend on?

CONFIG_HUGETLB_PAGE is aliased to the value of CONFIG_HUGETLBFS, so one
option can be removed without any effect.  The first patch merges the
two options into one option: CONFIG_HUGETLB.  The second patch updates
the defconfigs to set the one new option appropriately.

I have cross-compiled this on i386, x86_64, ia64, powerpc, sparc64 and
sh with the option enabled and disabled.  This is completely mechanical
but, due to the large number of files affected (especially defconfigs),
could do well with a review from several sets of eyeballs.  Thanks.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

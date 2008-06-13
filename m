Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 14:47:03 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:8160 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20035202AbYFMNrB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 14:47:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DDkYpb009968;
	Fri, 13 Jun 2008 14:46:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DDkTRP009937;
	Fri, 13 Jun 2008 14:46:29 +0100
Date:	Fri, 13 Jun 2008 14:46:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adam Litke <agl@us.ibm.com>
Cc:	linux-mm <linux-mm@kvack.org>, npiggin@suse.de, nacc@us.ibm.com,
	mel@csn.ul.ie, Eric B Munson <ebmunson@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 0/2] Merge HUGETLB_PAGE and HUGETLBFS Kconfig
	options
Message-ID: <20080613134629.GD16344@linux-mips.org>
References: <1213296540.17108.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1213296540.17108.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 02:49:00PM -0400, Adam Litke wrote:

> There are currently two global Kconfig options that enable/disable the
> hugetlb code: CONFIG_HUGETLB_PAGE and CONFIG_HUGETLBFS.  This may have
> made sense before hugetlbfs became ubiquitous but now the pair of
> options are redundant.  Merging these two options into one will simplify
> the code slightly and will, more importantly, avoid confusion and
> questions like: Which hugetlbfs CONFIG option should my code depend on?
> 
> CONFIG_HUGETLB_PAGE is aliased to the value of CONFIG_HUGETLBFS, so one
> option can be removed without any effect.  The first patch merges the
> two options into one option: CONFIG_HUGETLB.  The second patch updates
> the defconfigs to set the one new option appropriately.
> 
> I have cross-compiled this on i386, x86_64, ia64, powerpc, sparc64 and
> sh with the option enabled and disabled.  This is completely mechanical
> but, due to the large number of files affected (especially defconfigs),
> could do well with a review from several sets of eyeballs.  Thanks.

MIPS doesn't do HUGETLB (at least not in-tree atm) so I'm not sure why
linux-mips@linux-mips.org was cc'ed at all.  So feel free to add my
Couldnt-care-less: ack line ;-)

  Ralf

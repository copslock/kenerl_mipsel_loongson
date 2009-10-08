Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 16:41:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58250 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493192AbZJHOlZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 16:41:25 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n98EgWQk005713;
	Thu, 8 Oct 2009 16:42:33 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n98EgUro005710;
	Thu, 8 Oct 2009 16:42:30 +0200
Date:	Thu, 8 Oct 2009 16:42:30 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
Message-ID: <20091008144230.GA682@linux-mips.org>
References: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 08, 2009 at 04:57:32PM +0800, Wu Zhangjin wrote:

> When CONFIG_FLAGMEM enabled, STD/Hiberation will fail on YeeLoong
> laptop, This patch fix it:
> 
> if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
> return TRUE, but in reality, if the memory is not continuous, it should
> be false. for example:

Hm...  All that pfn_valid() indicates is that a page frame number is valid
to index a pfn.  That is that a pfn is valid to index the mem_map array.

> $ cat /proc/iomem | grep "System RAM"
> 00000000-0fffffff : System RAM
> 90000000-bfffffff : System RAM
> 
> as we can see, it is not continuous, so, some of the memory is not valid
> but regarded as valid by pfn_valid(), and at last make STD/Hibernate
> fail when shrinking a too large number of invalid memory.
> 
> Here, we fix it via checking pfn is in the "System RAM" or not, if yes,
> return TRUE.

Are the non-memory parts marked as reserved?

  Ralf

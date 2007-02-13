Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 19:04:17 +0000 (GMT)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:657 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20039277AbXBMTEM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 19:04:12 +0000
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 26C1D3ED7F;
	Tue, 13 Feb 2007 14:03:31 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17874.2946.982942.958962@zeus.sw.starentnetworks.com>
Date:	Tue, 13 Feb 2007 14:03:30 -0500
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: problems booting sb1250, page fault issue?
In-Reply-To: <20070213.233505.64804701.anemo@mba.ocn.ne.jp>
References: <17869.2075.900049.547334@zeus.sw.starentnetworks.com>
	<20070211.010336.15248113.anemo@mba.ocn.ne.jp>
	<17872.61204.190437.109367@zeus.sw.starentnetworks.com>
	<20070213.233505.64804701.anemo@mba.ocn.ne.jp>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto writes:
> On Mon, 12 Feb 2007 17:49:56 -0500, Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com> wrote:
> > I added both flush_data_cache_page to c-sb1.c and
> > __flush_icache_page() to flush_icache_page in cacheflush.h.
> > 
> > With those, the page faults work correctly and booting seems to be
> > reliable on 2.6.18.
> 
> I think the problem of c-sb1.c was fixed in lmo 2.6.18-stable branch.
> Could you try it?

I merged in the flush_data_cache_page routine (from linux-2.6.18.6
tag) instead of the ones from the mailing list and it's good as well.

Even though local_flush_data_cache_page is only used in
__ide_flush_dcache_range() (and that is inside a cpu_has_dc_aliases
check) it still might be good to fill it out anyway.

-- 
Dave Johnson
Starent Networks

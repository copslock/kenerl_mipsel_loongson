Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 04:10:06 +0200 (CEST)
Received: from p508B6FF8.dip.t-dialin.net ([80.139.111.248]:19135 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123891AbSJQCKG>; Thu, 17 Oct 2002 04:10:06 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9H29vk26805;
	Thu, 17 Oct 2002 04:09:57 +0200
Date: Thu, 17 Oct 2002 04:09:56 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: break_cow and cache flushing
Message-ID: <20021017040956.B26285@linux-mips.org>
References: <3DADFC0B.81C8C058@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DADFC0B.81C8C058@broadcom.com>; from kwalker@broadcom.com on Wed, Oct 16, 2002 at 04:53:47PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 16, 2002 at 04:53:47PM -0700, Kip Walker wrote:

To add a few technical details ...

> 1) 'flush_cache_page' seems to be intended for flushing virtually
> indexed dcaches when a virtual->physical mapping changes (based on
> PAddr)

Yes.

> 2) 'flush_page_to_ram' is also related to avoiding virtual aliasing in
> the dcache (based on VAddr)

Yes again.

Note that flush_page_to_ram is deprecated and should be implement as empty
function for all architecture and the other flushing mechanisms be used
instead.

> 3) 'flush_icache_page' seems to be intended for making the icache
> coherent with the dcache after an executable page has been filled

Yes.

> 4) 'break_cow' may copy an executable page that is marked executable,
> for example a stack page (which has VM_EXEC) and might contain a live
> signal trampoline

Yes.

> On a CPU with writeback physically indexed/tagged dcache and virtually
> indexed icache that isn't coherent with the dcache, (1) and (2) are NOPs
> and (3) must writeback the dcache and flush the icache.

Yes, where this is getting complicated by some CPUs where remote i-caches
are coherent but the local isn't.

  Ralf

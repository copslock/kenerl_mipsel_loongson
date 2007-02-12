Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 22:50:48 +0000 (GMT)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:28828 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20039135AbXBLWun (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Feb 2007 22:50:43 +0000
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 4C71A3EC0C;
	Mon, 12 Feb 2007 17:49:56 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17872.61204.190437.109367@zeus.sw.starentnetworks.com>
Date:	Mon, 12 Feb 2007 17:49:56 -0500
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: problems booting sb1250, page fault issue?
In-Reply-To: <20070211.010336.15248113.anemo@mba.ocn.ne.jp>
References: <17869.2075.900049.547334@zeus.sw.starentnetworks.com>
	<20070211.010336.15248113.anemo@mba.ocn.ne.jp>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto writes:
> You mean 2.6.18 is OK and more recent kernel has problem?  Or 2.6.18
> has problem?

2.6.18 has the problem.  I haven't tried a more recent version.

> Is this problem still happen in 2.6.20?
> 
> Please refer this thread:
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=710F16C36810444CA2F5821E5EAB7F230A0DFA%40NT-SJCA-0752.brcm.ad.broadcom.com

I added both flush_data_cache_page to c-sb1.c and
__flush_icache_page() to flush_icache_page in cacheflush.h.

With those, the page faults work correctly and booting seems to be
reliable on 2.6.18.

Thanks.

-- 
Dave Johnson
Starent Networks

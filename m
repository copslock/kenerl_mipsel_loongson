Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 23:30:17 +0100 (BST)
Received: from p508B618D.dip.t-dialin.net ([IPv6:::ffff:80.139.97.141]:21468
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225281AbTHFWaP>; Wed, 6 Aug 2003 23:30:15 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h76MUApR011881;
	Thu, 7 Aug 2003 00:30:10 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h76MU9UG011880;
	Thu, 7 Aug 2003 00:30:09 +0200
Date: Thu, 7 Aug 2003 00:30:09 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
Message-ID: <20030806223009.GA2669@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02> <3F30DFB7.8030304@ict.ac.cn> <20030806115531.GA12161@linux-mips.org> <3F30FA1E.3000002@ict.ac.cn> <20030806144513.GB12161@linux-mips.org> <3F3118F3.1030001@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3118F3.1030001@ict.ac.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2003 at 11:04:19PM +0800, Fuxin Zhang wrote:

> After cache rewrite,flush_page_to_ram is null; and in this case 
> flush_cache_page
> do nothing for a stack page. (It flushes only when has_dc_aliases or 
> exec set).
> So  the  one use  the new copy will  have problem ?!  Am I missing 
> something?

The stack page contains the trampoline so it must be marked executable,
so on an RM7000 flush_dcache_page must flush both the D-cache and
I-cache.

  Ralf

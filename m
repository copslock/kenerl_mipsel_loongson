Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 14:29:29 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:50714 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465647AbVJSN3J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 14:29:09 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9JDT3Fn022843;
	Wed, 19 Oct 2005 14:29:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9JDT2ub022828;
	Wed, 19 Oct 2005 14:29:02 +0100
Date:	Wed, 19 Oct 2005 14:29:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix zero length sys_cacheflush
Message-ID: <20051019132902.GE2616@linux-mips.org>
References: <20051019.195714.89066462.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019.195714.89066462.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 07:57:14PM +0900, Atsushi Nemoto wrote:

> I found cacheflush(0, 0, 0) will crash the system.
> 
> This is because flush_icache_range(start, end) tries to flushing whole
> address space (0 - ffffffff) if both start and end are zero (at least
> in c-r4k.c).

Applied,

  Ralf

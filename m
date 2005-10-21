Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 12:38:49 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:63752 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133434AbVJULi3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 12:38:29 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9LBcOou006517;
	Fri, 21 Oct 2005 12:38:24 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9LBcNgJ006512;
	Fri, 21 Oct 2005 12:38:23 +0100
Date:	Fri, 21 Oct 2005 12:38:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Call flush_icache_range for handle_tlb[lsm]
Message-ID: <20051021113823.GC2607@linux-mips.org>
References: <20051021.171208.55510690.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051021.171208.55510690.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 21, 2005 at 05:12:08PM +0900, Atsushi Nemoto wrote:

> Call flush_icache_range for handle_tlb[lsm].  These flushing were
> removed by 452cafe60d0605e9af0c33bbef4f9443776461ea.  This patch add
> them again in safe place.

Applied,

  Ralf

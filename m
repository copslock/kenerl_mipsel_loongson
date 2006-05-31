Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 21:37:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:25017 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133518AbWEaThZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 21:37:25 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4VJbPaG005526;
	Wed, 31 May 2006 20:37:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4VJbLHv005512;
	Wed, 31 May 2006 20:37:21 +0100
Date:	Wed, 31 May 2006 20:37:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] remove unused define from addrspace.h
Message-ID: <20060531193721.GA4697@linux-mips.org>
References: <20060531160005.3303a91e.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531160005.3303a91e.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 31, 2006 at 04:00:05PM +0900, Yoichi Yuasa wrote:

> This patch removes unused definitions from addrspace.h .
> If these definitions are needed, please let me know.

They're indeed unused so patch queued for 2.6.18.  I was planning to
eventually use the values deleted by your patch but came to the
conclusion they should rather be probed.  Another cleanup would be to
remove the per-processor definition of TO_PHYS_MASK - the fixed value
of 0x7ffffffffffffffULL should work for all processors.

Thanks,

  Ralf

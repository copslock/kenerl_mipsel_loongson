Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:47:02 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:50952 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465571AbVI3Kmg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:36 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLus005536;
	Fri, 30 Sep 2005 11:42:30 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8TNUxd5004328;
	Fri, 30 Sep 2005 00:30:59 +0100
Date:	Fri, 30 Sep 2005 00:30:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: sync c-tx39.c with c-r4k.c
Message-ID: <20050929233058.GA3983@linux-mips.org>
References: <20050928.202458.32344678.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928.202458.32344678.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 28, 2005 at 08:24:58PM +0900, Atsushi Nemoto wrote:

> tx39_flush_cache_range() do nothing if !cpu_has_dc_aliases.  It should
> flush d-cache and invalidate i-cache since TX39(H2) has separate I/D
> cache.

Thanks, applied.

If you and other patch submitters would in the future please also start
sending patches with Signed-off-by: lines, for more please see
Documentation/SubmittingPatches.

In the past I didn't bother because we ended up blending all patches in
the CVS archive anyway to the point where they just didn't make sense
anymore.  Now with git that has changed.

  Ralf

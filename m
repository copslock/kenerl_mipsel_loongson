Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2005 17:17:35 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:35599 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3466431AbVKDRRR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Nov 2005 17:17:17 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA4HI7jb007487;
	Fri, 4 Nov 2005 17:18:07 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA4HI5Ri007486;
	Fri, 4 Nov 2005 17:18:05 GMT
Date:	Fri, 4 Nov 2005 17:18:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] define MAX_UDELAY_MS
Message-ID: <20051104171805.GF2694@linux-mips.org>
References: <20051105.020254.41196576.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105.020254.41196576.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Nov 05, 2005 at 02:02:54AM +0900, Atsushi Nemoto wrote:

> If HZ was 1000, mdelay(2) cause overflow on multiplication in
> __udelay.  We should define MAX_UDELAY_MS properly to prevent this.

Applied,

  Ralf

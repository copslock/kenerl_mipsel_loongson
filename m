Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 11:49:41 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:20758 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465574AbVI3Kmh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Sep 2005 11:42:37 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8UAgLuq005536;
	Fri, 30 Sep 2005 11:42:30 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8U0KHHV004732;
	Fri, 30 Sep 2005 01:20:17 +0100
Date:	Fri, 30 Sep 2005 01:20:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jan Pedersen <jan.pedersen@glaze.dk>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] cfi: prevent kernel panic with cfi flash
Message-ID: <20050930002017.GG3983@linux-mips.org>
References: <20050927192543.CAD8F376451@rocket.glaze.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927192543.CAD8F376451@rocket.glaze.se>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 27, 2005 at 09:25:42PM +0200, Jan Pedersen wrote:

> When using the cfi (common flash interface) driver, every word written to
> the flash chips is followed by a operation complete poll. This poll is
> intended to have a timeout of 1 ms. However this timeout is calculated by
> HZ/1000, which happends to be 0 because HZ < 1000. The result of this is
> that there will be just one poll for operation complete. If this single poll
> fails, the kernel panics. This patch increases this timeout to HZ (1
> second). This is far more than needed, but is preferred over a panic. This
> fix is well tested and completely avoids the panic.
> 
> Signed-off-by: Jan Pedersen <jp@jp-embedded.com>

Patch looks good to me - but this code isn't maintained by linux-mips.org,
so you may want to resend your patches here:

MEMORY TECHNOLOGY DEVICES
P:      David Woodhouse
M:      dwmw2@infradead.org
W:      http://www.linux-mtd.infradead.org/
L:      linux-mtd@lists.infradead.org
S:      Maintained

Thanks anyway,

  Ralf

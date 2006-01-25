Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 13:29:08 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:7197 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133519AbWAYN2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 13:28:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0PDXOFE009807;
	Wed, 25 Jan 2006 13:33:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0PDXM00009806;
	Wed, 25 Jan 2006 13:33:22 GMT
Date:	Wed, 25 Jan 2006 13:33:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaj-Michael Lang <milang@tal.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP32 gbefb depth change fix
Message-ID: <20060125133322.GB3454@linux-mips.org>
References: <Pine.LNX.4.61.0601251502170.11000@tori.tal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601251502170.11000@tori.tal.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 03:06:53PM +0200, Kaj-Michael Lang wrote:

> The gbefb driver does not update the framebuffer layers visual
> setting when depth is changed with fbset, resulting in strange
> colors (very dark blue in 16-bit, almost black in 24-bit).
> The attached patch fixes that.

Please send to:

FRAMEBUFFER LAYER
P:      Antonino Daplas
M:      adaplas@pol.net
L:      linux-fbdev-devel@lists.sourceforge.net
W:      http://linux-fbdev.sourceforge.net/
S:      Maintained

  Ralf

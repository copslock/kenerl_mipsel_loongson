Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2011 10:39:41 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43599 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491082Ab1JYIjh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2011 10:39:37 +0200
Received: from finisterre.wolfsonmicro.main (unknown [85.13.70.251])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 6BCFA11085E;
        Tue, 25 Oct 2011 09:39:31 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.76)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1RIcXh-0008EQ-30; Tue, 25 Oct 2011 10:39:29 +0200
Date:   Tue, 25 Oct 2011 10:39:28 +0200
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mike Frysinger <vapier@gentoo.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
Message-ID: <20111025083928.GC31508@opensource.wolfsonmicro.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20111025083301.GD4605@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111025083301.GD4605@ponder.secretlab.ca>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17953

On Tue, Oct 25, 2011 at 10:33:01AM +0200, Grant Likely wrote:

> (not that I've actually tested this much yet; it should probably go
> into a separate branch to marinate in linux-next for a bit without
> impacting the other GPIO patches I've got queued.

Yes, it should.  I've test built a few configurations covering both
asm/gpio.h and default implementations and it seems to be doing the
right thing but I might well have missed something.  I'm hoping to also
have a further patch to go on top of this which makes _OPTIONAL_GPOILIB
on by default.

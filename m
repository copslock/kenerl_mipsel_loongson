Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2011 09:29:56 +0100 (CET)
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:54830 "EHLO
        mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491029Ab1CXI3t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2011 09:29:49 +0100
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAH+cik1R8iFe/2dsb2JhbAClQniITbk9DYVcBA
Received: from 94.33-242-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.242.33.94])
  by relay.skynet.be with ESMTP; 24 Mar 2011 09:29:41 +0100
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1Q2fvI-0001iE-Km; Thu, 24 Mar 2011 09:29:40 +0100
Date:   Thu, 24 Mar 2011 09:29:40 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [trivial PATCH 1/2] treewide: Fix iomap resource size
        miscalculations
Message-ID: <20110324082940.GB4968@infomag.iguana.be>
References: <cover.1300909445.git.joe@perches.com> <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Joe,

> Convert off-by-1 r->end - r->start to resource_size(r)
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arm/mach-ux500/mbox-db5500.c |    6 ++----
>  arch/mips/rb532/gpio.c            |    2 +-
>  drivers/video/msm/mddi.c          |    2 +-
>  drivers/watchdog/bcm63xx_wdt.c    |    2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

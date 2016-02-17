Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 22:18:06 +0100 (CET)
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:25883 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012508AbcBQVSElTUb4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2016 22:18:04 +0100
X-MHO-User: fbec20d0-d5bb-11e5-8dfb-c75234cc769e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.100
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.100])
        by outbound1.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Wed, 17 Feb 2016 21:18:26 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 7FF978006E;
        Wed, 17 Feb 2016 21:17:59 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 7FF978006E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1455743879;
        bh=FZuv7164CvRV20rL9Jhdc5Pn2bbR3wtCi/P3jQkCSEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a47pEZTACRuEkLt4EP3m5y5bWMtVy2z5BNiy4IFZoULFUcEpP9UlNXmxikz4t1X+E
         MB0Ld5UMyomhHwjGsMJnd+RtoWkHgSvGDRRSE10a0C0aFb5CaNaPDk091T5lJS/8sf
         ShxIfCMlm6rsWFdXaNAS/PMVb+3c8F0Lj8Gvg0o5M+mS0pSp7HuNOGlxLZNcoY8Aw8
         c9UQmNVpL8sg5/RtTBI3TLnwHkwNt/c60wl1KOp456FHrHrc7LmYcs+/wOG2nCUBbv
         cLiisi3vPMz0QPBrU7A8eq98Y8GiuNH29IYP2i3bJh00mXajDdCDgWtVS0IuxKQsjX
         nhb2e/ufNRtsA==
Date:   Wed, 17 Feb 2016 21:17:59 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MIPS: ath79: irq: Move the MISC driver to
 drivers/irqchip
Message-ID: <20160217211759.GL5183@io.lakedaemon.net>
References: <1453553867-27003-1-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453553867-27003-1-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Alban,

On Sat, Jan 23, 2016 at 01:57:46PM +0100, Alban Bedel wrote:
> The driver stays the same but the initialization changes a bit.
> For OF boards we now get the memory map from the OF node and use
> a linear mapping instead of the legacy mapping. For legacy boards
> we still use a legacy mapping and just pass down all the parameters
> from the board init code.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> Changelog:
> v2: * Added the missing calls to chained_irq_enter/leave()
> ---
>  arch/mips/ath79/irq.c                    | 163 +++-----------------------
>  arch/mips/include/asm/mach-ath79/ath79.h |   3 +
>  drivers/irqchip/Makefile                 |   1 +
>  drivers/irqchip/irq-ath79-misc.c         | 189 +++++++++++++++++++++++++++++++
>  4 files changed, 208 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/irqchip/irq-ath79-misc.c

Both applied to irqchip/mips with Marc's Acked-by.

thx,

Jason.

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:18:51 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45182 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903864Ab1KPTSs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 20:18:48 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAGJIlgo015055;
        Wed, 16 Nov 2011 19:18:47 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAGJIlhr015053;
        Wed, 16 Nov 2011 19:18:47 GMT
Date:   Wed, 16 Nov 2011 19:18:47 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
Subject: Re: [PATCH 00/13] MIPS: ath79: add initial support for AR933X SoCs
Message-ID: <20111116191847.GQ8932@linux-mips.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13755

On Mon, Jun 20, 2011 at 09:26:00PM +0200, Gabor Juhos wrote:

> This patch set adds initial support for the Atheros AR933X SoCs.
> 
> The patch set depends on the following unmerged patches:
> MIPS: ath79: modify number of available IRQs
> MIPS: ath79: handle more MISC IRQs
> MIPS: ath79: add common USB Host Controller device
> 
> Gabor Juhos (13):
>   MIPS: ath79: remove superfluous parentheses
>   MIPS: ath79: add revision id for the AR933X SoCs
>   MIPS: ath79: add early printk support for the AR933X SoCs
>   MIPS: ath79: add AR933X specific clock init
>   MIPS: ath79: add AR933X specific glue for
>     ath79_device_reset_{set,clear}
>   MIPS: ath79: add AR933X specific IRQ initialization
>   MIPS: ath79: add AR933X specific GPIO initialization
>   MIPS: ath79: add config symbol for the AR933X SoCs
>   USB: ehci-ath79: add device_id entry for the AR933X SoCs
>   MIPS: ath79: add AR933X specific USB platform device registration
>   serial: add driver for the built-in UART of the AR933X SoC
>   MIPS: ath79: register UART device for the AR933X SoCs
>   MIPS: ath79: add initial support for the Atheros AP121 reference
>     board

I've merged this entire series and a previous 3 part series that is
required for this series to be applied.  But the patches are no longer
entirely fresh.  I'm going to review it for changes needed due to
changes elsewhere in the kernel and try to fix it up.  I don't have
hardware to test on so I'd appreciate testing by others as a valuable
help to get this upstream for 3.3 in a good shape!

Thanks,

  Ralf

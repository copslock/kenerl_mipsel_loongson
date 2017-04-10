Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 00:06:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6618 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993910AbdDJWGOJkOmK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 00:06:14 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 436E741F8D55;
        Tue, 11 Apr 2017 00:12:36 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 11 Apr 2017 00:12:36 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 11 Apr 2017 00:12:36 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BDA54331FB054;
        Mon, 10 Apr 2017 23:06:03 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 10 Apr
 2017 23:06:07 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 10 Apr
 2017 15:06:05 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] irqchip/mips-gic: Fix Local compare interrupt
Date:   Mon, 10 Apr 2017 15:06:00 -0700
Message-ID: <9298882.YeGiCV4jUY@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <1490958332-31094-3-git-send-email-matt.redfearn@imgtec.com>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com> <1490958332-31094-3-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1982805.bh7FSdFrlm";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart1982805.bh7FSdFrlm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Matt,

On Friday, 31 March 2017 04:05:32 PDT Matt Redfearn wrote:
> Commit 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts") added
> mapping of several local interrupts during initialisation of the gic
> driver. This associates virq numbers with these interrupts.
> Unfortunately, as not all of the interrupts are mapped in hardware
> order, when drivers subsequently request these interrupts they conflict
> with the mappings that have already been set up. For example, this
> manifests itself in the gic clocksource driver, which fails to probe
> with the message:
> 
> clocksource: GIC: mask: 0xffffffffffffffff max_cycles: 0x7350c9738,
> max_idle_ns: 440795203769 ns
> GIC timer IRQ 25 setup failed: -22
> 
> This is because virq 25 (the correct IRQ number specified via device
> tree) was allocated to the PERFCTR interrupt (and 24 to the timer, 26 to
> the FDC).

I'm confused by this - the DT doesn't specify VIRQs, it specifies hardware IRQ 
numbers. Which VIRQ is used should be irrelevant. Is this on a system using 
gic_clocksource_init() from platform code? (Malta?) and therefore relying on  
MIPS_GIC_IRQ_BASE?

If so I think this would be much more cleanly fixed by moving to probe the 
clocksource using DT than by adding more fragile order-dependent mappings in 
the GIC driver. Perhaps we have to live with it for this cycle though...

Thanks,
    Paul

> To fix this, map all of these local interrupts in the hardware
> order so as to associate their virq numbers with the correct hw
> interrupts.
> 
> Fixes: 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts")
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
> 
>  drivers/irqchip/irq-mips-gic.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 11d12bccc4e7..cd20df12d63d 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -991,8 +991,12 @@ static void __init gic_map_single_int(struct
> device_node *node,
> 
>  static void __init gic_map_interrupts(struct device_node *node)
>  {
> +	gic_map_single_int(node, GIC_LOCAL_INT_WD);
> +	gic_map_single_int(node, GIC_LOCAL_INT_COMPARE);
>  	gic_map_single_int(node, GIC_LOCAL_INT_TIMER);
>  	gic_map_single_int(node, GIC_LOCAL_INT_PERFCTR);
> +	gic_map_single_int(node, GIC_LOCAL_INT_SWINT0);
> +	gic_map_single_int(node, GIC_LOCAL_INT_SWINT1);
>  	gic_map_single_int(node, GIC_LOCAL_INT_FDC);
>  }


--nextPart1982805.bh7FSdFrlm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAljsAcgACgkQgiDZ+mk8
HGVlIRAAqduRkFEEnTH3I6vpQwkwoFtz8v6um0LA4MWhkZddicE01LOLgSvv5hzC
uctCVf4wZkVRAE2JUcPTrp4LKzLV2Ekk0egBkLiW/y3FBRcKOaeh94VvtmWBgWWQ
Psec+aKmnsVWBKINbEWSCnIp37+aLyZaN0C/fjGJx+mKVk1p1X6Cgjjj/VeUnuqw
n5DEVwXh9nTeiHQNKzs1sDHczBRdhS8zEPmjZifnrbru/UWquqWjeMK+dobPk8+C
sJzhhoM+7EzXjnaWJYUJHIRnTkitnJtc8zXA7GR1q4JwIGl2j/pyVOFA4n9swRPq
z/WLPF/MDuBM316eQQa/QDwamA+qp7oYE1O1/mC7yBIZRypdZQrO/pfFHb94qr6C
yv/iw+5Izby8Ze7wKpIibqxvF0OgyE2afYibO34S1haW+JTHRpScHje3NEAgqV3s
Ym0cqRNch6KOrkAYaMPqNp5shylKfTsglJ8U+A3Q4Bnx5uUa2399ULhbxGwm9zsT
XoKGXai6rlZvhQkOCYFLekoKlbsW6zmn4BxJ87Ck/ujiOiHqdLxUMHraw7PF4KID
4CVMcR0aW2Uxi1HNGnvPsBG2+uXVlfnud1HL6/M2jbXUwDipBbcmyBdoUysbbDRg
RDWZV0+5TAq4j0m8x+Fm1RRqP4fkcxt6sT6wFojQgAZCr4mSH9Y=
=uJjj
-----END PGP SIGNATURE-----

--nextPart1982805.bh7FSdFrlm--

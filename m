Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 19:57:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39726 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992974AbdDKR44zj3ZX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 19:56:56 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9BAA741F8D68;
        Tue, 11 Apr 2017 20:03:21 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 11 Apr 2017 20:03:21 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 11 Apr 2017 20:03:21 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 649FF3263315D;
        Tue, 11 Apr 2017 18:56:47 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Apr 2017 18:56:51 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 11 Apr
 2017 18:56:50 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 11 Apr
 2017 10:56:48 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] irqchip/mips-gic: Fix Local compare interrupt
Date:   Tue, 11 Apr 2017 10:56:42 -0700
Message-ID: <1787874.Cz8gmWEnDJ@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <a71e58d4-b223-7bc7-803a-937e3b6837bb@imgtec.com>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com> <9298882.YeGiCV4jUY@np-p-burton> <a71e58d4-b223-7bc7-803a-937e3b6837bb@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5159577.nx1DIkd7Ij";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57671
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

--nextPart5159577.nx1DIkd7Ij
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Matt,

On Tuesday, 11 April 2017 01:20:35 PDT Matt Redfearn wrote:
> On 10/04/17 23:06, Paul Burton wrote:
> > On Friday, 31 March 2017 04:05:32 PDT Matt Redfearn wrote:
> >> Commit 4cfffcfa5106 ("irqchip/mips-gic: Fix local interrupts") added
> >> mapping of several local interrupts during initialisation of the gic
> >> driver. This associates virq numbers with these interrupts.
> >> Unfortunately, as not all of the interrupts are mapped in hardware
> >> order, when drivers subsequently request these interrupts they conflict
> >> with the mappings that have already been set up. For example, this
> >> manifests itself in the gic clocksource driver, which fails to probe
> >> with the message:
> >> 
> >> clocksource: GIC: mask: 0xffffffffffffffff max_cycles: 0x7350c9738,
> >> max_idle_ns: 440795203769 ns
> >> GIC timer IRQ 25 setup failed: -22
> >> 
> >> This is because virq 25 (the correct IRQ number specified via device
> >> tree) was allocated to the PERFCTR interrupt (and 24 to the timer, 26 to
> >> the FDC).
> > 
> > I'm confused by this - the DT doesn't specify VIRQs, it specifies hardware
> > IRQ numbers. Which VIRQ is used should be irrelevant. Is this on a system
> > using gic_clocksource_init() from platform code? (Malta?) and therefore
> > relying on MIPS_GIC_IRQ_BASE?
> 
> Yes, this is on Malta, which as you say, uses MIPS_GIC_IRQ_BASE. On
> Malta that ends up, through the definition of I8259A_IRQ_BASE and
> MIPS_CPU_IRQ_BASE, to be 24. Therefore hardware interrupt 1 of the GIC
> ends up expecting to be allocated at virq 25. But since 4cfffcfa5106,
> that virq number was allocated to the PERFCTR interrupt. Everything
> about the order-dependent and hardcoded bases of Maltas IRQs seems bad
> and needs looking at but this was the easiest fix for this cycle.
> 
> > If so I think this would be much more cleanly fixed by moving to probe the
> > clocksource using DT
> 
> Not sure that would help if Maltas expected virq for this source had
> already been allocated?

Well the problem is that Malta expects a particular VIRQ - if it instead 
probed the clock event driver via DT, which specifies a hardware interrupt 
number, then that problem goes away & it doesn't matter which VIRQ is used.

For example the generic platform (including the Malta board support for it in 
the downstream engineering kernels) ought to work fine without this because 
there isn't an expectation for a particular VIRQ. Hopefully I'll have time to 
submit some more of that code for the v4.13 cycle & we can eventually scrap 
all of these hardcoded VIRQs along with the mti-malta board code that commits 
the sins.

An alternative might be to have the Malta board code use irq_create_mapping() 
to map the hardware IRQ to a VIRQ rather than hardcoding the VIRQ, which would 
be an improvement but would then require that the board code have access to 
the GIC's struct irq_domain. Given that we want to move Malta towards DT 
anyway that doesn't seem worth much effort.

Thanks,
    Paul
--nextPart5159577.nx1DIkd7Ij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAljtGNoACgkQgiDZ+mk8
HGVmvg/+Nh7/mkmyEcPXq7RApDXkRfdbr9kCCgjqdpAkngEgtKPyVz/FCN8BBXH7
Hx+COTNGsAW+iU2cSFRO6LuJYvFeovdabd1mOXKK39GxYkdPYhUcW25fdMbznzyl
Xr5ZIFv3Rf652LziDlbE7/IrhDuP+Ci8KWXQDUKIlNBdkaxyEZL+656779qQkPWT
cANEYjqjsqHT9cmyOraumXt4VmyqgEtPRpr+tJeq+fRbgrUBnMHw8n+JwG1hLb/8
HfJtp9I/NLeN9i80CikbqZY4dYEk506iWemezu0RM0Cf0U98e2CLb33oizJ3TKfH
CYZzSxjnH1WCurI16EYXxtuKU5YFg6lH38IM4p1I4ERTKOH+cZwv+8MFNNOlFsMV
t3ewoJ+Sswf7lRUUFxx2aIQkqaHcrkfXrTLu71dQffoJVdyudGaFlKffYAVBd8sp
C/lV6iyU/IIy5C2EPf2SPTpF4kjhRdRTXicVrs6vXbCYDQcjxL2+8tsb+eKB9zmL
rhmXMXkeddPStr6GMIMtCYjGw5aUa2UzQvFBh5BpWBjSy+uerdu3cmEI1FroSbMm
uEHIINS76J8PPhCjvnk8p08wlBGaXFUv2cP03w+k3/FvLphg3Py43CsRsnlyU5TX
lvfDNO1KH44ptybEMiVzcDbwnPsDBDsxUn+1do7VaUsgf1Zn2GE=
=g3MV
-----END PGP SIGNATURE-----

--nextPart5159577.nx1DIkd7Ij--

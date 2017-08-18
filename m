Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 23:10:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54382 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994939AbdHRVKLf5reH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 23:10:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id F15EE3E196389;
        Fri, 18 Aug 2017 22:10:00 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 18 Aug 2017 22:10:05 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 22:10:04 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 18 Aug
 2017 14:10:02 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 00/38] irqchip: mips-gic: Cleanup & optimisation
Date:   Fri, 18 Aug 2017 14:09:58 -0700
Message-ID: <8259948.IKz1zfOHbW@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <b6b59dc3-0390-1eb8-f30e-c753b462972e@arm.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com> <3865163.6ibQ6d6yKY@np-p-burton> <b6b59dc3-0390-1eb8-f30e-c753b462972e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3068740.hOu8ehoW4b";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59691
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

--nextPart3068740.hOu8ehoW4b
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

On Friday, 18 August 2017 10:49:27 PDT Marc Zyngier wrote:
> On 18/08/17 18:44, Paul Burton wrote:
> > Hi Marc,
> > 
> > On Friday, 18 August 2017 10:28:01 PDT Marc Zyngier wrote:
> >> Hi Paul,
> >> 
> >> On 13/08/17 05:36, Paul Burton wrote:
> >>> This series cleans up the MIPS Global Interrupt Controller (GIC) driver
> >>> somewhat. It moves us towards using a header in a similar vein to the
> >>> ones we have for the MIPS Coherence Manager (CM) & Cluster Power
> >>> Controller (CPC) which allows us to access the GIC outside of the
> >>> irqchip driver - something beneficial already for the clocksource &
> >>> clock event driver, and which will be beneficial for further drivers
> >>> (eg. one for the GIC watchdog timer) and for multi-cluster work. Using
> >>> this header is also beneficial for consistency & code-sharing.
> >>> 
> >>> In addition to cleanups the series also optimises the driver in various
> >>> ways, including by using a per-CPU variable for pcpu_masks & removing
> >>> the need to read the GIC_SH_MASK_* registers when decoding interrupts in
> >>> gic_handle_shared_int().
> >>> 
> >>> This series requires my "[PATCH 00/19] MIPS: Initial multi-cluster
> >>> support" series to be applied first.
> >> 
> >> I went through the whole series, and didn't spot anything bad (the
> >> couple of nits I raised can either be fixed at a later time or as a
> >> fixup on top of what you have).
> > 
> > Thanks :) I appreciate your review. So shall I take that as you'd prefer
> > that I submit separate fixup patches rather than submit a v2?
> 
> Just post the fixups on top. Nobody wants a new 38 series in their
> Inbox! ;-)

The changes to patch 35 wound up causing conflicts with patch 37 if you go 
squash the fixup commit, so I instead submitted a v2 of just those 2 patches.

I've also updated a bundle on the linux-mips patchwork which is hopefully 
convenient for whomever merges the series:

https://patchwork.linux-mips.org/bundle/paulburton/4.14-gic/

Thanks,
    Paul
--nextPart3068740.hOu8ehoW4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmXV6YACgkQgiDZ+mk8
HGVWLQ//Ul/R6VTQHRtdsRDGMxA1k0ThBlvs87e8NP/rvbUyQAn/5RGaA4wWyS/V
GBLUkZ1TDeFOuXi8tV4A+44IdEUN2lmLZQab9eISPp3wOsrWu7lMSgqJ/OAKb3WZ
sgBTWrJKVkGc3GIC/qvDQ8mZwJJrmpen/uTDiUY4qt3U4ZxG+Gw3l/GWRjeQyIgJ
rbMxeG+DUVtSiu4F97IwRFZBRHxInMc5nqqlyx1ED9PonYviNP8p3+ni/u9v8VFU
NNm6UgdAoJY+vzRVtGbV/L9w3aYbQ/WV9D0j7B+Tvtp0KgRO0yHONilxk838bcl1
W3L3nv2McyB0OiIIyg7xyWW0VJOeJ0V9jzxM92le5PKmRiANwwP0HfdqbGG8SJ3F
y+SH5vrfCLL1nHHrxYAG5QQdAxAp6zg1letxlRSDtN/MPDeLNUJ6cB+MCUg84LFn
UhToKv0fzIxWCA5A/l+B+CJ0CqtXnhJoS8mmgRWPzb62s3ggWwfLMIc8kkbsh13S
EeN7F4c1XPAgkJ7eMFQmet2360JUDPnh4b1XSdjDjELjOYjEKFOhW4j99WGFwURV
vU/zwpdLLnH7/XGhPTrepy1x1o0SMqHNv57RDXwufKZbLPZW01WFqQICCL3R1rsx
qDDozjHLEu/iHsf8adY11bLa37uu8EqzmlDb90xMFwxfkUtsFI8=
=TV0f
-----END PGP SIGNATURE-----

--nextPart3068740.hOu8ehoW4b--

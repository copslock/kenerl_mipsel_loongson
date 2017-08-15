Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 18:16:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60465 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbdHOQQiOkhZO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 18:16:38 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 95FD19435F8D2;
        Tue, 15 Aug 2017 17:16:26 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 15 Aug 2017 17:16:29 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 15 Aug
 2017 17:16:29 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 15 Aug
 2017 09:16:27 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 00/38] irqchip: mips-gic: Cleanup & optimisation
Date:   Tue, 15 Aug 2017 09:16:21 -0700
Message-ID: <1561377.UX34hIl2NL@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <deae1e69-010e-474d-9bb6-a4d92c955356@arm.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com> <deae1e69-010e-474d-9bb6-a4d92c955356@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9653451.lu2m504oov";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59588
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

--nextPart9653451.lu2m504oov
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

On Tuesday, 15 August 2017 03:13:03 PDT Marc Zyngier wrote:
> Hi Paul,
> 
> On 13/08/17 05:36, Paul Burton wrote:
> > This series cleans up the MIPS Global Interrupt Controller (GIC) driver
> > somewhat. It moves us towards using a header in a similar vein to the
> > ones we have for the MIPS Coherence Manager (CM) & Cluster Power
> > Controller (CPC) which allows us to access the GIC outside of the
> > irqchip driver - something beneficial already for the clocksource &
> > clock event driver, and which will be beneficial for further drivers
> > (eg. one for the GIC watchdog timer) and for multi-cluster work. Using
> > this header is also beneficial for consistency & code-sharing.
> > 
> > In addition to cleanups the series also optimises the driver in various
> > ways, including by using a per-CPU variable for pcpu_masks & removing
> > the need to read the GIC_SH_MASK_* registers when decoding interrupts in
> > gic_handle_shared_int().
> > 
> > This series requires my "[PATCH 00/19] MIPS: Initial multi-cluster
> > support" series to be applied first.
> 
> I'm not on Cc on this one, so it is a bit hard to see what's going on.

That other series is only really related insomuch as it adds asm/mips-cps.h 
which this series makes use of, and changes a couple of lines in irq-mips-
gic.c which would cause conflicts if this series is applied without the other 
first.

> But overall, it is incredibly difficult to follow what is going on here.
> Everything seems to move around, and while I'm sure that you have
> something in mind, the mix of fixes+optimizations+new features is a bit
> hard to swallow (not to mention the VDSO stuff in the middle of what is
> supposed to be an irqchip series).

In general the non-irqchip patches preceed the irqchip patch that they enable. 
For example, the VDSO patch you mention (presumably patch 22 "MIPS: VDSO: Drop 
git_get_usm_range() usage") is followed immediately by the removal of that 
function in patch 23 "irqchip: mips-gic: Remove gic_get_usm_range()".

The issue is that the MIPS GIC irqchip driver currently provides a bunch of 
functions which have nothing to do with interrupts, and so probably ought to 
be elsewhere. Moving that code elsewhere involves both adjusting the callers 
of those functions & then removing them from the irqchip driver, hence the 
non-irqchip patches followed by the related irqchip patches.

In general the only things that move are:

 - The GIC register definitions, to asm/mips-gic.h for reasons described in 
patch 2.

 - Functions as I mentioned in the previous paragraph which have nothing to do 
with the irqchip driver & don't need to be there once we have access to GIC 
registers elsewhere through asm/mips-gic.h.

 - A few other bits from linux/irqchip/mips-gic.h just so we can drop that 
header.

> Is there any chance you could rework this to have a more logical
> ordering? Something like fixes first, new features next, and
> optimizations in the end, organized by domains (arch stuff first, then
> irqchip, then timer, then userspace)?

It's already almost grouped like that. We have:

- Patch 1 is a fix.

- Patches 2 through 34 are cleanup, though a couple could probably be 
secondarily considered optimisations too.

- Patch 35 is an optimisation.

- Patches 36 through 38 could be considered optimisation or cleanup depending 
upon the tint of your glasses.

So I'm not sure what you're asking me to do here - to group them better I 
could perhaps move patch 35 to the end, but I'm not sure I see how that would 
make review any easier.

I didn't group by domain like you suggest for the reason I mention before - 
the non-irqchip patches are purely there to enable the following irqchip patch 
so it made sense to me to group those together. If you really want I could 
move all the non-irqchip patches to the start & all the irqchip patches to the 
end, but again I'm not sure I see how that helps - it would just mean that 
tightly related patches no longer follow one another.

> Because at the moment, this is a bit overwhelming...

My intent in splitting this into so many patches, and in grouping together the 
related non-irqchip & irqchip patches, was to reduce that overwhelming-ness by 
making each patch pretty readable by itself & perhaps taking into account only 
a patch or two before it. I guess that didn't work though.. :)

Thanks,
    Paul
--nextPart9653451.lu2m504oov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmTHlUACgkQgiDZ+mk8
HGVmEQ//bpx4t1JYQwwbJSsbGKgvJ2jynxrTVxHolGqEa3nKg3Pw4jKineslrazE
V6PT/EuVVZ9l2fBnBj1NJ3Wbhnu3LoN/PYk043d1IOdBflQBsdDofV5LIkr82vGF
+sMFBCy9gbQFD76KzB6VJ8ItP0nJRQgjSl1P9VCYwfMm4dr+809YHvBKocBFvxlE
d3ePOXNYqyRzW3LEEiv7gJX4a+OJXpevU6dkZjrcHXF9qK7wBCt9fQN5YBfTPLez
tU3j8mz/SUv7uKLLq8rFlAFyAgfbeCeSSFn7ZdH0EehxBKCywZnmA4Xl74UHR6fT
UcBGQGhp3jM6mFjtC8HAa1dJhnxWDLMHLIcGZ2+a0asB3QhDK2R0JFtvITQtFVrJ
IGj395Wn8BSWOFQM/n5BBOTGlPxVw5v8kdQa8bjtW169nztBnxU94x+DHCXQUC6T
v6ZcFatxQM+C0Y6EFBUBUz7e/6n0k8VlL3xI+/s1c2b9SNjAFJrz6sEl4rC+Yjhf
IxI57v/BDv+vDtnEVql/paacOxBMt0tn2+llTNkevP2siV3QPKGaYRh4q61wqa9j
jpzkQ6EOceJZxBTau4Kypl1TInui5fFqNAPk2+qNKPa6q1hsI6VlqzxPt2U4SHQL
6lD66PATqd2vbmg6F0qzl/lomywIrRPG83ioJaPxkq28H3MvEwA=
=Euta
-----END PGP SIGNATURE-----

--nextPart9653451.lu2m504oov--

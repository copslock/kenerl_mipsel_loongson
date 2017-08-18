Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 19:45:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8894 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994934AbdHRRo55XKph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 19:44:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DD18AA8407654;
        Fri, 18 Aug 2017 18:44:47 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 18 Aug 2017 18:44:51 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 18:44:51 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 18 Aug
 2017 10:44:49 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 00/38] irqchip: mips-gic: Cleanup & optimisation
Date:   Fri, 18 Aug 2017 10:44:48 -0700
Message-ID: <3865163.6ibQ6d6yKY@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <b01bbb35-938c-360a-4025-53dbec24c411@arm.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com> <b01bbb35-938c-360a-4025-53dbec24c411@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1717051.W43csUDo1W";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59686
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

--nextPart1717051.W43csUDo1W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

On Friday, 18 August 2017 10:28:01 PDT Marc Zyngier wrote:
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
> I went through the whole series, and didn't spot anything bad (the
> couple of nits I raised can either be fixed at a later time or as a
> fixup on top of what you have).

Thanks :) I appreciate your review. So shall I take that as you'd prefer that 
I submit separate fixup patches rather than submit a v2?

> Given that this has a number of dependencies (your multicluster series),
> how do you want to get this merged?
> 
> Thanks,
> 
> 	M.

Ralf mentioned in a meeting yesterday that he was going to speak to Thomas 
about that, and suggested that perhaps it'd be easiest for him to take it 
through the MIPS tree. I'm happy either way.

Thanks,
    Paul
--nextPart1717051.W43csUDo1W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmXJ5AACgkQgiDZ+mk8
HGUsLg//e6PNq2GcOQJ9vDUTgBJQAedVNGFUbPBTQl97RMy3O7HEhNcllhbSYBMH
tvq/AnokYB8i0DwF2bHYKjgnRj0X9SU11LYnyS8wdHAHfiOowPSnw5EJMvxYy8eV
VE1LA6DXaFIr0u4adr61Z0nYBS3OeX2N67OEa867Vmtmi1m82GcKgcORw/sajG3G
E9huoEfTH6HiqjUTTHY9RXTFgocUro8YnobFU0pawhZwO1FkzboUGfmOX1SpwJvV
G7xiRZzYvd36y3w3RUs9w9I+FngrA8VkEbhXs3t4SRcf/47MRodkS8bv/GaO9iiV
r5As4539zz+JwKV0Bg/uTgf35kRa4alNrCNR0ccphrz+KOgnzHFta7yex7hfdvX5
dh4BZPgJQhqe5SmZEPJYXH9FGVer+kmFOVpNGdxu9K9H95Gule9ZxLLQUb3fJVQE
+1rGrMKkX+1+W5H/iPIFV5/1bHDiE4K2BMjJyVk+XbIU7h8Zh8KnDAlXKf8dI/NF
0ataDgj6fnOm4YrMO0L1LrNyxxpvZMknGp0Wr3rvd/WnWEG+2wUp5obqTZJX9J4Y
rM3QBt9Lyqqdy0oMxUVF2gwYFbOUh6PzXxwMSePsEQdY0oGlIvI6EblnlPgKIexR
6GvKKOuJ8+2X7pOciJrNv61pTEtqLmFk3qFtyHSwEjsdwmqCARg=
=cI6C
-----END PGP SIGNATURE-----

--nextPart1717051.W43csUDo1W--

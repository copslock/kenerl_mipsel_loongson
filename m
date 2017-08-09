Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2017 19:00:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56194 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995091AbdHIRACISLnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2017 19:00:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EA631F28A6171;
        Wed,  9 Aug 2017 17:59:51 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 9 Aug
 2017 17:59:55 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 9 Aug 2017
 09:59:52 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Nathan Sullivan" <nathan.sullivan@ni.com>
Subject: Re: [PATCH 3/7] MIPS: NI 169445: Only include in 32r2el kernels
Date:   Wed, 9 Aug 2017 09:59:46 -0700
Message-ID: <5563565.3xWpng3KyW@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170809081424.GB31455@jhogan-linux.le.imgtec.org>
References: <20170807230119.10629-1-paul.burton@imgtec.com> <20170807230119.10629-4-paul.burton@imgtec.com> <20170809081424.GB31455@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13930196.6hhny5v6M4";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59458
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

--nextPart13930196.6hhny5v6M4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi James,

On Wednesday, 9 August 2017 01:14:24 PDT James Hogan wrote:
> On Mon, Aug 07, 2017 at 04:01:14PM -0700, Paul Burton wrote:
> > The NI 169445 board uses a little endian MIPS32r2 CPU, and therefore
> > including board support in kernels that are unable to run on such a CPU
> > is pointless.
> > 
> > Specify requirements in the board config fragment that cause the NI
> > 169445 board support to only be included in generic kernels that target
> > little endian MIPS32r2 CPUs.
> > 
> > For example, NI 169445 support will be included when configuring using
> > 32r2el_defconfig but not when using 64r6_defconfig.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Nathan Sullivan <nathan.sullivan@ni.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > 
> > ---
> > I'm basing this upon the Kconfig entries that were present in the
> > initial upstream submission of NI 169445 board support[1]. If this is
> > wrong at all please let me know :)
> > 
> > [1] https://www.linux-mips.org/archives/linux-mips/2016-12/msg00016.html
> > 
> >  arch/mips/configs/generic/board-ni169445.config | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/mips/configs/generic/board-ni169445.config
> > b/arch/mips/configs/generic/board-ni169445.config index
> > 0bae1f861a5b..f72223b366ca 100644
> > --- a/arch/mips/configs/generic/board-ni169445.config
> > +++ b/arch/mips/configs/generic/board-ni169445.config
> > @@ -1,3 +1,6 @@
> > +# require CONFIG_CPU_MIPS32_R2=y
> 
> Technically, won't this unnecessarily prevent it being included in r1
> configs?

Yes, I suppose it does...

> I suppose the only better suggestion I have at the moment is
> # require CONFIG_32BIT=y
> # require CONFIG_CPU_MIPS32_R6=n
> 
> I suppose being specific about exclusions is probably inevitable (e.g.
> for boards which can't support micromips).

It would just seem a shame to eventually end up with:

  # require CONFIG_CPU_MIPS32_R6=n
  # require CONFIG_CPU_MIPS32_R7=n
  # require CONFIG_CPU_MIPS32_R8=n
  # require CONFIG_CPU_MIPS32_R9=n
  # require CONFIG_CPU_MIPS32_RX=n
  # require CONFIG_CPU_MIPS32_RXI=n
  # require CONFIG_CPU_MIPS32_RXII=n
  # require CONFIG_CPU_MIPS32_RXIII=n
  # require CONFIG_CPU_MIPS32_RXIV=n

Or whatever. I guess one option would be to add Kconfig entries that indicate 
the ISA being less-than or greater-than-equal some version. Then we could have 
for example:

  # require CONFIG_ISA_GE_R6=n

...and that would allow the board support to be included in any kernel 
targeting a pre-r6 ISA.

That might be handy for selecting support for arch features in Kconfig too 
actually, where we currently have things like:

  default y if CPU_MIPSR1 || CPU_MIPSR2 || CPU_MIPSR6

and could instead have:

  default y if ISA_GE_R1

Thanks,
    Paul
--nextPart13930196.6hhny5v6M4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmLP4IACgkQgiDZ+mk8
HGXsjA/+Lf37shfVVRyx+rTg2KJ73gDzRWGR5rQR6SRl+omSoB0RFOmOG+tw4vuq
ylTbghtU9d1KAtH6YzuJAC/G4UKYUHa1FKA8vsEa/rDwwJYq6cpN+eSIp227gNsI
X2DJdFHkenRYIJXx5CgeFNNWO9bkmH9RFUiJM7VvfNZvbpq+53Jv7CVAbg75H99k
9/l9Xpes+7acDQh8wfMHYJ+EEQBXhH6TJKjaATSX013sqD+D2v2shQ77sFvsJcAi
8RjeUuq0SzZZwwSYiWfiyQdpUX3Foyfn8YWPyIE/3l/98YYveSzALP2A0kO/Z8VN
i1BGFNOX8PrITBa1pypzQsryY1AKSFe+JKi/BOXG6oGZJzin633kQbhUv3ftoIPN
ZwFBwSazNvVO6deUKgVCwb4akejXZkpJwxFsCRyoYsduOmo7353/PXMLv7T4315B
UVEJ9kzRI5tN0Jr3OdDQ6FreuHM9ZG3pw/oZkJMZ5NPhgd4k1vhQvLMDUb5gUXqt
hW9SHgdX+H2pSnznIIT0QRyeHVo5o/hliuIylYAZinibCInAYgfdgkfWCA46UKt3
hPpiVk1qdocLnqYPGbBcoV7WytDSVFrg9nYk6HbnQGiZY53C4V35drvfziI3yJLT
iCDeC8pfg0iEj4zN5lepUz1j5Qdxy6JYf28k3MVrXYAqUcXz0fg=
=GUoU
-----END PGP SIGNATURE-----

--nextPart13930196.6hhny5v6M4--

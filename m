Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2018 23:23:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992827AbeBHWXE2PnkZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Feb 2018 23:23:04 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B64221738;
        Thu,  8 Feb 2018 22:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B64221738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 8 Feb 2018 22:22:48 +0000
From:   James Hogan <jhogan@kernel.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v4 0/7] Add Octeon Hotplug CPU Support.
Message-ID: <20180208222247.GC31316@saruman>
References: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <1512021981-15560-1-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Steven,

On Thu, Nov 30, 2017 at 12:06:14AM -0600, Steven J. Hill wrote:
> This patchset adds working Octeon Hotplug CPU. It has been tested
> on our 70xx and 78xx develpoment boards. The 70xx has 4 cores and
> the 78xx has 48 cores. This was also tested on an EdgerouterPRO,
> which has 2 cores.
>=20
> Changes in v4:
> - Rebased against v4.15-rc1 kernel.
> - Smaller patchset due to some previous patches going upstream.

This series doesn't appear to build even cavium_octeon_defconfig since
patch 1, and is full of checkpatch errors and warnings.

Cheers
James

>=20
>=20
> David Daney (3):
>   MIPS: Octeon: Populate kernel memory from cvmx_bootmem named blocks.
>   MIPS: Add the concept of BOOT_MEM_KERNEL to boot_mem_map.
>   MIPS: Octeon: Add working hotplug CPU support.
>=20
> Steven J. Hill (4):
>   MIPS: Octeon: Header and file cleaning.
>   MIPS: Octeon: Update values for CVMX_CIU_FUSE register.
>   MIPS: Octeon: Add Octeon III platforms for console output.
>   MIPS: Octeon: Remove crufty KEXEC and CRASH_DUMP code.
>=20
>  arch/mips/Kconfig                                  |   2 +-
>  .../cavium-octeon/executive/cvmx-helper-board.c    |   2 +-
>  .../cavium-octeon/executive/cvmx-helper-jtag.c     |   1 +
>  .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   1 +
>  .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   1 +
>  .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   1 +
>  .../cavium-octeon/executive/cvmx-helper-xaui.c     |   1 +
>  arch/mips/cavium-octeon/executive/cvmx-helper.c    |   1 +
>  arch/mips/cavium-octeon/executive/cvmx-pko.c       |   1 +
>  arch/mips/cavium-octeon/executive/cvmx-spi.c       |   1 +
>  arch/mips/cavium-octeon/executive/octeon-model.c   |  53 ++++-
>  arch/mips/cavium-octeon/octeon-platform.c          |   1 +
>  arch/mips/cavium-octeon/octeon_boot.h              |  95 --------
>  arch/mips/cavium-octeon/setup.c                    | 246 +++++++--------=
------
>  arch/mips/cavium-octeon/smp.c                      | 234 +++++++--------=
-----
>  arch/mips/include/asm/bootinfo.h                   |   1 +
>  arch/mips/include/asm/mach-cavium-octeon/irq.h     |   8 +
>  .../asm/mach-cavium-octeon/kernel-entry-init.h     |  58 ++++-
>  arch/mips/include/asm/mipsregs.h                   |   1 +
>  arch/mips/include/asm/octeon/cvmx-asm.h            |   6 +-
>  arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 169 ++++++--------
>  arch/mips/include/asm/octeon/cvmx-coremask.h       |  26 ++-
>  arch/mips/include/asm/octeon/cvmx-sysinfo.h        |   4 +-
>  arch/mips/include/asm/octeon/cvmx.h                |  32 +--
>  arch/mips/include/asm/octeon/octeon.h              |   2 +
>  arch/mips/kernel/setup.c                           |  30 ++-
>  26 files changed, 427 insertions(+), 551 deletions(-)
>  delete mode 100644 arch/mips/cavium-octeon/octeon_boot.h
>=20
> --=20
> 2.1.4
>=20
>=20

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp8zbcACgkQbAtpk944
dnoBgA//f4nRp6N1RyUfa9L8eqq8lKApzLCDsotYi/U9Q2Nffh4hR4OU8axtnD2d
nC+BDhkPp85ZeSOBLTFOvjzV5ClaufPdvQLU+h1dx1gvhzVQl0B+D3no3lGYCfzu
f4Kjum36h94n8NnNTxafYxo4NQDjBhJpoMiqnOFQ9uUdXeQVennHnSbtU1w9xrMJ
L0nrr2pKSvgNyTJZEUM1zT0BxsFr4p2T7y27uQlA7EIDZQ/YZWYUJGDwunzlCDa7
UUOUuA04FEkYVcUMWlpGPNdoHF2e9s4vG/f424KkCxr1gZ5NKRWLfn2CQkPG53VM
ky+nfbJnYuaP4rLHwx+iqWmrZTKXh+CVwutPuxjd9GDa3eYmzLWuNngCIFV0blgn
gvAcUL+YUDirrH1deZC2AcQW484qc4OGF0vtIM6MBdYnYhlXaTQB6oHQaQayAy/i
3L4KT1Hfk74ueAq8mixhX0MQk5KcLOGjZaX1WsJXyoSnTDWmfbQTjouiglX0L8sJ
uCEldQqDAOXEpT875fd+ZYqp7gIXO7hWWl5yJRs2Aysw6Cf4IHxuVFlxMyA71RmY
I2JjygMImIz5+09sL6pTuzmqiihEYnBXmGLs4fqOJTDL1VfiQV58N92rmnqDdEft
oj5pB03qqSQxqSjDhgysGWMhcipo+wtthrD9Xhbga41vP6PiGQc=
=rwAK
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--

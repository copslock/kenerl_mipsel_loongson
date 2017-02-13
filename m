Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 16:20:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22367 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993552AbdBMPUYAEXP2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2017 16:20:24 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B70D141F8EA1;
        Mon, 13 Feb 2017 16:24:12 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 13 Feb 2017 16:24:12 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 13 Feb 2017 16:24:12 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id B8D84BF50E454;
        Mon, 13 Feb 2017 15:20:14 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 13 Feb
 2017 15:20:17 +0000
Date:   Mon, 13 Feb 2017 15:20:17 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Binbin Zhou <zhoubb@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v5 0/8] MIPS: Loongson: Add the Loongson-1A processor
 support
Message-ID: <20170213152017.GK24226@jhogan-linux.le.imgtec.org>
References: <1486519069-9364-1-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Content-Disposition: inline
In-Reply-To: <1486519069-9364-1-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 08, 2017 at 09:57:41AM +0800, Binbin Zhou wrote:
> The Loongson-1A CPU is similar with Loongson-1B/1C, which is a 32-bit SoC.
>=20
> It is a cost-effective single chip system based on LS232 processor core,
> and is applicable to fields such as industrial control, and security appl=
ications.
>=20
> It implements the MIPS32 release 2 instruction set.
>=20
> They share the same PRID, so we rewrite them into PRID_REV_LOONGSON1ABC,
> and use their CPU macros to distinguish.
>=20
> Changes since v1:
>=20
> 1. According commit c908656a7531771ae7642990a7c5f3c7307bd612
>    (MIPS: Loongson: Naming style cleanup and rework) to fix the naming st=
yle.
>=20
> Changes since v2:
>=20
> 1. Remove __irq_set_handler_locked()
> 2. Rebases on top of v4.5-rc5.
>=20
> Changes since v3:
>=20
> 1. Rename the Loongson-1 series's PRID name
> 2. Rewite Loongson-1A's clk driver
> 2. Rebases on top of v4.10-rc2.
>=20
> Changes since v4:
>=20
> 1. Fix some commit message error

Please can you look back at review comments from previous revisions, as
most of them seem to be unaddressed & unanswered unless I'm missing
something, and the common clock framework maintainers still aren't Cc'd
on the relevant patches.

Regarding switching to devicetree, note that it can usually be done
incrementally and without any boot ABI changes by embedding the
flattened devicetree(s) in the kernel.

Cheers
James

>=20
> Binbin Zhou(8):
>  MIPS: Loongson: Merge PRID macro for Loongson-1A/1B/1C
>  MIPS: Loongson: Expand Loongson-1's register definition
>  MIPS: Loongson: Add basic Loongson-1A CPU support
>  MIPS: Loongson: Add Loongson-1A Kconfig options
>  MIPS: Loongson: Add platform devices for Loongson-1A
>  MIPS: Loongson: Add Loongson-1A board support
>  clk: Loongson: Add Loongson-1A clock support
>  MIPS: Loongson: Add Loongson-1A default config file
>=20
> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> --=20
>  arch/mips/Kconfig                                 |  12 +++++++++
>  arch/mips/configs/loongson1a_defconfig            | 131 ++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/mips/include/asm/cpu-type.h                  |   3 ++-
>  arch/mips/include/asm/cpu.h                       |   3 +--
>  arch/mips/include/asm/mach-loongson32/irq.h       |  16 ++++++++----
>  arch/mips/include/asm/mach-loongson32/loongson1.h | 172 ++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++---------------------
>  arch/mips/include/asm/mach-loongson32/platform.h  |   2 ++
>  arch/mips/include/asm/mach-loongson32/regs-clk.h  |  30 ++++++++++++++++=
++++-
>  arch/mips/include/asm/mach-loongson32/regs-mux.h  |  36 ++++++++++++++++=
++++++++-
>  arch/mips/kernel/cpu-probe.c                      |   6 ++++-
>  arch/mips/loongson32/Kconfig                      |  20 ++++++++++++++
>  arch/mips/loongson32/Makefile                     |   6 +++++
>  arch/mips/loongson32/Platform                     |   1 +
>  arch/mips/loongson32/common/irq.c                 |   2 +-
>  arch/mips/loongson32/common/platform.c            |  83 ++++++++++++++++=
++++++++++++++++++++++++++++++++----------
>  arch/mips/loongson32/common/setup.c               |   6 +++--
>  arch/mips/loongson32/ls1a/Makefile                |   5 ++++
>  arch/mips/loongson32/ls1a/board.c                 |  31 ++++++++++++++++=
++++++
>  arch/mips/mm/c-r4k.c                              |  10 +++++++
>  drivers/clk/loongson1/Makefile                    |   1 +
>  drivers/clk/loongson1/clk-loongson1a.c            |  75 ++++++++++++++++=
++++++++++++++++++++++++++++++++++++
>  21 files changed, 593 insertions(+), 58 deletions(-)
>  create mode 100644 arch/mips/configs/loongson1a_defconfig
>  create mode 100644 arch/mips/loongson32/ls1a/Makefile
>  create mode 100644 arch/mips/loongson32/ls1a/board.c
>  create mode 100644 drivers/clk/loongson1/clk-loongson1a.c
> --
> 1.9.0
>=20
>=20

--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYoc6pAAoJEGwLaZPeOHZ6XwoP/RgXLLuyFzd46QXFsQ8nwWid
26UsFjc8qB3L0UjWSQ4sJyl/nd1ytxCFO/0ww/6B57r8uVHqxWDIPBjZh6XwD+RZ
EUMSfh/Qesz+qAV+MUJdjAmpyKgwXN630/OphN7x8JNargyuTLCVBRi1hOghOoMF
Xn2uBoIfu4lcA5eLutORGff07kEkARR6LHNqAUY7BD0DKqAwt+6DidWq57oQSv4n
rdN09vLmXc1yXx107Em8I3AiMgY4P4oL9taJL/TurIfqLqW1wS8GT5v2+U/VBiLH
/vCS6Hm3oruS9XNB1xxboCGEa4VFpYqoKaPrgZvbuaZpBiaCeYGhZkY21eLSrJgn
kIgsv/NAY2jiA5NkTohpRmsSyXLZW5twbrazJHkMSQT/i5V6O4kZxICN1e+uzxKM
vhsleqHI9snGLSUmD/k80/C5h0cLgDE6b9LuYU2cgnfwBRJgFtdPY26VU4SFbSWs
MJsQj3hmAdpXER+cg0/77/Qkn8pBAxlwPGQWiqQu0lFpzSv6IkHmHUB7l6VPeXtL
m/PTIQqF7dTEQfC1jMWnar3b5/Cq63JTSiGvJ60OuCNGnFahYAOuM5Wx33COBKHl
Txpxma49++SLxmfClxWSulGIBSO2gPXghsOyoq5MdlUGB+2+Duk0f5M+RQcrcmYn
5iSKZOJ7bdfVh8mqLhD4
=KTVz
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--

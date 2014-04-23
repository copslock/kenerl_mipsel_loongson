Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 16:22:39 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:61931 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6841849AbaDWOWgRWaEh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 16:22:36 +0200
Received: by mail-wg0-f49.google.com with SMTP id a1so946134wgh.32
        for <linux-mips@linux-mips.org>; Wed, 23 Apr 2014 07:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=2De+L/7bcwNLQWCW2ZHCk9k2db2VP0ZeuzhXhf3/lQI=;
        b=BtaPkn0iENQSLZk8tZAhgGDkm/TDZNG4ItMZ4zSBp8RtqMXRP4OPl8x8yRQvGjnMVT
         tc8HNSrn2iE1QsLCd1wkOpKl/YbV6YghQdCJU5MgUCmcU13sBHcEF2M8EM1zIU5X8z4C
         hm/wAaCCseeEpNO4yab1iD/Ms1CbAHU7mZ37bRq6Af08Y91Cjv1o9ap3mahH1WuA/dbC
         zjHwv01rltNX61aq0A96wGBSXsNv2mOKk4R5x+///HhDEMOjgO8citm9DtjTouvgDEes
         uz0Q/2uvdg0AlxUQmr0bYtSx6EKVeceFgisCKicM0s2Y5OtRmONHys1onaThi31rbK/Q
         TAMw==
X-Gm-Message-State: ALoCoQlAmxN2AFgBIKrzYnwRfYZrm7K+54Nqjxfd8NbZhYFaOFe6ZjtF2SYArhg13dNU8C5/6GIo
X-Received: by 10.180.80.3 with SMTP id n3mr2050484wix.36.1398262950852;
        Wed, 23 Apr 2014 07:22:30 -0700 (PDT)
Received: from [192.168.0.100] (nat-63.starnet.cz. [178.255.168.63])
        by mx.google.com with ESMTPSA id gz1sm4537360wib.14.2014.04.23.07.22.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Apr 2014 07:22:29 -0700 (PDT)
Message-ID: <5357CCA1.9080708@monstr.eu>
Date:   Wed, 23 Apr 2014 16:22:25 +0200
From:   Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130330 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     Grant Likely <grant.likely@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Bonn <jonas@southpole.se>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux@lists.openrisc.net, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org, Mark Salter <msalter@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org
Subject: Re: [PATCH v2 00/21] FDT clean-ups and libfdt support
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
X-Enigmail-Version: 1.6
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A"
Return-Path: <monstr@monstr.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: monstr@monstr.eu
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/23/2014 03:18 AM, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> This is a series of clean-ups of architecture FDT code and converts the=

> core FDT code over to using libfdt functions. This is in preparation
> to add FDT based address translation parsing functions for early
> console support. This series removes direct access to FDT data from all=

> arches except powerpc.
>=20
> The current MIPS lantiq and xlp DT code is buggy as built-in DTBs need
> to be copied out of init section. Patches 2 and 3 should be applied to
> 3.15.
>=20
> Changes in v2 are relatively minor. There was a bug in the unflattening=

> code where walking up the tree was not being handled correctly (thanks
> to Michal Simek). I re-worked things a bit to avoid globally adding
> libfdt include paths.
>=20
> A branch is available here[1], and I plan to put into linux-next in a f=
ew
> days. Please test! I've compiled on arm, arm64, mips, microblaze, xtens=
a,
> and powerpc and booted on arm and arm64.
>=20
> Rob
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git libfdt=

>=20
> Rob Herring (21):
>   mips: octeon: convert to use unflatten_and_copy_device_tree
>   mips: lantiq: copy built-in DTB out of init section
>   mips: xlp: copy built-in DTB out of init section
>   mips: ralink: convert to use unflatten_and_copy_device_tree
>   ARM: dt: use default early_init_dt_alloc_memory_arch
>   c6x: convert fdt pointers to opaque pointers
>   mips: convert fdt pointers to opaque pointers
>   of/fdt: consolidate built-in dtb section variables
>   of/fdt: remove some unneeded includes
>   of/fdt: remove unused of_scan_flat_dt_by_path
>   of/fdt: update of_get_flat_dt_prop in prep for libfdt
>   of/fdt: Convert FDT functions to use libfdt
>   of/fdt: use libfdt accessors for header data
>   of/fdt: create common debugfs
>   of/fdt: move memreserve and dtb memory reservations into core
>   of/fdt: fix phys_addr_t related print size warnings
>   of/fdt: introduce of_get_flat_dt_size
>   powerpc: use libfdt accessors for header data
>   x86: use FDT accessors for FDT blob header data
>   of/fdt: convert initial_boot_params to opaque pointer
>   of: push struct boot_param_header and defines into powerpc
>=20
>  arch/arc/include/asm/sections.h             |   1 -
>  arch/arc/kernel/devtree.c                   |   2 +-
>  arch/arm/include/asm/prom.h                 |   2 -
>  arch/arm/kernel/devtree.c                   |  34 +--
>  arch/arm/mach-exynos/exynos.c               |   2 +-
>  arch/arm/mach-vexpress/platsmp.c            |   2 +-
>  arch/arm/mm/init.c                          |   1 -
>  arch/arm/plat-samsung/s5p-dev-mfc.c         |   4 +-
>  arch/arm64/mm/init.c                        |  21 --
>  arch/c6x/kernel/setup.c                     |   4 +-
>  arch/metag/kernel/setup.c                   |   4 -
>  arch/microblaze/kernel/prom.c               |  39 +--
>  arch/mips/cavium-octeon/setup.c             |  20 +-
>  arch/mips/include/asm/mips-boards/generic.h |   4 -
>  arch/mips/include/asm/prom.h                |   6 +-
>  arch/mips/kernel/prom.c                     |   2 +-
>  arch/mips/lantiq/prom.c                     |  15 +-
>  arch/mips/lantiq/prom.h                     |   2 -
>  arch/mips/mti-sead3/sead3-setup.c           |   8 +-
>  arch/mips/netlogic/xlp/dt.c                 |  19 +-
>  arch/mips/ralink/of.c                       |  29 +-
>  arch/openrisc/kernel/vmlinux.h              |   2 -
>  arch/powerpc/include/asm/prom.h             |  39 +++
>  arch/powerpc/kernel/Makefile                |   1 +
>  arch/powerpc/kernel/epapr_paravirt.c        |   2 +-
>  arch/powerpc/kernel/fadump.c                |   4 +-
>  arch/powerpc/kernel/prom.c                  |  78 ++----
>  arch/powerpc/kernel/rtas.c                  |   2 +-
>  arch/powerpc/mm/hash_utils_64.c             |  22 +-
>  arch/powerpc/platforms/52xx/efika.c         |   4 +-
>  arch/powerpc/platforms/chrp/setup.c         |   4 +-
>  arch/powerpc/platforms/powernv/opal.c       |  12 +-
>  arch/powerpc/platforms/pseries/setup.c      |   4 +-
>  arch/x86/kernel/devicetree.c                |  12 +-
>  arch/xtensa/kernel/setup.c                  |   3 +-
>  drivers/of/Kconfig                          |   1 +
>  drivers/of/Makefile                         |   2 +
>  drivers/of/fdt.c                            | 398 ++++++++++----------=
--------
>  drivers/of/of_reserved_mem.c                |   4 +-
>  include/linux/of_fdt.h                      |  63 +----
>  40 files changed, 280 insertions(+), 598 deletions(-)
>=20

For Microblaze and generic changes:
Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlNXzKIACgkQykllyylKDCHfdwCgiJNPWBZCjUqOaapgY9tFFiZM
34UAl1gzqEO33NTC3JDpDfaBeLQ52K8=
=iDhY
-----END PGP SIGNATURE-----

--fa44qwhiFD5wEbiglH9p22ihdKl4vOM5A--

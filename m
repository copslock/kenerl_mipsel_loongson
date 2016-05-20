Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 16:49:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5205 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27031744AbcETOt4WRy1b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2016 16:49:56 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E6CC741F8EA9;
        Fri, 20 May 2016 15:49:50 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 20 May 2016 15:49:50 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 20 May 2016 15:49:50 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 599D67457F9A2;
        Fri, 20 May 2016 15:49:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 15:49:50 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 20 May
 2016 15:49:50 +0100
Date:   Fri, 20 May 2016 15:49:50 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <Paul.Burton@imgtec.com>
Subject: Re: [PATCH]: ELF/MIPS build fix
Message-ID: <20160520144950.GA1145@jhogan-linux.le.imgtec.org>
References: <20160520141705.GA1913@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20160520141705.GA1913@linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 6e37d52
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53561
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

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 04:17:05PM +0200, Ralf Baechle wrote:
> CONFIG_MIPS32_N32=3Dy but CONFIG_BINFMT_ELF disabled results in the follo=
wing
> linker errors:
>=20
> arch/mips/built-in.o: In function `elf_core_dump':
> binfmt_elfn32.c:(.text+0x23dbc): undefined reference to `elf_core_extra_p=
hdrs'
> binfmt_elfn32.c:(.text+0x246e4): undefined reference to `elf_core_extra_d=
ata_size'
> binfmt_elfn32.c:(.text+0x248d0): undefined reference to `elf_core_write_e=
xtra_phdrs'
> binfmt_elfn32.c:(.text+0x24ac4): undefined reference to `elf_core_write_e=
xtra_data'
>=20
> CONFIG_MIPS32_O32=3Dy but CONFIG_BINFMT_ELF disabled results in the follo=
wing
> linker errors:
>=20
> arch/mips/built-in.o: In function `elf_core_dump':
> binfmt_elfo32.c:(.text+0x28a04): undefined reference to `elf_core_extra_p=
hdrs'
> binfmt_elfo32.c:(.text+0x29330): undefined reference to `elf_core_extra_d=
ata_size'
> binfmt_elfo32.c:(.text+0x2951c): undefined reference to `elf_core_write_e=
xtra_phdrs'
> binfmt_elfo32.c:(.text+0x29710): undefined reference to `elf_core_write_e=
xtra_data'
>=20
> This is because binfmt_elfn32 and binfmt_elfo32 are using symbols
> from elfcore but for these configurations elfcore will not be built.
>=20
> Fixed by making elfcore selectable by a separate config symbol which
> unlike the current mechanism can also be used from other directories
> than kernel/, then having each flavor of ELF that relies on elfcore.o,
> select it in Kconfig, including CONFIG_MIPS32_N32 and CONFIG_MIPS32_O32
> which fixes this issue.
>=20
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

FWIW this looks good to me,

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> ---
>  arch/mips/Kconfig | 1 +
>  fs/Kconfig.binfmt | 8 ++++++++
>  kernel/Makefile   | 4 +---
>  3 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5663f41..f19e15c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -3116,6 +3116,7 @@ config MIPS32_N32
>  config BINFMT_ELF32
>  	bool
>  	default y if MIPS32_O32 || MIPS32_N32
> +	select ELFCORE
> =20
>  endmenu
> =20
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 2d0cbbd..72c0335 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -1,6 +1,7 @@
>  config BINFMT_ELF
>  	bool "Kernel support for ELF binaries"
>  	depends on MMU && (BROKEN || !FRV)
> +	select ELFCORE
>  	default y
>  	---help---
>  	  ELF (Executable and Linkable Format) is a format for libraries and
> @@ -26,6 +27,7 @@ config BINFMT_ELF
>  config COMPAT_BINFMT_ELF
>  	bool
>  	depends on COMPAT && BINFMT_ELF
> +	select ELFCORE
> =20
>  config ARCH_BINFMT_ELF_STATE
>  	bool
> @@ -34,6 +36,7 @@ config BINFMT_ELF_FDPIC
>  	bool "Kernel support for FDPIC ELF binaries"
>  	default y
>  	depends on (FRV || BLACKFIN || (SUPERH32 && !MMU) || C6X)
> +	select ELFCORE
>  	help
>  	  ELF FDPIC binaries are based on ELF, but allow the individual load
>  	  segments of a binary to be located in memory independently of each
> @@ -43,6 +46,11 @@ config BINFMT_ELF_FDPIC
> =20
>  	  It is also possible to run FDPIC ELF binaries on MMU linux also.
> =20
> +config ELFCORE
> +	bool
> +	help
> +	  This option enables kernel/elfcore.o.
> +
>  config CORE_DUMP_DEFAULT_ELF_HEADERS
>  	bool "Write ELF core dumps with partial segments"
>  	default y
> diff --git a/kernel/Makefile b/kernel/Makefile
> index f0c40bf..e2ec54e 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -91,9 +91,7 @@ obj-$(CONFIG_TASK_DELAY_ACCT) +=3D delayacct.o
>  obj-$(CONFIG_TASKSTATS) +=3D taskstats.o tsacct.o
>  obj-$(CONFIG_TRACEPOINTS) +=3D tracepoint.o
>  obj-$(CONFIG_LATENCYTOP) +=3D latencytop.o
> -obj-$(CONFIG_BINFMT_ELF) +=3D elfcore.o
> -obj-$(CONFIG_COMPAT_BINFMT_ELF) +=3D elfcore.o
> -obj-$(CONFIG_BINFMT_ELF_FDPIC) +=3D elfcore.o
> +obj-$(CONFIG_ELFCORE) +=3D elfcore.o
>  obj-$(CONFIG_FUNCTION_TRACER) +=3D trace/
>  obj-$(CONFIG_TRACING) +=3D trace/
>  obj-$(CONFIG_TRACE_CLOCK) +=3D trace/

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPyQOAAoJEGwLaZPeOHZ6hzAP/32Vaq/ZdjZuL8tFYjAfDQy1
4DppvoGMAzGDDVBuptQwoutQENmT1UucGTYRNL8b6TBRArUNsIlXw4ahnKKyR9sE
GOH/Y0QDGrp/0xJz9XugWQ580O4HQU2mJ7Mxlw+vkxeSzZnAaifTIgmO8WK6xbd6
ec1O5brVZsQiyK8aIxd/mTe+4iwDUR7InRiQK/nCJE4VVKPYCZSIeelzezwcpLR8
7ILiSFQ4lTon+4tIUHm7uCnxdRqcdqsPCHZ8fuO3hJp8+NWYHsCEKF4RqoFyuDHv
EpjrJZHmdm6uLkYGGY1PUnJuojNYtIg0CIoIGTdwN9x69hDoPZRSstQ86N1r83Yj
47gCJSaoj2ExYHvrxEuFWlhjLv47NghPWFPJtGbVhG+UTGNFKOZ+rkWN9za1lJt9
SalbetPFlbvd/hLZGy+tofbqSaUNLIVw0WxE2MAHOH3ErdDtxUsOY6DO1ngu1wZy
H2TmpVFNJORtXE5TgQ+4+n7ljOQAmBtIU6stCHnGf1ftA8rbmKlpJUgw6QOnlG1i
BYLuSGt73BUkMc7Jwo6Kzhxen33osdkLG4EyxX0e+oN+s7gOJyqkaW05drGJDmqW
EG5x8RK5IzhXcgyYww6CF2u6NQUDAaUzE0OIIkvwX8wBXqxzflSutWoClBZTOP3v
emCMrZr1gYPZtARBGGw5
=jyWA
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

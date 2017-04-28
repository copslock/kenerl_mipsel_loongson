Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 10:36:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64093 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993417AbdD1IgkKj0el (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 10:36:40 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CC62641F8DF6;
        Fri, 28 Apr 2017 10:43:49 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 28 Apr 2017 10:43:49 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 28 Apr 2017 10:43:49 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DD9264C0830FF;
        Fri, 28 Apr 2017 09:36:31 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 28 Apr
 2017 09:36:33 +0100
Date:   Fri, 28 Apr 2017 09:36:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Rob Landley <rob@landley.net>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>
Subject: Re: Commit 10b6ea0959de broke qemu reboot/exit.
Message-ID: <20170428083633.GL1105@jhogan-linux.le.imgtec.org>
References: <bb1f5b37-26ca-10ff-c514-33899f21ea24@landley.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <bb1f5b37-26ca-10ff-c514-33899f21ea24@landley.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57809
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

--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, Apr 28, 2017 at 02:39:39AM -0500, Rob Landley wrote:
> QEMU fails to reboot with current kernels, instead it hangs eating CPU:
>=20
>   # exit
>   reboot: Restarting system
>   Reboot failed -- System halted
>=20
> I bisected it to "MIPS: Malta: Use syscon-reboot driver to reboot"
> commit 10b6ea0959de back in September. To reproduce, build a kernel with:
>=20
> cat > mini.conf << EOF
> # CONFIG_EMBEDDED is not set
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_RD_GZIP=3Dy
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> CONFIG_MISC_FILESYSTEMS=3Dy
> CONFIG_DEVTMPFS=3Dy
>=20
> CONFIG_MIPS_MALTA=3Dy
> CONFIG_CPU_MIPS32_R2=3Dy
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_PM=3Dy
> CONFIG_PCNET32=3Dy
> CONFIG_BLK_DEV_PIIX=3Dy
> EOF
>=20
> make ARCH=3Dmips allnoconfig KCONFIG_ALLCONFIG=3Dmini.conf
> make ARCH=3Dmips CROSS_COMPILE=3Dblah-
>=20
> And then boot qemu with a simple initramfs:
>=20
> qemu-system-mips -M malta -nographic -no-reboot -kernel vmlinux \
>   -append "console=3DttyS0 panic=3D1" -initrd root.cpio.gz
>=20
> And then try to shut it down. Before that commit it did, after it
> doesn't. (I rebuilt qemu from git this morning and that didn't help,
> same behavior as last year's build. New kernel doesn't know how to tell
> it to shut down, old one did.)

I presume this is due to the following missing from your config:
CONFIG_POWER_RESET=3Dy
CONFIG_POWER_RESET_SYSCON=3Dy

The commit added these to the Malta defconfigs, but perhaps should have
selected them from CONFIG_MIPS_MALTA instead, as CONFIG_ARCH_EXYNOS
does, since its pretty core functionality that didn't used to be
optional?

Cheers
James

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlkC/vMACgkQbAtpk944
dnpvkw//c3F9tS3JYooS9JxzP82fFnzVqdXMb2cgEeafQkayMLZ/SEUc6nkmRN0Q
2vRtezbhx3PVAmSkTSG5yEXdKREA/HYgfufBdWi8I5iceNOHS4vdh06tSE2iNG/v
JYyO78NeL+Yz3cF5fij8EEkBdsOJ2aZ4zdM3+66utHH/iBBbsfH6iAGVrrDTGw3O
/3fqoK1bZembbrt05BJDlWMzHwRXsc/oEaZcp0EuhWq3kI2C3aHIN842VjQAMgmF
GnW8Op6+7Agi5uWQJqEV7I+szJaHhZ3j/m4sWPLBqi/F1mPgE9J+nPIAw3ExDt2Q
9UtmScpCOurX/LfDFMa+3+hGFfXjKQusNv1vpyyAfmKOZwbOKAFm19eqx3i+lN3J
aPxsSPi4SPXYFzGKuF2/aCwEyoNzfTINubyhjoToQTTNas95C9nxHIZ6enZlQEuG
BJFJUt4ETnJb3vVwmQfxoxHIpzfAO3tiVHqclF5Qp6VFL9nAMfhCH0Npt7YYAP0K
Zr/DVqkvPvCLEI6zWJsuq5LJ28g/xhcCvit14stv2lp0SkaV6A2JGT6cKUogvj4H
G2N0Gc4jX1I/KVLtqZvmSyr/TDJnKRDP2oo05JqF0sUNmx/Jluqt5UNAjS8JGX1x
CULpE2Oy8wpB4llIO9CneCMHPwLx4DCWKdOX3sYWE50a0mpkfyU=
=cXKX
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--

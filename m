Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 16:16:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49697 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992800AbdFOOQe1LmqS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2017 16:16:34 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 36E3641F8DF9;
        Thu, 15 Jun 2017 16:25:56 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 15 Jun 2017 16:25:56 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 15 Jun 2017 16:25:56 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 95EEF9C16FF31;
        Thu, 15 Jun 2017 15:16:25 +0100 (IST)
Received: from [10.150.130.85] (10.150.130.85) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 15 Jun
 2017 15:16:28 +0100
Subject: Re: [PATCH] MIPS: Octeon: Remove unused L2C types and macros.
To:     "Steven J. Hill" <steven.hill@cavium.com>, <ralf@linux-mips.org>
References: <1489068855-9670-1-git-send-email-steven.hill@cavium.com>
From:   James Cowgill <James.Cowgill@imgtec.com>
CC:     <linux-mips@linux-mips.org>
Message-ID: <92415d13-3c66-76e7-8db3-ee0110c0611b@imgtec.com>
Date:   Thu, 15 Jun 2017 15:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1489068855-9670-1-git-send-email-steven.hill@cavium.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature";
        boundary="ho62ndgCPjpLUXEBQwfa6sFWILHlbf6f9"
X-Originating-IP: [10.150.130.85]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

--ho62ndgCPjpLUXEBQwfa6sFWILHlbf6f9
Content-Type: multipart/mixed; boundary="HiICR3gpOVC7bKoJAocRomcNgPIPDVGOG";
 protected-headers="v1"
From: James Cowgill <James.Cowgill@imgtec.com>
To: "Steven J. Hill" <steven.hill@cavium.com>, ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Message-ID: <92415d13-3c66-76e7-8db3-ee0110c0611b@imgtec.com>
Subject: Re: [PATCH] MIPS: Octeon: Remove unused L2C types and macros.
References: <1489068855-9670-1-git-send-email-steven.hill@cavium.com>
In-Reply-To: <1489068855-9670-1-git-send-email-steven.hill@cavium.com>

--HiICR3gpOVC7bKoJAocRomcNgPIPDVGOG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/03/17 14:14, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
>=20
> Remove all unused bitfields and macros. Convert the remaining
> bitfields to use __BITFIELD_FIELD instead of #ifdef.
>=20
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

This patch broke the EDAC_OCTEON_L2C driver which apparently uses some
of these "unused" structures. I therefore think this patch (or the
relevant parts of it which are still used) should be reverted for 4.12.

drivers/edac/octeon_edac-l2c.c: In function =E2=80=98octeon_l2c_poll_oct1=
=E2=80=99:
drivers/edac/octeon_edac-l2c.c:26:21: error: storage size of =E2=80=98l2d=
_err=E2=80=99 isn=E2=80=99t known
  union cvmx_l2d_err l2d_err, l2d_err_reset;
                     ^~~~~~~
drivers/edac/octeon_edac-l2c.c:26:30: error: storage size of =E2=80=98l2d=
_err_reset=E2=80=99 isn=E2=80=99t known
  union cvmx_l2d_err l2d_err, l2d_err_reset;
                              ^~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:44:30: error: =E2=80=98CVMX_L2D_ERR=E2=80=99=
 undeclared (first use in this function)
  l2d_err.u64 =3D cvmx_read_csr(CVMX_L2D_ERR);
                              ^~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:44:30: note: each undeclared identifier is=
 reported only once for each function it appears in
drivers/edac/octeon_edac-l2c.c:26:30: warning: unused variable =E2=80=98l=
2d_err_reset=E2=80=99 [-Wunused-variable]
  union cvmx_l2d_err l2d_err, l2d_err_reset;
                              ^~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:26:21: warning: unused variable =E2=80=98l=
2d_err=E2=80=99 [-Wunused-variable]
  union cvmx_l2d_err l2d_err, l2d_err_reset;
                     ^~~~~~~
drivers/edac/octeon_edac-l2c.c: In function =E2=80=98_octeon_l2c_poll_oct=
2=E2=80=99:
drivers/edac/octeon_edac-l2c.c:62:26: error: storage size of =E2=80=98err=
_tdtx=E2=80=99 isn=E2=80=99t known
  union cvmx_l2c_err_tdtx err_tdtx, err_tdtx_reset;
                          ^~~~~~~~
drivers/edac/octeon_edac-l2c.c:62:36: error: storage size of =E2=80=98err=
_tdtx_reset=E2=80=99 isn=E2=80=99t known
  union cvmx_l2c_err_tdtx err_tdtx, err_tdtx_reset;
                                    ^~~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:63:26: error: storage size of =E2=80=98err=
_ttgx=E2=80=99 isn=E2=80=99t known
  union cvmx_l2c_err_ttgx err_ttgx, err_ttgx_reset;
                          ^~~~~~~~
drivers/edac/octeon_edac-l2c.c:63:36: error: storage size of =E2=80=98err=
_ttgx_reset=E2=80=99 isn=E2=80=99t known
  union cvmx_l2c_err_ttgx err_ttgx, err_ttgx_reset;
                                    ^~~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:68:31: error: implicit declaration of func=
tion =E2=80=98CVMX_L2C_ERR_TDTX=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
  err_tdtx.u64 =3D cvmx_read_csr(CVMX_L2C_ERR_TDTX(tad));
                               ^~~~~~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:103:31: error: implicit declaration of fun=
ction =E2=80=98CVMX_L2C_ERR_TTGX=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
  err_ttgx.u64 =3D cvmx_read_csr(CVMX_L2C_ERR_TTGX(tad));
                               ^~~~~~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:63:36: warning: unused variable =E2=80=98e=
rr_ttgx_reset=E2=80=99 [-Wunused-variable]
  union cvmx_l2c_err_ttgx err_ttgx, err_ttgx_reset;
                                    ^~~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:63:26: warning: unused variable =E2=80=98e=
rr_ttgx=E2=80=99 [-Wunused-variable]
  union cvmx_l2c_err_ttgx err_ttgx, err_ttgx_reset;
                          ^~~~~~~~
drivers/edac/octeon_edac-l2c.c:62:36: warning: unused variable =E2=80=98e=
rr_tdtx_reset=E2=80=99 [-Wunused-variable]
  union cvmx_l2c_err_tdtx err_tdtx, err_tdtx_reset;
                                    ^~~~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:62:26: warning: unused variable =E2=80=98e=
rr_tdtx=E2=80=99 [-Wunused-variable]
  union cvmx_l2c_err_tdtx err_tdtx, err_tdtx_reset;
                          ^~~~~~~~
drivers/edac/octeon_edac-l2c.c: In function =E2=80=98octeon_l2c_probe=E2=80=
=99:
drivers/edac/octeon_edac-l2c.c:155:22: error: storage size of =E2=80=98l2=
d_err=E2=80=99 isn=E2=80=99t known
   union cvmx_l2d_err l2d_err;
                      ^~~~~~~
drivers/edac/octeon_edac-l2c.c:162:31: error: =E2=80=98CVMX_L2D_ERR=E2=80=
=99 undeclared (first use in this function)
   l2d_err.u64 =3D cvmx_read_csr(CVMX_L2D_ERR);
                               ^~~~~~~~~~~~
drivers/edac/octeon_edac-l2c.c:155:22: warning: unused variable =E2=80=98=
l2d_err=E2=80=99 [-Wunused-variable]
   union cvmx_l2d_err l2d_err;
                      ^~~~~~~
  CC      arch/mips/math-emu/sp_tint.o
cc1: some warnings being treated as errors
scripts/Makefile.build:308: recipe for target 'drivers/edac/octeon_edac-l=
2c.o' failed
make[4]: *** [drivers/edac/octeon_edac-l2c.o] Error 1

James


--HiICR3gpOVC7bKoJAocRomcNgPIPDVGOG--

--ho62ndgCPjpLUXEBQwfa6sFWILHlbf6f9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+Ixt5DaZ6POztUwQx/FnbeotAe8FAllClrYACgkQx/Fnbeot
Ae+pfxAAhoVvBxzzujz4f1LIe5LRv3xucREKQHFXcbx8yqekHECX2SKcFxVue+Tf
jxWzcZDVudDAq07zkdf05hT2RiEBPj6+I6XD1YjWkqVZfJVZR4uTnxWeDaHQvIXD
IyQw7z2xYO6ckESga5bNckNwotMc/0v/ljToMEE6DtU5wvZ+z7VbKqHinxAY1/Nc
tLjLcZ5IHJREvS7pUiq6kzjeKHuudO2MbttMyiSlIL//Vogl0G5mPdtPAPCaE49l
5aCuSG2YCwW6MCfzszBXDrVbZ4e6BYQTUk4Uhj6TTzet+9GRyZMEfWZKcWYrUnZj
MvDL1MxL4F/HdN4sQONZIjTrP/84mVCh4RTiu+bIJDe195lP4vxtACqzrCYu3dNg
eLi+Ya7SvyauhoTeFvNzycxDQDq0Sz7o8ZNNxqh345ajPn80xJLJ8awyUD6ebB/i
4JkFb8z3KoccDpVG0zDHhRYpCu1+MracMnG3pbELnLCTP3HFoOHXtGDeYAq/CXlY
5Qg+myVDwT8KiW8T7Co/hQaqUFXr3P5rPRNMcOIVFYJuYpVI4IvJltzRCsGKaxxb
sDDvVEKTMYjHP/zDOiT9b9qqb/kRYJkOgmjvmvifpRI0w0u+hCDedRvAxZQn4hYT
jla2zKFg4UaoKwnB/rZyw3cpeLwxl3AAxi5zZDWc4TLlSIlh5YM=
=xzXr
-----END PGP SIGNATURE-----

--ho62ndgCPjpLUXEBQwfa6sFWILHlbf6f9--

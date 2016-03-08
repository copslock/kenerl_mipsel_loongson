Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 15:35:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32500 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007002AbcCHOfiqPVYz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Mar 2016 15:35:38 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7A90941F8E73;
        Tue,  8 Mar 2016 14:35:33 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 08 Mar 2016 14:35:33 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 08 Mar 2016 14:35:33 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 5B3E3EA99DD2A;
        Tue,  8 Mar 2016 14:35:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 8 Mar 2016 14:35:33 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 8 Mar
 2016 14:35:32 +0000
Date:   Tue, 8 Mar 2016 14:35:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Build regressions/improvements in v4.5-rc7
Message-ID: <20160308143532.GN31414@jhogan-linux.le.imgtec.org>
References: <1457340934-23042-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWe9bTjp-qmTJc9=n9-iP-qH8-O0jafiRD3-y_EtT=WvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="prC3/KjdfqNV7evK"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWe9bTjp-qmTJc9=n9-iP-qH8-O0jafiRD3-y_EtT=WvA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52552
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

--prC3/KjdfqNV7evK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 07, 2016 at 10:01:09AM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 7, 2016 at 9:55 AM, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > JFYI, when comparing v4.5-rc7[1] to v4.5-rc6[3], the summaries are:
> >   - build errors: +8/-7
>   + error: debugfs.c: undefined reference to `clk_round_rate':  =3D>
> .text+0x11b9e0)
>=20
> arm-randconfig
>=20
> While looking for more context, I noticed another regression that fell th=
rough
> the cracks of my script:
>=20
>     arch/arm/kernel/head.o: In function `stext':
>     (.head.text+0x40): undefined reference to `CONFIG_PHYS_OFFSET'
>     drivers/built-in.o: In function `v4l2_clk_set_rate':
>     debugfs.c:(.text+0x11b9e0): undefined reference to `clk_round_rate'
>=20
>   + error: misc.c: undefined reference to `ftrace_likely_update':  =3D>
> .text+0x714), .text+0x94c), .text+0x3b8), .text+0xc10)
>=20
> sh-randconfig
>=20
>     arch/sh/boot/compressed/misc.o: In function `lzo1x_decompress_safe':
>     misc.c:(.text+0x3b8): undefined reference to `ftrace_likely_update'
>     misc.c:(.text+0x714): undefined reference to `ftrace_likely_update'
>     misc.c:(.text+0x94c): undefined reference to `ftrace_likely_update'
>     arch/sh/boot/compressed/misc.o: In function `unlzo.constprop.2':
>     misc.c:(.text+0xc10): undefined reference to `ftrace_likely_update'
>=20
>   + /tmp/cc52LvuK.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  =3D> 41, 403
>   + /tmp/ccHfoDA4.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  =3D> 43
>   + /tmp/cch1r0UQ.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  =3D> 49, 378
>   + /tmp/ccoHdFI8.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  =3D> 43
>=20
> mips-allnoconfig
> bigsur_defconfig
> malta_defconfig
> cavium_octeon_defconfig
>=20
> Not really new, but it would be great if the MIPS people could get this
> fixed for the final release.

This would appear to be related to the ld version check for VDSO
failing.

awk: /home/kisskb/slave/src/scripts/ld-version.sh: line 4: regular expressi=
on compile failed (missing '(')
=2E*)
/bin/sh: 1: [: -lt: unexpected operator

I.e. this line:
gsub(".*)", "");

appears to be trying to turn e.g. "GNU ld (Gentoo 2.25.1 p1.1) 2.25.1"
into " 2.25.1", so perhaps the bracket should be escaped. What version
of awk is it using? (GNU Awk 4.0.2 works for me).

Can somebody experiencing this please try:
${CROSS_COMPILE}ld --version | ./scripts/ld-version.sh

with the following patch, to see if it helps.

Thanks
James

diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index 198580d245e0..1659b409ef10 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -1,7 +1,7 @@
 #!/usr/bin/awk -f
 # extract linker version number from stdin and turn into single number
 	{
-	gsub(".*)", "");
+	gsub(".*\\)", "");
 	split($1,a, ".");
 	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
 	exit

--prC3/KjdfqNV7evK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3uM0AAoJEGwLaZPeOHZ6qBIP/A1o8LERtDSh4DcTXe9DLPG8
g2sWejK+8zzFdM6OK15MfRiK7qv5N1fq97l8STYJiY+Yhs5lWGxLe1A/eVYHhvB/
99ExqRUgRZMJoiFiO2FBV/Z0eu60EkK4BSMrM02nmIu9kIrBTwSfO/MDa59NcqX5
udnudur3IOXT1ccExENU+jrrBSC4z/VCqcpF0QbRvBIgHjFpeKzY9yIOQFjzC/9v
m55DQt+SZFD6eUnH/ybeAFNSG9K8nA6jaTjrxHauCOovFBrAacxO17iZAWzG/qE1
yV69bZiBTK2365gzlWaURNDUmVO25sUUvsvOkaQd7+mqfUUVZSwF6B8BGOHySw96
92ivhLDdamHvRLiRm8XjucJ9sVl3HaSfLRHxorFy7AKad3CqwG8oetlwWK6jSS9F
ky0iCWjz6YPFpX5pei0+mpAE5o9d6hofskAvFRy34/PiRkt3Q5VAM2ie9pItCBNn
+qETmGssDaiIyvsOmG8aK2tFUaI4e2VgpKT42nRFpI/yCF8Y4euk+avag/JcX/Dw
B0AAyI/L3HPr5yb2o8JN4v8D6HRWR8NOWd31P5/0oWb766dKV11WW8YrC30Pzq4L
MqrbVqPN2kH4q9Fxsnkx2M2klW+qQsnjWyt0jWzga9LtZKZs18QZbQgWTU7vhw5w
SDO6OJo6hnA4RWNM8OjO
=a5rQ
-----END PGP SIGNATURE-----

--prC3/KjdfqNV7evK--

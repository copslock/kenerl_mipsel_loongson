Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 14:25:53 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:44357 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeAQNZqoz8Jo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 14:25:46 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 17 Jan 2018 13:25:24 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 17 Jan
 2018 05:25:14 -0800
Date:   Wed, 17 Jan 2018 13:25:13 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: About Loongson platforms' directories
Message-ID: <20180117132512.GG5027@jhogan-linux.mipstec.com>
References: <1516182767.23672.1.camel@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UKsZWh/ZtaJX4ozz"
Content-Disposition: inline
In-Reply-To: <1516182767.23672.1.camel@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1516195522-321459-8816-53779-11
X-BESS-VER: 2017.17-r1801091856
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189070
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--UKsZWh/ZtaJX4ozz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 05:52:47PM +0800, Jiaxun Yang wrote:
> Hi, MIPS maintainers
>=20
> Recently Loongson has released their now SystemOnChip chip called
> Loongson2K, and I'm going to submit patches for that chip soon. But I
> noticed that currently,  Loongson64 code in mainline kernel is pretty
> in confusion. We mixed loongson2e/2f/3a/3b together in
> /arch/mips/loongson64, but they don't have many similarities. 2E/2F are
> legacy products that don't support many features such as EFI or SMBIOS,

Can you expand on these. To what extent is Loongson's EFI similar to the
EFI from the x86 world? Do these allow multiple new platforms to be
supported more easily without much new platform code (like devicetree
support would)?

> only a little code can be reused with 3 series. After discussed with
> another maintainer Huacai Chen, we thought we can separate 2E/2F with 3
> series and make 4 directories.
>=20
> /loongson-1 (Loongson 1B/1C Micro Control Units formal loongson32)
> /loongson-2ef (Loongson 2E/2F legacy CPU machines formal
> loongson64/lemote-2f fuloong-2e)
> /loongson-2soc (Loongson2H/2K SoCs will be submited latter)
> /loongson-3 (Loongson 3A/3B CPU machines formal loongson64/loongson3)
>=20
> So we can maintain code for different family chips easier. Just ask if
> anybody have a better idea about that.

I believe the general approach in the ARM camp since Linus put his foot
down about the proliferation of platform code is to have it all
devicetree based rather than littering the arch directories with
platform devices. That way a single multiplatform kernel can boot on a
variety of different platforms with the DT provided by the bootloader or
appended to the kernel.

As well as cleaning up and reducing platform code it also simplifies the
work for distributions since they only need a small number of kernel
builds.

On that front MIPS has the "generic" platform (Paul CC'd) which is
effectively a multi-platform configuration. It is possible to produce a
single ITB file which contains a kernel and multiple device tree files
for different platforms which the bootloader can choose from. It may be
possible to also boot using legacy boot protocols too, though it depends
on how it differs from the MIPS UHI spec (so a single kernel could boot
on either platform), and it may require some form of DT shim to set up a
DT for the kernel to use internally.

What challenges would you foresee if Loongson headed this way? (even if
it was a single separate loongson platform in the kernel source). It may
require some driver revamping, and the boot protocol might be an issue
for it to share with the other "generic" platforms. Each new board
potentially becomes easier to upstream though since the only new arch
code is devicetree, and the rest is drivers in various other subsystems.

That's the way things should be heading in my opinion (and already are).

>=20
> BTW: My recent patches have been ignored for a long time. Probably
> because Ralf didn't appear for a long time. Just ask if these patches
> can get a chance to be applied. And I don't know what's the proper
> upstream for me, Ralf's mips-next or James's mips-next?

Currently Ralf's mips-next, though there isn't a lot there yet and the
merge window is imminent...

Cheers
James

--UKsZWh/ZtaJX4ozz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpfTp4ACgkQbAtpk944
dnroxQ/+MJ6rJNBlrDNxs493Ylzw6CO47If3SlnnOOgJqh2d/7gV6pFZnBUWkYG3
Az/ygG3s+Y96zvMopRDgdPMv9WkPfMIYtir7KpZpQXF3jK06gbne+loHx+CBCi38
Xs0KOMiVpeuOqIDHeumMKUrdDlJ28QmRtWvDHvIp7/gBwdPFVWAtnRu5WxpJRqIo
8oXZFbZcsyIIIct7OTa1wK8TEvPgUBeZLByfB7CICLx+jdUqfaQlN7yeAX6EHG63
2rzK5wTadeoDhgS9vmzoCEjxWZr+El3kyDr62DnO3790DIGAyJ2buNh2dKzWg2w+
MS4xMtifU3IlNAgU5LGnsctROXt4MQ7AtF1htR+SG+aYJcGDnjUFvroJqq5Gx1R6
gtRJBOw6UIODWQLNwzLnit7zthk8YksZD2Ukb464TrwZNKMFDTAs4i/fjFJLQZal
XutrxckgJGDgYq6GF7tOHSEfw/NgiueQnfmeIXoXSYBahE5RnLVT60bN5zqzFRFc
3LgpXfgvWT9x1x80T2uSKju2Rhjtebr+M74rqZDR3/TU77LR9qwhGI3BgEYEKmUu
vhVfUx+gtEoz+7bN4wb7Eax8RXr86cugeylnjXJOxbrxgVI5mmtKalUHDHNGL8Lx
Uss6zvKpKiMmlpmoybivjI/MXMGvpmauvbijW5Mobu7/3eSVVNI=
=ngA/
-----END PGP SIGNATURE-----

--UKsZWh/ZtaJX4ozz--

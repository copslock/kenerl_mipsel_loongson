Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2015 12:31:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38126 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009913AbbJPKbTuh0mM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2015 12:31:19 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8467341F8D8F;
        Fri, 16 Oct 2015 11:31:13 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 16 Oct 2015 11:31:13 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 16 Oct 2015 11:31:13 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9716AB961DB43;
        Fri, 16 Oct 2015 11:31:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Oct 2015 11:31:13 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 16 Oct
 2015 11:31:12 +0100
Date:   Fri, 16 Oct 2015 11:31:12 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Alex Smith <alex@alex-smith.me.uk>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>,
        <linux-mtd@lists.infradead.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH v7,3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
Message-ID: <20151016103112.GB29285@jhogan-linux.le.imgtec.org>
References: <1444148837-10770-1-git-send-email-harvey.hunt@imgtec.com>
 <1444148837-10770-4-git-send-email-harvey.hunt@imgtec.com>
 <20151015084727.GG14475@jhogan-linux.le.imgtec.org>
 <CAOFt0_D5mO-7_cnpvm_MwvsZNv1yCFynbeA3dSw=H5hVyQbgTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <CAOFt0_D5mO-7_cnpvm_MwvsZNv1yCFynbeA3dSw=H5hVyQbgTA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e4aa9c8
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49567
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

--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Fri, Oct 16, 2015 at 11:11:29AM +0100, Alex Smith wrote:
> Hi James,
>=20
> On 15 October 2015 at 09:47, James Hogan <james.hogan@imgtec.com> wrote:
> >> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/=
ingenic/ci20.dts
> >> index 9fcb9e7..453f1d3 100644
> >> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> >> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> >> @@ -42,3 +42,57 @@
> >>  &uart4 {
> >>       status =3D "okay";
> >>  };
> >> +
> >> +&nemc {
> >> +     status =3D "okay";
> >> +
> >> +     nand: nand@1 {
> >> +             compatible =3D "ingenic,jz4780-nand";
> >
> > Isn't the NAND a micron part? This doesn't seem right. Is the device
> > driver and binding already accepted upstream with that compatible
> > string?
>=20
> This is the compatible string for the JZ4780 NAND driver, this patch
> is part of the series adding that. Detection of the NAND part is
> handled by the MTD subsystem.

Right (didn't spot that it was part of a series).

The node appears to describe the NAND interface itself, i.e. a part of
the SoC, so should be in the SoC dtsi file, with overrides in the board
file if necessary for it to work with a particular NAND part
(potentially utilising status=3D"disabled"). Would you agree?

Cheers
James

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWINHwAAoJEGwLaZPeOHZ6sx4QAIaMMqM4IJbFIcTiKRT8vdMr
r89sxi5SsS6VdUDZI2IlAnQYnB6rrDjZ53Wag3PbA3G9PZFA16wOQDSVCyLiyPHL
ss/4bl2D3cIabC9I9f5vjMQcSl0/AVD/VPDXSG3yP7XNv8Jh1cMkvIXIyI7mguIc
kaJs0mlSTStWIOGuRf98vxqv1sVuxM7vnEu59SOfM90xYYsHSoAiKuAjUpVBZHcj
0zWifGpbwBmUIjeA2znbbJifvrKUzybxywQaRlKmYC4cpxIEsrQWVj01OLB2nZv9
wbXBQq3xzl79LHex/180IBzqzrpVZmt5ewHZLNv1zFH82WPMFJCON6JwgI7qL5g2
6EnXX93WVC+kLfBv8gKFqumNnZgtQCjGgM5wMzmsofhFOOdk3ymusaubVFLd0KdR
vcgsdiq59zthDTLEZjYHQa0zE1CANNvmz89WeMUjI/58qPbE0RwXoh7VJgaZlouP
KICMH0MKTSvaSiuKobaS/ngz5W21z5LgLmDfna73Ia+wMgFcxd0svTfhv6fA+WWg
bobnxtujCkFXTrlQHBiRnLLNrRx1hSjuH2azLlyW9MAHRLbbfZ+x6nTUOPghZtbR
KTOOjHKvT0yD036ZQomRS98ubfAZWbj4YoQ/tYCuBik+nvZeAh92BRA/Oa75A7bu
eEmfb7HtPycmATK4/6Ip
=6LZP
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

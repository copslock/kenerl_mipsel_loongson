Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 18:04:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35186 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994781AbdHUQEaybhH3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2017 18:04:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 289A2A0B860E9;
        Mon, 21 Aug 2017 17:04:19 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 21 Aug 2017 17:04:22 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 21 Aug
 2017 17:04:21 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 21 Aug
 2017 09:04:17 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, "David S . Miller" <davem@davemloft.net>,
        Paul Cercueil <paul@crapouillou.net>,
        <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 2/6] crypto: jz4780-rng: Make ingenic CGU driver use syscon
Date:   Mon, 21 Aug 2017 09:04:16 -0700
Message-ID: <45556677.8n3yGzOkJs@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <CANc+2y6tRe_kkWyGX+-BT-ugb5JiZhKpPoHWkAn=2ZC6cb6uKA@mail.gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com> <3563032.h0vdzx9HfC@np-p-burton> <CANc+2y6tRe_kkWyGX+-BT-ugb5JiZhKpPoHWkAn=2ZC6cb6uKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8306877.L2Sq6hHNpB";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59736
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

--nextPart8306877.L2Sq6hHNpB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi PrasannaKumar,

On Sunday, 20 August 2017 09:12:12 PDT PrasannaKumar Muralidharan wrote:
> > Could you instead perhaps:
> >  - Just add "syscon" as a second compatible string to the CGU node in the
> >  
> >    device tree, but otherwise leave it as-is without the extra
> >    cgu_registers
> >    node.
> >  
> >  - Have your RNG device node as a child of the CGU node, which should let
> >  it
> >  
> >    pick up the regmap via syscon_node_to_regmap() as it already does.
> >  
> >  - Leave the CGU driver as-is, so it can continue accessing memory
> >  directly
> >  
> >    rather than via regmap.
> 
> As per my understanding, CGU driver and syscon will map the same
> register set. Is that fine?

That should work fine.

It's only risky if you have 2 drivers using the same registers in ways that 
might race with one another or clobber one another's data. In this case each 
of the 2 drivers is using a different subset of registers that just happen to 
be in the same address range, so there shouldn't be an issue.

Thanks,
    Paul
--nextPart8306877.L2Sq6hHNpB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmbBIAACgkQgiDZ+mk8
HGVe1Q/6Au2TClXs/W79i3QnmUiwaV9otdtoqCPYhvX6pFQ3vlrPt+Dn1FsvoRwL
dccm/fueHvkdYvueUbkqmjUDuiWrt3tv4YoVnih81gtmBWVeF9hQ9hLqd3nlZhbS
9aFryozQ8mO6AHP4N58Iv8aPubtoYunDasCdMZ72cq9T3SxIaAl9B2AEQEls5JO8
mgESbB7kGrv5d484ktOGGRr4KjNlCxFxOVWxZq7zPQxuCMRbsIAZEnpW9ei1OXuV
b2VGa/o8oz3WnPiCrxwgNHH7ckp6LBjdtv4Rq+oxiOs9ONWRZoXXC0ygvdc1Pv6a
9Y1DCZWzQrzali8g1YAytuEQgql+i/xId9uoNxQy3Fw0SGIRsNkEXjqASFzUF/wb
Z/8jvxuia4EQEUsgb5UWlDP2zy2q7zCCj/IB3pvAn9u4vD8WtQRrZIhR7W0qOd3f
P8Q1Eq/u4rnyPdNV9x7TrFSRlIJ90FTytYCfKDu0qeGcsfYi39vrVPEEESgzSPmM
UVD4/biG80szEmkCNeGFsaViNoUCE1/5sw4nvCmStsH0IIYaXHV3hLDi4J0L90JY
PsDssx1NUF+ySLeaNYLfIfg5ySRJlnFRN7kdC2fcp85D1bx4xBc5qqDuo2MIXR5K
G9jZOj2H2DzoVI22SW2mbRJYSwTWIApkMzyfBXPcGUByUm1QCQM=
=fpS/
-----END PGP SIGNATURE-----

--nextPart8306877.L2Sq6hHNpB--

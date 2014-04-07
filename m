Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 12:54:29 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:28980 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816686AbaDGKyZ03t23 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 12:54:25 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4ABFE41F8E28;
        Mon,  7 Apr 2014 11:54:19 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 07 Apr 2014 11:54:19 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 07 Apr 2014 11:54:19 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EE9083FB49BAA;
        Mon,  7 Apr 2014 11:54:16 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 7 Apr
 2014 11:54:19 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 7 Apr 2014 11:54:18 +0100
Received: from [192.168.154.65] (192.168.154.65) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 7 Apr
 2014 11:54:18 +0100
Message-ID: <534283D3.7060704@imgtec.com>
Date:   Mon, 7 Apr 2014 11:54:11 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux@openrisc.net>, <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 08/20] of/fdt: consolidate built-in dtb section variables
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com> <1396563423-30893-9-git-send-email-robherring2@gmail.com>
In-Reply-To: <1396563423-30893-9-git-send-email-robherring2@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="Gfk1QLSHjtOWmUr7AwUXJUmxWIMf6JPRk"
X-Originating-IP: [192.168.154.65]
X-ESG-ENCRYPT-TAG: ea208f3a
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39674
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

--Gfk1QLSHjtOWmUr7AwUXJUmxWIMf6JPRk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/04/14 23:16, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> Unify the various architectures __dtb_start and __dtb_end definitions
> moving them into of_fdt.h.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-metag@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux@lists.openrisc.net
> Cc: linux-xtensa@linux-xtensa.org

Acked-by: James Hogan <james.hogan@imgtec.com> [metag]

Cheers
James


--Gfk1QLSHjtOWmUr7AwUXJUmxWIMf6JPRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJTQoPaAAoJEGwLaZPeOHZ6+toQAIb0ewv1g3ZgJoFKpR2ZwIHe
kqRjmitkiyUKh/agMjq2xW5wE1L9Rnxm4wToqS3BBcOJV4Rg+90Hm8+dIgZbPRam
hiNT1E8oyTuHfjEcJdGTHmCn2gvfyYKyuf68PQ6mTLVRTmizcWXI3uS6CVaq98Gg
19ulvfjhxOA0aakdisvnhhW8h0ADqYtGv3wn2vE7CevE9JtK8T5qFNzaCgSPhPL4
phe06ApG1utiZ3XQO1zSheO5amnjPCytNHG+l+hRfQgmtxad0cs6/Ba66Nak36WL
8M5aja6uQkZ+5XroX2T3dkcBSpMwenCsX9fYAuui0Gjmlsv+8k/C4tGG4d0MTNG2
Saj5yWxd4LcyfnWsRQIezEpJUCIViwCrfRDlppFSVaUCx1gHBrSG+4zPLuumdURB
I5qDhk7Q1tZgJb3Z5GBCW1TZLPM6VAkWyVvOHHlnbnVPekFG1wp2DBYGYyIoapSc
gG5vvACxIjBDrgK5WlSBQaD+l7m6d7TUhQAljHYJmmMReBmyefgltl2PNtIAtk8A
rQ1diw3ZkryOg5kWowsL99/iH+KCAwp4eIlgfEMFfHULnTldAPhQNnSXer3Kn+yj
Sp82NNjRiZCcdVcX9NkdEcjpaSpphMAL6papiS6F6baCCEdOcb4cBJzr1NIWDJUZ
lIHd9h8T/MMB6Ls2DJyx
=Qpb9
-----END PGP SIGNATURE-----

--Gfk1QLSHjtOWmUr7AwUXJUmxWIMf6JPRk--

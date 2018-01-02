Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 14:40:21 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:35235 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992692AbeABNkNCBsT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 14:40:13 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 02 Jan 2018 13:39:49 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 2 Jan 2018
 05:39:46 -0800
Date:   Tue, 2 Jan 2018 13:39:45 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai CHen <chenhc@lemote.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Loongson64: Drop 32-bit support for Loongson 2E/2F
 devices
Message-ID: <20180102133944.GO5027@jhogan-linux.mipstec.com>
References: <20171226042138.13227-1-jiaxun.yang@flygoat.com>
 <20180102084759.GL5027@jhogan-linux.mipstec.com>
 <1514899786.1694.6.camel@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l4IMblsHEWQg+b+m"
Content-Disposition: inline
In-Reply-To: <1514899786.1694.6.camel@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1514900389-321458-22647-215238-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188572
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
X-archive-position: 61827
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

--l4IMblsHEWQg+b+m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 09:29:46PM +0800, Jiaxun Yang wrote:
> On 2018-01-02 Tue 08:48 +0000=EF=BC=8CJames Hogan Wrote=EF=BC=9A
> > On Tue, Dec 26, 2017 at 12:21:38PM +0800, Jiaxun Yang wrote:
> > > Make loongson64 a pure 64-bit mach.
> >=20
> > Please expand to provide some rationale behind the change. Was 32-bit
> > support broken at runtime, or broken at build time, or are we simply
> > no
>=20
> The 32-bit support was broken at runtime, it doesn't boot anymore,
> witch is hard to debug because even early printk isn't working, also
> there are some build warnings. Some newer bootloader may not support
> 32-bit ELF. So we decide to drop 32-bit support.

Okay, please put that in the commit message so that somebody digging
through the history later (perhaps summarising what is new in the next
release) can understand the *why* as well as the what.

Cheers
James

--l4IMblsHEWQg+b+m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpLi6AACgkQbAtpk944
dnoeMw/6A3VTDVgKw0mKGZeyhJl82QQZ3eE+n06u4iRDNxB+bEoluGpbmm9NEv75
U9EB9GymoOCA0dZLlX5qI4aStZuMgHKzZo+QQQX1ADHOJfpfncG+Y8nwlPTENLPh
Fk0wYylBUgFoRq7DaC3yOF/LqM5z9pjo9WSq7qK4nixedtGzjkXhh+hOwXhSfUEh
/Ufsu5Yg7KMcmoUG6Z3KIOV6ZwqhnLw2bKLez9Hw7L29oSPECww5LgChaY3NftLR
brJlYqMQNabnPLUM9kAtNhhdbDvoEt+25C9XuNFX6ED8XxMRmo2bU2OY94cQ6tDw
HXTvsY5EoRUShVUwiGiSQpMC+QrKqcaPQv0le7J2YPB5Poe5s3aIsWz9AKSF9W7S
i06vVum23fTcj34EYay3Rbr2z+hRqIqmA753EU/NvVzGGzWtSH26oMS3mSb8YqmN
ecj9Mak1SW4RbYn7UxpoNfdfciQPdcYFqPeEEftG0hWU4pn/Qa0VXmHsBinCEt2v
j77nJjoogBxNbCvOh4btyVSPDwM3HXOXQYoApWP4GtbBSbO927J2nxeG91WI/PMt
prG92AFRJwAg+yk1HUoxETLB0XBf+CABOZ/2FeqMA/Tuura3NylDxeWWJODZdTzE
oFn9ahwaaNPt6RahBlTATjjdRpPJQAyJBz6IB4F5RqeiUgiawUs=
=l6v8
-----END PGP SIGNATURE-----

--l4IMblsHEWQg+b+m--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2014 17:21:41 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:10196 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6835073AbaEPPVjLdng0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 May 2014 17:21:39 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4902F41F8E7C;
        Fri, 16 May 2014 16:21:33 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 16 May 2014 16:21:33 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 16 May 2014 16:21:33 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 88EAD6D4C520C;
        Fri, 16 May 2014 16:21:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 16 May 2014 16:21:33 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 16 May
 2014 16:21:32 +0100
Date:   Fri, 16 May 2014 16:21:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Chen Jie <chenj@lemote.com>
CC:     <linux-mips@linux-mips.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        =?utf-8?B?546L6ZSQ?= <wangr@lemote.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Message-ID: <20140516152132.GB63315@pburton-linux.le.imgtec.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400137743-8806-2-git-send-email-chenj@lemote.com>
 <20140515114053.GW34353@pburton-linux.le.imgtec.org>
 <CAGXxSxVUOT_R-zHKpmEGZpE1nCSeOyfNzmc1xooYrKBxTuuaNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <CAGXxSxVUOT_R-zHKpmEGZpE1nCSeOyfNzmc1xooYrKBxTuuaNQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 2110538f
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40124
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

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2014 at 09:29:39PM +0800, Chen Jie wrote:
> >> -#ifdef CONFIG_CPU_MIPSR2
> >> +#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
> >
> > Is there some reason CPU_LOONGSON3 can't select CPU_MIPSR2?
>=20
> Loongson 3a is not fully mips32r2 compatible, but Loongson 3b is.

Interesting, I was led to believe that the 3A was MIPS64r2 compliant
(and thus by nature MIPS32r2 compliant) with the one difference with
other implementations being how it handles Status.FR=3D0 (appearing as
16x64b registers rather than the 32x32b registers of other CPUs). Are
there any other ways in which Loongson 3A is not MIPS64r2/MIPS32r2
compliant?

If not then wouldn't it make more sense to select CPU_MIPSR2 & then
special case any FPU differences? That would get you all the R2 bits of
the kernel with minimal #ifdef-ery.

Thanks,
    Paul

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTdiz8AAoJEIIg2fppPBxleZkP/3piMx3uqQzrzfKraNrNWIg5
yoEEZC86cRP1jJyZATLE7KsLq0KFHghSuZkjQtMWdqh9hmjIiiPukXvxJt//ZL4l
rZMQ+/0C8oEQIQ1ABCOC4IqhY6w4jd1cJddZf8gxUQStcREqKtsTaCLKHZdgBYZ5
8R0FNHvxKxw51fnYdmLrPtHIc2FbGgu9pmdV89h7j/hJFk99Q5GhzU0CV5IRKSUS
WP41WQ2w56EIjqe89PAgtdPcs7nDvgl5le5G4H82nnaCycOUN1P2ar2TqjKIUMHF
na3wpR13olDjY66ozKd+GIQljx2yux1jrd/1v1tz3YcZAPDRwQMOwOgAJyzjyeiO
CBlaDzWk4IgR4hBHWoXnK7THYgm3rgFz9fqIWmM0RlOrkwIBovX+KBOQbhpxgLPi
0/UOHxE/HorQXV0bIfZANY9w7amkikhfwHSMaCwLmug6gRD5oqsSedj9N+zjnvbK
ivx08vfYaqX91DbhlLCWRiq+mGnpLfpbVg3S6C7rWksIOtcq2B0U70H9NQsml11O
2df2C80UG54yXYd988Y4PSPPXsM2LZfvmN0DCAh4YGIoQr4Ff26bfk23iWf1JHDI
ccNTQSSTFSfYashx4NAFcOjViIhWvKQkiEZrqFZhHoBEfY//j0VZt/L6eA9fy2CC
0quE4/cWC22xdFbSanZ+
=wIPO
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--

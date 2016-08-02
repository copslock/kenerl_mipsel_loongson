Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 11:47:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22638 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992951AbcHBJralmLeL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Aug 2016 11:47:30 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7C8B441F8E96;
        Tue,  2 Aug 2016 10:47:21 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 02 Aug 2016 10:47:21 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 02 Aug 2016 10:47:21 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0B3EE6D65FA9B;
        Tue,  2 Aug 2016 10:47:18 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 2 Aug
 2016 10:47:20 +0100
Date:   Tue, 2 Aug 2016 10:47:20 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Binbin Zhou <zhoubb@lemote.com>, John Crispin <john@phrozen.org>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuichboo@163.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH RESEND v4 7/9] MIPS: Loongson-1A: Enable SPARSEMEN and
 HIGHMEM
Message-ID: <20160802094720.GZ1292@jhogan-linux.le.imgtec.org>
References: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
 <1463621912-9883-6-git-send-email-zhoubb@lemote.com>
 <20160802082923.GA15910@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L4xCDQ7GT+ph8Lmk"
Content-Disposition: inline
In-Reply-To: <20160802082923.GA15910@linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54392
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

--L4xCDQ7GT+ph8Lmk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 02, 2016 at 10:29:23AM +0200, Ralf Baechle wrote:
> On Thu, May 19, 2016 at 09:38:30AM +0800, Binbin Zhou wrote:
>=20
> > diff --git a/arch/mips/include/asm/sparsemem.h b/arch/mips/include/asm/=
sparsemem.h
> > index b1071c1..f73e671 100644
> > --- a/arch/mips/include/asm/sparsemem.h
> > +++ b/arch/mips/include/asm/sparsemem.h
> > @@ -11,7 +11,11 @@
> >  #else
> >  # define SECTION_SIZE_BITS	28
> >  #endif
> > -#define MAX_PHYSMEM_BITS	48
> > +#ifdef CONFIG_64BIT
> > +# define MAX_PHYSMEM_BITS	48
> > +#else
> > +# define MAX_PHYSMEM_BITS	36
> > +#endif
>=20
> This doesn't look right for XPA.  What do you think, James?

XPA appears to naturally support up to 59 physical address bits, but
with a "practical limit" of 40 bits. I haven't quite figured out what
the practical limit means to be honest (maybe MIPS32 XPA implementations
are simply expected not to exceed 40 bits in practice).

So yeh, it should probably be at least 40 when CONFIG_XPA is enabled,
although I'm unclear about the consequences. E.g. a bigger
MAX_PHYSMEM_BITS increases the number of segment id bits
(MAX_PHYSMEM_BITS - SECTION_SIZE_BITS).

>=20
> I think we don't use sparsemem on XPA atm so I can apply this safely -
> but it should be fixed properly.

Right, sparsemem seems to be enabled depending on the platform, so it
may only be a matter of time.

Cheers
James

--L4xCDQ7GT+ph8Lmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXoGwoAAoJEGwLaZPeOHZ6jeMQAKkivsf6+54DExQOYIOBwyHv
AwMrn8k9uL/M1L0PINHhKBl9kRDgA2Yos8xkfecJpoBfjAFoWwWrYKglpnLlbjX6
1qzBHlEtwAjrHYRKqxugODteChG508Z6lHzBWsC3TRypZKm8bPbFPjN8aut9xDfj
Hd9ZFr5fZn10fVkVu8IdtfhMU0cHnLRAyEUVwNczlrwRRhXoWX3xfDgBEYGSLzT6
RFpsq3rysbci41cPBXtnrPFxc54hgZq3+VQaNLarM9gOqrOeODtm/cSvbBS4TjbO
v4IijnIwhWlNY6gqr0T2lSmdLUMu8JXf3pIK4T/5I+gJnh+BYUFWbjUT4waOTNvb
H8TsgXj0lns01qfJbKXARuixddK8WNOSgHRW15sVxfrdshPHQXBRIHUQqv/wt0kh
USsORLtIFx0q4TkXO+f6CSWHojYQVS3S2I0hsRc6vO/d9wCz9Mfae3eS19bf050f
9d0Vdq1K1fj4Ye0oOo6oK4ngCJwFqggCCnt4J4uudYrnnqNZtLyojnDxs59BUhM+
rXX3OL2IU2RaOdsOWkUVNky07Gyiy1aFO/jRt3RDWw2gn5gtOUMuXOIbWoKW2f0g
xU9twDJQkMCi7fDPDLLa/0sGphTvnz84V6jOEgV1fBMeuP99Seq0hMe8rkOOUKz9
ULVtOzeEBnl8fVrHWPps
=/cbS
-----END PGP SIGNATURE-----

--L4xCDQ7GT+ph8Lmk--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 14:50:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15784 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007830AbcCDNueVHWkp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 14:50:34 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E8C4F41F8D77;
        Fri,  4 Mar 2016 13:50:28 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 04 Mar 2016 13:50:28 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 04 Mar 2016 13:50:28 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 1340311B5B371;
        Fri,  4 Mar 2016 13:50:26 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 4 Mar 2016 13:50:28 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 4 Mar
 2016 13:50:27 +0000
Date:   Fri, 4 Mar 2016 13:50:28 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: smp.c: Fix uninitialised temp_foreign_map
Message-ID: <20160304135028.GE31414@jhogan-linux.le.imgtec.org>
References: <1457086251-6477-1-git-send-email-james.hogan@imgtec.com>
 <56D99109.2050306@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <56D99109.2050306@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52447
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

--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Mar 04, 2016 at 01:43:37PM +0000, Matt Redfearn wrote:
> Hi James,
>=20
> On 04/03/16 10:10, James Hogan wrote:
> > When calculate_cpu_foreign_map() recalculates the cpu_foreign_map
> > cpumask it uses the local variable temp_foreign_map without initialising
> > it to zero. Since the calculation only ever sets bits in this cpumask
> > any existing bits at that memory location will remain set and find their
> > way into cpu_foreign_map too. This could potentially lead to cache
> > operations suboptimally doing smp calls to multiple VPEs in the same
> > core, even though the VPEs share primary caches.
> >
> > Therefore initialise temp_foreign_map using cpumask_clear() before use.
> >
> > Fixes: cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")
>=20
> cccf34e9411c was CC'd to stable 3.15+, should this fix do the same?

I originally didn't think it was needed for stable, since it only causes
a few unnecessary IPIs. However having thought some more about it, I
think it could result in cpu_foreign_map containing VPEs that are
offline, and not ones online, which could result in the IPI *not* being
called on a given core at all when it should.

E.g.
if the initial undefined value is 0x2 (CPU 1) and 2nd VPE of 1st core is
offline, then CPU 0 wouldn't be set (since CPU 1 is a sibling) and
neither VPE in core 0 would get the IPI.

So yeh, maybe it should.

Cheers
James

>=20
> Thanks,
> Matt
>=20
>=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: linux-mips@linux-mips.org
> > ---
> >   arch/mips/kernel/smp.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> > index bd4385a8e6e8..2b521e07b860 100644
> > --- a/arch/mips/kernel/smp.c
> > +++ b/arch/mips/kernel/smp.c
> > @@ -121,6 +121,7 @@ static inline void calculate_cpu_foreign_map(void)
> >   	cpumask_t temp_foreign_map;
> >  =20
> >   	/* Re-calculate the mask */
> > +	cpumask_clear(&temp_foreign_map);
> >   	for_each_online_cpu(i) {
> >   		core_present =3D 0;
> >   		for_each_cpu(k, &temp_foreign_map)
>=20

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2ZKkAAoJEGwLaZPeOHZ6nCgP/0cE0n6o93+DVF6AGk6Ahq0m
fsKnRf+kOoIhMEni/PrFnjgpG0awhz3D8Bpq+csdhEtTYZOh0RsI1S4JWxjEgIBE
1oJguHbdkgjLeA5frgucMUqCa3aZusLpgKj4vVCe0EfXfvzlpOPwIdxIQs4KDA7r
LiVVOaxqCxJn5+4irD6JvifA2dtnDNv5hchjhXfBdsF7Z4YPsGgiD4ZnNrb7Xed3
kFr3v/BW2fgplAbV3fQxUDPGbxNnPZgmn222nU5+1PNQmnZqoeAiZzfUEhG7mXzZ
XXTfs3tnA3DKFGVHce+JMfE/NZWMrj2f7pt0kgLokQVDLViv+9FPZiOAmNtaJU6e
o2UJjb81YxvCZN6XnlVrXOIjItAFkfKVyFeoJsaMH+Bo5IGceB12a/o2Ygsj4K9F
5szWYit71Orixo4LOx0EP8/waga+6LCpGX7M1wzaxo3mqMZvI1PVpb3u3y8i1n6F
UnmN/Au5a089htvT/R5/tv2DbLuyVNZtsQcJ5uQ80yMQl0FajNi1uRSZLPDVA+1y
eLw+SMUg2AM3ssyamWTh4LoKpJds8LMBvHtWMGuTNjTdleWatG6AEi17gxy/h6bT
pv2phwHovbHA1eCiVPBama3iGkdBIVefuBOsS2U3OR/vbYCYP5l5YBGp6bjjy7Xq
k1GWc6waVMALTTy2RrEY
=NYk4
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--

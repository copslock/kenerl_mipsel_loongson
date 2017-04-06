Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 13:25:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60605 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990600AbdDFLZXSvsuc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 13:25:23 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 88DAF41F8D68;
        Thu,  6 Apr 2017 13:31:33 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 06 Apr 2017 13:31:33 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 06 Apr 2017 13:31:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 40D728B9C15C6;
        Thu,  6 Apr 2017 12:25:14 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Apr
 2017 12:25:17 +0100
Date:   Thu, 6 Apr 2017 12:25:17 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Amit Pundir <amit.pundir@linaro.org>
CC:     <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 for-4.9 04/32] MIPS: Lantiq: Fix cascaded IRQ setup
Message-ID: <20170406112517.GR31606@jhogan-linux.le.imgtec.org>
References: <1491388344-13521-1-git-send-email-amit.pundir@linaro.org>
 <1491388344-13521-5-git-send-email-amit.pundir@linaro.org>
 <20170406092947.GQ31606@jhogan-linux.le.imgtec.org>
 <CAMi1Hd1c=yA=mmEwpUechAvquv9intSGePtyQkbSH1L-4N_UUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NphB68aIrRU2wdue"
Content-Disposition: inline
In-Reply-To: <CAMi1Hd1c=yA=mmEwpUechAvquv9intSGePtyQkbSH1L-4N_UUA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57583
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

--NphB68aIrRU2wdue
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 04:23:24PM +0530, Amit Pundir wrote:
> On 6 April 2017 at 14:59, James Hogan <james.hogan@imgtec.com> wrote:
> > Is there a particular reason this is desired in stable? I was under the
> > impression it was only helpful in the presence of a bug in the separate
> > IRQ stack stuff in 4.11, which was fixed in the above mentioned commit
> > de856416e714 ("MIPS: IRQ Stack: Fix erroneous jal to
> > plat_irq_dispatch"), and otherwise just a nice to have cleanup.
>=20
> I picked up this patch from Lede source tree
> https://github.com/lede-project/source/ for stable 4.9.
>=20
> >
> > If you've cherry picked the IRQ stack work, have you also cherry-picked
> > de856416e714?
>=20
> Thanks for pointing it out. I indeed missed out on picking
> de856416e714 ("MIPS: IRQ Stack: Fix erroneous jal to
> plat_irq_dispatch") and dda45f701c9d ("MIPS: Switch to the irq_stack
> in interrupts"). Should I pick them too for 4.9/4.10 stable or drop
> these 3 IRQ stack patches altogether if they are not stable material?

I'd definitely drop this one.

Greg said he doesn't object to accepting the IRQ stack work once its
been shaken out in mainline, at which point the fixes will be needed
too:

https://marc.info/?l=3Dlinux-mips&m=3D148449064421154&w=3D2

Though note that its more than just the one patch:

https://patchwork.linux-mips.org/project/linux-mips/list/?series=3D23&state=
=3D*

(I seem to remember somebody saying LEDE had applied these patches).

Cheers
James

--NphB68aIrRU2wdue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5iWWAAoJEGwLaZPeOHZ69FAP/3BABcT9SgnjnaToUUtFIKmJ
qdGOuZwpMx3uh2VKIWnZPwpRRNZVgbY8u2EYHn9FsMd+BbLwuTno4IoGscimHxJz
GIuj/ZDi2fMyZVA5Dlf9vqdCCY9tFBQSF8+hOjt2ODdNwCGMCalnfOCEnAp2Qngn
rvjM/KSpn1YaIP8Cx8JbSJgONcN/nuTD1hpmdh2ZSxyW/Bk2+1jIA4wXN4HGdzvO
WuqdYydrZzPuf1s2kgTot2qR/gPlkC0sPH6MP4dLFvpKcNUEO6PC6Di2+9qid8AB
I4HTQLAMyNTC/JwNPBqa5L8eVV1tMtiKjlLWmSdoTmjAXJRZ5wrc6MfOYGirrUwr
OLutshLD8+u0NJ6A9CtuaNTmCYMxjYqHm+Oru6q9jLk8SwvQyYuSG53EGXnbCUnw
cYJTyPr1O0/iyiUmbuMW+2frhq0suNLX2PAGvTIcoEhBZWT4Llth6NXXqTgzDl6u
VVZyuaK/Xkrrrxj4a1fJcp1MYUVhb+INQmL1aJjiZ1cbkRzjOXsvCjsqDn42Z27Y
zfBU+i4g0UGeNUgptUc6wZHSA2t4zXgDdcLLvUYsuRTh02bssxu+/0Eud129vFc8
jkf10AMPaHTC96+c36cNvRCfm1Ix+Uq9TeVUyrqmjOtbLk9E9kEEnPpoKMruCenZ
lB/7Em7ek9cqAvBTc39i
=H5Uq
-----END PGP SIGNATURE-----

--NphB68aIrRU2wdue--

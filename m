Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 22:18:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12748 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992880AbcGKUStnvVRs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 22:18:49 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E06E241F8DAD;
        Mon, 11 Jul 2016 21:18:40 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 11 Jul 2016 21:18:40 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 11 Jul 2016 21:18:40 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C113DB8FA83BF;
        Mon, 11 Jul 2016 21:18:36 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 21:18:40 +0100
Date:   Mon, 11 Jul 2016 21:18:40 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <yhb@ruijie.com.cn>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: We need to clear MMU contexts of all other
 processes when asid_cache(cpu) wraps to 0.
Message-ID: <20160711201839.GD26799@jhogan-linux.le.imgtec.org>
References: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn>
 <5783DF18.1080408@imgtec.com>
 <20160711180755.GA29839@jhogan-linux.le.imgtec.org>
 <5783E332.2020503@imgtec.com>
 <20160711192121.GC26799@jhogan-linux.le.imgtec.org>
 <5783F5D7.2090804@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <5783F5D7.2090804@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: cee91754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54290
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

--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Leonid,

On Mon, Jul 11, 2016 at 12:39:03PM -0700, Leonid Yegoshin wrote:
> On 07/11/2016 12:21 PM, James Hogan wrote:
> > Note also that I have a patch I'm about to submit which changes some of
> > those assignments of 0 to assign 1 instead (so as not to confuse the
> > cache management code into thinking the CPU has never run the code when
> > it has, while still triggering ASID regeneration). That applies here
> > too, so it should perhaps be doing something like this instead:
> >
> > if (t->mm !=3D mm && cpu_context(cpu, t->mm))
> > 	cpu_context(cpu, t->mm) =3D 1;
> Not sure, but did you have chance to look into having another variable=20
> for cache flush control? It can be that some more states may be needed=20
> in future, so - just disjoin both, TLB and cache coontrol.

No, I haven't yet. I'll Cc you so we can discuss there instead, and in
the mean time perhaps its best to ignore what I said above for this
patch.

Cheers
James

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXg/8fAAoJEGwLaZPeOHZ64Q0P/1zylxxSGQ2j1XBBXZkvcrM3
mlKJbYpVC/MXrSEZ4T99TXRKu3O17eIQvqjuEvknMAa+4pyjakIOpDEDHgaVq118
sKEHnATghnYzC6Oq1efm6FFCfKyn+n4EYUkP5dBkR6aaalhSMi7XYPshUd00Bf6k
NPrxJGVBPGCjezSSWd2x7w7WDyJmFp4lxGjuWlYxXnGxprBxBkwkxAIEF5sLpdIK
cltdpXokj45y0RZznxVMO/u2NPgrHRAynoA9Eumg0gbUGIi3vXmvZlWxMkP50ROF
lQLKKTkEtv5XzeeVL6SP0EGwvkBpvh8nq8oZGdabloS7tvyU4sRLrPONPPiqe1GP
IRRf/YHX3jEoJTWWPjXRz2w+0CMQu01uD5puTdD6pVfyoqNiIHgTYoBccrD+pvMn
v5jRfIQmTfIvLm+tVm/NJWQyc3LUz4j9CJj96DAsTSvVIeImKCT2ESSo0lAPM58b
oKn2fZoEyNfcyruX2QFKhWm125q7VI+/c+XnmzDNJeAy3PEvARqLVys3LqtwYrY/
QWIb17jI0OykRLaCN/rAlOrpnAmYpjQuKM41yTJb+Xl/E50NMImnAcBOCTErXIA8
wXdGrx/Ld6QbgBaleeeUdmEQzYDWxwHWWTv5hIrO3bjNwbTS4yaZs4cwv1t99Uw0
ogqMf9zspR62cmcT4fKx
=IWa2
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

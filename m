Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2017 13:37:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45776 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993411AbdCCMhax33-M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Mar 2017 13:37:30 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id D7F1F41F8E32;
        Fri,  3 Mar 2017 13:42:08 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 03 Mar 2017 13:42:08 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 03 Mar 2017 13:42:08 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DC20013C45713;
        Fri,  3 Mar 2017 12:37:21 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 3 Mar
 2017 12:37:24 +0000
Date:   Fri, 3 Mar 2017 12:37:24 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 11/32] KVM: MIPS: Add VZ capability
Message-ID: <20170303123724.GD2878@jhogan-linux.le.imgtec.org>
References: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
 <17827db14f848b69e8184ae80b5d63ba01b4b106.1488447004.git-series.james.hogan@imgtec.com>
 <bb40a6bb-e6b3-a37b-a08e-daccbf52bbef@redhat.com>
 <20170302113923.GC2878@jhogan-linux.le.imgtec.org>
 <1a071956-a897-a2f9-4523-e6da074568b6@redhat.com>
 <20170302223407.GQ996@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <20170302223407.GQ996@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57015
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

--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 10:34:07PM +0000, James Hogan wrote:
> I suppose the exception is T&E. It shouldn't assume that just because VZ
> is available that T&E isn't (even if that is the case right now). It
> could always just try KVM_CREATE_VM with kvm type 0 and detect the error
> I suppose, but capabilities are nicer.
>=20
> Maybe I'll redefine KVM_CAP_MIPS_VZ a bit, such that the value returned
> + 1 is a bitmask of supported kvm types:
> has T&E =3D !!( (v + 1) & BIT(KVM_VM_MIPS_TE) )
> has VZ  =3D !!( (v + 1) & BIT(KVM_VM_MIPS_VZ) )
>=20
> That way old kernels which return 0 are consistent, and other
> implementations could be added if really necessary without confusing
> userland (but fingers crossed it'll never ever be necessary).

Actually I think the way I had designed KVM_CAP_MIPS_VZ is fine. I had
defined it as an enumeration rather than a mask because it isn't
expected you'd have more than one hardware virtualisation type able to
run on a particular core.

Whether T&E is still supported is I think better exposed by a new
KVM_CAP_MIPS_TE capability, indicating whether T&E is exposed when
KVM_CAP_MIPS_VZ is also set.

It would be set to 1 on new kernels whenever T&E is supported.

For compatibility with older kernels, userland would be expected to
determine whether T&E is present by:
check(KVM_CAP_MIPS_VZ) =3D=3D 0 || check(KVM_CAP_MIPS_TE) !=3D 0

Old userland that doesn't check KVM_CAP_MIPS_TE would just hit an EINVAL
=66rom KVM_CREATE_VM if T&E isn't supported.

Cheers
James

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYuWN9AAoJEGwLaZPeOHZ66QQP/2h5QTmXXCNWhX56jpnNxgg5
ThVsfufExbMt/LNU8IMTNcPbApYLbq8eLOtAxP8dC0F3Mhhq4C1paFvcQBf9xe+K
hbBfkQMC+AgclCozgOssMLsq3l+/UImmQkd9U6oLp30a6KMrqDdyMXQzWAqDDmB/
esdPsHkIo2nxDaWq3RVZfvxeI8dbtqkkOtF8NVLKg6kTUCUPLXAk5xc7sed8fpKQ
rUXbb9NSmFTypuRimkh7hG4CuOh7lhHCNjAA+3jHtI4RNFIIA1NxgK2hozEudB/2
1wJabu9QuH/AgHxI5Y8UqdZeE8yM75gVnkFzHKBNOEnh+vkqOwimHhlNglsML1aC
yltiUixi/ocY+z4F6QU9dfbYQ3+HHN0xgoz0+Q2ztKVvaF4SVYT70EBa/5+ae8op
EoXumZcr5R0d+i++P1XYgBbZ9zckFWpChLK7BcsWhmKg+qwa4f1+2PoAuP9ihpzh
FvxtZere4Z6H0aj9Zr7aqLvo84WP0slEzfNUL3Y/2XV7NUnG9TtMjoLeDOUJrroj
Re0h0Du44YT7LIZbABCRHMTVtOlPRdOGc8aI4AEYDgNE/bRfkjCvvUJ5xWV0+2vx
u2q2PcwIZ6BLlwDSMRWSyRPINOeLLH0ymWHQUgF7D1yu6T+pJZ74Bp6Fgf9I9BjF
p6xtOqPMWYmS3X6Ji2Mr
=lkZI
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--

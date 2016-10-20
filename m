Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 15:16:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30141 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993008AbcJTNQgkIkqy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 15:16:36 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 64AF341F8EB6;
        Thu, 20 Oct 2016 14:16:01 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 20 Oct 2016 14:16:01 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 20 Oct 2016 14:16:01 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6A46847B43F2B;
        Thu, 20 Oct 2016 14:16:27 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 20 Oct
 2016 14:16:30 +0100
Date:   Thu, 20 Oct 2016 14:16:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC:     <linux-mips@linux-mips.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: MIPS: Add missing uaccess.h include
Message-ID: <20161020131630.GL7370@jhogan-linux.le.imgtec.org>
References: <d852b5f35e84e60c930589eeb14a6df21ea9b1cb.1476834183.git-series.james.hogan@imgtec.com>
 <20161020131054.GF8573@potion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WR+jf/RUebEcofwt"
Content-Disposition: inline
In-Reply-To: <20161020131054.GF8573@potion>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55521
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

--WR+jf/RUebEcofwt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Radim,

On Thu, Oct 20, 2016 at 03:10:54PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2016-10-19 00:45+0100, James Hogan:
> > MIPS KVM uses user memory accessors but mips.c doesn't directly include
> > uaccess.h, so include it now.
> >=20
> > This wasn't too much of a problem before v4.9-rc1 as asm/module.h
> > included asm/uaccess.h, however since commit 29abfbd9cbba ("mips:
> > separate extable.h, switch module.h to it") this is no longer the case.
> >=20
> > This resulted in build failures when trace points were disabled, as
> > trace/define_trace.h includes trace/trace_events.h only ifdef
> > TRACEPOINTS_ENABLED, which goes on to include asm/uaccess.h via a couple
> > of other headers.
> >=20
> > Fixes: 29abfbd9cbba ("mips: separate extable.h, switch module.h to it")
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: kvm@vger.kernel.org
> > ---
>=20
> We'd like to have this patch in 4.9-rc2 and I see it in kvm-mips/next.
> Would you prefer to send a pull request?

Yes, I've applied it to my next branch and was going to send a pull
request this afternoon.

BTW, generally speaking do you always prefer pull requests to have the
patches sent in reply to it, or only if they haven't already been posted
for review?

> (I can apply it directly just as well.)

Thanks
James

--WR+jf/RUebEcofwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCMOmAAoJEGwLaZPeOHZ65hsP/jGIwoeoSQu4b1x6FuXSu5bJ
f5iZpTvopa9/ShCm321ZPppp3QgcpSV/V8Yvol1sQmfCMPqeEnLUThWGKVfkjXWp
b9/b37OeHhxwD19XZpFCkwhjbD6nyG3jWqRyTa6e4lh/XNjOIMQEqjGkQ9sIIH92
2CJjB4c+XSeLAvapwP2kLBew09EeIJyB+rG20gVaJj343X+te3qx96mMYB19kpCJ
2TIvTB9Z37Vujbv7196Jn8oN8eNZrMa3Nja+tnauKa3hTmQQXS3vE8u8QriB4+VF
DBTJJNT3hti1NWpilDcRpQBinlTpvn2m4oy9Fgic6h8pL1ScWbA3AAL/btFn9Bf7
9XrTm96OApcQZWWYOQ3eEWCTvD2+j0eeY3FriuPX8h6q8L9IBWfuzX6x4xTdiMXh
74/OejmCsnR2b1K/HTnI3WHvLgoTtL0T54kDO/N4p81EcgVzJwg+YB4RqE/DUj79
uCeKywb8ULEQf/7R361UIKn4GIa/W5xzUgYTtqNKzT4ndjdhApq0cUNEXfBWHydO
BE/6sOMj+XT5nUt7zFwfxlxvuDfk053NhrnbJvmRPpPTL6pTvjpqD29yg0BhSY/n
AYmQ1HTBzi7a6GVax9xYNBsG4f9+pOD8gcy4ROk7iKXnELbBNPybhBPucMnKXx1z
/20qsHY0XYdGKok+VHVf
=YfQv
-----END PGP SIGNATURE-----

--WR+jf/RUebEcofwt--

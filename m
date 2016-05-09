Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 21:04:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50823 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028409AbcEITEskbyKn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 21:04:48 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0556841F8E84;
        Mon,  9 May 2016 20:04:43 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 09 May 2016 20:04:43 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 09 May 2016 20:04:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 4F4A53BC023E9;
        Mon,  9 May 2016 20:04:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 9 May 2016 20:04:42 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 9 May
 2016 20:04:42 +0100
Date:   Mon, 9 May 2016 20:04:42 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>, Jayachandran C.
        <jchandra@broadcom.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim
 =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH 0/7] MIPS: Add extended ASID support
Message-ID: <20160509190442.GC23699@jhogan-linux.le.imgtec.org>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
 <20160509132315.GA28818@linux-mips.org>
 <alpine.DEB.2.00.1605091756520.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605091756520.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53320
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

--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 06:01:27PM +0100, Maciej W. Rozycki wrote:
> On Mon, 9 May 2016, Ralf Baechle wrote:
>=20
> > Already PMC-Sierra's RM9000 / E9000 core had an extended ASID field, of
> > 12 bits for 4096 ASID contexts.  Afaics this was an extension derived
> > in-house back in the wild days before everything had to be sanctioned by
> > the architecture folks, so there is nothing in a config register to test
> > for it.
>=20
>  Couldn't you just probe it in EntryHi directly, by writing all-ones,=20
> reading back and seeing how many bits have stuck?

Note, the tlbinv feature in recent versions of MIPS32/MIPS64 arch has
EHINV bit in bit 10 (if I remember right) of EntryHi, which marks whole
tlb entry as invalid, and the small pages feature (for 1k pages) extends
VPN field downwards to bit 11.

Cheers
James

>=20
> > PMCS simply extended the ASID field to 12 bits; no of the EntryHi bits
> > which today would conflict doing so did exist back then.
>=20
>  Especially as it was as simple like that -- bits 12:8 were hardwired to=
=20
> zeros in the usual implementations back then.
>=20
>   Maciej

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMN9KAAoJEGwLaZPeOHZ6SvoP/jJxF1pYEtflgdcZDjKFWtvh
t9WSNERpSIxwpd0DRKnhemvcQndlzdOFaZShXMXCdoFewNJE5L7lw8PDKmtqHkky
QI/xr8NtyVtrxAEgS4lAAItQn1V1jKwBt9e4jfA/+eVbm8gNEt//Zeju2RAfQWi4
fkqyv0F9WjSLoxeYbXpzCHJK+BsHxpm39pzOmo6X0prGEBADr7qcG/5TwoANFLLF
GzcLVFNWHRprsVZwyTLcRJIVnZCWzluQqLYz4z6WuKIwdOXS8B+lpzlQI329B92i
9yaQzpNo190tIaGGUbs/S3cxyiG0Q5lIjWnii2LZZiTjkEu7Dd6gHMVMrr/z7MsC
RR4QR1psZZXFvjIWHMW7rzePXbnIVnC0uW1p+RqL5xK4cIco7fN+k6p1BFiomxw9
F1innK2pjP1DC9b4TK6p3BC5XAVocwkK/vG3RQJA7UZ2JV1ouLkAAHyCriDZZVJv
lYYu1Mctr4s6qGXMJfXkqlWs2WUIkBvfYmQD4Hqidlrq124NNCqPj5pr5dGKyzxx
xP61MALtksH8xDn4g1XjhzdsGyOo+DE+ZH3tKZrf7qVTI/RP0sytWAyJ19IiX5t9
FMBsLLr+VQOjm16mNJINQ+YNAiJhdKFptFn/srX08gr4WC3EpqJnfcZoLGEHGOP+
O2BUWxfpmKzDcb5kqAYm
=ji/B
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--

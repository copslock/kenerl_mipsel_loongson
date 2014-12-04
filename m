Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2014 11:16:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41543 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006959AbaLDKQaItgza (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Dec 2014 11:16:30 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 792EF41F8E54;
        Thu,  4 Dec 2014 10:16:24 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 04 Dec 2014 10:16:24 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 04 Dec 2014 10:16:24 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 13AE44E51F0A6;
        Thu,  4 Dec 2014 10:16:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Dec 2014 10:16:24 +0000
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Dec
 2014 10:16:22 +0000
Date:   Thu, 4 Dec 2014 10:16:22 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     David Daney <ddaney@caviumnetworks.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <peterz@infradead.org>,
        <paul.gortmaker@windriver.com>, <macro@linux-mips.org>,
        <chenhc@lemote.com>, <cl@linux.com>, <mingo@kernel.org>,
        <richard@nod.at>, <zajec5@gmail.com>, <james.hogan@imgtec.com>,
        <keescook@chromium.org>, <tj@kernel.org>, <alex@alex-smith.me.uk>,
        <pbonzini@redhat.com>, <blogic@openwrt.org>,
        <qais.yousef@imgtec.com>, <linux-kernel@vger.kernel.org>,
        <markos.chandras@imgtec.com>, <dengcheng.zhu@imgtec.com>,
        <manuel.lauss@gmail.com>, <lars.persson@axis.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/3] MIPS: Add full ISA emulator.
Message-ID: <20141204101229.GC5482@NP-P-BURTON>
References: <1417650258-2811-1-git-send-email-ddaney.cavm@gmail.com>
 <1417650258-2811-3-git-send-email-ddaney.cavm@gmail.com>
 <547FA2E5.1040105@imgtec.com>
 <547FA8D2.2030703@caviumnetworks.com>
 <547FB032.2000000@imgtec.com>
 <547FB8FB.7040803@caviumnetworks.com>
 <547FBF63.70802@imgtec.com>
 <547FC530.1060109@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <547FC530.1060109@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.131]
X-ESG-ENCRYPT-TAG: f2c42831
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44574
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

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nice work David, I like this approach. It's so much simpler than hacking
atop the current dsemul code. I also imagine this could be reused for
emulation of instructions removed in r6, when running pre-r6 userland
binaries on r6 systems.

On Wed, Dec 03, 2014 at 06:21:36PM -0800, David Daney wrote:
> On 12/03/2014 05:56 PM, Leonid Yegoshin wrote:
> >I see only two technical issues here which differs:
> >
> >1.  You believe your GCC experts, I trust HW Architecture manual and
> >don't trust toolchain people too much =3D=3D> we see a different value in
> >fact that your approach has a subset of emulated ISAs (and it can't, of
> >course, emulate anything because some custom opcodes are reused).
>=20
> Yes, I agree that the emulation approach cannot handle some of the cases =
you
> mention (most would have to be the result of hand coded assembly
> specifically trying to break it).

I'm not sure I'd agree even with that - ASEs & vendor-specific
instructions could easily be added if necessary.

On Thu, Dec 04, 2014 at 05:56:51PM -0800, Leonid Yehoshin wrote:
> >2.  My approach is ready to use and is used right now, you still have a
> >framework which passed an initial boot.

Subjective.

Thanks,
    Paul

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUgDR2AAoJENzvn0paErs5WycP/RcMXEbYDfFVuqfMx/WJVgd5
xbpn5TcXqBWjRckUMqIYInzwVOskzrUVZ9OKT7AQ50mP9DtGhxX6Cy+zPGkSY9Ud
8p8HAq7KQJ2OFhFfk7vpeuquVj3KkMvuz7F8iFw090SfTEBmttiohieMY3nZ7l9w
QfLlq+U2uUZMBD0OiUnhxwi1d1EW2Lv5HefdMy+gbH2/C5Eg6dhWwqSSkCCgMed8
9ewfwVZAOKrj6lHFx4nqQ3qO+YnsAoSglb5QC/48SCmqWLDpivGr2VS21DXds2Gk
Pl6xqJgVaRK6nHQjzUyiR+CTSkO8EyhoU5bLCiQ5GzhNlmuvlV871QjcBEbRAJR/
ZF1darPvA7B4rtPgd020E6SQYlIZ1S6TINzQkJNzJ/EX4mG/dSErNQmORnmaCQou
sZaOozUh0w8O0+GfaeqqCChIYKM3PzYKvgDkd5/WlZXlG7QkoU+kdKwhmOHC/Y/y
+NS1RFH8eV4Y7Q9O2iZfq998YDTJTMR549oybDcff2wS3eSk5Az0GO8pzhamRmB/
ZymTwZLUHqOyX+CMgGwY/Np0L7nQRJcIE6dV9DomhgR/QHI4VmoH7Oppn7259rNj
jpzCVpvZyAhaky5gOhqdGWE2J91IENdiDtKYGK1WEkYzVtaPBjh3RLAb9xqvt4Io
wsQiy/uINrPi4BJ6Pga3
=Ed87
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--

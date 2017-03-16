Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 14:12:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50983 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992155AbdCPNMBSwdZ- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 14:12:01 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id A462E41F8EC8;
        Thu, 16 Mar 2017 14:17:14 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 16 Mar 2017 14:17:14 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 16 Mar 2017 14:17:14 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DCAB76A3F365C;
        Thu, 16 Mar 2017 13:11:52 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 16 Mar
 2017 13:11:55 +0000
Date:   Thu, 16 Mar 2017 13:11:55 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/8] MIPS: Add Octeon III register accessors & definitions
Message-ID: <20170316131155.GE996@jhogan-linux.le.imgtec.org>
References: <cover.79b3feae3a98cb166c2d40a7bd4e854a5faedc89.1489486985.git-series.james.hogan@imgtec.com>
 <306f747a0743b91bbfbc321572d28d0e42f9bbb8.1489486985.git-series.james.hogan@imgtec.com>
 <20170315134132.GE5512@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WZxEPQZByX0ieXff"
Content-Disposition: inline
In-Reply-To: <20170315134132.GE5512@linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57330
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

--WZxEPQZByX0ieXff
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 02:41:32PM +0100, Ralf Baechle wrote:
> On Tue, Mar 14, 2017 at 10:25:44AM +0000, James Hogan wrote:
>=20
> > Add accessors for some VZ related Cavium Octeon III specific COP0
> > registers, along with field definitions. These will mostly be used by
> > KVM to set up interrupt routing and partition the TLB between root and
> > guest.
>=20
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!

>=20
> Btw, asm/mipsregs.h is growing towards 3000 lines making it a candiate
> for splitting.

Yes, it already contains:
1) CP0 register numbers (~80 lines)
2) CP0/CP1 register field definitions (~1000 lines)
3) Various thin MIPS assembly wrappers (~900 lines)
4) CP0/CP1 [guest] register accessors & modifiers (~700 lines)

Maybe it makes sense to start by splitting out all those assembly
wrappers (3) into an asm/mipsops.h, which asm/mipsregs.h includes and
uses for defining the register accessors.

Cheers
James

--WZxEPQZByX0ieXff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYyo8aAAoJEGwLaZPeOHZ6n9sP/RtHEDNC/Z/Bint0jbTwJVV1
+wtjctDD5tqvErR9skJ7TcBwpMFHFgOVlnNYGk5nqofLdQBpJaMdUd6KJ/524yDV
fj21yz8brWBUWU/K8XmlLSYRsUTI1zVle3jaUWXU+MCMpZSemEUAX2i9lsPzSpQg
3G1EmfyWPFNJC7thyJIZ12IRJU+3B5xBkPYRO0O96R0SmtNhCbm/SMduH6VManTF
R82LJksxVm2CuWVRA3SqzleDo23plzexP5ymbmez0neoGhRYXT86bxANQWHsUJ0a
ISlGrxJNqIsEYFYGUsV8saOiCuKapNy7ADJTlx+8vPV0JZkyKsBew8bWOX6/m+2t
uBR2d1MiWYRkRpojRHUuNUJT70xSFLF2MMW30675THlRDhGvNukHHln/SEts1Izs
gDeC3/QnGT3SOUbWXyC03C+AoG/jNgpPYq9ZLDbDdBkwBZCE4qZwCqr0l1CJpXKv
lEZPOmi61wCcTeRfcZMf9Gu0bB5w1rIE2l420ExptHmK3UwRuKe8DgX2qmikLqZg
IAJz/Jw7EyYE++1sqayKp90olx4D4LJC5BqqeJhfE5YTV3LRUbveD5xw/JfYpFV8
N91dQ3OmuNxW8sQUDsfXzQiKbAKwR1zp6uTLwtcO2XOLEeFk4MsDgcqEZ/rpBebd
J5Xj2XjyF1+U+6jcd1zQ
=YMNe
-----END PGP SIGNATURE-----

--WZxEPQZByX0ieXff--

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2014 19:45:35 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:15783 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6822081AbaEARpcsXqU8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2014 19:45:32 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0D22841F8D6F;
        Thu,  1 May 2014 18:45:27 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 01 May 2014 18:45:27 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 01 May 2014 18:45:27 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4CECAE5CA3CFC;
        Thu,  1 May 2014 18:45:23 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 1 May
 2014 18:45:26 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 1 May 2014 18:45:26 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 1 May
 2014 18:45:26 +0100
Date:   Thu, 1 May 2014 18:45:26 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: Malta: support powering down
Message-ID: <20140501174526.GH55879@pburton-linux.le.imgtec.org>
References: <1395415232-42288-1-git-send-email-paul.burton@imgtec.com>
 <1395415232-42288-2-git-send-email-paul.burton@imgtec.com>
 <alpine.LFD.2.11.1404191624180.11598@eddie.linux-mips.org>
 <20140422100713.GC42386@pburton-linux.le.imgtec.org>
 <alpine.LFD.2.11.1404221540540.11598@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1404221540540.11598@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 96d62635
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40008
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

--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 06:28:26PM +0100, Maciej W. Rozycki wrote:
> > Returning to
> > the monitor/bootloader prompt (which may or may not be YAMON) is not
> > generally possible since the memory it was using has probably been
> > overwritten.
>=20
>  It depends on whether the YAMON memory (first 1MB IIRC) is claimed by th=
e=20
> kernel or not; I don't remember offhand.  Also I don't know if YAMON=20
> reinstalls its exception handlers on application return.  In principle it=
=20
> should be doable.
>=20

The memory used by YAMON is reserved throughout boot (presumably to
allow the amon interface to be used by the old CONFIG_MIPS_CMP SMP
implementation). It's freed at the end of boot though.

> > It may make sense to separate halt & power off though, with
> > halt simply executing an infinite loop as you suggest.
>=20
>  Yes, that would be great if YAMON return turns out infeasible.
>=20

One big issue is that the system may not even be running YAMON. U-boot
runs just fine on a Malta and executes from the end of the first 256MB
of kseg0, rather than from the start of it. It would be possible to
specify some mechanism for the bootloader to tell the kernel what memory
it uses & avoid touching it, then attempt a return if that information
is provided, but I don't really think it would be worthwhile.

> > >  Shouldn't the handle on the device and the resource be requested ear=
ly=20
> > > on, where mips_machine_halt (mips_machine_power_off) is installed as =
the=20
> > > halt (power-off) handler?  Especially requesting the resource here se=
ems=20
> > > to make little sense to me -- we're about to kill the box, so why bot=
her=20
> > > verifying whether it's going to interfere with a random driver?
> >=20
> > Well requesting the I/O region was more about sanity checking that it's
> > present. This could be done earlier I guess, it would just mean keeping
> > around the needed I/O & PCI bus pointers in globals and I don't see the
> > issue with just acquiring them when they're needed.
>=20
>  I have two issues with that:
>=20
> 1. Drivers generally claim resources at initialisation, not at the time=
=20
>    the resources need to be used.  While the power-off driver is very=20
>    simple and single-use only, I see no reason for it to be different. =
=20
>    I find it useful to see what hardware has drivers attached in=20
>    /proc/iomem or /proc/ioports too.
>=20
> 2. Any resource claim error message seen at boot can prompt the system=20
>    operator to take a corrective action.  When it's only issued at system=
=20
>    shutdown, it's likely it'll be too late already.
>=20
> Do you think there's anything wrong with these obervations?
>=20

Nope that's fine, I'll move the request for v2 and implement the hang on
halt behaviour.

Thanks,
    Paul

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTYog2AAoJEIIg2fppPBxlZSEQAJfBZ4+9BKuuAPOHkD0teIwS
3rgKMLkbad2OU3XAJ2kbxUWn6rYUpD8C89K0Ta4+DFZQ5mZOBVzA4QlcaPNUdM7j
QkgrkleaOem9rqaoJQLJu7O8zuJKAHE/C66Wzy8nKHna+FVMzugub0j6ZV10yVYy
ilgv0r5Lshe+worKz82iUpqZDkrzrs1e/zyxBN/cGfZ8A8t8Q9D3yT3iwh3tnCp2
DAJjL84mYXJPGnVXimCG9eJHpcedb8jb/H9verlkVxN2ILmaNR+0vub1XIReVkDZ
nblN0IqWQ+hGE7tHBC93BY6+01RZaFO+SbgBonh8qNtoh0tlTlKCC3OoVmWKzxSK
An0ntIWg/EKD9z17m0d/56Y2qeYgof3AWI9CYmZPrV9y9PTJ7oRp1wF8m2qCxtN2
YrnP+3DAyysYii8wu9Yas+tbx6w812Fi60HyRbxeoS+1mmGV/VSpRwe6E8QeKbVT
wnTRbPQe9Mlb0J4FUcxnwzMUk7g8nMJMGEHIfiEF/8JATAxaRKbyJqKKxR3KWa2a
6CUt5oe1Lp1GG93bPQ23fwUl0yEb3NMEANsNBxLWSMDdTI1luoHon6mgdgaWpas/
+GliImTLJaA2SBNQZFdF7hoYoLVcGal2OYfJRJJ8b6e7YCj8aYcwDSIOiy3dVBIR
zSsOTmBBziRakcImTcUu
=OqBh
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--

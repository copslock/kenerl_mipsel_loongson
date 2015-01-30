Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 19:23:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64826 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011164AbbA3SXWvskiL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 19:23:22 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7943741F8DEB;
        Fri, 30 Jan 2015 18:23:17 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 30 Jan 2015 18:23:17 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 30 Jan 2015 18:23:17 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 53B8263D22F5E;
        Fri, 30 Jan 2015 18:23:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 18:23:16 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 18:23:16 +0000
Date:   Fri, 30 Jan 2015 18:23:16 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] MIPS: fix kernel lockup or crash after CPU
 offline/online
Message-ID: <20150130182316.GA30459@jhogan-linux.le.imgtec.org>
References: <1421355719-17576-1-git-send-email-aaro.koskinen@iki.fi>
 <1421355719-17576-2-git-send-email-aaro.koskinen@iki.fi>
 <alpine.LFD.2.11.1501300347170.28301@eddie.linux-mips.org>
 <54CB5B59.5050203@imgtec.com>
 <alpine.LFD.2.11.1501301242080.28301@eddie.linux-mips.org>
 <54CB9C6D.1080506@imgtec.com>
 <20150130175532.GE591@fuloong-minipc.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20150130175532.GE591@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45590
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

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 07:55:32PM +0200, Aaro Koskinen wrote:
> Hi,
>=20
> On Fri, Jan 30, 2015 at 02:59:57PM +0000, James Hogan wrote:
> > On 30/01/15 12:47, Maciej W. Rozycki wrote:
> > > On Fri, 30 Jan 2015, James Hogan wrote:
> > >=20
> > >>>  Hmm, why can a call to `printk' cause a TLB miss, what's so specia=
l about=20
> > >>> this function?  Does it use kernel mapped addresses for any purpose=
 such=20
> > >>> as `vmalloc'?
> > >>
> > >> It would be the fact netconsole (or whatever other console is in use=
) is
> > >> built as a kernel module, memory for which is allocated from the vma=
lloc
> > >> area.
> > >=20
> > >  Ah, I see, thanks for enlightening me.  But in that case wouldn't it=
 be=20
> > > possible to postpone console output from `printk' until it is safe to=
=20
> > > access the device?  In a manner similar to how for example we handle =
calls=20
> > > to `printk' made from the hardirq context.  That would make things le=
ss=20
> > > fragile.
> >=20
> > Hmm, kernel/printk/printk.c does have:
> >=20
> > static inline int can_use_console(unsigned int cpu)
> > {
> > 	return cpu_online(cpu) || have_callable_console();
> > }
> >=20
> > which should prevent it dumping printk buffer to console. CPU shouldn't
> > be marked online that early, which suggests that the console has the
> > CON_ANYTIME flag set, which it probably shouldn't if it depends on
> > module code. call_console_drivers() seems to ensure the CPU is online or
> > has CON_ANYTIME before calling the console write callback.
> >=20
> > A quick glance and I can't see any evidence of netconsole being able to
> > get CON_ANYTIME.
>=20
> It does not set the flag. But flags are kept in module's static data,
> so the original problem stays.
>=20
> A.

Ah yes, of course. This approach looks correct to me then.

Cheers
James

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy8wUAAoJEGwLaZPeOHZ6h+AP/jHpE0FkxtbabT0l7MFEu9Ib
Hn21mAt+Ygp6CUVgjH0l/mQt5jtCo+OzHCTFl0KYXxxXwBHHh9hYdbDaOEsmMszl
/n36H25jzva83HA55vEVBmeelzjXrFKiokYnJLZ/mIWK4dqxO/cMSdAA3oWYKcOC
nFp8YoOf0dGAhQGpExkmJpqvIqYdkYa8G/wIPGL2n1ZJ0CQ4EaVHZQUdLqZle8Rn
c3jPrNBgJgBz7ZaTWFFIEu9J8XQ+70A7o6vO7kELMZWWnSvf91RMWX+gOB575aCS
a7jrjPREeJVnt4QgLMEzWLD1G4yqyJKrBCjyZlDwyIWjB0dx7dSAfq34Be8ZpR1w
etmOLIKbSjrWgJcoLUh8wTWV1cLGWXbkpJtT3Z2PJbmdSFU2z3QTD7DjCdzfondc
ndcxs3eBkzPAu4eiBAX6KGLOt6Jn8F6aElSq/KLKo1rnfFvmiSFZ2Khkfuj16Ig+
0OIn8KJ+8djJfenxr2gk8/w3yqfXHDWg4K7Nzh+H/dgKJmmNxCGjfFbdDd8QnH43
ci2cLfG8EoU2wbN7Je/ZTggH4CglNHh3v9DRga7UqWKTZVNCwTjiOv1hWR2RfLwP
65je+i/BwnIwQHYEH4uu2xlFslq+oAt7RQlPd+NUOjOL2y5Uh8QhSad9juPM4evJ
3AhVtZi7xKftg8LNEeVm
=DeVk
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

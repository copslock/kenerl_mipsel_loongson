Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 23:39:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38716 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992123AbdBJWji4PLWt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 23:39:38 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DBA3041F8EB3;
        Fri, 10 Feb 2017 23:43:20 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 10 Feb 2017 23:43:20 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 10 Feb 2017 23:43:20 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7EF4951A250B1;
        Fri, 10 Feb 2017 22:39:28 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 10 Feb
 2017 22:39:33 +0000
Date:   Fri, 10 Feb 2017 22:39:32 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        <linux-mips@linux-mips.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Crash in -next due to 'MIPS: Add cacheinfo support'
Message-ID: <20170210223932.GA9246@jhogan-linux.le.imgtec.org>
References: <20170208234523.GA13263@roeck-us.net>
 <CAJx26kWDuH2AbibrOdHi7yh9YG314T7J5Zz7CwgTrZCfwDGuYw@mail.gmail.com>
 <eee97bba-5386-9d78-1c82-9e9753a28920@roeck-us.net>
 <20170210094011.GB24226@jhogan-linux.le.imgtec.org>
 <20170210103952.GC24226@jhogan-linux.le.imgtec.org>
 <20170210174644.GA15372@roeck-us.net>
 <6360d767-39f9-ad9b-6ca4-cb16c617e3cc@gmail.com>
 <20170210221152.GA20435@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20170210221152.GA20435@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56764
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

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 02:11:52PM -0800, Guenter Roeck wrote:
> On Fri, Feb 10, 2017 at 11:15:31AM -0800, Florian Fainelli wrote:
> > On 02/10/2017 09:46 AM, Guenter Roeck wrote:
> > > On Fri, Feb 10, 2017 at 10:39:52AM +0000, James Hogan wrote:
> > >> On Fri, Feb 10, 2017 at 09:40:11AM +0000, James Hogan wrote:
> > >>> Hi Guenter,
> > >>>
> > >>> On Thu, Feb 09, 2017 at 08:50:04PM -0800, Guenter Roeck wrote:
> > >>>> On 02/09/2017 04:01 PM, Justin Chen wrote:
> > >>>>> Hello Guenter,
> > >>>>>
> > >>>>> I am unable to reproduce the problem. May you give me more detail=
s?
> > >>>>>
> > >>>> The scripts I am using are available at
> > >>>>
> > >>>> https://github.com/groeck/linux-build-test/tree/master/rootfs
> > >>>>
> > >>>> in the mips and mipsel subdirectories (both crash). Individual
> > >>>> build logs are always available at kerneltests.org/builders,
> > >>>> in the 'next' column.
> > >>>
> > >>> Did you find it 100% reproducible? I was trying to reproduce yester=
day
> > >>> evening, and did hit it a few times, but then it stopped happening
> > >>> before I could try and figure out what was going wrong.
> > >>
> > >> I switched to gcc 5.2 (buildroot toolchain) for building kernel, and=
 now
> > >> it reproduces every time :)
> > >>
> > > gcc 5.4.0 (binutils 2.26.1) also reliably crashes. The exact crash de=
pends on
> > > the kernel (-next is different to ToT + offending patch, qemu command=
 line
> > > makes a difference, qemu version makes a difference), but the crash i=
s easy
> > > to reproduce, at least for me.
> >=20
> > Just to clarify here, is the crash a combination of:
> >=20
> > - the kernel image, based on different trees/branches
>=20
> I tried with linux-next, and I tried with ToT with the offending patch
> applied. Both fail reliably. Without the patch, both pass reliably.
>=20
> > - different GCC versions
>=20
> I can only say that I see it crashes with both gcc 5.2.0 and gcc 5.4.0.
>=20
> > - different ways of invoking QEMU/QEMU version?
> >=20
> Yes and no. One way of _not_ (or maybe not always) seeing this crash
> is to use the bare-bone command line with qemu 2.7 or 2.8 (with no
> root file system provided). This crashes because there is no root file
> system, but not as described earlier. It does crash, though, when
> providing a more comprehensive command line. All kernel versions
> without this patch do not crash.
>=20
> On the other side, blaming this on the qemu command line is akin to
> saying that a crash only seen if a mouse is connected would be caused
> by the mouse, so I am not entirely sure if that helps too much.
> Also see below, regarding heisenbug.
>=20
> > and essentially Justin's commit just made problem 1) to occur, but is
> > not the root cause of the crash you are seeing?
>=20
> That would not necessarily be my conclusion. Of course, the code appears
> to be heavily SMP related, so it may well be that it exposes some
> problem associated with cache handling or support in non-SMP configuratio=
ns.
>=20
> Of course, it might also be possible that there is a qemu problem somewhe=
re
> which only manifests itself on non-SMP mips images with Justin's commit
> applied. That appears to be somewhat unlikely, though I have no hard data
> supporting this guess.
>=20
> I'll do some more testing and try to find the actual crash location.
> Tricky though since it almost looks like there is a not completely
> initialized workqueue. Making things worse, the problem "goes away"
> if I add some debug log into process_one_work(), meaning there may
> be a heisenbug.

cracked it by moving around an early return error. populate_cache()
macro has multiple statements with no do while (0) around it. The
c->scache.waysize condition in populate_cache_leaves then only
conditionalises the first statement in the macro and in absense of l2
(or l3 for that matter) it'll continue to write beyond the end of the
array allocated in detect_cache_attributes(). Badness ensues.

The SMP calls in arch/mips/kernel/cacheinfo.c file are pretty redundant
too since all the cache info is read from the cpu info structures.

I'll write a patch. Thanks for reporting Guenter!

Cheers
James

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnkEbAAoJEGwLaZPeOHZ6CiEQAK399bxIGXpKLa2Wg5Jvk+d0
InF6pDuNG50iGfDF1al3N3T+7+lLDjno+D1U9aSCD1z07/zwWD4WRU4IJyRvngZP
foR9TbCqvCeQfqmbDYV7kHx0kt4JDv79mrklV45TIY4KTFTqpH1iSeBE4DZYRmmc
p7wUKwGG/34UrGqBZ1xTMJMkPEgkr0E/Gjh0o3vdWl4Ar816XjypbMXo5O1RHii3
UknaVyAOub8KkP8rqeb4TZHxL13Sp+LmOSCq46B2b+eT60zClLhF2bmY3t/R75aR
2pZ/pyh5a70HHK34fcNvJlSTHla97rd9cxekGLsVo4/mHSawd5fnZYnDGZ0cqvKN
YUw45bBYKvPJjdGJStR8OhvEJzEfumLTzJQtrgak0zWIYTGYzzip9sCgo1H8quaw
CLqpLiPMjQ3hdrln+fDxG0vdbZk/7nue86l7wucoQ4hl8I2AulOfPfvPdxD8DrUs
YD7wuwYiE8z3eKbujRSn6SWiv9/v2WpEoeBRgFlpdxVm0CPM32CnAK5/h8R0WSFr
1FMlUOVb42j/N7TqA5KybHQ4AYWv6y42bUQ9/5YrBRMaMR9CUL11RbyUNhnux6/x
2o1wZ+mQvQswjys7AmrzFsGjfpFOqA9MN8KiHBqmND7pn42uQwt3LDN+XUVUyj4D
HebXFpqdwXSZr8lELFQA
=s5ee
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

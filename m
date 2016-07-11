Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 21:21:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56162 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993405AbcGKTV2GxbMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 21:21:28 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id A137B41F8E08;
        Mon, 11 Jul 2016 20:21:22 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 11 Jul 2016 20:21:22 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 11 Jul 2016 20:21:22 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 96D9EA064AF08;
        Mon, 11 Jul 2016 20:21:17 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 20:21:22 +0100
Date:   Mon, 11 Jul 2016 20:21:22 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <yhb@ruijie.com.cn>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: We need to clear MMU contexts of all other
 processes when asid_cache(cpu) wraps to 0.
Message-ID: <20160711192121.GC26799@jhogan-linux.le.imgtec.org>
References: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn>
 <5783DF18.1080408@imgtec.com>
 <20160711180755.GA29839@jhogan-linux.le.imgtec.org>
 <5783E332.2020503@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <5783E332.2020503@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54288
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

--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2016 at 11:19:30AM -0700, Leonid Yegoshin wrote:
> On 07/11/2016 11:07 AM, James Hogan wrote:
> > Hi Leonid,
> >
> > On Mon, Jul 11, 2016 at 11:02:00AM -0700, Leonid Yegoshin wrote:
> >> On 07/10/2016 06:04 AM, yhb@ruijie.com.cn wrote:
> >>> Subject: [PATCH] MIPS: We need to clear MMU contexts of all other pro=
cesses
> >>>    when asid_cache(cpu) wraps to 0.
> >>>
> >>> Suppose that asid_cache(cpu) wraps to 0 every n days.
> >>> case 1:
> >>> (1)Process 1 got ASID 0x101.
> >>> (2)Process 1 slept for n days.
> >>> (3)asid_cache(cpu) wrapped to 0x101, and process 2 got ASID 0x101.
> >>> (4)Process 1 is woken,and ASID of process 1 is same as ASID of proces=
s 2.
> >>>
> >>> case 2:
> >>> (1)Process 1 got ASID 0x101 on CPU 1.
> >>> (2)Process 1 migrated to CPU 2.
> >>> (3)Process 1 migrated to CPU 1 after n days.
> >>> (4)asid_cache on CPU 1 wrapped to 0x101, and process 2 got ASID 0x101.
> >>> (5)Process 1 is scheduled, and ASID of process 1 is same as ASID of p=
rocess 2.
> >>>
> >>> So we need to clear MMU contexts of all other processes when asid_cac=
he(cpu) wraps to 0.
> >>>
> >>> Signed-off-by: yhb <yhb@ruijie.com.cn>
> >>>
> >> I think a more clear description should be given here - there is no
> >> indication that wrap happens over 32bit integer.
> >>
> >> And taking into account "n days" frequency - can we just kill all local
> >> ASIDs in all processes (additionally to local_flush_tlb_all) and enfor=
ce
> >> reassignment if wrap happens? It should be a very rare event, you are
> >> first to hit this.
> >>
> >> It seems to be some localized stuff in get_new_mmu_context() instead of
> >> widespread patching.
> > That is what this patch does, but to do so it appears you need to lock
> > the other tasks one by one, and that must be doable from a context
> > switch, i.e. hardirq context, and that requires the task lock to be of
> > the _irqsave variant, hence the widespread changes and the relatively
> > tiny MIPS change hidden in the middle.
> >
> Not exactly. The change must be done only for local CPU which executes=20
> at the moment get_new_mmu_context(). Just prevent preemption here and=20
> change of cpu_context(THIS_CPU,...) can be done safely - other CPUs=20
> don't do anything with this variable besides killing it (writing 0 to it).

Right, but I was thinking more along the lines of whether you can ensure
the other tasks / mm continues to exist. I think this is partly achieved
by the read_lock'ing of tasklist_lock, but also possibly by the
find_lock_task_mm() call, which has a comment saying:

/*
 * The process p may have detached its own ->mm while exiting or through
 * use_mm(), but one or more of its subthreads may still have a valid
 * pointer.  Return p, or any of its subthreads with a valid ->mm, with
 * task_lock() held.
 */

(but of course I could be mistaken and something else guarantees it
won't go away).

Note also that I have a patch I'm about to submit which changes some of
those assignments of 0 to assign 1 instead (so as not to confuse the
cache management code into thinking the CPU has never run the code when
it has, while still triggering ASID regeneration). That applies here
too, so it should perhaps be doing something like this instead:

if (t->mm !=3D mm && cpu_context(cpu, t->mm))
	cpu_context(cpu, t->mm) =3D 1;

Cheers
James

>=20
> You can look into flush_tlb_mm() for example how it is cleared for=20
> single memory map.
>=20
> We have a macro to safely walk all processes, right? (don't remember=20
> it's name).
>=20
>=20

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXg/GxAAoJEGwLaZPeOHZ6HX0P/irMbs9sWRyG/WKlDU+n8gRi
bFlCbfVypvZH3HR0CXtIoqQ7z+jGJD9i853c82cDnYDFUTMwi56LXjtF3jbWzlrr
9k7u19aSBHlHaTYWA6+boUUJ13nHdS9xMguZ7mk1YALLDeI7BTrjGtibIpmmpFzi
DJ2komBvDtNa1LM0iWTkbua3aH0G9xFCnrDZESE3MiIMrrEU7m85lsnvuM+Uvds7
ZVtoBRaC8TtgHMrAQc7C9zD/juWaKvBoXU5A1humC3I0pOccMEE2ckdRCx7ApP8t
RXlcmCQx4MOC6yWiHS+3Oq5ppQq8hI69Fv7g58RCFwZRt/ItPLTmOqPvEGj63H/H
h28jco2sKdYG5XACH2dhiDtbN0bZ7Bh1D0HLy06MMF3oJXIqu+yH3zzUSaepEtWF
DwSu9zIfn6lasykKfi7DUVEsN34865m5yILTj/jih9hadLvNHIZjNM5J86JRSIeL
QLjXGkUO7fpMdO5nPqV9P689vA2bmIKssjbSWlLR0qadIpDFRcXPcvdOBJafzQHm
uhSreoW/4Jc1T3CfwYmp0Yw/4tWi5gpt9ojw2VSWHc5alu6Hw2Ee2fPTb9I3I8AG
btV9Ul+SLArg6C9ux6Zwpsf8sqgZB1HgmDha+DDmYKlRRskrUjmUhVFyBWRV6R9r
UXQo0LRphy2yEmzKkwvN
=Ub5t
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

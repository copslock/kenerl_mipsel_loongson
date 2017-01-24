Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 23:06:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10498 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992183AbdAXWGBOSydH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2017 23:06:01 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E460141F8DB3;
        Tue, 24 Jan 2017 23:08:56 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 24 Jan 2017 23:08:56 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 24 Jan 2017 23:08:56 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AC13D2D9D928F;
        Tue, 24 Jan 2017 22:05:50 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 24 Jan
 2017 22:05:54 +0000
Date:   Tue, 24 Jan 2017 22:05:54 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/2] MIPS: ptrace: disallow setting watchpoints in
 kernel address space
Message-ID: <20170124220554.GM29015@jhogan-linux.le.imgtec.org>
References: <1485163113-21780-1-git-send-email-marcin.nowakowski@imgtec.com>
 <alpine.DEB.2.00.1701232258380.13564@tp.orcam.me.uk>
 <20170124185452.GL29015@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1701241909540.13564@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UUMz/kfoogzZ9WLZ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1701241909540.13564@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56482
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

--UUMz/kfoogzZ9WLZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 08:52:22PM +0000, Maciej W. Rozycki wrote:
> On Tue, 24 Jan 2017, James Hogan wrote:
>=20
> > >  Can't for example the low-level exception handling entry/exit code b=
e=20
> > > moved out of the way of the EVA overlap range and then all watchpoint=
s=20
> > > masked for the duration of kernel mode execution?  This would be quit=
e=20
> > > expensive, however it could only be executed if a task flag indicates=
=20
> > > watchpoints are being used.
> >=20
> > That doesn't cover data watches. RAM would still need accessing, e.g. to
> > save/restore the watch state from the thread context, or even to read
> > the task flag, and stack accesses in C code.
>=20
>  All the critical data structures would have to be outside the EVA=20
> overlap.

This in itself is awkward. If a SoC supports multiple RAM sizes, e.g.
up to 2GB, you might want a single EVA kernel that could support both.
Normally you could just go with a 2GB compatible layout (for the sake of
argument, lets say RAM cached @ kernel VA 0x40000000 .. 0xBFFFFFFF,
ignoring BEV overlays for now), but if less than 1GB is fitted then none
of that RAM is outside of the user overlap range.

>=20
> > The only safe way for it to work would be to somehow disable or inhibit=
=20
> > watchpoints before clearing EXL, and re-enable them after setting EXL,=
=20
> > though you'd still get a loop of deferred watchpoints if it hit on the=
=20
> > way out to user mode unless cleared at the last moment before ERET.
>=20
>  Ah, I forgot about CP0.Cause.WP -- is it not enough to clear the bit to=
=20
> have any pending exception cancelled?  If so (and the architecture manual=
=20
> is actually clear that it is) then it looks like we have a solution and w=
e=20
> don't have to place any code or data specially, although it'll have to be=
=20
> carefully coded.
>=20
> > > Alternatively perhaps we could clobber=20
> > > CP0.EntryHi.ASID, at least temporarily; that would be cheaper.
> >=20
> > Kernel mode still needs to access the user address space.
>=20
>  Sure, that's why it would have to be temporary.  Low-level exception=20
> entry/exit code is not supposed to have a need to access user memory.

Ah I see, really temporary.

>=20
>  So we can put aside a certain ASID value, say 0 (for easy pasting with=
=20
> INS from $0), and never use it for a real context.  Then it can be cleare=
d=20
> right away at the general exception entry point if EVA is in use, say:
>=20
> 	<d>mfc0	$k0, $10
> 	<d>ins	$k0, $zero, 0, 10
> 	<d>mtc0	$k0, $10
>=20
> (there'll be a hazard here, but we can clear it later on if needed). =20
> There is no neeed to save the old ASID as we can retrieve the original=20
> from our data structures.
>=20
>  Then we can proceed with the usual switch to the kernel mode, switching=
=20
> stacks, saving registers, etc.  We can then check CP0.Cause.WP and stash=
=20
> it away for further processing if needed (though discarding it would I=20
> think be the usual if not only choice) and clear, with a hazard barrier,=
=20
> right before CP0.Status.EXL is cleared.
>=20
>  Now that we're in the regular kernel mode, with ASID still set to 0, we=
=20
> can check if process tracing has been enabled and if so, then iterate ove=
r=20
> the watchpoints registers masking them all.  At this point we can restore=
=20
> the correct ASID in CP0.EntryHi and proceed with the exception handler.
>=20
>  And then we'd do the reverse in the exception epilogue, only restoring=
=20
> the ASID as the last instruction before final ERET.
>=20
> > Alternatively we could set WatchHi.ASID to a reserved one, and only
> > clear/set the WatchHi.G bit (to bypass the ASID match) at the first/last
> > moment while EXL=3D1. It still wouldn't protect against code watches
> > around there exposing the kernel address of that code by the resulting
> > hang though, so would need to move the ebase out of the overlap range
> > too (which would have to be platform specific).
>=20
>  You'd still have to iterate over all WatchHi registers, a variable numbe=
r=20
> up to 8 architecturally, which I think would be too expensive for the=20
> common exception path.
>=20
>  Poking at ASID as I described above is just a couple of instructions at=
=20
> entry and exit, and the rest would only be done if tracing is active. =20
> Plus you don't actually have to move anything away, except from the final=
=20
> ERET, though likely not even that, owing to the delayed nature of an ASID=
=20
> update.

Probably, so long as you ignore QEMU.

>=20
>  So can you find a flaw in my proposal so far?

not a functional one.

> We'll have to think about=20
> the TLB refill handler yet though.

A deferred watch from refill handler (e.g. page tables) would I think
trigger an immediate watch exception on eret, and get cleared / ignored.
It would probably make enough of a timing difference for userland to
reliably detect (in order to probe where the process' page tables are in
kernel virtual memory, to be able to mount a more successful attack
given some other vulnerability).

Cheers
James

--UUMz/kfoogzZ9WLZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYh8+5AAoJEGwLaZPeOHZ6eXEP/2YVWUQX1f/vZ3PeaA+bwHF3
gQE+foeLnQaujORnPVs53WF2xq1m1Xo+UAaKMJL982n8yyAWLSbI9DUiVWdWSGkJ
A/E/ZbnAuCEX42AgfnHG8RTnyB4pjF+WEMoOodNitWmL/+Pcu3x8WKUbG/sZjvYA
XrnXGovpsBEtEp8gcdTmcwPBkxs2euqPvqCIS9QsPp+r0qBdBT9g6zhsISirGK/K
SBqKLXn4lUyYIb8YHZVX/wlP8hXIyy8WxgNDKgxr0rE2NEOyzXkiezzv8zQH+Vhk
/7wOAwn+YhyB9o9JMM4LMvT0tevQcc26hNVgKy+xsyhuDTUmQlhn30pphWjn4Fsq
ZCsDEdkPBg+BiAyJbEsc8PX7Nzsp/FxQ1HuqAdmnuBdiIPAmaIg5ZwUZfG7X5+2O
LO2KPBG9NVllkEZHfiAY8jqFM8bZbrW4xGxWHr6HjxqU6Jhb4KVggmCddyU+1RaF
QXXOgvVXuBcrqEbixjlRwhZqdBS8cjWy9SKf+EDpOGVvKvt9Ink55OPCN2y4qgRd
awaE2i3pwOf0BSJeBtOx+6HRLbFR9v2TBinMcmxQjLaAVEw5MWmAE4F1azl/lwxR
RZ3qf1lj2LVUn/US8ekZuaM8t5LZEJVKTRT/IXpFi/P9tDer5DoawgQJ8k9upAxw
D1AU7LaxHtpuqIMVYksy
=9bQw
-----END PGP SIGNATURE-----

--UUMz/kfoogzZ9WLZ--

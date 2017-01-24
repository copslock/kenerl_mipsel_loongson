Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 19:55:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40982 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991346AbdAXSy6aFege (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2017 19:54:58 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CE0F641F8DB3;
        Tue, 24 Jan 2017 19:57:53 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 24 Jan 2017 19:57:53 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 24 Jan 2017 19:57:53 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 745945D0A5164;
        Tue, 24 Jan 2017 18:54:48 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 24 Jan
 2017 18:54:52 +0000
Date:   Tue, 24 Jan 2017 18:54:52 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/2] MIPS: ptrace: disallow setting watchpoints in
 kernel address space
Message-ID: <20170124185452.GL29015@jhogan-linux.le.imgtec.org>
References: <1485163113-21780-1-git-send-email-marcin.nowakowski@imgtec.com>
 <alpine.DEB.2.00.1701232258380.13564@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FnOKg9Ah4tDwTfQS"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1701232258380.13564@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56478
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

--FnOKg9Ah4tDwTfQS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Tue, Jan 24, 2017 at 05:09:32PM +0000, Maciej W. Rozycki wrote:
> On Mon, 23 Jan 2017, Marcin Nowakowski wrote:
>=20
> > With certain EVA configurations it is possible for the kernel address
> > space to overlap user address space, which allows the user to set
> > watchpoints on kernel addresses via ptrace.
> >=20
> > If a watchpoint is set in the watch exception handling code (after
> > exception level has been cleared) then the system will hang in an
> > infinite loop when hitting a watchpoint while trying to process it.
> >=20
> > To prevent that simply disallow placing any watchpoints at addresses
> > above start of kernel that overlap userspace.
>=20
>  This can be severely crippling for user debugging.  Is there no better=
=20
> way?

See the v1 patches, but as you say below, an architectural fix is vastly
preferable. Other proposed solutions have so far added complexity and
fragility, while struggling to completely plug the original problem.

>=20
>  Can't for example the low-level exception handling entry/exit code be=20
> moved out of the way of the EVA overlap range and then all watchpoints=20
> masked for the duration of kernel mode execution?  This would be quite=20
> expensive, however it could only be executed if a task flag indicates=20
> watchpoints are being used.

That doesn't cover data watches. RAM would still need accessing, e.g. to
save/restore the watch state from the thread context, or even to read
the task flag, and stack accesses in C code. The only safe way for it to
work would be to somehow disable or inhibit watchpoints before clearing
EXL, and re-enable them after setting EXL, though you'd still get a loop
of deferred watchpoints if it hit on the way out to user mode unless
cleared at the last moment before ERET.

> Alternatively perhaps we could clobber=20
> CP0.EntryHi.ASID, at least temporarily; that would be cheaper.

Kernel mode still needs to access the user address space.

Alternatively we could set WatchHi.ASID to a reserved one, and only
clear/set the WatchHi.G bit (to bypass the ASID match) at the first/last
moment while EXL=3D1. It still wouldn't protect against code watches
around there exposing the kernel address of that code by the resulting
hang though, so would need to move the ebase out of the overlap range
too (which would have to be platform specific).

Cheers
James

>=20
>  Overall I think this situation is asking for a watchpoint flag to be=20
> added to inhibit hits in the kernel mode in hardware; for completeness=20
> this probably actually ought to be a field to cover the kernel, superviso=
r=20
> and user modes separately -- either a plain bitmask for arbitrary control=
=20
> or an encoded value similar to CP0.Status.KSU which would indicate the=20
> most privileged mode to accept a watchpoint in.
>=20
>  I had a recollection of such a facility already being available for JTAG=
=20
> debugging, but I can't track it down in the specification, so perhaps it=
=20
> was for another architecture and it would be completely new for ours.
>=20
>   Maciej

--FnOKg9Ah4tDwTfQS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYh6L1AAoJEGwLaZPeOHZ6eJMQAJ0r/0mXKVxsBTe0rSt2uGfe
emYzxLGBCxHF8NxzKk7Hp2rco8g5WJA59pllAV8CqziK+NHdB2i6sbK1UpQIgTG9
dkRIToNfhx+XenOYZBu3I+fT1cegpfNExS+p7qSsCnNRWCMJKIiaFzxoIPXtLI3a
ejF5rZGN+AawlOyLaC4MjLvoNcUnv6xdiOlJtO0pBb+1RZLvZMOwwt4iw5452cwO
kPVQUX4Z2/k0BvHNSEmGllrO8dexo3JnRS1z3JpGiuWguRV8AryaMWNCntiPPrAj
R4BMB8I9sDRfhFGiYMVGyTiFHkQZAy2tUp5uPIju8NOtCeMpylcbDpIPwdxfikLs
jGTMOSe4DpfX1hBI02NoTAswQxHNV46pkrNri6/fGCinrGhiTn5Gdm3pL6ALu36h
/JFJm1j7Rnupi1UhHFstLndiCS+jh4EToOFmSXBHJ29o73fx7slJi5jjNxnXnH8k
yyJgIQcNBmnKKN02rl7gjbARQjhj8DlBDOxnkF0LKKauTqdscetFWdCY9+RLcIBl
SIx0bzgyXRPYWZ9t1lrNwL5wqCS9tn/RWpVCLMHYm7Qpx9VwTrYVheLnzaKqSw/a
ZI/7dffWesmPUcY4mfX3Qwx9Bos3yNHVa7U/ITZKsu5ZFPeW9H/fIiazLDMoUTmz
vg4/uG2haZyX39+bbC35
=bIQs
-----END PGP SIGNATURE-----

--FnOKg9Ah4tDwTfQS--

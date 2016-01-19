Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 11:02:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55183 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009266AbcASKCBRf-Cv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 11:02:01 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E9B4241F8D7A;
        Tue, 19 Jan 2016 10:01:55 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 19 Jan 2016 10:01:55 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 19 Jan 2016 10:01:55 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 5F6018F25EA53;
        Tue, 19 Jan 2016 10:01:53 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 19 Jan 2016 10:01:55 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 19 Jan
 2016 10:01:54 +0000
Date:   Tue, 19 Jan 2016 10:01:55 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>
Subject: Re: cannot build Linux 4.4: =?utf-8?Q?arch?=
 =?utf-8?B?L21pcHMva2VybmVsL3NpZ25hbC5jOjE0MjoxMjogZXJyb3I6IOKAmHN0cnVj?=
 =?utf-8?Q?t_ucontext=E2=80=99_has_no_member_named_=E2=80=98uc=5Fextcontex?=
 =?utf-8?B?dOKAmQ==?=
Message-ID: <20160119100154.GJ30608@jhogan-linux.le.imgtec.org>
References: <569B9CFE.1090007@gmx.de>
 <569BA9BB.3080508@gmx.de>
 <569D9DDD.7080909@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4vpci17Ql0Nrbul2"
Content-Disposition: inline
In-Reply-To: <569D9DDD.7080909@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: e68ca197
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51210
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

--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, Jan 18, 2016 at 06:22:21PM -0800, Florian Fainelli wrote:
> Le 17/01/2016 06:48, Heinrich Schuchardt a =C3=A9crit :
> > On 01/17/2016 02:54 PM, Heinrich Schuchardt wrote:
> >>
> >> HEAD is now at afd2ff9... Linux 4.4
> >> arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=80=
=99:
> >> arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=E2=
=80=99 has no member
> >> named =E2=80=98uc_extcontext=E2=80=99
> >>   return &uc->uc_extcontext;
> >>             ^
> >> In file included from include/linux/poll.h:11:0,
> >>                  from include/linux/ring_buffer.h:7,
> >>                  from include/linux/trace_events.h:5,
> >>                  from include/trace/syscall.h:6,
> >>                  from include/linux/syscalls.h:81,
> >>                  from arch/mips/kernel/signal.c:26:
> >> arch/mips/kernel/signal.c: In function =E2=80=98save_msa_extcontext=E2=
=80=99:
> >> arch/mips/kernel/signal.c:170:40: error: dereferencing pointer to
> >> incomplete type
> >>
> >=20
> > The problem stemmed from make not recognizing that this file was outdat=
ed:
> >=20
> > Oct 16  2014 arch/mips/include/generated/asm/ucontext.h
> >=20
> > Shouldn't make automatically regenerate outdated files?
>=20
> The reduced test case can be simplified to these steps:
>=20
> git co f1fe2d21f4e1aca8644cea888dc618f0183ad671\^1
> configure your kernel
> ARCH=3Dmips make arch/mips/kernel/signal.o
> git co f1fe2d21f4e1aca8644cea888dc618f0183ad671
> ARCH=3Dmips make arch/mips/kernel/signal.o
>=20
> The problem seems to be that if there was a previous build which
> resulted in creating an asm-generic wrapper for a file
> (arch/mips/include/generated/asm/ucontext.h in that case), but this file
> was later moved into an arch-specific, non asm-generic header file, then
> we are just not going to automatically remove this auto-generated
> wrapper, and generate the new one.
>=20
> This seems to be aggravated by the fact that commit
> f1fe2d21f4e1aca8644cea888dc618f0183ad671 does not add ucontext.h to
> arch/mips/include/uapi/Kbuild, Paul, James is that intentional?

I suspect it was intended to be exported in kernel headers, for
libc/signal handlers to use, although it isn't referenced by other
headers. Paul?

>=20
> After trying to mess a bit with a clean solution, I just gave up and
> decided that this was not worth fixing since it is a very infrequent
> problem.

Thing is it isn't that uncommon. I've lost count of the number of times
I've hit this specific case (especially during bisection), and as Ralf
says, several others have mentioned it on the list, but rm -fr
arch/mips/include/generated always seemed so much easier than fixing
the actual problem.

Anyway, after a bit of fiddling around I think i've fixed this properly
now. I'll submit the patch asap.

Cheers
James

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWngmSAAoJEGwLaZPeOHZ6G+YQAJodCA0oOYQtlGHAH/CWlqeD
y01BL+UYd3OvcqKinYkYxQWEU/MmGpskT37P0eCleGLWdzfNJRaomW9kXNGf00cW
lZpP7f1/62IWzUgIneX+fHivtzcyS0avkmyGkG4yZnAxIqSj/Yk6WRQYirwL2eKR
apMhhDvOJCka4PtNzwUMk9kqGqoFIQR6uC62HfbcgDlQdpid7PsqnnOhZG4AxJK0
l8oJY98ccMP5zFGDcMmH1vane1BZhqXQ02J6CNQ04FLoMlRXNdlIjQAPUixmA3UU
TmzAxsFFST4dQ9KYGQsdFaJbMMFlPNAs1AQInLdcfTto5nptkMcePbW5YvkqAYum
fRLo+bnYuEqU5fb/LU0nMf0C0WjMMUfJPs0A9a2PsK1yC0yXSR82JKQcMZMYXew0
fxxl4kZXvsUKthNaYIEtwWcmmugzZHh/Kt3OgLkVTbYG93hAyXCKtP/SVNEijyUa
syazGRjVKCbEHUUFyza4EmKd0+RhLeZQAp9dtgPxfqh65f80NsGzKIV9XxNwDEzT
GhUeqUyy2St0sLTUJztkPUu2GM8vGsTsegc2wQ1E2od7aWoYQ6hPlqJC/tlxt/9k
RrGEoTr29dxh/9/JKjuKakezYhiY/n0XHCN7hN2pY5olR9UW/4XflZsxgoO66X93
x/8YyMGyRKWSh2wvMDNl
=Wb/y
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 14:16:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48681 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011522AbcBANQ3gTe6l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 14:16:29 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 260EB41F8D56;
        Mon,  1 Feb 2016 13:16:24 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 01 Feb 2016 13:16:24 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 01 Feb 2016 13:16:24 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id E1C6380ED3AA6;
        Mon,  1 Feb 2016 13:16:21 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 1 Feb 2016 13:16:23 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 1 Feb
 2016 13:16:23 +0000
Date:   Mon, 1 Feb 2016 13:16:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Milko Leporis <milko.leporis@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix buffer overflow in syscall_get_arguments()
Message-ID: <20160201131623.GC32210@jhogan-linux.le.imgtec.org>
References: <1453753923-26620-1-git-send-email-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1601312327590.5958@tp.orcam.me.uk>
 <20160201115036.GB32210@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1602011236500.15885@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1602011236500.15885@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51584
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

--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 12:50:16PM +0000, Maciej W. Rozycki wrote:
> On Mon, 1 Feb 2016, James Hogan wrote:
>=20
> > > > diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/as=
m/syscall.h
> > > > index 6499d93ae68d..47bc45a67e9b 100644
> > > > --- a/arch/mips/include/asm/syscall.h
> > > > +++ b/arch/mips/include/asm/syscall.h
> > > > @@ -101,10 +101,8 @@ static inline void syscall_get_arguments(struc=
t task_struct *task,
> > > >  	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
> > > >  	if ((config_enabled(CONFIG_32BIT) ||
> > > >  	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
> > > > -	    (regs->regs[2] =3D=3D __NR_syscall)) {
> > > > +	    (regs->regs[2] =3D=3D __NR_syscall))
> > > >  		i++;
> > > > -		n++;
> > > > -	}
> > > > =20
> > > >  	while (n--)
> > > >  		ret |=3D mips_get_syscall_arg(args++, task, regs, i++);
> > >=20
> > >  What I think it really needs to do is to *decrease* the number of=20
> > > arguments, as we're throwing the syscall number away as not an argume=
nt to=20
> > > itself.  So this looks like a typo to me, the expression was meant to=
 be=20
> > > `n--' rather than `n++'.  With the number of arguments unchanged, as =
in=20
> > > your proposed change, we're still reaching one word too far.
> >=20
> > No, the caller asked for n args, thats what it should get. It doesn't
> > care whether the syscall was indirected or not.
> >=20
> > The syscall doesn't have 1 less arg as a result of indirection. E.g.
> > What about system calls with 6 arguments, and hence 7 arguments
> > including syscall number argument when redirected? We'd get an
> > uninitialised 6th arg back when passing n=3D6.
>=20
>  Do you mean the caller ignores the extra argument holding the number of=
=20
> the wrapped syscall in counting syscall arguments?

No, the caller never sees the extra argument containing syscall number,
because i is incremented, so if caller asks for 3 args start at arg 0,
it would now actually gets 3 args starting at arg 1.

> Where does it take `n' from?

=46rom a quick audit:

sys_enter trace event, seccomp, & proc_pid_syscall gets n=3D6 args
starting at i=3D0.

Syscall tracing uses syscall metadata to fetch exactly the right number
of arguments starting at i=3D0 (this is where its particularly important
not to decrement n).

(This could probably be considered broken for the above cases of padded
64-bit args).

Also of interest is the kerneldoc comment describing this function in
include/asm-generic/syscall.h:

/**
 * syscall_get_arguments - extract system call parameter values
 * @task:	task of interest, must be blocked
 * @regs:	task_pt_regs() of @task
 * @i:		argument index [0,5]
 * @n:		number of arguments; n+i must be [1,6].
 * @args:	array filled with argument values
 *
 * Fetches @n arguments to the system call starting with the @i'th argument
 * (from 0 through 5).  Argument @i is stored in @args[0], and so on.
 * An arch inline version is probably optimal when @i and @n are constants.
 *
 * It's only valid to call this when @task is stopped for tracing on
 * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
 * It's invalid to call this with @i + @n > 6; we only support system calls
 * taking up to 6 arguments.
 */
void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
			   unsigned int i, unsigned int n, unsigned long *args);

Cheers
James

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWr1qnAAoJEGwLaZPeOHZ6VAsP/1EBgsCE9p0Xqhsx8+gbOhju
FQbpTuo9pYK0qZ/qkoC/P9znkSyDk34/+di2GmCKXk5RPWjrZej1XTgE2j6Dsm2Z
3jrAtEFRXkmfxCEAN5VuSSvhGqNJ9GovHr6sSTE6QfCEpNmP0IA0Sv7HZz75Jb3a
c8C44oy9JPIxuXYRJyRyNjbSvjSXDYPrYbKlJrFly55seH9A9xlAYQbn5zxUDG1R
NN/0xjrAMXV0Yzk8JeaVhHYpTdvo9QkoDROPtqixT3aMKW31nhX+OGUjEmc+R8x5
bry7Y5e+FA2oDxPcpmvt663nMkvmaM6pdeGieTugMfcNRsLHSOhkJPsgrpo1uCMe
zj9YRa5z3/igj+L8YxB6lWW2dad5jdi2hmYBzeXAsvvyzvSIHdxeEEobRgu45TZ2
tURinO+U38dfCehg3dvipBAND7vk3/wFVBkD8f6XZTasiDWkcZNAYhAEN746HUZp
ZeL76czl1nTEO2eQ8+PbF5o1SNLK+BbtSxF8apMmud9jqAeOQgwjy0rdKpZtaUV3
CWaBuwBivl3Cov9cmWaC5qg5EBbITCD3u1I8r06IJ7BLIHvSSx6I+o9qlSUlHunk
3snzI4GSc4/nj/FOX6YF7YDwTP90Bt21AUs7rqx8RJ2n/cvl1iBuIQ4fHne04Q6u
NmId1jZSdNazuflKyspD
=JlkK
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--

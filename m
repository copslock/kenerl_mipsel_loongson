Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 12:50:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21048 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010982AbcBALunCLKcY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 12:50:43 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id AFA2E41F8DF9;
        Mon,  1 Feb 2016 11:50:37 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 01 Feb 2016 11:50:37 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 01 Feb 2016 11:50:37 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C6E801CCE6E1A;
        Mon,  1 Feb 2016 11:50:35 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 1 Feb 2016 11:50:37 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 1 Feb
 2016 11:50:36 +0000
Date:   Mon, 1 Feb 2016 11:50:36 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Milko Leporis <milko.leporis@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix buffer overflow in syscall_get_arguments()
Message-ID: <20160201115036.GB32210@jhogan-linux.le.imgtec.org>
References: <1453753923-26620-1-git-send-email-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1601312327590.5958@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1601312327590.5958@tp.orcam.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 30575414
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51581
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

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Sun, Jan 31, 2016 at 11:33:30PM +0000, Maciej W. Rozycki wrote:
> On Mon, 25 Jan 2016, James Hogan wrote:
>=20
> > Since commit 4c21b8fd8f14 ("MIPS: seccomp: Handle indirect system calls
> > (o32)"), syscall_get_arguments() attempts to handle o32 indirect syscall
> > arguments by incrementing both the start argument number and the number
> > of arguments to fetch. However only the start argument number needs to
> > be incremented. The number of arguments does not change, they're just
> > shifted up by one, and in fact the output array is provided by the
> > caller and is likely only n entries long, so reading more arguments
> > overflows the output buffer.
> [...]
> > diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/sy=
scall.h
> > index 6499d93ae68d..47bc45a67e9b 100644
> > --- a/arch/mips/include/asm/syscall.h
> > +++ b/arch/mips/include/asm/syscall.h
> > @@ -101,10 +101,8 @@ static inline void syscall_get_arguments(struct ta=
sk_struct *task,
> >  	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
> >  	if ((config_enabled(CONFIG_32BIT) ||
> >  	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
> > -	    (regs->regs[2] =3D=3D __NR_syscall)) {
> > +	    (regs->regs[2] =3D=3D __NR_syscall))
> >  		i++;
> > -		n++;
> > -	}
> > =20
> >  	while (n--)
> >  		ret |=3D mips_get_syscall_arg(args++, task, regs, i++);
>=20
>  What I think it really needs to do is to *decrease* the number of=20
> arguments, as we're throwing the syscall number away as not an argument t=
o=20
> itself.  So this looks like a typo to me, the expression was meant to be=
=20
> `n--' rather than `n++'.  With the number of arguments unchanged, as in=
=20
> your proposed change, we're still reaching one word too far.

No, the caller asked for n args, thats what it should get. It doesn't
care whether the syscall was indirected or not.

The syscall doesn't have 1 less arg as a result of indirection. E.g.
What about system calls with 6 arguments, and hence 7 arguments
including syscall number argument when redirected? We'd get an
uninitialised 6th arg back when passing n=3D6.

Note scall32-o32.S sys_syscall shifts 7 arguments starting at a1 (I've
reordered code slightly):
	move	a0, a1				# shift argument registers
	move	a1, a2
	move	a2, a3
	lw	a3, 16(sp)
	lw	t4, 20(sp)
	lw	t5, 24(sp)
	lw	t6, 28(sp)

	sw	a0, PT_R4(sp)			# .. and push back a0 - a3, some
	sw	a1, PT_R5(sp)			# syscalls expect them there
	sw	a2, PT_R6(sp)
	sw	a3, PT_R7(sp)
	sw	t4, 16(sp)
	sw	t5, 20(sp)
	sw	t6, 24(sp)

So it takes args 0..2 from a1..a3, and 3..6 from stack.

I presume the handling of 7th arg after syscall number argument is for
fadvise64_64 and sync_file_range, which had badly designed arguments
(odd 64bit args requiring a word of padding).

Cheers
James

>=20
>   Maciej

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWr0aMAAoJEGwLaZPeOHZ6YI4QAJFt3ofcuJd55luAvREqrwcn
aaXGLaLFFuXyeRU4zhiSmJ9eWvdLQ67EfiDXvVXcCJfcSvT6lyndtTuZD4XudWRY
7o2netybOy2xjqjvUTBXES3YGd6nzFBuQn/4fzJ9jHJgxglL46M7eCtYMkJkHcdn
6tg55bAHvHh1v0n9rh+fol6tN5yiZ8IrounJVWEz9VkyLJddXCl3EEVabYZUVgdh
4ZIsrkKA5Ia4oZHpfmEJPAudL2Z9F01ZRHd67dvOf544BqreGzOzuDEzwJpkClcE
sY2ojReimA22Jv2qn1wHCnZPq1GOG0z+ef4ektRBF5Rx35QfcS8otpvALnBGVHfe
urOaLx0FuO1D0W56cNUqkWhUQHllJUcnblFbm4GdAyE9o9ksRtOaY2Jd3KIzzB66
HjPG9r/rebbKETpix5cGPYmhvosGWr018O1BBdPle/ucOpUlFgV8MHfXrU4DQ5bQ
0yjPZkexfmK7d0Bjh/tqqhtnmWZnEJhcZ6NOmaTcTxrqrFekF10yXwLwVO3Wdyvv
M1odJdp6CvcbQaooxI1ELaVGlI4vjge7HhRg6agqiDRKJgqGFkw5ZWoE15DjFLav
TA9S0+CiK5XDoRdYfGJ/VTptEHPeVtjn2C04neDsA+zWUZlwUZ6XagVSYotH7BNx
Vym6CqhIR4p2nEykWRHX
=/lsx
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

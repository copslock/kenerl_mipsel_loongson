Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2017 16:03:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24032 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991867AbdG1ODqJkEsX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2017 16:03:46 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5624141F8EDF;
        Fri, 28 Jul 2017 16:15:05 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 28 Jul 2017 16:15:05 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 28 Jul 2017 16:15:05 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 98EC530141A01;
        Fri, 28 Jul 2017 15:03:36 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 28 Jul
 2017 15:03:40 +0100
Date:   Fri, 28 Jul 2017 15:03:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     James Cowgill <James.Cowgill@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: Remove pt_regs adjustments in indirect syscall
 handler
Message-ID: <20170728140339.GX31455@jhogan-linux.le.imgtec.org>
References: <20170331160959.3192-1-James.Cowgill@imgtec.com>
 <20170331160959.3192-3-James.Cowgill@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6yuPXOSZRpyw7iEV"
Content-Disposition: inline
In-Reply-To: <20170331160959.3192-3-James.Cowgill@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 3d264444
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59302
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

--6yuPXOSZRpyw7iEV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 05:09:59PM +0100, James Cowgill wrote:
> If a restartable syscall is called using the indirect o32 syscall
> handler - eg: syscall(__NR_waitid, ...), then it is possible for the
> incorrect arguments to be passed to the syscall after it has been
> restarted. This is because the syscall handler tries to shift all the
> registers down one place in pt_regs so that when the syscall is restarted,
> the "real" syscall is called instead. Unfortunately it only shifts the
> arguments passed in registers, not the arguments on the user stack. This
> causes the 4th argument to be duplicated when the syscall is restarted.
>=20
> Fix by removing all the pt_regs shifting so that the indirect syscall
> handler is called again when the syscall is restarted. The comment "some
> syscalls like execve get their arguments from struct pt_regs" is long
> out of date so this should now be safe.
>=20
> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Tested-by: James Hogan <james.hogan@imgtec.com>

This is safe to backport as far back as 4.2 too (I just tested), which
is I think as far back as patch 1 (commit f9c4e3a6dae1) can be
backported due to the commit 3033f14ab78c3 ("clone: support passing tls
argument via C rather than pt_regs magic") referenced in patch 1, so I
suggest adding:

Cc: <stable@vger.kernel.org> # f9c4e3a6dae1: MIPS: Opt into HAVE_COPY_THREA=
D_TLS
Cc: <stable@vger.kernel.org> # 4.2+

Thanks
James

> ---
>  arch/mips/kernel/scall32-o32.S | 11 -----------
>  arch/mips/kernel/scall64-o32.S |  6 ------
>  2 files changed, 17 deletions(-)
>=20
> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o3=
2.S
> index c29d397eee86..d8d6336c4cc5 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -190,12 +190,6 @@ illegal_syscall:
>  	sll	t1, t0, 2
>  	beqz	v0, einval
>  	lw	t2, sys_call_table(t1)		# syscall routine
> -	sw	a0, PT_R2(sp)			# call routine directly on restart
> -
> -	/* Some syscalls like execve get their arguments from struct pt_regs
> -	   and claim zero arguments in the syscall table. Thus we have to
> -	   assume the worst case and shuffle around all potential arguments.
> -	   If you want performance, don't use indirect syscalls. */
> =20
>  	move	a0, a1				# shift argument registers
>  	move	a1, a2
> @@ -207,11 +201,6 @@ illegal_syscall:
>  	sw	t4, 16(sp)
>  	sw	t5, 20(sp)
>  	sw	t6, 24(sp)
> -	sw	a0, PT_R4(sp)			# .. and push back a0 - a3, some
> -	sw	a1, PT_R5(sp)			# syscalls expect them there
> -	sw	a2, PT_R6(sp)
> -	sw	a3, PT_R7(sp)
> -	sw	a3, PT_R26(sp)			# update a3 for syscall restarting
>  	jr	t2
>  	/* Unreached */
> =20
> diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o3=
2.S
> index 5a47042dd25f..6fd8ecca89e7 100644
> --- a/arch/mips/kernel/scall64-o32.S
> +++ b/arch/mips/kernel/scall64-o32.S
> @@ -198,7 +198,6 @@ LEAF(sys32_syscall)
>  	dsll	t1, t0, 3
>  	beqz	v0, einval
>  	ld	t2, sys32_call_table(t1)		# syscall routine
> -	sd	a0, PT_R2(sp)		# call routine directly on restart
> =20
>  	move	a0, a1			# shift argument registers
>  	move	a1, a2
> @@ -207,11 +206,6 @@ LEAF(sys32_syscall)
>  	move	a4, a5
>  	move	a5, a6
>  	move	a6, a7
> -	sd	a0, PT_R4(sp)		# ... and push back a0 - a3, some
> -	sd	a1, PT_R5(sp)		# syscalls expect them there
> -	sd	a2, PT_R6(sp)
> -	sd	a3, PT_R7(sp)
> -	sd	a3, PT_R26(sp)		# update a3 for syscall restarting
>  	jr	t2
>  	/* Unreached */
> =20
> --=20
> 2.11.0
>=20
>=20

--6yuPXOSZRpyw7iEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAll7RDMACgkQbAtpk944
dnpCWBAAkpeBzPlFljnuMosjvo3ALoOhUMfNCXNsIlwxixaSEFzeslolcZvXZX3l
OvUOYne6I+OZCv62g6GBQsEYgcoFByZWNHr3vbgXYOiDGmlY7HVuCY2edcPZJsxC
A4aPnPi44kEBuOWJWJUWI4cWWojl/uxe3lVCbiJBoKM8otHwOn0NcUjQ4glm3vyH
xl5/RYz6dsMPSAVid+NAZ0tSx1HC+9lAwXVgeMNqOgy0kKArGIglAF6sE/5kJx3w
k2NczvWtI0w1mXBHbfVUPxpF/xI4JOOwOlkvH56X40GHKVYB7RQPUl+2Ib8mjums
D1veRR/koLXcB+63T1Y1vL93j2SZP06dJagCbm1hTECgJ03fRqPyaq28MLBCDe5H
bMIEJWz0iy+pOeaW4XK8LLjjBw28Bh+jcPKhmgOk4UWTaKH7L0fFN2HVj92KvrQJ
zxkNCuCJEoxx+zp3VvtQ5eDyYc/MYAiplaYNGpHW/w6DRcq8GYRDoS4o25XN/c0S
BbWQCvmFakdidJLtN+ZfGpEuj2/odb1fN5ClQTnOVRRmy1S4NjLARATDl2xYUf4S
mxQcaFXj1SFmey/z+w7G5b0aIEsA51cmBrNlSba37PpMZ4pGuEYwCwaarj8pARRI
IqXUe001DiT9RuznMbOrwA9FYUfu3kuvS+VROWDksZjtHET/K1U=
=bnoH
-----END PGP SIGNATURE-----

--6yuPXOSZRpyw7iEV--

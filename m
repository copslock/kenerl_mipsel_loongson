Return-Path: <SRS0=aT0P=SG=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D737C4360F
	for <linux-mips@archiver.kernel.org>; Thu,  4 Apr 2019 18:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5156620663
	for <linux-mips@archiver.kernel.org>; Thu,  4 Apr 2019 18:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDDSSx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:18:53 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:54046 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfDDSSx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 4 Apr 2019 14:18:53 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DB43B72CC8C;
        Thu,  4 Apr 2019 21:18:49 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C30037CCE4F; Thu,  4 Apr 2019 21:18:49 +0300 (MSK)
Date:   Thu, 4 Apr 2019 21:18:49 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Dave Martin <dave.martin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 6/6 v3] syscalls: Remove start and number from
 syscall_set_arguments() args
Message-ID: <20190404181849.GA8711@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.442323029@goodmis.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20190401134421.442323029@goodmis.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 09:41:10AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>=20
> After removing the start and count arguments of syscall_get_arguments() it
> seems reasonable to remove them from syscall_set_arguments(). Note, as of
> today, there are no users of syscall_set_arguments(). But we are told that
> there will be soon. But for now, at least make it consistent with
> syscall_get_arguments().
>=20
> Link: http://lkml.kernel.org/r/20190327222014.GA32540@altlinux.org

FWIW, you can add
Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>
=20
There are two places listed below where I'd prefer to see more readable
equivalents, but feel free to leave it to respective arch maintainers.

> diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/sy=
scall.h
> index 89a6ec8731d8..671ebd357496 100644
> --- a/arch/nds32/include/asm/syscall.h
> +++ b/arch/nds32/include/asm/syscall.h
> @@ -129,39 +129,20 @@ void syscall_get_arguments(struct task_struct *task=
, struct pt_regs *regs,
>   * syscall_set_arguments - change system call parameter value
>   * @task:	task of interest, must be in system call entry tracing
>   * @regs:	task_pt_regs() of @task
> - * @i:		argument index [0,5]
> - * @n:		number of arguments; n+i must be [1,6].
>   * @args:	array of argument values to store
>   *
> - * Changes @n arguments to the system call starting with the @i'th argum=
ent.
> - * Argument @i gets value @args[0], and so on.
> - * An arch inline version is probably optimal when @i and @n are constan=
ts.
> + * Changes 6 arguments to the system call. The first argument gets value
> + * @args[0], and so on.
>   *
>   * It's only valid to call this when @task is stopped for tracing on
>   * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUD=
IT.
> - * It's invalid to call this with @i + @n > 6; we only support system ca=
lls
> - * taking up to 6 arguments.
>   */
>  void syscall_set_arguments(struct task_struct *task, struct pt_regs *reg=
s,
> -			   unsigned int i, unsigned int n,
>  			   const unsigned long *args)
>  {
> -	if (n =3D=3D 0)
> -		return;
> -
> -	if (i + n > SYSCALL_MAX_ARGS) {
> -		pr_warn("%s called with max args %d, handling only %d\n",
> -			__func__, i + n, SYSCALL_MAX_ARGS);
> -		n =3D SYSCALL_MAX_ARGS - i;
> -	}
> -
> -	if (i =3D=3D 0) {
> -		regs->orig_r0 =3D args[0];
> -		args++;
> -		i++;
> -		n--;
> -	}
> +	regs->orig_r0 =3D args[0];
> +	args++;
> =20
> -	memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
> +	memcpy(&regs->uregs[0] + 1, args, 5 * sizeof(args[0]));
>  }

A shorter and slightly more readable equivalent of the last memcpy is

	memcpy(&regs->uregs[1], args, 5 * sizeof(args[0]));

> diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/sysc=
all.h
> index ee0b1f6aa36d..59c3e91f2cdb 100644
> --- a/arch/s390/include/asm/syscall.h
> +++ b/arch/s390/include/asm/syscall.h
> @@ -74,15 +74,14 @@ static inline void syscall_get_arguments(struct task_=
struct *task,
> =20
>  static inline void syscall_set_arguments(struct task_struct *task,
>  					 struct pt_regs *regs,
> -					 unsigned int i, unsigned int n,
>  					 const unsigned long *args)
>  {
> -	BUG_ON(i + n > 6);
> +	unsigned int n =3D 6;
> +
>  	while (n-- > 0)
> -		if (i + n > 0)
> -			regs->gprs[2 + i + n] =3D args[n];
> -	if (i =3D=3D 0)
> -		regs->orig_gpr2 =3D args[0];
> +		if (n > 0)
> +			regs->gprs[2 + n] =3D args[n];
> +	regs->orig_gpr2 =3D args[0];
>  }

A shorter and slightly more readable equivalent of the loop is

	while (--n > 0)
		regs->gprs[2 + n] =3D args[n];


--=20
ldv

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcpkqJAAoJEAVFT+BVnCUIkZ4QAOj5yCToMhv0yo7mY8ZiYOeM
4W75B2oenIbr0XPjODdE7bJ8Zz2aWXIy8ivTN5TkHPrhXeqD/+TrvHc8SIlGGZaQ
RCkrjp8yN0vTWNQQyZ0QrAu27Z0bLMcM2RMTHYFHIKtIN9y/6FqOy+KFHBX+XTHs
wRtrmxXaOg6tFsrw5ljEZJEPn4hiTStgTUNuUWfFHJ45xkLm/Xl1xy5I+q0vSTRe
2TVfqiAgRND0rwyLCQnc6Q9A+eG/tojEI/yBeaePhNVc2aT8kjbopkH9ppxMf83s
FR+Hy0IcJpSUEmNDPzFJ5dR4oTXVXSgxsVacQLbI1cYXZmFbe4kbmCArmS40Z1ID
ETWm8m9repzEYVjVCGXNcPeZHwY6qm5V8TNSJYkuNdYLO/G5ViBSjNe/4EPp7Jsy
U63M5VuKOWMfEW5JL3KV17+xKjQ8ehpeBWo9+CYRQlbjlmDfjL9CPqC+W0qWUcQn
ID3Ifll16M/ERzBRky4+XTlNHBRIUnKsolQY+b8V9WL7F7FZAbi0EGOSBAiLIcYd
f2JeixCHd3ax9okr0/3F3O0TWxRMfaId+9yxz8dUJUcDZ/QuMMzymnKYrmXN0Sug
TwaWCVXiIhl3jYCF+AbJNA0dz72Jj4rz4PzQChRwagZEa5bGCRuzgU931k7xnobH
JOoCPu0p7CEMVSeyAENw
=xrhw
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

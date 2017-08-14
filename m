Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 11:42:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29440 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdHNJlw5rASJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 11:41:52 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 74E12B932D2C;
        Mon, 14 Aug 2017 10:41:43 +0100 (IST)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 14 Aug
 2017 10:41:45 +0100
Date:   Mon, 14 Aug 2017 10:41:45 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 4/4] MIPS/ptrace: Add PTRACE_SET_SYSCALL operation
Message-ID: <20170814094145.GP6973@jhogan-linux.le.imgtec.org>
References: <20170811205653.21873-1-james.hogan@imgtec.com>
 <20170811205653.21873-5-james.hogan@imgtec.com>
 <CAGXu5j+Z_n1G9_q=FrOHVbz0axR8G6izB2Rvku1k6bRjJ6rMrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bl8CjiHBfOoF9JLC"
Content-Disposition: inline
In-Reply-To: <CAGXu5j+Z_n1G9_q=FrOHVbz0axR8G6izB2Rvku1k6bRjJ6rMrA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59561
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

--Bl8CjiHBfOoF9JLC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 03:23:34PM -0700, Kees Cook wrote:
> On Fri, Aug 11, 2017 at 1:56 PM, James Hogan <james.hogan@imgtec.com> wro=
te:
> > Add a PTRACE_SET_SYSCALL ptrace operation to allow the system call to be
> > cancelled independently to the value of the v0 system call number
> > register.
> >
> > This is needed for SECCOMP_RET_TRACE when the tracer wants to cancel the
> > system call, since it has to set both the system call number to -1 and
> > the chosen return value, both of which reside in the same register (v0).
> > The tracer should set the return value first, followed by
> > PTRACE_SET_SYSCALL to set the system call number to -1.
> >
> > That is in contrast to the normal ptrace syscall hook which triggers the
> > tracer on both entry and exit, allowing the system call to be cancelled
> > during the entry hook (setting system call number register to -1, or
> > optionally using PTRACE_SET_SYSCALL), separately to setting the return
> > value during the exit hook.
> >
> > Positive values (to change the syscall that should be executed instead
> > of cancelling it entirely) are explicitly disallowed at the moment. The
> > same thing can be done safely already by writing the v0 system call
> > number register and the argument registers, and allowing
> > thread_info::syscall to be changed to a different value independently of
> > the v0 register would potentially allow seccomp or the syscall trace
> > events to be fooled into thinking a different system call was being
> > executed.
>=20
> Wouldn't the sycall be reloaded, so no spoofing could occur?

The case I was thinking of was:
- PTRACE_POKEUSR v0 =3D __NR_some_disallowed_syscall
- PTRACE_SET_SYSCALL __NR_some_allowed_syscall

syscall_get_nr() will return __NR_some_allowed_syscall, so seccomp will
allow, but when syscall_trace_enter() returns to syscall_trace_entry in
arch/mips/kernel/scall32-o32.S, it will reload the syscall number from
v0 (i.e. __NR_some_disallowed_syscall).

>=20
> Regardless, can you update
> tools/testing/selftests/seccomp/seccomp_bpf.c to update or eliminate
> the MIPS-only SYSCALL_NUM_RET_SHARE_REG special-case? (Or maybe it
> needs to be further special-cased to split syscall-changing from
> syscall-cancelling?)

Sure, i'll look into that,

Thanks for reviewing,

Cheers
James

>=20
> -Kees
>=20
> >
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: linux-mips@linux-mips.org
> > ---
> >  arch/mips/include/uapi/asm/ptrace.h |  1 +
> >  arch/mips/kernel/ptrace.c           | 11 +++++++++++
> >  arch/mips/kernel/ptrace32.c         | 11 +++++++++++
> >  3 files changed, 23 insertions(+)
> >
> > diff --git a/arch/mips/include/uapi/asm/ptrace.h b/arch/mips/include/ua=
pi/asm/ptrace.h
> > index 91a3d197ede3..23af103c4e8d 100644
> > --- a/arch/mips/include/uapi/asm/ptrace.h
> > +++ b/arch/mips/include/uapi/asm/ptrace.h
> > @@ -58,6 +58,7 @@ struct pt_regs {
> >
> >  #define PTRACE_GET_THREAD_AREA 25
> >  #define PTRACE_SET_THREAD_AREA 26
> > +#define PTRACE_SET_SYSCALL     27
> >
> >  /* Calls to trace a 64bit program from a 32bit program.         */
> >  #define PTRACE_PEEKTEXT_3264   0xc0
> > diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> > index 465fc5633e61..9bf31a990c6e 100644
> > --- a/arch/mips/kernel/ptrace.c
> > +++ b/arch/mips/kernel/ptrace.c
> > @@ -853,6 +853,17 @@ long arch_ptrace(struct task_struct *child, long r=
equest,
> >                 ret =3D put_user(task_thread_info(child)->tp_value, dat=
alp);
> >                 break;
> >
> > +       case PTRACE_SET_SYSCALL:
> > +               /*
> > +                * This is currently only useful to cancel the syscall =
=66rom a
> > +                * seccomp RET_TRACE tracer.
> > +                */
> > +               if ((long)data >=3D 0)
> > +                       return -EINVAL;
> > +               task_thread_info(child)->syscall =3D -1;
> > +               ret =3D 0;
> > +               break;
> > +
> >         case PTRACE_GET_WATCH_REGS:
> >                 ret =3D ptrace_get_watch_regs(child, addrp);
> >                 break;
> > diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
> > index 2b9260f92ccd..cca76aec9c10 100644
> > --- a/arch/mips/kernel/ptrace32.c
> > +++ b/arch/mips/kernel/ptrace32.c
> > @@ -287,6 +287,17 @@ long compat_arch_ptrace(struct task_struct *child,=
 compat_long_t request,
> >                                 (unsigned int __user *) (unsigned long)=
 data);
> >                 break;
> >
> > +       case PTRACE_SET_SYSCALL:
> > +               /*
> > +                * This is currently only useful to cancel the syscall =
=66rom a
> > +                * seccomp RET_TRACE tracer.
> > +                */
> > +               if ((long)data >=3D 0)
> > +                       return -EINVAL;
> > +               task_thread_info(child)->syscall =3D -1;
> > +               ret =3D 0;
> > +               break;
> > +
> >         case PTRACE_GET_THREAD_AREA_3264:
> >                 ret =3D put_user(task_thread_info(child)->tp_value,
> >                                 (unsigned long __user *) (unsigned long=
) data);
> > --
> > 2.13.2
> >
>=20
>=20
>=20
> --=20
> Kees Cook
> Pixel Security

--Bl8CjiHBfOoF9JLC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlmRcEcACgkQbAtpk944
dnpLRw//YmbX0+UEBZF6f39Nhrsr+Tp/WqIKu+kOGT8duf3wQbB/MnKlusAsvHh9
nOD1ebs/7KGj5t22krBOrOZEAIbbo/W22BxwFcXzRdiyoXCLFI7arbr41oHOfW/7
QawLBHAUPqcH9cut07NjIuBQ7JhO1ecfBYLtkmeJtp6eXXeHWYBR597waCJq5LBM
07a3n2I/neOX7MsKDg3b4G425XFjZhAxj5a6vwep5xfY3RUSkXOXxwO/1qlIuw2s
+z0S+onYY4r7aLyGrWmen3RnoEJ60jSNBLPHuQr92O/mg3bYwBjHtbqYi4+3LkEA
lk5zhAMkWJnW0sixGx+q9BJ4PVhpvxQwaOTbQfdyhqlQP8rmhvM7pfLQAMiWj7kr
aap0tpy0kzJdMTrw/qWeQEnxHc3lM+x9kW7gD/lVr5fnrXRkXhK6CqXAzNymlIPx
2ZFyQOBgXP8z5dlnbdlfhGuB8fZBLrfA6v59cJQGZi57CXm+07TUsk48mcG5siMx
9MdzQ5wejiG+Dw7eD3dLQ12GWJhzfOE+0ZkvnUUFs8qcT6jeG3ipZ89it7Y+FqaP
T4gp0j04VDeu0FEx+kZ8LUAUw/cATyNd6ocEQ4QYroGL5ZywodRp4yhFaMrpp0My
ADbx86lQKwpWNUncAGZOMwqip+ZAdBtUqDUv/ZkWlEmbJO/2ygc=
=vJpe
-----END PGP SIGNATURE-----

--Bl8CjiHBfOoF9JLC--

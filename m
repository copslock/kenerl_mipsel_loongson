Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 12:11:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7568 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992267AbdAMLLr05DG- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 12:11:47 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0C55B41F8DB4;
        Fri, 13 Jan 2017 12:14:12 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 13 Jan 2017 12:14:12 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 13 Jan 2017 12:14:12 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D76152A6EAF16;
        Fri, 13 Jan 2017 11:11:38 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 13 Jan
 2017 11:11:41 +0000
Date:   Fri, 13 Jan 2017 11:11:41 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: ptrace: protect watchpoint handling code from
 setting watchpoints
Message-ID: <20170113111141.GL10569@jhogan-linux.le.imgtec.org>
References: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3gNIKMlg37D5iFb5"
Content-Disposition: inline
In-Reply-To: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56299
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

--3gNIKMlg37D5iFb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcin,

On Fri, Jan 13, 2017 at 08:44:46AM +0100, Marcin Nowakowski wrote:
> With certain EVA configurations it is possible for the kernel address
> space to overlap user address space, which allows the user to set
> watchpoints on kernel addresses via ptrace.
>=20
> If a watchpoint is set in the watch exception handling code (after
> exception level has been cleared) then the system will hang in an
> infinite loop when hitting a watchpoint while trying to process it.
>=20
> To prevent that place all watch exception entry/exit code in a single
> named section and disallow placing watchpoints in that area.

An interesting approach. If I understand correctly, any watch placed on
watch exception entry code up to when watchpoints are disabled in
do_watch and interrupts re-enabled is disallowed, as well as the code
after watchpoints are restored.

Should mips_install_watch_registers() also move into that section?

Should do_watch be made notrace too, so we don't get calls into
unprotected ftrace code?

>=20
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
>  arch/mips/kernel/entry.S       |  2 +-
>  arch/mips/kernel/genex.S       |  2 ++
>  arch/mips/kernel/ptrace.c      | 14 ++++++++++++++
>  arch/mips/kernel/traps.c       |  2 ++
>  arch/mips/kernel/vmlinux.lds.S |  8 ++++++++
>  5 files changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> index 7791840..ef69a64 100644
> --- a/arch/mips/kernel/entry.S
> +++ b/arch/mips/kernel/entry.S
> @@ -24,7 +24,7 @@
>  #define __ret_from_irq	ret_from_exception
>  #endif
> =20
> -	.text
> +	.section .text..no_watch
>  	.align	5
>  #ifndef CONFIG_PREEMPT
>  FEXPORT(ret_from_exception)
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index dc0b296..102a9e8 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -433,6 +433,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
>  	BUILD_HANDLER msa msa sti silent		/* #21 */
>  	BUILD_HANDLER mdmx mdmx sti silent		/* #22 */
> +.section .text..no_watch
>  #ifdef	CONFIG_HARDWARE_WATCHPOINTS
>  	/*
>  	 * For watch, interrupts will be enabled after the watch
> @@ -442,6 +443,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  #else
>  	BUILD_HANDLER watch watch sti verbose		/* #23 */
>  #endif
> +.previous
>  	BUILD_HANDLER mcheck mcheck cli verbose		/* #24 */
>  	BUILD_HANDLER mt mt sti silent			/* #25 */
>  	BUILD_HANDLER dsp dsp sti silent		/* #26 */
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index c8ba260..1c8d75c 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -235,6 +235,17 @@ int ptrace_get_watch_regs(struct task_struct *child,
>  	return 0;
>  }
> =20
> +static int ptrace_watch_in_watch_code_region(unsigned long addr)
> +{
> +	extern unsigned long __nowatch_text_start, __nowatch_text_end;
> +	unsigned long start, end;
> +
> +	start =3D (((unsigned long)&__nowatch_text_start) & ~MIPS_WATCHLO_IRW);
> +	end =3D (((unsigned long)&__nowatch_text_end) & ~MIPS_WATCHLO_IRW);
> +
> +	return addr >=3D start && addr < end;
> +}
> +
>  int ptrace_set_watch_regs(struct task_struct *child,
>  			  struct pt_watch_regs __user *addr)
>  {
> @@ -262,6 +273,9 @@ int ptrace_set_watch_regs(struct task_struct *child,
>  				return -EINVAL;
>  		}
>  #endif
> +		if (ptrace_watch_in_watch_code_region(lt[i]))
> +			return -EINVAL;

This would apparently permit userland to probe for the address of the
kernel on EVA kernels, regardless of KASLR (assuming that works with
EVA). Perhaps in that case we should be more restrictive and disallow
any watchpoints in the same segment as the kernel.

Actually for stable kernel purposes, it might be better to do that
first, i.e. disallow any to the same segments as kernel (tagged for
stable), then relax it as you've done here.

> +
>  		__get_user(ht[i], &addr->WATCH_STYLE.watchhi[i]);
>  		if (ht[i] & ~MIPS_WATCHHI_MASK)
>  			return -EINVAL;
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 6c7f9d7..b86ce85 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1509,6 +1509,8 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
>   * Called with interrupts disabled.
>   */
>  asmlinkage void do_watch(struct pt_regs *regs)
> +	__attribute__((section(".text..no_watch")));

maybe worth a macro, especially if any other functions do need this.

is a separate declaration really needed? could it go after void in the
definition like notrace does?

Cheers
James

> +asmlinkage void do_watch(struct pt_regs *regs)
>  {
>  	siginfo_t info =3D { .si_signo =3D SIGTRAP, .si_code =3D TRAP_HWBKPT };
>  	enum ctx_state prev_state;
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.ld=
s.S
> index d5de675..f76f481 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -32,6 +32,13 @@ PHDRS {
>  	jiffies	 =3D jiffies_64;
>  #endif
> =20
> +#define NOWATCH_TEXT							\
> +		ALIGN_FUNCTION();					\
> +		VMLINUX_SYMBOL(__nowatch_text_start) =3D .;		\
> +		*(.text..no_watch)					\
> +		VMLINUX_SYMBOL(__nowatch_text_end) =3D .;
> +
> +
>  SECTIONS
>  {
>  #ifdef CONFIG_BOOT_ELF64
> @@ -54,6 +61,7 @@ SECTIONS
>  	_text =3D .;	/* Text and read-only data */
>  	.text : {
>  		TEXT_TEXT
> +		NOWATCH_TEXT
>  		SCHED_TEXT
>  		CPUIDLE_TEXT
>  		LOCK_TEXT
> --=20
> 2.7.4
>=20

--3gNIKMlg37D5iFb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYeLXmAAoJEGwLaZPeOHZ6H8YP+gKIO1CDnbPHuy0fpUvQJNEp
2eVHOnCJ9FfIAqiHHDP9uQukRq01DvVd8N9gp7Cr8OYI3LeA3hSyHy6JSc6nTbRZ
GMeCmPUGCXmHFb7n3Q1n5c0nMOko9GodCp4+/kYz8NhKhFIbxdFKSqvEuqv4SKrp
SQnvJiaogolewBjxx+v38nrZrz/97YJ24bbSbAWAKjKolwvx0nqD3EnmyTaj2e/G
Zg6HoOd4YsAPjp9Cve/ioY3/3DUdCVvPWkKvkrklpsn/DJ25nQRAbwYAiAu5JkR0
RwmLpT0xwMqKTOvI6opZ+dv5pSnk/+rKjDmBZMM7yJBPUyMjycU5y2Dw4sXeYuMX
0vskW9uYm8Tv3zykLUCN7JVST0Lm6v3uWsEFKDnekJzhzCqxNAX+SRJsgHuKKY8n
AlHPMIwmuRTrHHsYTibVdhVJQXUSZMuD5Ij+6ledXUleKrBLsSvkJ3z0x9viXnta
sE6vEgsJLTEFKcaDQk9H4nR5N/svcU49hbJbQav03TacCJv4U+21GTv5rLiNOqHW
vydA7iajEKi7T3Wr704yRhwLQtapAN47cjI9y0heBkesyZrgTTs53JRRkYOXKsbJ
sYeJPtPVQmWrQA8q4TOnqFV8QkSeFpDk5ucB+N4vnJ4C0tzcX47oxZ9QPRhYnlDp
H8t2eMfdlKfTcdfAQhry
=yxg/
-----END PGP SIGNATURE-----

--3gNIKMlg37D5iFb5--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 12:42:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34937 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993940AbdAMLmY6zZEn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 12:42:24 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id AA41641F8DB4;
        Fri, 13 Jan 2017 12:44:49 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 13 Jan 2017 12:44:49 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 13 Jan 2017 12:44:49 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 643E79A7218DB;
        Fri, 13 Jan 2017 11:42:16 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 13 Jan
 2017 11:42:18 +0000
Date:   Fri, 13 Jan 2017 11:42:18 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: ptrace: disable watchpoints if hit in kernel
 mode
Message-ID: <20170113114218.GM10569@jhogan-linux.le.imgtec.org>
References: <1484293487-5770-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1484293487-5770-2-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HUNbJr+8XKUS5qN7"
Content-Disposition: inline
In-Reply-To: <1484293487-5770-2-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56301
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

--HUNbJr+8XKUS5qN7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 08:44:47AM +0100, Marcin Nowakowski wrote:
> If a watchpoint is hit when in kernel mode it is possible for the system
> to end up in an infinite loop processing the watchpoint. This can happen
> if a user sets a watchpoint in the kernel addess space (which is
> possible in certain EVA configurations) or if a user sets a watchpoint
> in a user area accessed directly by the kernel (eg. a user buffer
> accessed via a syscall).
>=20
> To prevent the infinite loop ensure that the watchpoint was hit in
> userspace, and clear the watchpoint registers otherwise.
>=20
> As this change could mean that a watchpoint is not hit when it should be
> (when returning to the interrupted traced task on exception exit), the
> resume_userspace path needs to be extended to conditionally restore the
> watchpoint configuration. If a task switch occurs when returning to
> userspace, the watchpoints will be restored in a typical way in the
> switch_to() handler.
>=20
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
>  arch/mips/kernel/entry.S | 9 ++++++++-
>  arch/mips/kernel/traps.c | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> index ef69a64..b15a9a9 100644
> --- a/arch/mips/kernel/entry.S
> +++ b/arch/mips/kernel/entry.S
> @@ -55,7 +55,14 @@ resume_userspace:
>  	LONG_L	a2, TI_FLAGS($28)	# current->work
>  	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
>  	bnez	t0, work_pending
> -	j	restore_all
> +#ifdef CONFIG_HARDWARE_WATCHPOINTS
> +	li	t0, _TIF_LOAD_WATCH
> +	and	t0, a2, t0
> +	beqz	t0, 1f
> +	PTR_L	a0, TI_TASK($28)
> +	jal	mips_install_watch_registers
> +#endif

Perhaps this should also be conditional upon EVA, otherwise the return
to userland path would get unnecessarily slower whenever watchpoints are
enabled.


TBH my worry with this general approach is that it permits userland to
mess with kernel assumptions in quite controlled and unexpected ways.
For example, it allows userland to inject temporary enabling of
interrupts at any point, e.g. in a spin_lock_irq() critical section
somewhere.

Perhaps that specific case can be worked around by having do_watch leave
interrupts disabled if they were already disabled when the exception was
taken. resume_kernel won't call preempt_schedule_irq() if IRQs are
disabled in the context being restored.

The other issue is I think it only really considers instruction watches
(hardware breakpoints). What about if userland put a data watchpoint on
a kernel stack address that gets hit in do_watch()'s prologue (i.e.
after EXL=3D0)? That can't be placed in a dedicated section, and would be
tricky to specifically exclude (would fork result in a new kernel stack
pointer and also preserve watch points?), and doing so would potentially
leak the process' kernel stack pointer too (regardless of KASLR),
presumably a valuable target for an exploit.

Cheers
James

> +1:	j	restore_all
> =20
>  #ifdef CONFIG_PREEMPT
>  resume_kernel:
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index b86ce85..d92169e 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1527,7 +1527,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
>  	 * their values and send SIGTRAP.  Otherwise another thread
>  	 * left the registers set, clear them and continue.
>  	 */
> -	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
> +	if (user_mode(regs) && test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
>  		mips_read_watch_registers();
>  		local_irq_enable();
>  		force_sig_info(SIGTRAP, &info, current);
> --=20
> 2.7.4
>=20

--HUNbJr+8XKUS5qN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYeL0aAAoJEGwLaZPeOHZ6nOUP/jD3Ak1i3d1aS73QqwWoPi40
MZkuQHcW6WWlp8zrkr/7Rs7EEaJgXOFTOo41ojIKSQ5oUaBXMy6y4cCOlB4yNlo6
Jvlfw7izDw/+03xifNzrDu9Kk9u3etSq2JYG/HBkGb8ixDXqbojDebmNBHKz6o5I
ojKTpYPLbr/Jbfm8Z3F9CTZFEWizp4hCeVj3850XGSnTpGRHNVv1E9N5pMrPemZW
6NnL6HvjuldPRLXZfweCpWJOKhUSpEYOTBEjcjDEMe2GuhIoJkdbPB4kDrReIxJZ
uDUU6NZOT/12ZDBTwR034MAf32X/Ht7n2jHjqIkUS6tC0YmhYpiPMy8L955Wx/E/
kDC5zQPolqzpVBB/tFvobua1F5ZRQkShDwdiCc72/RGu5mCWKeho3g+lEQqSHBnf
Z2le2CrnY5CbMcBiXR1NfAxiq4db63za7O90WuNOra6rckfwOgua4bmjRCSmcyRx
6WC18AZTuEAURx27iuYQEHHpiUlCdW3qf1jhxqGiAJ7veg+HRyWDpwla1eHILWK2
bnz02feQ2JrllcERIoBpXd/XzYV+tsqAcoMjYvk1q8h48hP4bpQEAXffDLVaT/fC
qL9BA0qICGMETG1bB4EWoFL3gQOtPLcavhFfQOqLC5Mj9h+sw2I949Wb0cYrNXE8
9Sa+VVkkG+UPKv61/Cfd
=uCrP
-----END PGP SIGNATURE-----

--HUNbJr+8XKUS5qN7--

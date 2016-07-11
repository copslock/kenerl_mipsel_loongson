Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2016 11:31:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40169 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992579AbcGKJbEH2PB1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jul 2016 11:31:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 477E241F8E08;
        Mon, 11 Jul 2016 10:30:58 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 11 Jul 2016 10:30:58 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 11 Jul 2016 10:30:58 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BB66070839E59;
        Mon, 11 Jul 2016 10:30:55 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 11 Jul
 2016 10:30:57 +0100
Date:   Mon, 11 Jul 2016 10:30:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     <yhb@ruijie.com.cn>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: MIPS: We need to clear MMU contexts of all other processes when
 asid_cache(cpu) wraps to 0.
Message-ID: <20160711093057.GB17625@jhogan-linux.le.imgtec.org>
References: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: cee91754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54278
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

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 10, 2016 at 01:04:47PM +0000, yhb@ruijie.com.cn wrote:
> From cd1eb951d4a7f01aaa24d2fb902f06b73ef4f608 Mon Sep 17 00:00:00 2001
> From: yhb <yhb@ruijie.com.cn>
> Date: Sun, 10 Jul 2016 20:43:05 +0800
> Subject: [PATCH] MIPS: We need to clear MMU contexts of all other process=
es
>  when asid_cache(cpu) wraps to 0.
>=20
> Suppose that asid_cache(cpu) wraps to 0 every n days.
> case 1:
> (1)Process 1 got ASID 0x101.
> (2)Process 1 slept for n days.
> (3)asid_cache(cpu) wrapped to 0x101, and process 2 got ASID 0x101.
> (4)Process 1 is woken,and ASID of process 1 is same as ASID of process 2.
>=20
> case 2:
> (1)Process 1 got ASID 0x101 on CPU 1.
> (2)Process 1 migrated to CPU 2.
> (3)Process 1 migrated to CPU 1 after n days.
> (4)asid_cache on CPU 1 wrapped to 0x101, and process 2 got ASID 0x101.
> (5)Process 1 is scheduled, and ASID of process 1 is same as ASID of proce=
ss 2.
>=20
> So we need to clear MMU contexts of all other processes when asid_cache(c=
pu) wraps to 0.
>=20
> Signed-off-by: yhb <yhb@ruijie.com.cn>
> ---
>  arch/blackfin/kernel/trace.c               |  7 ++--
>  arch/frv/mm/mmu-context.c                  |  6 ++--
>  arch/mips/include/asm/mmu_context.h        | 53 ++++++++++++++++++++++++=
++++--
>  arch/um/kernel/reboot.c                    |  5 +--
>  block/blk-cgroup.c                         |  6 ++--
>  block/blk-ioc.c                            | 17 ++++++----
>  drivers/staging/android/ion/ion.c          |  5 +--
>  drivers/staging/android/lowmemorykiller.c  | 15 +++++----
>  drivers/staging/lustre/lustre/ptlrpc/sec.c |  5 +--
>  drivers/tty/tty_io.c                       |  6 ++--
>  fs/coredump.c                              |  5 +--
>  fs/exec.c                                  | 17 ++++++----
>  fs/file.c                                  | 16 +++++----
>  fs/fs_struct.c                             | 16 +++++----
>  fs/hugetlbfs/inode.c                       |  6 ++--
>  fs/namespace.c                             |  5 +--
>  fs/proc/array.c                            |  5 +--
>  fs/proc/base.c                             | 40 +++++++++++++---------
>  fs/proc/internal.h                         |  5 +--
>  fs/proc/proc_net.c                         |  6 ++--
>  fs/proc/task_mmu.c                         |  5 +--
>  fs/proc_namespace.c                        |  9 ++---
>  include/linux/cpuset.h                     |  8 ++---
>  include/linux/nsproxy.h                    |  6 ++--
>  include/linux/oom.h                        |  3 +-
>  include/linux/sched.h                      |  8 ++---
>  ipc/namespace.c                            |  5 +--
>  kernel/cgroup.c                            |  5 +--
>  kernel/cpu.c                               |  5 +--
>  kernel/cpuset.c                            |  7 ++--
>  kernel/exit.c                              | 19 +++++++----
>  kernel/fork.c                              | 32 +++++++++++-------
>  kernel/kcmp.c                              |  5 +--
>  kernel/nsproxy.c                           |  5 +--
>  kernel/ptrace.c                            | 11 ++++---
>  kernel/sched/debug.c                       |  5 +--
>  kernel/sys.c                               | 16 +++++----
>  kernel/utsname.c                           |  5 +--
>  mm/memcontrol.c                            |  5 +--
>  mm/mempolicy.c                             | 46 ++++++++++++++++--------=
--
>  mm/mmu_context.c                           | 10 +++---
>  mm/oom_kill.c                              | 37 ++++++++++++---------
>  net/core/net_namespace.c                   | 11 ++++---
>  net/core/netclassid_cgroup.c               |  6 ++--
>  net/core/netprio_cgroup.c                  |  5 +--
>  45 files changed, 337 insertions(+), 188 deletions(-)

[snip / reorder]

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 52c4847..9e643fd 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2769,14 +2769,14 @@ static inline int thread_group_empty(struct task_=
struct *p)
>   * It must not be nested with write_lock_irq(&tasklist_lock),
>   * neither inside nor outside.
>   */
> -static inline void task_lock(struct task_struct *p)
> +static inline void task_lock(struct task_struct *p, unsigned long *irqfl=
ags)
>  {
> -	spin_lock(&p->alloc_lock);
> +	spin_lock_irqsave(&p->alloc_lock, *irqflags);

Since most of the patch is relating to this change, which is only a
means to an end, I suggest some changes if you stick to this approach
(but see my comments below too):

1) Please separate the change to use _irqsave/_irqrestore (and pass in
irqflags parameter) from whatever else this patch contains (presumably
only the arch/mips/include/asm/mmu_context.h change).

2) Please provide some explanation for why the irqsave change is
necessary. Presumably its due to the desire to lock tasks between irq
context (when context switching, in order to clear all *other* task's
asids) and the various other places.

3) This will affect other arches which don't need the irqsave at all,
which will bloat the kernel slightly unnecessarily. We should consider
if it can/should be made MIPS specific, and whether it can be avoided
entirely.

[snip / reorder]

> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/=
mmu_context.h
> index 45914b5..68966b5 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -12,6 +12,7 @@
>  #define _ASM_MMU_CONTEXT_H
> =20
>  #include <linux/errno.h>
> +#include <linux/oom.h>/* find_lock_task_mm */
>  #include <linux/sched.h>
>  #include <linux/smp.h>
>  #include <linux/slab.h>
> @@ -97,6 +98,52 @@ static inline void enter_lazy_tlb(struct mm_struct *mm=
, struct task_struct *tsk)
>  #define ASID_VERSION_MASK  ((unsigned long)~(ASID_MASK|(ASID_MASK-1)))
>  #define ASID_FIRST_VERSION ((unsigned long)(~ASID_VERSION_MASK) + 1)
> =20
> +/*
> + * Yu Huabing
> + * Suppose that asid_cache(cpu) wraps to 0 every n days.
> + * case 1:
> + * (1)Process 1 got ASID 0x101.
> + * (2)Process 1 slept for n days.
> + * (3)asid_cache(cpu) wrapped to 0x101, and process 2 got ASID 0x101.
> + * (4)Process 1 is woken,and ASID of process 1 is same as ASID of proces=
s 2.
> + *
> + * case 2:
> + * (1)Process 1 got ASID 0x101 on CPU 1.
> + * (2)Process 1 migrated to CPU 2.
> + * (3)Process 1 migrated to CPU 1 after n days.
> + * (4)asid_cache on CPU 1 wrapped to 0x101, and process 2 got ASID 0x101.
> + * (5)Process 1 is scheduled,and ASID of process 1 is same as ASID of pr=
ocess 2.
> + *
> + * So we need to clear MMU contexts of all other processes when asid_cac=
he(cpu)
> + * wraps to 0.
> + *
> + * This function might be called from hardirq context or process context.
> + */
> +static inline void clear_other_mmu_contexts(struct mm_struct *mm,
> +						unsigned long cpu)
> +{
> +	struct task_struct *p;
> +	unsigned long irqflags;
> +
> +	read_lock(&tasklist_lock);
> +	for_each_process(p) {
> +		struct task_struct *t;
> +
> +		/*
> +		 * Main thread might exit, but other threads may still have
> +		 * a valid mm. Find one.
> +		 */
> +		t =3D find_lock_task_mm(p, &irqflags);
> +		if (!t)
> +			continue;
> +
> +		if (t->mm !=3D mm)
> +			cpu_context(cpu, t->mm) =3D 0;
> +		task_unlock(t, &irqflags);
> +	}
> +	read_unlock(&tasklist_lock);
> +}
> +
>  /* Normal, classic MIPS get_new_mmu_context */
>  static inline void
>  get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
> @@ -112,8 +159,10 @@ get_new_mmu_context(struct mm_struct *mm, unsigned l=
ong cpu)
>  #else
>  		local_flush_tlb_all();	/* start new asid cycle */
>  #endif
> -		if (!asid)		/* fix version if needed */
> -			asid =3D ASID_FIRST_VERSION;
> +		if (!asid) {
> +			asid =3D ASID_FIRST_VERSION; /* fix version if needed */
> +			clear_other_mmu_contexts(mm, cpu);
> +		}
>  	}
> =20
>  	cpu_context(cpu, mm) =3D asid_cache(cpu) =3D asid;

Thank you for pointing out this issue. Clearly it needs to be fixed.

Would it be sufficient/better though to expand the ASID to 64-bit with
e.g. u64 (i.e. even on 32-bit MIPS kernels), and maybe enforce that the
ASID is stored shifted to the least significant bits, rather than in a
form that can be directly written to EntryHi?

Even at 2GHz with an ASID generated every CPU cycle (completely
unrealistic behaviour), it'd still take 292 years before we'd hit this
problem.

That would increase overhead slightly in the common cases around ASID
handling rather than the exceptional overflow case, but would avoid the
additional overhead needed around task locking.

Cheers
James

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXg2dRAAoJEGwLaZPeOHZ6EfIQAJMzYMOcoeWYInZ4Mm0nHEUU
YgsVvbW2lftqJkflp0+lL1Xzko8dxKzQ8R3LVRLozemJvxScHgvWRO9YM3/t/UNF
SxrXmcqQkxPtikarKqFvxYy2BPQMmDBDuMfNDpxA7S650zAkxxHJAfYazJh3WzUW
zUWq7ruvb2i/09+hq/JXcHbe3IiQHo3w2Ynw/K7M/E5VBMqD1AFhLp4zulzg1O22
Otb17Ph2Xgf0lwXcl1OkWLZuKKJaNjU45yOF0kZpelVgIiCPyhf1/lniM04z6HoL
bw5x+olHIin9jvmplvfDGsdECBWOhImYKYL84F0PGlUt8DUoEgFbE/CX66W5K8pF
tKKciap4stFbP8PbB7h0wPSi+dakm6k0A7y28h8/cxkKgQYnfdmqi9DEOSfGccUe
Vb7sq4mQUff69m1W7pbFX9C3wImoN7jTBE6GeBiZ9pCXmtGbdzvH0/xr2EGIeqqy
YVXOieXDG9dxP32MNwMRsa4nSipMkNCbWGA5J6ubFcZ6ZKBqW8AQDW0rQObwsSNA
aTFrKAZWTvfYWvtzFJpok2rZbhPWaZrruIFQhD0TGCO1M5KV4+vGCVHq5QFX2ESp
9ZDWOg00nCHNb6cjkyVWRJRDXadqO+boQJdQhByRCaR93o2AOaD/0hId1HkMLOyo
tNqinR93bUFFo7/iQWET
=uoV/
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

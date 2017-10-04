Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Oct 2017 04:46:26 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35751 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdJDCqQF6f3A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Oct 2017 04:46:16 +0200
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dzZhO-0006hx-6H; Wed, 04 Oct 2017 03:46:15 +0100
Date:   Wed, 4 Oct 2017 03:46:14 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Message-ID: <20171004024614.GC2971@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [RFC PATCH] MIPS: cmpxchg64() and HAVE_VIRT_CPU_ACCOUNTING_GEN don't
 work for 32-bit SMP
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

__cmpxchg64_local_generic() is atomic only w.r.t tasks and interrupts
on the same CPU (that's what the 'local' means).  We can't use it to
implement cmpxchg64() in SMP configurations.

So, for 32-bit SMP configurations:

- Don't define cmpxchg64()
- Don't enable HAVE_VIRT_CPU_ACCOUNTING_GEN, which requires it

Fixes: e2093c7b03c1 ("MIPS: Fall back to generic implementation of ...")
Fixes: bb877e96bea1 ("MIPS: Add support for full dynticks CPU time accounti=
ng")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/Kconfig               | 2 +-
 arch/mips/include/asm/cmpxchg.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cb7fcc4216fd..1e23f8455b7d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -64,7 +64,7 @@ config MIPS
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select MODULES_USE_ELF_REL if MODULES
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxch=
g.h
index 903f3bf48419..ae2b4583b486 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -202,8 +202,10 @@ static inline unsigned long __cmpxchg(volatile void *p=
tr, unsigned long old,
 #else
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (=
n))
+#ifndef CONFIG_SMP
 #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
 #endif
+#endif
=20
 #undef __scbeqz
=20

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWdRLdee/yOyVhhEJAQorxRAAhJ07FBUYKq7uZGcLYKxPZJbGgJtBXP4F
3Og7KAKnT4gpGx61DlR+UT+HzsI4b5As8/9fkd+JLc+Pe/Q3ehLGCoZxVMMNlKOw
F9oRLlcxwfJESjtZ6LKpXakx0tj38eThQ7+uBJhhPzk5nFfOSJ/pumCQCAEQ/EO5
JM3FC25AniXMr+oVDaX1IQWMwv1fWLCBarF5AweerLvyPsm6ctAEKgZyI8CgO3SD
k4AEywk3cv+cy8xpq03bLSBVSCiOvLLE9H0LFn1Mt/au2t61ng+vzND3m8Lkfttl
9HCf71wkcg52EdxPCPSkxFhkw6rCAbJ5D8RGP2cntqVbjJBuuM9Ger0srY+GcTna
mldZjTCXJni2u+/HOnY1n0IMsy8Mekk2pmfBFpz4ZcvTaOCWMorG3LaDIyT3DroQ
0eoggsbPuOz1AKQ30NCYMSTDt+fCOQEsztHf5cd+q6j9wnyY9eqmIXQNcErrNsFD
jmhM1+NLIL6cdjNlSDmKddRi1SqLQaLZjTpWdr6lbEip+ArL0RGYNRAdiOUaDxvV
em7fJqJkRafhWFMgYkmXwTjoPkcyNSMYsJnXg6QwqW6mRS4YroyftxIbDjYsUQK6
2AISE38tnhgmMYXIm1Gw7UrB7VXD7PeFL5Ak4/Xfg/5l1LAQoB0XdthjcofIWQ6Y
8PvOa932uvs=
=iZCK
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--

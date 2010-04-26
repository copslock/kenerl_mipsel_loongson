Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 06:53:42 +0200 (CEST)
Received: from ppa04.Princeton.EDU ([128.112.128.215]:37523 "EHLO
        ppa04.Princeton.EDU" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491057Ab0DZExh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Apr 2010 06:53:37 +0200
Received: from smtpserver1.Princeton.EDU (smtpserver1.Princeton.EDU [128.112.129.65])
        by ppa04.Princeton.EDU (8.14.3/8.14.3) with ESMTP id o3Q4rZ5r006375;
        Mon, 26 Apr 2010 00:53:35 -0400
Received: from tetra.ee.Princeton.EDU (tetra.ee.Princeton.EDU [128.112.49.188])
        (authenticated bits=0)
        by smtpserver1.Princeton.EDU (8.12.9/8.12.9) with ESMTP id o3Q4rXiZ008485
        (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
        Mon, 26 Apr 2010 00:53:34 -0400 (EDT)
Received: from penta.localdomain (nat04-resnet-ext.rutgers.edu [192.12.88.4])
        (authenticated bits=0)
        by tetra.ee.Princeton.EDU (8.14.3/8.14.3/Debian-9) with ESMTP id o3Q4rUaM025426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Apr 2010 00:53:32 -0400
Received: from penta.localdomain (tcp@localhost.localdomain [127.0.0.1])
        by penta.localdomain (8.14.3/8.14.3/Debian-9.1) with ESMTP id o3Q4rErJ003215;
        Mon, 26 Apr 2010 00:53:25 -0400
Date:   Mon, 26 Apr 2010 00:53:10 -0400
From:   Yury Polyanskiy <ypolyans@princeton.edu>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] die() does not call die notifier chain
Message-ID: <20100426005310.0786273f@penta.localdomain>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/QOxfIid8d50t3C+JA2D/=kE"; protocol="application/pgp-signature"
Return-Path: <ypolyans@princeton.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ypolyans@princeton.edu
Precedence: bulk
X-list: linux-mips

--Sig_/QOxfIid8d50t3C+JA2D/=kE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Ralf,

I think that the arch/mips implementation of die() forgets to call the
notify_die() and thus notifiers registered via register_die_notifier()
are not called.

For example this results in kgdb not being activated on exceptions.

The patch is very simple and attached: the only subtlety is that main
notify_die declares regs argument w/o const, so I needed to remove const=20
from mips die() as well.


Best wishes,
Yury.

PS. Please CC me: I am not on the list.

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index ce47118..cdc6a46 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -142,9 +142,9 @@ extern int ptrace_set_watch_regs(struct task_struct *ch=
ild,
=20
 extern asmlinkage void do_syscall_trace(struct pt_regs *regs, int entryexi=
t);
=20
-extern NORET_TYPE void die(const char *, const struct pt_regs *) ATTRIB_NO=
RET;
+extern NORET_TYPE void die(const char *, struct pt_regs *) ATTRIB_NORET;
=20
-static inline void die_if_kernel(const char *str, const struct pt_regs *re=
gs)
+static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 {
 	if (unlikely(!user_mode(regs)))
 		die(str, regs);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4e00f9b..fdc6773 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -352,9 +352,10 @@ void show_registers(const struct pt_regs *regs)
=20
 static DEFINE_SPINLOCK(die_lock);
=20
-void __noreturn die(const char * str, const struct pt_regs * regs)
+void __noreturn die(const char * str, struct pt_regs * regs)
 {
 	static int die_counter;
+	int sig =3D SIGSEGV;
 #ifdef CONFIG_MIPS_MT_SMTC
 	unsigned long dvpret =3D dvpe();
 #endif /* CONFIG_MIPS_MT_SMTC */
@@ -365,6 +366,10 @@ void __noreturn die(const char * str, const struct pt_=
regs * regs)
 #ifdef CONFIG_MIPS_MT_SMTC
 	mips_mt_regdump(dvpret);
 #endif /* CONFIG_MIPS_MT_SMTC */
+
+	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_no, SIGSEGV) =
=3D=3D NOTIFY_STOP)
+		sig =3D 0;
+
 	printk("%s[#%d]:\n", str, ++die_counter);
 	show_registers(regs);
 	add_taint(TAINT_DIE);
@@ -379,7 +384,7 @@ void __noreturn die(const char * str, const struct pt_r=
egs * regs)
 		panic("Fatal exception");
 	}
=20
-	do_exit(SIGSEGV);
+	do_exit(sig);
 }
=20
 extern struct exception_table_entry __start___dbe_table[];

--Sig_/QOxfIid8d50t3C+JA2D/=kE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvVHDYACgkQemuRe3zuqOS1/ACeIZoaRsF8Jo2KFZFhTL8dUDB3
Zj8AniZXj9R2r967yFqJWe9PAdacxzyC
=ng0i
-----END PGP SIGNATURE-----

--Sig_/QOxfIid8d50t3C+JA2D/=kE--

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Nov 2010 13:31:38 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:58686 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491099Ab0KGMbe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Nov 2010 13:31:34 +0100
Received: by wyf22 with SMTP id 22so4496065wyf.36
        for <multiple recipients>; Sun, 07 Nov 2010 04:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:subject:to
         :cc:in-reply-to:x-mailer:message-id:mime-version:content-type;
        bh=21TpNNB6G5+W2+jF3xq1AqeNquwbxp1WRfh0VqwunhQ=;
        b=mwtUn/+L0A5Vc94efoYLVpeIV8Up2toc6EtXlYsw2XdCxuANqzpgOap2b95NbEmTgd
         RoG8GPku5o/TnPEgth2phRJDlRnfFY1URe+rK3s8FQog8ppDzBmawSsJZc7L/yTr3e+s
         PhBWe8+iZbMzT9UIHnlz8MKq0Aa//Dm+hKjPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:subject:to:cc:in-reply-to:x-mailer:message-id
         :mime-version:content-type;
        b=PRavX4DN7HygNEqHkzL5ntPla60HwYb6QxjY8+Ji4X72oDnSElSGhkbrES9i7ow3Le
         5Jnv0myygJ7+BWq7YX1jaMnKL1qDh3PyNtBCGAY+N9BPd1xp1CcR4DQNxfDW69yYXxGd
         CfxYJpcMoMi7NiSsGIt8QgL4ACp+sueH8sMPs=
Received: by 10.216.179.81 with SMTP id g59mr3177260wem.35.1289133088168;
        Sun, 07 Nov 2010 04:31:28 -0800 (PST)
Received: from thorin ([81.38.198.117])
        by mx.google.com with ESMTPS id w8sm2349706wei.21.2010.11.07.04.31.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 04:31:27 -0800 (PST)
Date:   Sun, 07 Nov 2010 13:30:59 +0100
From:   Robert Millan <rmh@gnu.org>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
To:     Robert Millan <rmh@gnu.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <AANLkTik3SH8EmhcgY9HNQLLk9Np+E6LGo8jVoGQiQCx4@mail.gmail.com>
        (from rmh@gnu.org on Thu Nov  4 19:43:08 2010)
X-Mailer: Balsa 2.4.1
Message-Id: <1289133059.1547.0@thorin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-sNv32FuZMrZ1rJb7Jb1J"
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

--=-sNv32FuZMrZ1rJb7Jb1J
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El 04/11/10 19:43:08, en/na Robert Millan va escriure:
> David Daney a =E9crit :
> > You are claiming that all loongson2 are loongson-2f. =A0Is that=20
> > really true? =A0Or are there other types of loongson2 that are not
> > loongson-2f?
>=20
> I'll figure out how to distinguish them and send a new patch.

I looked at details about CPU identification, and this
seems to be broken.

See the the notes about PRId in pages 72 and 66, respectively:
http://dev.lemote.com/files/resource/documents/Loongson/ls2f/Loongson2FUser=
Guide.pdf

In both 2E and 2F, the implementation field is the same (0x63).

Revision field is the same too, according to docs, and it can't
be used anyway (no garantee of consistency).

I'm sending a new patch that uses machtype instead. Yes, I know
it's a bit of a kludge, but it really seems to be the only way.

> Well I appreciate consistency with GCC flag names,

Actually, I missread GCC flag (it's dashless).  I'm using
"loongson2f" as David requested.


--=-sNv32FuZMrZ1rJb7Jb1J
Content-Type: text/x-patch; charset=us-ascii; name=loongson2f.diff
Content-Disposition: attachment; filename=loongson2f.diff
Content-Transfer-Encoding: quoted-printable


Enable AT_PLATFORM for Loongson 2F CPU.

Signed-off-by: Robert Millan <rmh@gnu.org>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 71620e1..69905d2 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -5,6 +5,7 @@
  * Copyright (C) 1994 - 2006 Ralf Baechle
  * Copyright (C) 2003, 2004  Maciej W. Rozycki
  * Copyright (C) 2001, 2004  MIPS Inc.
+ * Copyright (C) 2010  Robert Millan
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -18,6 +19,7 @@
 #include <linux/stddef.h>
 #include <linux/module.h>
=20
+#include <asm/bootinfo.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/fpu.h>
@@ -613,7 +615,30 @@ static inline void cpu_probe_legacy(struct cpuinfo_mip=
s *c, unsigned int cpu)
 		break;
 	case PRID_IMP_LOONGSON2:
 		c->cputype =3D CPU_LOONGSON2;
-		__cpu_name[cpu] =3D "ICT Loongson-2";
+		/*
+		 * On Loongson 2, PRID doesn't specify sub-class reliably.
+		 * We use machtype info passed by bootloader, when available,
+		 * or otherwise fallback to generic "ICT Loongson-2".
+		 */
+		switch (mips_machtype) {
+		case MACH_LEMOTE_FL2E:
+			__cpu_name[cpu] =3D "ICT Loongson-2E";
+			if (cpu =3D=3D 0)
+				__elf_platform =3D "loongson2e";
+			break;
+		case MACH_LEMOTE_FL2F:
+		case MACH_LEMOTE_ML2F7:
+		case MACH_LEMOTE_YL2F89:
+		case MACH_DEXXON_GDIUM2F10:
+		case MACH_LEMOTE_NAS:
+		case MACH_LEMOTE_LL2F:
+			__cpu_name[cpu] =3D "ICT Loongson-2F";
+			if (cpu =3D=3D 0)
+				__elf_platform =3D "loongson2f";
+			break;
+		default:
+			__cpu_name[cpu] =3D "ICT Loongson-2";
+		}
 		c->isa_level =3D MIPS_CPU_ISA_III;
 		c->options =3D R4K_OPTS |
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index acd3f2c..74b8c16 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -551,6 +551,14 @@ void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
 	prom_init();
+#ifdef CONFIG_MACH_LOONGSON
+	/*
+	 * On Loongson 2, CPU detection is defective. machtype
+	 * heuristics are used instead, but they only work after
+	 * prom_init().
+	 */
+	cpu_probe();
+#endif
=20
 #ifdef CONFIG_EARLY_PRINTK
 	setup_early_printk();


--=-sNv32FuZMrZ1rJb7Jb1J--

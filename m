Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 15:47:58 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:60826 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491032Ab0KKOrz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Nov 2010 15:47:55 +0100
Received: by ewy19 with SMTP id 19so1069118ewy.36
        for <multiple recipients>; Thu, 11 Nov 2010 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:subject:to
         :cc:references:in-reply-to:x-mailer:message-id:mime-version
         :content-type;
        bh=CF+CDz0EY6LLLYN6cvWUD9FP7j7zAXobvo9oOGwTjHc=;
        b=R9/2FjO8NUys0fPHYEqmxndHj0p012l6ERADux7nG0EI2O8wmY7K+DULWuA3QfJ5zq
         wshf4KVW1JByCNNqNbauAXmGzfBEjCbYWtESTYojZuLuVWkeMp3CSo11qziVn+FtNO/i
         3/nOJgZaj5JiDGj/DSnElThn3xFJMm3vE2lyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:subject:to:cc:references:in-reply-to:x-mailer
         :message-id:mime-version:content-type;
        b=XuazlcYThTdoK/wQ5mkdqLUfhZjr9dwhtdA44iDCBtQAxWlOzeu/6Ozah5vyVRdS6/
         FwPAyP91tsZEydyFv//aGi33T81/rksy2XKvIAuGmOMBo5OORrMhdv7Qdj64NhUQDipQ
         vSG0uRuns7ADJ4ybWdlxYww3ZhC5k6J1qRhe4=
Received: by 10.213.3.80 with SMTP id 16mr1883055ebm.11.1289486874302;
        Thu, 11 Nov 2010 06:47:54 -0800 (PST)
Received: from thorin ([83.45.77.222])
        by mx.google.com with ESMTPS id x54sm1994573eeh.23.2010.11.11.06.47.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:47:52 -0800 (PST)
Date:   Thu, 11 Nov 2010 15:47:35 +0100
From:   Robert Millan <rmh@gnu.org>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     wu zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
References: <1289305442.31389.0@thorin>
        <20101109154055.GD10799@linux-mips.org>
In-Reply-To: <20101109154055.GD10799@linux-mips.org> (from
        ralf@linux-mips.org on Tue Nov  9 16:40:55 2010)
X-Mailer: Balsa 2.4.1
Message-Id: <1289486855.14828.0@thorin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-JmLzlPP0kTVobA4+X7Q2"
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

--=-JmLzlPP0kTVobA4+X7Q2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El 09/11/10 16:40:55, en/na Ralf Baechle va escriure:
> Cavium introduced this idion first.  Now your patch is repeating it
> and I'm
> sure other SMP platforms will soon use it.   I don't want a thousand
> if (cpu =3D=3D 0) in that file, so can you cook a patch that introduces a
> helper, something like
>=20
> static void set_elf_platform(const char *plat)
> {
> 	if (cpu =3D=3D 0)
> 		__elf_platform =3D plat;
> }
>=20
> Then use that for all assignments to __elf_platform?  Thanks.

Here.


--=-JmLzlPP0kTVobA4+X7Q2
Content-Type: text/x-patch; charset=us-ascii; name=loongson2f.diff
Content-Disposition: attachment; filename=loongson2f.diff
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Robert Millan <rmh@gnu.org>

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index fd1d39e..58844f6 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -344,6 +344,12 @@ extern int dump_task_fpu(struct task_struct *, elf_fpr=
egset_t *);
 #define ELF_PLATFORM  __elf_platform
 extern const char *__elf_platform;
=20
+static inline void set_elf_platform(int cpu, const char *plat)
+{
+	if (cpu =3D=3D 0)
+		__elf_platform =3D plat;
+}
+
 /*
  * See comments in asm-alpha/elf.h, this is the same thing
  * on the MIPS.
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 71620e1..7e547ca 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -613,7 +613,18 @@ static inline void cpu_probe_legacy(struct cpuinfo_mip=
s *c, unsigned int cpu)
 		break;
 	case PRID_IMP_LOONGSON2:
 		c->cputype =3D CPU_LOONGSON2;
-		__cpu_name[cpu] =3D "ICT Loongson-2";
+		switch (c->processor_id & PRID_REV_MASK) {
+		case PRID_REV_LOONGSON2E:
+			__cpu_name[cpu] =3D "ICT Loongson-2E";
+			set_elf_platform(cpu, "loongson2e");
+			break;
+		case PRID_REV_LOONGSON2F:
+			__cpu_name[cpu] =3D "ICT Loongson-2F";
+			set_elf_platform(cpu, "loongson2f");
+			break;
+		default:
+			__cpu_name[cpu] =3D "ICT Loongson-2";
+		}
 		c->isa_level =3D MIPS_CPU_ISA_III;
 		c->options =3D R4K_OPTS |
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
@@ -957,14 +968,12 @@ static inline void cpu_probe_cavium(struct cpuinfo_mi=
ps *c, unsigned int cpu)
 		c->cputype =3D CPU_CAVIUM_OCTEON_PLUS;
 		__cpu_name[cpu] =3D "Cavium Octeon+";
 platform:
-		if (cpu =3D=3D 0)
-			__elf_platform =3D "octeon";
+		set_elf_platform(cpu, "octeon");
 		break;
 	case PRID_IMP_CAVIUM_CN63XX:
 		c->cputype =3D CPU_CAVIUM_OCTEON2;
 		__cpu_name[cpu] =3D "Cavium Octeon II";
-		if (cpu =3D=3D 0)
-			__elf_platform =3D "octeon2";
+		set_elf_platform(cpu, "octeon2");
 		break;
 	default:
 		printk(KERN_INFO "Unknown Octeon chip!\n");


--=-JmLzlPP0kTVobA4+X7Q2--

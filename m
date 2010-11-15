Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2010 00:50:46 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:34712 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492263Ab0KOXul (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Nov 2010 00:50:41 +0100
Received: by ewy19 with SMTP id 19so27107ewy.36
        for <multiple recipients>; Mon, 15 Nov 2010 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:subject:to
         :cc:references:in-reply-to:x-mailer:message-id:mime-version
         :content-type;
        bh=dEA7e5sH5ys0mV71RRyRLQ2cfgXuvWLrNN4jUOz9ZKc=;
        b=kD6YYWHGFDzEysTOxPqCxpHT04Sz/S7FP4Mi9yOhMGrV4iTYrBWAY6Q/GS/ir/ek1x
         sdi180ABz/2ObO5sVkJi08198k4VtSpLiFFQNlV104E22eRwzpZH8djE1l+8EyMHFNhq
         5o4gDdl0988P8I/7TJSjrMCEv6+4ZN15B1xL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:subject:to:cc:references:in-reply-to:x-mailer
         :message-id:mime-version:content-type;
        b=wpaUVIoRkY7tbiDp4d9lQGCNCsNgkPN+IBZ2ndvUGFGZ3RI9x5OYCirYLc11HYLj45
         P8gw0mjfGrTLUE5YQpx4p8Gl1t2tk8fNvFpuGZQHIPFqTuk3OTJvL5ekd3BM5zlWxmlU
         Q3Aj0cRMSY7LVo2oHG76PzkJfO54XIUUQVCwY=
Received: by 10.213.8.136 with SMTP id h8mr5314304ebh.36.1289865039884;
        Mon, 15 Nov 2010 15:50:39 -0800 (PST)
Received: from thorin ([83.45.77.222])
        by mx.google.com with ESMTPS id x54sm500933eeh.11.2010.11.15.15.50.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 15:50:37 -0800 (PST)
Date:   Tue, 16 Nov 2010 00:50:28 +0100
From:   Robert Millan <rmh@gnu.org>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
To:     Robert Millan <rmh@gnu.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        wu zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
References: <20101109154055.GD10799@linux-mips.org>
        <1289486855.14828.0@thorin>
In-Reply-To: <1289486855.14828.0@thorin> (from rmh@gnu.org on Thu Nov 11
        15:47:35 2010)
X-Mailer: Balsa 2.4.1
Message-Id: <1289865028.9277.0@thorin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TrgpL6pPRRG/T6pcLOqM"
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

--=-TrgpL6pPRRG/T6pcLOqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El 11/11/10 15:47:35, en/na Robert Millan va escriure:
> -		__cpu_name[cpu] =3D "ICT Loongson-2";
> +		switch (c->processor_id & PRID_REV_MASK) {
> +		case PRID_REV_LOONGSON2E:
> +			__cpu_name[cpu] =3D "ICT Loongson-2E";

Actually, the V0.2 / V0.3 that follows in cpuinfo output
already indicates revision.  And I noticed that appending
the 'E' or 'F' breaks GCC's -march=3Dnative option (which
works by parsing /proc/cpuinfo).

Please use this patch instead.


--=-TrgpL6pPRRG/T6pcLOqM
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
index 71620e1..accde65 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -614,6 +614,14 @@ static inline void cpu_probe_legacy(struct cpuinfo_mip=
s *c, unsigned int cpu)
 	case PRID_IMP_LOONGSON2:
 		c->cputype =3D CPU_LOONGSON2;
 		__cpu_name[cpu] =3D "ICT Loongson-2";
+		switch (c->processor_id & PRID_REV_MASK) {
+		case PRID_REV_LOONGSON2E:
+			set_elf_platform(cpu, "loongson2e");
+			break;
+		case PRID_REV_LOONGSON2F:
+			set_elf_platform(cpu, "loongson2f");
+			break;
+		}
 		c->isa_level =3D MIPS_CPU_ISA_III;
 		c->options =3D R4K_OPTS |
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
@@ -957,14 +965,12 @@ static inline void cpu_probe_cavium(struct cpuinfo_mi=
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


--=-TrgpL6pPRRG/T6pcLOqM--

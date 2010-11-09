Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 13:24:28 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:63404 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490989Ab0KIMYV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Nov 2010 13:24:21 +0100
Received: by ewy19 with SMTP id 19so3349762ewy.36
        for <multiple recipients>; Tue, 09 Nov 2010 04:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:subject:to
         :cc:references:in-reply-to:x-mailer:message-id:mime-version
         :content-type;
        bh=KhepWFfgNBsyvGhKfSBe4KtulHN0sFWpQBzWrZYlpMA=;
        b=wR/DcIMtcreZseqtuGyyB6cBVw+2dsZzpNqn+7tWbW/C8GFjS8+M4bt3u6TcYUNsIA
         KYnn5NIc7ZBzWz9tl1b7CKTpOCAUHbNEoHkDmYn7PTt3tChLYfJvdRLOl/xwJPk3h1bp
         QZlv4JAn1CtAielkF1RU/gWwRuC9iJVAaVNB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:subject:to:cc:references:in-reply-to:x-mailer
         :message-id:mime-version:content-type;
        b=dLJjiBRZ4IqMZAXzbzvM6DHF92+Vc+cFIEvBbHa8TpfEewwcpQ1rIaN0W/ljYVRz7g
         LIxJvgwAZTdw1+wvrob5OVWNHl3xtRyLJDJpRVoWNPxGyj7T2a5gBhvyv6CruU/IjRhs
         4SDfz17U6moCHZ4HrQZxUw7JFvU+hPcRWfNqM=
Received: by 10.213.16.69 with SMTP id n5mr5400762eba.26.1289305460984;
        Tue, 09 Nov 2010 04:24:20 -0800 (PST)
Received: from thorin ([83.45.77.222])
        by mx.google.com with ESMTPS id b52sm1108629eei.7.2010.11.09.04.24.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 04:24:20 -0800 (PST)
Date:   Tue, 09 Nov 2010 13:24:02 +0100
From:   Robert Millan <rmh@gnu.org>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <AANLkTi=HjVCbghbH3LYHQfzh=qAPBV-0q_JnfkGPXyS1@mail.gmail.com>
        <AANLkTimbPpVmbrk13+KSF_DbBmfwjpeuzr2i7DMAKHbO@mail.gmail.com>
In-Reply-To: <AANLkTimbPpVmbrk13+KSF_DbBmfwjpeuzr2i7DMAKHbO@mail.gmail.com>
        (from wuzhangjin@gmail.com on Tue Nov  9 10:48:34 2010)
X-Mailer: Balsa 2.4.1
Message-Id: <1289305442.31389.0@thorin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-S8j8ieXtJRiiHPDhJPxR"
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

--=-S8j8ieXtJRiiHPDhJPxR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

El 09/11/10 10:48:34, en/na wu zhangjin va escriure:
> Just rechecked this with a friend from Lemote, in reality, the
> revision id of Loongson-2F is 0x3, so, my old code should be a
> reference for you:
>=20
> arch/mips/loongson/common/platform.c
>=20
> PRID_REV_LOONGSON2F and PRID_REV_LOONGSON2E has already been defined
> in arch/mips/include/asm/cpu.h
>=20
> So, the manual is buggy, perhaps the editors of the manuals did copy
> and paste for I have found the title of the 2F manual is the same as
> the 2E manual ;-)

Thank you!  Then I suppose this will do it.


--=-S8j8ieXtJRiiHPDhJPxR
Content-Type: text/x-patch; charset=us-ascii; name=loongson2f.diff
Content-Disposition: attachment; filename=loongson2f.diff
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Robert Millan <rmh@gnu.org>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 71620e1..4341950 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -613,7 +613,20 @@ static inline void cpu_probe_legacy(struct cpuinfo_mip=
s *c, unsigned int cpu)
 		break;
 	case PRID_IMP_LOONGSON2:
 		c->cputype =3D CPU_LOONGSON2;
-		__cpu_name[cpu] =3D "ICT Loongson-2";
+		switch (c->processor_id & PRID_REV_MASK) {
+		case PRID_REV_LOONGSON2E:
+			__cpu_name[cpu] =3D "ICT Loongson-2E";
+			if (cpu =3D=3D 0)
+				__elf_platform =3D "loongson2e";
+			break;
+		case PRID_REV_LOONGSON2F:
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


--=-S8j8ieXtJRiiHPDhJPxR--

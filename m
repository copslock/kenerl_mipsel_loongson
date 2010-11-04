Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 13:18:52 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:54976 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491863Ab0KDMSt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Nov 2010 13:18:49 +0100
Received: by wyf22 with SMTP id 22so1776747wyf.36
        for <multiple recipients>; Thu, 04 Nov 2010 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:subject:to
         :x-mailer:message-id:mime-version:content-type;
        bh=9t9h+kn5cxVamWXw7fiQwbLRKIT2Xfi0vuC/7+4m6WQ=;
        b=dQRYoTOtffgwuDig2lsKl+6aym52BrwkdK4pCl7i19uo9vcIbFlcNSTmxglLXQ/Vm7
         pJQKXQjQSXZkSV+KO/9J4zN1D3LeqNZFLpWCleql+wsbUyEhnuWnNJq+UHp/g/BnmijE
         jH99k1VrD2fJSds+1wov0dTIu3mAOLZ2kNhUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:subject:to:x-mailer:message-id:mime-version
         :content-type;
        b=uXLGwVErYGDPz0AVfuHJJtRIV69Wwm1I7aQ1oOp3TlDhrHIhaeSbl/poVAllbFShy/
         xrMNecVN17irUZ21ykOY9V2oXng6yFwkSuAVKJg7mzj0C+ikD45MGKWhbqPCvcZlvXmd
         7Oz23aSAGx7H9hWVGQfx4RDOMWkQUcKLJnHTs=
Received: by 10.227.32.147 with SMTP id c19mr656671wbd.43.1288873123222;
        Thu, 04 Nov 2010 05:18:43 -0700 (PDT)
Received: from thorin ([81.38.198.117])
        by mx.google.com with ESMTPS id i19sm8498206wbe.17.2010.11.04.05.18.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 05:18:42 -0700 (PDT)
Date:   Thu, 04 Nov 2010 13:18:39 +0100
From:   Robert Millan <rmh@gnu.org>
Subject: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
X-Mailer: Balsa 2.4.1
Message-Id: <1288873119.12965.1@thorin>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5GodYgjBcmMHasXlITod"
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

--=-5GodYgjBcmMHasXlITod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Please consider this patch, it enables AT_PLATFORM for Loongson 2F CPU.



--=-5GodYgjBcmMHasXlITod
Content-Type: text/x-patch; charset=us-ascii; name=loongson-2f.diff
Content-Disposition: attachment; filename=loongson-2f.diff
Content-Transfer-Encoding: quoted-printable


Enable AT_PLATFORM for Loongson 2F CPU.

Signed-off-by: Robert Millan <rmh@gnu.org>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 71620e1..504f3b1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -614,6 +614,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips=
 *c, unsigned int cpu)
 	case PRID_IMP_LOONGSON2:
 		c->cputype =3D CPU_LOONGSON2;
 		__cpu_name[cpu] =3D "ICT Loongson-2";
+		if (cpu =3D=3D 0)
+			__elf_platform =3D "loongson-2f";
 		c->isa_level =3D MIPS_CPU_ISA_III;
 		c->options =3D R4K_OPTS |
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |


--=-5GodYgjBcmMHasXlITod--

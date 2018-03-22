Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 15:22:52 +0100 (CET)
Received: from forward106p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:109]:39434
        "EHLO forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeCVOWkTV8tm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2018 15:22:40 +0100
Received: from mxback1g.mail.yandex.net (mxback1g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:162])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 6EB132D84021;
        Thu, 22 Mar 2018 17:22:33 +0300 (MSK)
Received: from smtp2j.mail.yandex.net (smtp2j.mail.yandex.net [2a02:6b8:0:801::ac])
        by mxback1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Scdfi7f1g3-MW7C4MR1;
        Thu, 22 Mar 2018 17:22:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521728553;
        bh=jZaVDcHQyTtcGThgp3tpmn12GTGUMcUouHcWoX9q99g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=baxK7ObrTyvXumtpFZDQmfFvz3I5j0YxunW0JSgDHuJcYVZg/TAsFdrDEAbN5AwK7
         R56LhJVFSv9smbokSLcw3dZczTu6xSgvFE9X9cCSR1YYiN761S7fiYk9Ixjk/W3QFM
         2IpGUdzIIwFKyuqjYcBQg56MvU2uC+gk1GOIfTJo=
Received: by smtp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xanZbOtqWb-MSvaRxMc;
        Thu, 22 Mar 2018 17:22:30 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521728551;
        bh=jZaVDcHQyTtcGThgp3tpmn12GTGUMcUouHcWoX9q99g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=n2YgRVIP3NT79wgJXBB0XZoXzG6J+qTTzRTS7ZWddtXimwNnbpyNooZYwXuLgaGI8
         VPEd1LIdSmqLTKQe/GuxzrPS+d/Uug1A0dciXD3jO3bMwyjgl1QNqlD83+qfmICPEK
         meDDV6EBL+z5bJn6D7gvWKmQqY4Y8ApIel/UDPds=
Authentication-Results: smtp2j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     jhogan@kernel.org
Cc:     chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/2] MIPS: Introduce has_cpu_mips*_user in cpu-features.h
Date:   Thu, 22 Mar 2018 22:22:14 +0800
Message-Id: <20180322142215.7705-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
References: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

Some processors support user mode instructions ISA level which is
different with the ISA level it should be treated in kernel, such
as Loongson 3A1000 3B1000 3A1500 3B1500 support all mips64r2 user
mode instructions however, they should be treated as mips64r1 in
kernel.

So we introduce has_cpu_mips*_user to decide which level should be
displayed in cpuinfo to prevent misleading userspace programs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/cpu-features.h | 39 ++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/proc.c              | 22 ++++++++++----------
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 721b698bfe3c..0eff1956e229 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -251,6 +251,45 @@
 # define cpu_has_mips64r6	(cpu_data[0].isa_level & MIPS_CPU_ISA_M64R6)
 #endif
 
+/*
+ * For the CPU that has a user mode instructions ISA level which is different
+ * from the ISA level it should be treated in kernel, this ISA level will
+ * be displayed in cpuinfo as a reference for userspace programs.
+ */
+#ifndef cpu_has_mips_1_user
+# define cpu_has_mips_1_user		(cpu_has_mips_1)
+#endif
+#ifndef cpu_has_mips_2_user
+# define cpu_has_mips_2_user		(cpu_has_mips_2)
+#endif
+#ifndef cpu_has_mips_3_user
+# define cpu_has_mips_3_user		(cpu_has_mips_3)
+#endif
+#ifndef cpu_has_mips_4_user
+# define cpu_has_mips_4_user		(cpu_has_mips_4)
+#endif
+#ifndef cpu_has_mips_5_user
+# define cpu_has_mips_5_user		(cpu_has_mips_5)
+#endif
+#ifndef cpu_has_mips32r1_user
+# define cpu_has_mips32r1_user	(cpu_has_mips32r1)
+#endif
+#ifndef cpu_has_mips32r2_user
+# define cpu_has_mips32r2_user	(cpu_has_mips32r2)
+#endif
+#ifndef cpu_has_mips32r6_user
+# define cpu_has_mips32r6_user	(cpu_has_mips32r6)
+#endif
+#ifndef cpu_has_mips64r1_user
+# define cpu_has_mips64r1_user	(cpu_has_mips64r1)
+#endif
+#ifndef cpu_has_mips64r2_user
+# define cpu_has_mips64r2_user	(cpu_has_mips64r2)
+#endif
+#ifndef cpu_has_mips64r6_user
+# define cpu_has_mips64r6_user	(cpu_has_mips64r6)
+#endif
+
 /*
  * Shortcuts ...
  */
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index b2de408a259e..65a9a695af3c 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -84,27 +84,27 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m, "isa\t\t\t:"); 
-	if (cpu_has_mips_1)
+	if (cpu_has_mips_1_user)
 		seq_printf(m, " mips1");
-	if (cpu_has_mips_2)
+	if (cpu_has_mips_2_user)
 		seq_printf(m, "%s", " mips2");
-	if (cpu_has_mips_3)
+	if (cpu_has_mips_3_user)
 		seq_printf(m, "%s", " mips3");
-	if (cpu_has_mips_4)
+	if (cpu_has_mips_4_user)
 		seq_printf(m, "%s", " mips4");
-	if (cpu_has_mips_5)
+	if (cpu_has_mips_5_user)
 		seq_printf(m, "%s", " mips5");
-	if (cpu_has_mips32r1)
+	if (cpu_has_mips32r1_user)
 		seq_printf(m, "%s", " mips32r1");
-	if (cpu_has_mips32r2)
+	if (cpu_has_mips32r2_user)
 		seq_printf(m, "%s", " mips32r2");
-	if (cpu_has_mips32r6)
+	if (cpu_has_mips32r6_user)
 		seq_printf(m, "%s", " mips32r6");
-	if (cpu_has_mips64r1)
+	if (cpu_has_mips64r1_user)
 		seq_printf(m, "%s", " mips64r1");
-	if (cpu_has_mips64r2)
+	if (cpu_has_mips64r2_user)
 		seq_printf(m, "%s", " mips64r2");
-	if (cpu_has_mips64r6)
+	if (cpu_has_mips64r6_user)
 		seq_printf(m, "%s", " mips64r6");
 	seq_printf(m, "\n");
 
-- 
2.16.2

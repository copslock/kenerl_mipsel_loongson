Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:31:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11294 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993941AbdFBTbhDdYmn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:31:37 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 61C725CFEB6BC;
        Fri,  2 Jun 2017 20:31:26 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:31:30
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/9] MIPS: generic: Abstract FDT fixup application
Date:   Fri, 2 Jun 2017 12:29:54 -0700
Message-ID: <20170602192959.25435-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602192959.25435-1-paul.burton@imgtec.com>
References: <20170602192959.25435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Introduce an apply_mips_fdt_fixups() function which can apply fixups to
an FDT based upon an array of fixup descriptions. This abstracts that
functionality such that legacy board code can apply FDT fixups without
requiring lots of duplication.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/generic/board-sead3.c | 33 +++++++++++----------------------
 arch/mips/generic/init.c        | 27 +++++++++++++++++++++++++++
 arch/mips/include/asm/machine.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/arch/mips/generic/board-sead3.c b/arch/mips/generic/board-sead3.c
index 97186a3a5d21..39e11bd249cf 100644
--- a/arch/mips/generic/board-sead3.c
+++ b/arch/mips/generic/board-sead3.c
@@ -138,6 +138,14 @@ static __init int remove_gic(void *fdt)
 	return 0;
 }
 
+static const struct mips_fdt_fixup sead3_fdt_fixups[] __initconst = {
+	{ yamon_dt_append_cmdline, "append command line" },
+	{ append_memory, "append memory" },
+	{ remove_gic, "remove GIC when not present" },
+	{ yamon_dt_serial_config, "append serial configuration" },
+	{ },
+};
+
 static __init const void *sead3_fixup_fdt(const void *fdt,
 					  const void *match_data)
 {
@@ -152,29 +160,10 @@ static __init const void *sead3_fixup_fdt(const void *fdt,
 
 	fw_init_cmdline();
 
-	err = fdt_open_into(fdt, fdt_buf, sizeof(fdt_buf));
-	if (err)
-		panic("Unable to open FDT: %d", err);
-
-	err = yamon_dt_append_cmdline(fdt_buf);
-	if (err)
-		panic("Unable to patch FDT: %d", err);
-
-	err = append_memory(fdt_buf);
-	if (err)
-		panic("Unable to patch FDT: %d", err);
-
-	err = remove_gic(fdt_buf);
-	if (err)
-		panic("Unable to patch FDT: %d", err);
-
-	err = yamon_dt_serial_config(fdt_buf);
-	if (err)
-		panic("Unable to patch FDT: %d", err);
-
-	err = fdt_pack(fdt_buf);
+	err = apply_mips_fdt_fixups(fdt_buf, sizeof(fdt_buf),
+				    fdt, sead3_fdt_fixups);
 	if (err)
-		panic("Unable to pack FDT: %d\n", err);
+		panic("Unable to fixup FDT: %d", err);
 
 	return fdt_buf;
 }
diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 4af619215410..4a9a1edbfb29 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -122,6 +122,33 @@ void __init device_tree_init(void)
 		err = register_up_smp_ops();
 }
 
+int __init apply_mips_fdt_fixups(void *fdt_out, size_t fdt_out_size,
+				 const void *fdt_in,
+				 const struct mips_fdt_fixup *fixups)
+{
+	int err;
+
+	err = fdt_open_into(fdt_in, fdt_out, fdt_out_size);
+	if (err) {
+		pr_err("Failed to open FDT\n");
+		return err;
+	}
+
+	for (; fixups->apply; fixups++) {
+		err = fixups->apply(fdt_out);
+		if (err) {
+			pr_err("Failed to apply FDT fixup \"%s\"\n",
+			       fixups->description);
+			return err;
+		}
+	}
+
+	err = fdt_pack(fdt_out);
+	if (err)
+		pr_err("Failed to pack FDT\n");
+	return err;
+}
+
 void __init plat_time_init(void)
 {
 	struct device_node *np;
diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machine.h
index 6b444cd9526f..ecb6c7335484 100644
--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -60,4 +60,35 @@ mips_machine_is_compatible(const struct mips_machine *mach, const void *fdt)
 	return NULL;
 }
 
+/**
+ * struct mips_fdt_fixup - Describe a fixup to apply to an FDT
+ * @apply: applies the fixup to @fdt, returns zero on success else -errno
+ * @description: a short description of the fixup
+ *
+ * Describes a fixup applied to an FDT blob by the @apply function. The
+ * @description field provides a short description of the fixup intended for
+ * use in error messages if the @apply function returns non-zero.
+ */
+struct mips_fdt_fixup {
+	int (*apply)(void *fdt);
+	const char *description;
+};
+
+/**
+ * apply_mips_fdt_fixups() - apply fixups to an FDT blob
+ * @fdt_out: buffer in which to place the fixed-up FDT
+ * @fdt_out_size: the size of the @fdt_out buffer
+ * @fdt_in: the FDT blob
+ * @fixups: pointer to an array of fixups to be applied
+ *
+ * Loop through the array of fixups pointed to by @fixups, calling the apply
+ * function on each until either one returns an error or we reach the end of
+ * the list as indicated by an entry with a NULL apply field.
+ *
+ * Return: zero on success, else -errno
+ */
+extern int __init apply_mips_fdt_fixups(void *fdt_out, size_t fdt_out_size,
+					const void *fdt_in,
+					const struct mips_fdt_fixup *fixups);
+
 #endif /* __MIPS_ASM_MACHINE_H__ */
-- 
2.13.0

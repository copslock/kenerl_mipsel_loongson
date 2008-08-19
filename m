Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:56:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53455 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580941AbYHSNzV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:21 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D0D763EAD; Tue, 19 Aug 2008 22:55:15 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 04/14] TXx9: Early command-line preprocessing
Date:	Tue, 19 Aug 2008 22:55:08 +0900
Message-Id: <1219154118-21193-4-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Select board by command-line option or firmware environment variable.
* Handle "masterclk=" option.
* Add boards.h to centerize board_vec declaration.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c |   74 ++++++++++++++++++++++++++++++++++++---
 include/asm-mips/txx9/boards.h |   10 +++++
 2 files changed, 78 insertions(+), 6 deletions(-)
 create mode 100644 include/asm-mips/txx9/boards.h

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 4ccc735..af97514 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -118,14 +118,31 @@ int irq_to_gpio(unsigned irq)
 EXPORT_SYMBOL(irq_to_gpio);
 #endif
 
-extern struct txx9_board_vec jmr3927_vec;
-extern struct txx9_board_vec rbtx4927_vec;
-extern struct txx9_board_vec rbtx4937_vec;
-extern struct txx9_board_vec rbtx4938_vec;
+#define BOARD_VEC(board)	extern struct txx9_board_vec board;
+#include <asm/txx9/boards.h>
+#undef BOARD_VEC
 
 struct txx9_board_vec *txx9_board_vec __initdata;
 static char txx9_system_type[32];
 
+static struct txx9_board_vec *board_vecs[] __initdata = {
+#define BOARD_VEC(board)	&board,
+#include <asm/txx9/boards.h>
+#undef BOARD_VEC
+};
+
+static struct txx9_board_vec *__init find_board_byname(const char *name)
+{
+	int i;
+
+	/* search board_vecs table */
+	for (i = 0; i < ARRAY_SIZE(board_vecs); i++) {
+		if (strstr(board_vecs[i]->system, name))
+			return board_vecs[i];
+	}
+	return NULL;
+}
+
 static void __init prom_init_cmdline(void)
 {
 	int argc = (int)fw_arg0;
@@ -168,9 +185,47 @@ static void __init prom_init_cmdline(void)
 	}
 }
 
-void __init prom_init(void)
+static void __init preprocess_cmdline(void)
 {
-	prom_init_cmdline();
+	char cmdline[CL_SIZE];
+	char *s;
+
+	strcpy(cmdline, arcs_cmdline);
+	s = cmdline;
+	arcs_cmdline[0] = '\0';
+	while (s && *s) {
+		char *str = strsep(&s, " ");
+		if (strncmp(str, "board=", 6) == 0) {
+			txx9_board_vec = find_board_byname(str + 6);
+			continue;
+		} else if (strncmp(str, "masterclk=", 10) == 0) {
+			unsigned long val;
+			if (strict_strtoul(str + 10, 10, &val) == 0)
+				txx9_master_clock = val;
+			continue;
+		}
+		if (arcs_cmdline[0])
+			strcat(arcs_cmdline, " ");
+		strcat(arcs_cmdline, str);
+	}
+}
+
+static void __init select_board(void)
+{
+	const char *envstr;
+
+	/* first, determine by "board=" argument in preprocess_cmdline() */
+	if (txx9_board_vec)
+		return;
+	/* next, determine by "board" envvar */
+	envstr = prom_getenv("board");
+	if (envstr) {
+		txx9_board_vec = find_board_byname(envstr);
+		if (txx9_board_vec)
+			return;
+	}
+
+	/* select "default" board */
 #ifdef CONFIG_CPU_TX39XX
 	txx9_board_vec = &jmr3927_vec;
 #endif
@@ -191,6 +246,13 @@ void __init prom_init(void)
 #endif
 	}
 #endif
+}
+
+void __init prom_init(void)
+{
+	prom_init_cmdline();
+	preprocess_cmdline();
+	select_board();
 
 	strcpy(txx9_system_type, txx9_board_vec->system);
 
diff --git a/include/asm-mips/txx9/boards.h b/include/asm-mips/txx9/boards.h
new file mode 100644
index 0000000..4abc814
--- /dev/null
+++ b/include/asm-mips/txx9/boards.h
@@ -0,0 +1,10 @@
+#ifdef CONFIG_TOSHIBA_JMR3927
+BOARD_VEC(jmr3927_vec)
+#endif
+#ifdef CONFIG_TOSHIBA_RBTX4927
+BOARD_VEC(rbtx4927_vec)
+BOARD_VEC(rbtx4937_vec)
+#endif
+#ifdef CONFIG_TOSHIBA_RBTX4938
+BOARD_VEC(rbtx4938_vec)
+#endif
-- 
1.5.6.3

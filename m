Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56LmPk12011
	for linux-mips-outgoing; Wed, 6 Jun 2001 14:48:25 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56LmOh11999
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 14:48:24 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2A763125BC; Wed,  6 Jun 2001 14:48:23 -0700 (PDT)
Date: Wed, 6 Jun 2001 14:48:23 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: gcc-patches@gcc.gnu.org
Cc: linux-mips@oss.sgi.com
Subject: Patch for config/mips/linux.h
Message-ID: <20010606144823.A27894@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Linux/mips supports .type for functions. Here is a patch.


H.J.
---
2001-06-06  H.J. Lu  (hjl@gnu.org)

	* config/mips/linux.h (ASM_DECLARE_FUNCTION_NAME): Defined.
	(ASM_DECLARE_FUNCTION_SIZE): Likewise.
	(FUNCTION_NAME_ALREADY_DECLARED): Likewise.

--- gcc/config/mips/linux.h.type	Tue Jun  5 10:28:29 2001
+++ gcc/config/mips/linux.h	Tue Jun  5 10:29:08 2001
@@ -204,3 +204,36 @@ Boston, MA 02111-1307, USA.  */
 	fputc ('-', FILE);						\
 	assemble_name (FILE, LO);					\
   } while (0)
+
+#undef ASM_DECLARE_FUNCTION_NAME
+#define ASM_DECLARE_FUNCTION_NAME(STREAM, NAME, DECL)			\
+  do {									\
+    if (!flag_inhibit_size_directive)					\
+      {									\
+	fputs ("\t.ent\t", STREAM);					\
+	assemble_name (STREAM, NAME);					\
+	putc ('\n', STREAM);						\
+      }									\
+    fprintf (STREAM, "\t%s\t ", TYPE_ASM_OP);				\
+    assemble_name (STREAM, NAME);					\
+    putc (',', STREAM);							\
+    fprintf (STREAM, TYPE_OPERAND_FMT, "function");			\
+    putc ('\n', STREAM);						\
+    assemble_name (STREAM, NAME);					\
+    fputs (":\n", STREAM);						\
+  } while (0)
+
+#undef ASM_DECLARE_FUNCTION_SIZE
+#define ASM_DECLARE_FUNCTION_SIZE(STREAM, NAME, DECL)			\
+  do {									\
+    if (!flag_inhibit_size_directive)					\
+      {									\
+	fputs ("\t.end\t", STREAM);					\
+	assemble_name (STREAM, NAME);					\
+	putc ('\n', STREAM);						\
+      }									\
+  } while (0)
+
+/* Tell function_prologue in mips.c that we have already output the .ent/.end
+   pseudo-ops.  */
+#define FUNCTION_NAME_ALREADY_DECLARED

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CMXau17148
	for linux-mips-outgoing; Tue, 12 Jun 2001 15:33:36 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CMXZP17145
	for <linux-mips@oss.sgi.com>; Tue, 12 Jun 2001 15:33:35 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B6991125BA; Tue, 12 Jun 2001 15:33:34 -0700 (PDT)
Date: Tue, 12 Jun 2001 15:33:34 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: gcc-patches@gcc.gnu.org
Cc: linux-mips@oss.sgi.com
Subject: PATCH: Support ident for Linux/mips
Message-ID: <20010612153334.A26787@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

It brings Linux/mips closer to other Linux targets.

H.J.
----
2001-06-12  H.J. Lu <hjl@gnu.org>

	* config/mips/linux.h (ASM_OUTPUT_IDENT): Defined.

--- gcc/config/mips/linux.h.ident	Sun Jun 10 01:02:34 2001
+++ gcc/config/mips/linux.h	Sun Jun 10 01:02:53 2001
@@ -237,3 +237,8 @@ Boston, MA 02111-1307, USA.  */
 /* Tell function_prologue in mips.c that we have already output the .ent/.end
    pseudo-ops.  */
 #define FUNCTION_NAME_ALREADY_DECLARED
+
+/* Output #ident as a .ident.  */
+#undef ASM_OUTPUT_IDENT
+#define ASM_OUTPUT_IDENT(FILE, NAME) \
+  fprintf (FILE, "\t%s\t\"%s\"\n", IDENT_ASM_OP, NAME);

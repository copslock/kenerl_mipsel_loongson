Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56GoCa05932
	for linux-mips-outgoing; Wed, 6 Jun 2001 09:50:12 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56GoBh05928
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 09:50:11 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 62FBA125BA; Wed,  6 Jun 2001 09:50:11 -0700 (PDT)
Date: Wed, 6 Jun 2001 09:50:11 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com
Cc: linux-mips@oss.sgi.com
Subject: Patch to report the illegal operand errors in gas/mips.
Message-ID: <20010606095011.A22262@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When you have an illegal operand, you will get a bogus error message
saying "opcode not supported on this processor: xxx". This patch fixes
it.

---
2001-06-06  H.J. Lu  <hjl@gnu.org>

	* gas/config/tc-mips.c (mips_ip): Properly report the illegal
	operand errors.

--- gas/config/tc-mips.c.diag	Tue Jun  5 20:28:20 2001
+++ gas/config/tc-mips.c	Tue Jun  5 20:46:50 2001
@@ -7087,19 +7087,25 @@ mips_ip (str, ip)
 	    }
 	  else
 	    {
-	      static char buf[100];
-	      sprintf (buf,
-		       _("opcode not supported on this processor: %s (%s)"),
-		       mips_cpu_to_str (mips_cpu),
-		       mips_isa_to_str (mips_opts.isa));
+	      if (!insn_error)
+		{
+		  static char buf[100];
+		  sprintf (buf,
+			   _("opcode not supported on this processor: %s (%s)"),
+			   mips_cpu_to_str (mips_cpu),
+			   mips_isa_to_str (mips_opts.isa));
 
-	      insn_error = buf;
+		  insn_error = buf;
+		}
+	      if (save_c)
+		*(--s) = save_c;
 	      return;
 	    }
 	}
 
       ip->insn_mo = insn;
       ip->insn_opcode = insn->match;
+      insn_error = NULL;
       for (args = insn->args;; ++args)
 	{
 	  if (*s == ' ')
@@ -7940,8 +7946,11 @@ mips_ip (str, ip)
 	{
 	  ++insn;
 	  s = argsStart;
+	  insn_error = _("illegal operands");
 	  continue;
 	}
+      if (save_c)
+	*(--s) = save_c;
       insn_error = _("illegal operands");
       return;
     }

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56Gj7D05354
	for linux-mips-outgoing; Wed, 6 Jun 2001 09:45:07 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56Gj7h05351
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 09:45:07 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D8156125BA; Wed,  6 Jun 2001 09:45:06 -0700 (PDT)
Date: Wed, 6 Jun 2001 09:45:06 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com
Cc: linux-mips@oss.sgi.com
Subject: Patch to silent mips gas
Message-ID: <20010606094506.A22174@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

It is very annoying for gas to warn NOPS generated from macros. It
causes many "make check" failures in gcc. Here is a patch.


H.J.
----
2001-06-06  H.J. Lu  <hjl@gnu.org>

	* config/tc-mips.c (warn_nops): New variable. Set to 0 to
	disable warning about all NOPS that the assembler generates.
	(macro): Warn NOPS generated only if warn_nops is not 0.
	(md_shortopts): Add `n'.
	(md_parse_option): Set warn_nops to 1 for `n'.

--- gas/config/tc-mips.c.warn	Tue Jun  5 21:01:37 2001
+++ gas/config/tc-mips.c	Tue Jun  5 21:02:36 2001
@@ -313,6 +313,9 @@ enum mips_pic_level
 
 static enum mips_pic_level mips_pic;
 
+/* Warn about all NOPS that the assembler generates.  */
+static int warn_nops = 0;
+
 /* 1 if we should generate 32 bit offsets from the GP register in
    SVR4_PIC mode.  Currently has no meaning in other modes.  */
 static int mips_big_got;
@@ -3620,12 +3623,16 @@ macro (ip)
 	  /* result is always false */
 	  if (! likely)
 	    {
-	      as_warn (_("Branch %s is always false (nop)"), ip->insn_mo->name);
+	      if (warn_nops)
+		as_warn (_("Branch %s is always false (nop)"),
+			 ip->insn_mo->name);
 	      macro_build ((char *) NULL, &icnt, NULL, "nop", "", 0);
 	    }
 	  else
 	    {
-	      as_warn (_("Branch likely %s is always false"), ip->insn_mo->name);
+	      if (warn_nops)
+		as_warn (_("Branch likely %s is always false"),
+			 ip->insn_mo->name);
 	      macro_build ((char *) NULL, &icnt, &offset_expr, "bnel",
 			   "s,t,p", 0, 0);
 	    }
@@ -8860,7 +8867,7 @@ md_number_to_chars (buf, val, n)
     number_to_chars_littleendian (buf, val, n);
 }
 
-CONST char *md_shortopts = "O::g::G:";
+CONST char *md_shortopts = "nO::g::G:";
 
 struct option md_longopts[] =
 {
@@ -8975,6 +8982,10 @@ md_parse_option (c, arg)
 
     case OPTION_EL:
       target_big_endian = 0;
+      break;
+
+    case 'n':
+      warn_nops = 1;
       break;
 
     case 'O':

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA63095 for <linux-archive@neteng.engr.sgi.com>; Sat, 7 Nov 1998 18:37:32 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA39091
	for linux-list;
	Sat, 7 Nov 1998 18:36:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA33639
	for <linux@engr.sgi.com>;
	Sat, 7 Nov 1998 18:36:03 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA08097
	for <linux@engr.sgi.com>; Sat, 7 Nov 1998 18:36:02 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-13.uni-koblenz.de [141.26.249.13])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA14784
	for <linux@engr.sgi.com>; Sun, 8 Nov 1998 03:35:50 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id UAA09599;
	Sat, 7 Nov 1998 20:52:10 +0100
Message-ID: <19981107205209.A9591@uni-koblenz.de>
Date: Sat, 7 Nov 1998 20:52:09 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Updated patch for binutils 2.9.1.0.4
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=3MwIy2ne0vdjdPXF
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii

Hi,

here is an updated patch for binutils 2.9.1.0.4.  If you want to successfully
recompile glibc 2.0.99 you'll need this patch.  This bug is probably in ld
as long as it exists.  For a more detailed explanation of the bug see the
comment in ld/ldlang.c.  The bugs mentioned in my previous posting are all
still unfixed.

  Ralf

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binutils-2.9.1.0.4.diff"

diff -urN binutils-2.9.1.0.4.orig/bfd/elf32-mips.c binutils-2.9.1.0.4/bfd/elf32-mips.c
--- binutils-2.9.1.0.4.orig/bfd/elf32-mips.c	Wed Apr  1 04:40:03 1998
+++ binutils-2.9.1.0.4/bfd/elf32-mips.c	Sat Nov  7 15:58:21 1998
@@ -5113,36 +5113,43 @@
 		    }
 		  else
 		    {
-		      long indx;
-
-		      if (h == NULL)
-			sec = local_sections[r_symndx];
-		      else
-			{
-			  BFD_ASSERT (h->root.type == bfd_link_hash_defined
-				      || (h->root.type
-					  == bfd_link_hash_defweak));
-			  sec = h->root.u.def.section;
-			}
-		      if (sec != NULL && bfd_is_abs_section (sec))
-			indx = 0;
-		      else if (sec == NULL || sec->owner == NULL)
+		      if (r_type == R_MIPS_32)
 			{
-			  bfd_set_error (bfd_error_bad_value);
-			  return false;
+			  outrel.r_info = ELF32_R_INFO (0, R_MIPS_REL32);
+			  addend += relocation;
 			}
-		      else
-			{
-			  asection *osec;
+		       else
+                        {
+		          long indx;
 
-			  osec = sec->output_section;
-			  indx = elf_section_data (osec)->dynindx;
-			  if (indx == 0)
-			    abort ();
-			}
+		          if (h == NULL)
+			    sec = local_sections[r_symndx];
+		          else
+			    {
+			      BFD_ASSERT (h->root.type == bfd_link_hash_defined
+				          || (h->root.type
+					      == bfd_link_hash_defweak));
+			      sec = h->root.u.def.section;
+			    }
+		          if (sec != NULL && bfd_is_abs_section (sec))
+			    indx = 0;
+		          else if (sec == NULL || sec->owner == NULL)
+			    {
+			      bfd_set_error (bfd_error_bad_value);
+			      return false;
+			    }
+		          else
+			    {
+			      asection *osec;
 
-		      outrel.r_info = ELF32_R_INFO (indx, R_MIPS_REL32);
-		      addend += relocation;
+			      osec = sec->output_section;
+			      indx = elf_section_data (osec)->dynindx;
+			      if (indx == 0)
+			        abort ();
+			    }
+		          outrel.r_info = ELF32_R_INFO (indx, R_MIPS_REL32);
+		          addend += relocation;
+		        }
 		    }
 
 		  if (! skip)
diff -urN binutils-2.9.1.0.4.orig/gas/ChangeLog binutils-2.9.1.0.4/gas/ChangeLog
--- binutils-2.9.1.0.4.orig/gas/ChangeLog	Mon Apr 27 23:22:47 1998
+++ binutils-2.9.1.0.4/gas/ChangeLog	Sat Nov  7 12:56:25 1998
@@ -1,3 +1,10 @@
+Thu Nov  4 03:23:59 1998  Ralf Baechle  <ralf@gnu.org>
+
+	* config/tc-mips.c (macro): Only emit a BFD_RELOC_MIPS_LITERAL
+	when the symbol is in the .lit section.  Required for a.out
+	support.
+	(mips_ip): Fix %HI, %hi and %lo operators.
+
 Mon Apr 27 13:45:04 1998  Ian Lance Taylor  <ian@cygnus.com>
 
 	* configure.in: Set version number to 2.9.1.
diff -urN binutils-2.9.1.0.4.orig/gas/config/tc-mips.c binutils-2.9.1.0.4/gas/config/tc-mips.c
--- binutils-2.9.1.0.4.orig/gas/config/tc-mips.c	Wed Mar 25 19:16:01 1998
+++ binutils-2.9.1.0.4/gas/config/tc-mips.c	Sat Nov  7 12:56:25 1998
@@ -5068,13 +5068,22 @@
       else
 	{
 	  assert (offset_expr.X_op == O_symbol
-		  && strcmp (segment_name (S_GET_SEGMENT
-					   (offset_expr.X_add_symbol)),
-			     ".lit4") == 0
 		  && offset_expr.X_add_number == 0);
-	  macro_build ((char *) NULL, &icnt, &offset_expr, "lwc1", "T,o(b)",
-		       treg, (int) BFD_RELOC_MIPS_LITERAL, GP);
-	  return;
+	  s = segment_name (S_GET_SEGMENT (offset_expr.X_add_symbol));
+	  if (strcmp (s, ".lit4") == 0)
+	    {
+	      macro_build ((char *) NULL, &icnt, &offset_expr, "lwc1", "T,o(b)",
+			   treg, (int) BFD_RELOC_MIPS_LITERAL, GP);
+	      return;
+	    }
+	  else
+	    {
+	      /* FIXME: This won't work for a 64 bit address.  */
+	      macro_build_lui ((char *) NULL, &icnt, &offset_expr, AT);
+	      macro_build ((char *) NULL, &icnt, &offset_expr, "lwc1", "T,o(b)",
+			   treg, (int) BFD_RELOC_LO16, AT);
+	      return;
+	    }
 	}
 
     case M_LI_D:
@@ -7553,11 +7562,23 @@
 	      c = my_getSmallExpression (&imm_expr, s);
 	      if (c != '\0')
 		{
-		  if (c != 'l')
+		  if (c == 'l')
 		    {
 		      if (imm_expr.X_op == O_constant)
-			imm_expr.X_add_number =
-			  (imm_expr.X_add_number >> 16) & 0xffff;
+			{
+			  imm_expr.X_add_number &= 0xffff;
+			  imm_reloc = BFD_RELOC_LO16;
+			}
+		    }
+		  else
+		    {
+		      if (imm_expr.X_op == O_constant)
+			{
+			  if (c == 'h' && (imm_expr.X_add_number & 0x8000))
+			    imm_expr.X_add_number += 0x1000;
+			  imm_expr.X_add_number =
+			    (imm_expr.X_add_number >> 16) & 0xffff;
+			}
 		      else if (c == 'h')
 			{
 			  imm_reloc = BFD_RELOC_HI16_S;
@@ -7652,11 +7673,22 @@
 		break;
 
 	      offset_reloc = BFD_RELOC_LO16;
-	      if (c == 'h' || c == 'H')
+	      if (c)
 		{
-		  assert (offset_expr.X_op == O_constant);
-		  offset_expr.X_add_number =
-		    (offset_expr.X_add_number >> 16) & 0xffff;
+		  if (c != 'l')
+		    {
+		      if (offset_expr.X_op == O_constant)
+			{
+			  if (c == 'h' && (offset_expr.X_add_number & 0x8000))
+			    offset_expr.X_add_number += 0x1000;
+			  offset_expr.X_add_number =
+			    (offset_expr.X_add_number >> 16) & 0xffff;
+			}
+		      else if (c == 'h')
+			offset_reloc = BFD_RELOC_HI16_S;
+		      else
+			offset_reloc = BFD_RELOC_HI16;
+		    }
 		}
 	      s = expr_end;
 	      continue;
@@ -7669,10 +7701,13 @@
 
 	    case 'u':		/* upper 16 bits */
 	      c = my_getSmallExpression (&imm_expr, s);
-	      if (imm_expr.X_op == O_constant
-		  && (imm_expr.X_add_number < 0
-		      || imm_expr.X_add_number >= 0x10000))
-		as_bad ("lui expression not in range 0..65535");
+	      if (!c)
+		{
+		  if (imm_expr.X_op == O_constant
+		      && (imm_expr.X_add_number < 0
+			  || imm_expr.X_add_number >= 0x10000))
+		    as_bad ("lui expression not in range 0..65535");
+		}
 	      imm_reloc = BFD_RELOC_LO16;
 	      if (c)
 		{
diff -urN binutils-2.9.1.0.4.orig/ld/ldlang.c binutils-2.9.1.0.4/ld/ldlang.c
--- binutils-2.9.1.0.4.orig/ld/ldlang.c	Wed Apr  1 04:40:12 1998
+++ binutils-2.9.1.0.4/ld/ldlang.c	Sat Nov  7 20:15:03 1998
@@ -2353,6 +2353,24 @@
       {
 	asection *i;
 
+	/* MIPS specific hack.  The .reginfo section on MIPS is special in
+	   that it's not being produced by concatenting the input sections.
+	   The size is always constant.  Here we check if an output
+	   .reginfo section has already been created.  If so, we skip the
+	   rest of the sizing process the output .reginfo section as all
+	   section fields which need to be set have already reached their
+	   final values.  We can't do this in the backend since by the time
+	   when the backend gets involved the vmas etc. have already been
+	   computed based on the assumption of concatenating all section.
+	   In case of a large number of files to be linked this may result
+	   in a third PT_LOAD header being created which will crash the
+	   linking process since we don't have header space for it.  */
+	if (output_section_statement->bfd_section->name
+	    && strcmp(".reginfo",
+		      output_section_statement->bfd_section->name) == 0
+	    && output_section_statement->bfd_section->_raw_size)
+	  break;
+
 	i = (*prev)->input_section.section;
 	if (! relax)
 	  {

--3MwIy2ne0vdjdPXF--

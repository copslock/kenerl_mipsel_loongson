Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77FgoN30569
	for linux-mips-outgoing; Tue, 7 Aug 2001 08:42:50 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77FgbV30557
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 08:42:37 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 95267125C3; Tue,  7 Aug 2001 08:42:36 -0700 (PDT)
Date: Tue, 7 Aug 2001 08:42:36 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: gcc-patches@gcc.gnu.org, linux-mips@oss.sgi.com
Subject: PATCH: Clean up Linux/mips.
Message-ID: <20010807084236.A5550@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Here is a patch to clean up Linux/mips. It also fixes a bug in
UNIQUE_SECTION in config/mips/elf.h, which uses `decl' instead of
`DECL'. Tested on Linux/mipsel.


H.J.
----
2001-08-06  H.J. Lu <hjl@gnu.org>

	* config/mips/mips.c (mips_unique_section): New. Copied from
	config/mips/elf.h.

	* config/mips/mips-protos.h (mips_unique_section): New
	prototype.

	* config/mips/elf.h (UNIQUE_SECTION): Use mips_unique_section.

	* config/mips/little.h: New. Generic little endian mips
	targets.

	* config/mips/linux.h: Include "gofast.h" and "mips/mips.h".
	(WCHAR_TYPE): Defined
	(WCHAR_TYPE_SIZE): Likewise.
	(INIT_SUBTARGET_OPTABS): Likewise.
	(BSS_SECTION_ASM_OP): Likewise.
	(SBSS_SECTION_ASM_OP): Likewise.
	(ASM_OUTPUT_ALIGNED_BSS): Likewise.
	(ASM_DECLARE_OBJECT_NAME): Likewise.
	(UNIQUE_SECTION): Likewise.
	(EXTRA_SECTIONS): Likewise.
	(ASM_OUTPUT_CONSTRUCTOR): Likewise.
	(ASM_OUTPUT_DESTRUCTOR): Likewise.
	(ASM_OUTPUT_DEF): Likewise.
	(HANDLE_SYSV_PRAGMA): Removed.
	(NO_IMPLICIT_EXTERN_C): Likewise.
	(TARGET_MEM_FUNCTIONS): Likewise.
	(STARTFILE_SPEC): Likewise.
	(ENDFILE_SPEC): Likewise.
	(LIB_SPEC): Likewise.
	(INVOKE__main): Likewise.
	(CTOR_LIST_BEGIN): Likewise.
	(CTOR_LIST_END): Likewise.
	(DTOR_LIST_BEGIN): Likewise.
	(DTOR_LIST_END): Likewise.
	(SET_ASM_OP): Likewise.
	(ASM_OUTPUT_SOURCE_LINE): Likewise.
	(ASM_OUTPUT_DEF): Likewise.
	(ASM_OUTPUT_IDENT): Likewise.

	* config/mips/mips.h (ASM_SPEC): Undefine before define.
	(CPLUSPLUS_CPP_SPEC): Likewise.
	(ASM_APP_ON) Redefine only if not defined.
	(ASM_APP_OFF): Likewise.
	(ASM_OUTPUT_SOURCE_LINE): Likewise.
	(ASM_OUTPUT_IDENT): Likewise.

	* config.gcc: Update tm_file for Linux/mips.

--- gcc/config.gcc.linux	Wed Aug  1 16:00:23 2001
+++ gcc/config.gcc	Sun Aug  5 08:56:33 2001
@@ -2200,9 +2200,9 @@ mipsel-*-netbsd* | mips-dec-netbsd*)    
 	;;
 mips*-*-linux*)				# Linux MIPS, either endian.
 	xmake_file=x-linux
+	tm_file="linux.h mips/linux.h"
 	case $machine in
-	       mips*el-*)  tm_file="elfos.h mips/elfl.h mips/linux.h" ;;
-	       *)	  tm_file="elfos.h mips/elf.h mips/linux.h" ;;
+	       mips*el-*)  tm_file="mips/little.h $tm_file" ;;
 	esac
 	tmake_file="t-slibgcc-elf-ver t-linux mips/t-linux"
 	extra_parts="crtbegin.o crtbeginS.o crtend.o crtendS.o"
--- gcc/config/mips/elf.h.linux	Mon Jul  2 21:03:24 2001
+++ gcc/config/mips/elf.h	Mon Aug  6 11:35:44 2001
@@ -214,70 +214,8 @@ do {									 \
 #undef UNIQUE_SECTION_P
 #define UNIQUE_SECTION_P(DECL) (DECL_ONE_ONLY (DECL))
 #undef UNIQUE_SECTION
-#define UNIQUE_SECTION(DECL,RELOC)					   \
-do {									   \
-  int len, size, sec;							   \
-  char *name, *string, *prefix;						   \
-  static char *prefixes[4][2] = {					   \
-    { ".text.", ".gnu.linkonce.t." },					   \
-    { ".rodata.", ".gnu.linkonce.r." },					   \
-    { ".data.", ".gnu.linkonce.d." },					   \
-    { ".sdata.", ".gnu.linkonce.s." }					   \
-  };									   \
-									   \
-  name = IDENTIFIER_POINTER (DECL_ASSEMBLER_NAME (DECL));		   \
-  size = int_size_in_bytes (TREE_TYPE (decl));				   \
-									   \
-  /* Determine the base section we are interested in:			   \
-     0=text, 1=rodata, 2=data, 3=sdata, [4=bss].  */			   \
-  if (TREE_CODE (DECL) == FUNCTION_DECL)				   \
-    sec = 0;								   \
-  else if (DECL_INITIAL (DECL) == 0					   \
-           || DECL_INITIAL (DECL) == error_mark_node)			   \
-    sec = 2;								   \
-  else if ((TARGET_EMBEDDED_PIC || TARGET_MIPS16)			   \
-      && TREE_CODE (decl) == STRING_CST					   \
-      && !flag_writable_strings)					   \
-    {									   \
-      /* For embedded position independent code, put constant strings	   \
-	 in the text section, because the data section is limited to	   \
-	 64K in size.  For mips16 code, put strings in the text		   \
-	 section so that a PC relative load instruction can be used to	   \
-	 get their address.  */						   \
-      sec = 0;								   \
-    }									   \
-  else if (TARGET_EMBEDDED_DATA)					   \
-    {									   \
-      /* For embedded applications, always put an object in read-only data \
-	 if possible, in order to reduce RAM usage.  */			   \
-									   \
-      if (DECL_READONLY_SECTION (DECL, RELOC))				   \
-	sec = 1;							   \
-      else if (size > 0 && size <= mips_section_threshold)		   \
-	sec = 3;							   \
-      else								   \
-	sec = 2;							   \
-    }									   \
-  else									   \
-    {									   \
-      /* For hosted applications, always put an object in small data if	   \
-	 possible, as this gives the best performance.  */		   \
-									   \
-      if (size > 0 && size <= mips_section_threshold)			   \
-	sec = 3;							   \
-      else if (DECL_READONLY_SECTION (DECL, RELOC))			   \
-	sec = 1;							   \
-      else								   \
-	sec = 2;							   \
-    }									   \
-									   \
-  prefix = prefixes[sec][DECL_ONE_ONLY (DECL)];				   \
-  len = strlen (name) + strlen (prefix);				   \
-  string = alloca (len + 1);						   \
-  sprintf (string, "%s%s", prefix, name);				   \
-									   \
-  DECL_SECTION_NAME (DECL) = build_string (len, string);		   \
-} while (0)
+#define UNIQUE_SECTION(DECL,RELOC) \
+  mips_unique_section ((DECL), (RELOC))
 
 /* Support the ctors/dtors and other sections.  */
  
--- gcc/config/mips/linux.h.linux	Wed Aug  1 10:24:54 2001
+++ gcc/config/mips/linux.h	Mon Aug  6 11:30:33 2001
@@ -18,6 +18,128 @@ along with GNU CC; see the file COPYING.
 the Free Software Foundation, 59 Temple Place - Suite 330,
 Boston, MA 02111-1307, USA.  */
 
+#include "gofast.h"
+
+/* US Software GOFAST library support.  */
+#define INIT_SUBTARGET_OPTABS INIT_GOFAST_OPTABS
+
+#include "mips/mips.h"
+
+#undef WCHAR_TYPE
+#define WCHAR_TYPE "int"
+
+#undef WCHAR_TYPE_SIZE
+#define WCHAR_TYPE_SIZE 32
+
+/* If defined, a C expression whose value is a string containing the
+   assembler operation to identify the following data as
+   uninitialized global data.  If not defined, and neither
+   `ASM_OUTPUT_BSS' nor `ASM_OUTPUT_ALIGNED_BSS' are defined,
+   uninitialized global data will be output in the data section if
+   `-fno-common' is passed, otherwise `ASM_OUTPUT_COMMON' will be
+   used.  */
+#define BSS_SECTION_ASM_OP	"\t.section\t.bss"
+
+#define SBSS_SECTION_ASM_OP	"\t.section .sbss"
+
+/* Like `ASM_OUTPUT_BSS' except takes the required alignment as a
+   separate, explicit argument.  If you define this macro, it is used
+   in place of `ASM_OUTPUT_BSS', and gives you more flexibility in
+   handling the required alignment of the variable.  The alignment is
+   specified as the number of bits.
+
+   Try to use function `asm_output_aligned_bss' defined in file
+   `varasm.c' when defining this macro. */
+#define ASM_OUTPUT_ALIGNED_BSS(FILE, DECL, NAME, SIZE, ALIGN)	\
+do {								\
+  ASM_GLOBALIZE_LABEL (FILE, NAME);				\
+  if (SIZE > 0 && SIZE <= mips_section_threshold)		\
+    sbss_section ();						\
+  else								\
+    bss_section ();						\
+  ASM_OUTPUT_ALIGN (FILE, floor_log2 (ALIGN / BITS_PER_UNIT));	\
+  last_assemble_variable_decl = DECL;				\
+  ASM_DECLARE_OBJECT_NAME (FILE, NAME, DECL);			\
+  ASM_OUTPUT_SKIP (FILE, SIZE ? SIZE : 1);			\
+} while (0)
+
+/* These macros generate the special .type and .size directives which
+   are used to set the corresponding fields of the linker symbol table
+   entries in an ELF object file under SVR4.  These macros also output
+   the starting labels for the relevant functions/objects.  */
+
+/* Write the extra assembler code needed to declare an object properly.  */
+
+#undef ASM_DECLARE_OBJECT_NAME
+#define ASM_DECLARE_OBJECT_NAME(FILE, NAME, DECL)		\
+  do {								\
+    fprintf (FILE, "%s", TYPE_ASM_OP);				\
+    assemble_name (FILE, NAME);					\
+    putc (',', FILE);						\
+    fprintf (FILE, TYPE_OPERAND_FMT, "object");			\
+    putc ('\n', FILE);						\
+    size_directive_output = 0;					\
+    if (!flag_inhibit_size_directive && DECL_SIZE (DECL))	\
+      {								\
+	size_directive_output = 1;				\
+	fprintf (FILE, "%s", SIZE_ASM_OP);			\
+	assemble_name (FILE, NAME);				\
+	fprintf (FILE, ",%d\n",					\
+		 int_size_in_bytes (TREE_TYPE (DECL)));		\
+      }								\
+    mips_declare_object (FILE, NAME, "", ":\n", 0);		\
+  } while (0)
+
+#undef UNIQUE_SECTION
+#define UNIQUE_SECTION(DECL,RELOC) \
+  mips_unique_section ((DECL), (RELOC))
+
+/* A list of other sections which the compiler might be "in" at any
+   given time.  */
+#undef EXTRA_SECTIONS
+#define EXTRA_SECTIONS in_sdata, in_sbss, in_rdata, in_ctors, in_dtors
+ 
+#undef EXTRA_SECTION_FUNCTIONS
+#define EXTRA_SECTION_FUNCTIONS                                         \
+  SECTION_FUNCTION_TEMPLATE(sdata_section, in_sdata, SDATA_SECTION_ASM_OP) \
+  SECTION_FUNCTION_TEMPLATE(sbss_section, in_sbss, SBSS_SECTION_ASM_OP) \
+  SECTION_FUNCTION_TEMPLATE(rdata_section, in_rdata, RDATA_SECTION_ASM_OP) \
+  SECTION_FUNCTION_TEMPLATE(ctors_section, in_ctors, CTORS_SECTION_ASM_OP) \
+  SECTION_FUNCTION_TEMPLATE(dtors_section, in_dtors, DTORS_SECTION_ASM_OP)
+
+#define SECTION_FUNCTION_TEMPLATE(FN, ENUM, OP)			\
+void FN ()							\
+{								\
+  if (in_section != ENUM)					\
+    {								\
+      fprintf (asm_out_file, "%s\n", OP);			\
+      in_section = ENUM;					\
+    }								\
+}
+
+/* A C statement (sans semicolon) to output an element in the table of
+   global constructors.  */
+#undef ASM_OUTPUT_CONSTRUCTOR
+#define ASM_OUTPUT_CONSTRUCTOR(FILE,NAME)			  \
+  do {								  \
+    ctors_section ();						  \
+    fprintf (FILE, "\t%s\t", TARGET_LONG64 ? ".dword" : ".word"); \
+    assemble_name (FILE, NAME);					  \
+    fprintf (FILE, "\n");					  \
+  } while (0)
+
+
+/* A C statement (sans semicolon) to output an element in the table of
+   global destructors.  */
+#undef ASM_OUTPUT_DESTRUCTOR
+#define ASM_OUTPUT_DESTRUCTOR(FILE,NAME)			  \
+  do {								  \
+    dtors_section ();						  \
+    fprintf (FILE, "\t%s\t", TARGET_LONG64 ? ".dword" : ".word"); \
+    assemble_name (FILE, NAME);					  \
+    fprintf (FILE, "\n");					  \
+  } while (0)
+
 #undef TARGET_VERSION
 #if TARGET_ENDIAN_DEFAULT == 0
 #define TARGET_VERSION fprintf (stderr, " (MIPSel GNU/Linux with ELF)");
@@ -35,17 +157,6 @@ Boston, MA 02111-1307, USA.  */
 #undef TARGET_DEFAULT
 #define TARGET_DEFAULT (MASK_ABICALLS|MASK_GAS)
 
-
-/* Handle #pragma weak and #pragma pack.  */
-#undef HANDLE_SYSV_PRAGMA
-#define HANDLE_SYSV_PRAGMA 1
-
-/* Don't assume anything about the header files.  */
-#define NO_IMPLICIT_EXTERN_C
-
-/* Generate calls to memcpy, etc., not bcopy, etc.  */
-#define TARGET_MEM_FUNCTIONS
-
 /* Specify predefined symbols in preprocessor.  */
 #undef CPP_PREDEFINES
 #if TARGET_ENDIAN_DEFAULT == 0
@@ -112,40 +223,12 @@ Boston, MA 02111-1307, USA.  */
 -D_GNU_SOURCE %(cpp) \
 "
 
-/* Provide a STARTFILE_SPEC appropriate for GNU/Linux.  Here we add
-   the GNU/Linux magical crtbegin.o file (see crtstuff.c) which
-   provides part of the support for getting C++ file-scope static
-   object constructed before entering `main'. */
-
-#undef  STARTFILE_SPEC
-#define STARTFILE_SPEC \
-  "%{!shared: \
-     %{pg:gcrt1.o%s} %{!pg:%{p:gcrt1.o%s} %{!p:crt1.o%s}}}\
-   crti.o%s %{!shared:crtbegin.o%s} %{shared:crtbeginS.o%s}"
-
-/* Provide a ENDFILE_SPEC appropriate for GNU/Linux.  Here we tack on
-   the GNU/Linux magical crtend.o file (see crtstuff.c) which
-   provides part of the support for getting C++ file-scope static
-   object constructed before entering `main', followed by a normal
-   GNU/Linux "finalizer" file, `crtn.o'.  */
-
-#undef  ENDFILE_SPEC
-#define ENDFILE_SPEC \
-  "%{!shared:crtend.o%s} %{shared:crtendS.o%s} crtn.o%s"
-
 /* From iris5.h */
 /* -G is incompatible with -KPIC which is the default, so only allow objects
    in the small data section if the user explicitly asks for it.  */
 #undef MIPS_DEFAULT_GVALUE
 #define MIPS_DEFAULT_GVALUE 0
 
-#undef LIB_SPEC
-/* Taken from sparc/linux.h.  */
-#define LIB_SPEC \
-  "%{shared: -lc} \
-   %{!shared: %{mieee-fp:-lieee} %{pthread:-lpthread} \
-     %{profile:-lc_p} %{!profile: -lc}}"
-
 /* Borrowed from sparc/linux.h */
 #undef LINK_SPEC
 #define LINK_SPEC \
@@ -165,44 +248,19 @@ Boston, MA 02111-1307, USA.  */
 %{!fno-PIC:%{!fno-pic:-KPIC}} \
 %{fno-PIC:-non_shared} %{fno-pic:-non_shared}"
 
-/* We don't need those nonsenses.  */
-#undef INVOKE__main
-#undef CTOR_LIST_BEGIN
-#undef CTOR_LIST_END
-#undef DTOR_LIST_BEGIN
-#undef DTOR_LIST_END
-
 /* The MIPS assembler has different syntax for .set. We set it to
    .dummy to trap any errors.  */
 #undef SET_ASM_OP
 #define SET_ASM_OP "\t.dummy\t"
 
-#undef  ASM_OUTPUT_SOURCE_LINE
-#define ASM_OUTPUT_SOURCE_LINE(FILE, LINE)				\
-do									\
-  {									\
-    static int sym_lineno = 1;						\
-    fprintf (FILE, "%sLM%d:\n\t%s 68,0,%d,%sLM%d",			\
-	     LOCAL_LABEL_PREFIX, sym_lineno, ASM_STABN_OP,		\
-	     LINE, LOCAL_LABEL_PREFIX, sym_lineno);			\
-    putc ('-', FILE);							\
-    assemble_name (FILE,						\
-		   XSTR (XEXP (DECL_RTL (current_function_decl), 0), 0));\
-    putc ('\n', FILE);							\
-    sym_lineno++;							\
-  }									\
-while (0)
-
-/* This is how we tell the assembler that two symbols have the
-   same value.  */
 #undef ASM_OUTPUT_DEF
 #define ASM_OUTPUT_DEF(FILE,LABEL1,LABEL2)				\
-  do {									\
-	fprintf ((FILE), "\t");						\
+ do {									\
+	fputc ( '\t', FILE);						\
 	assemble_name (FILE, LABEL1);					\
-	fprintf (FILE, "=");						\
+	fputs ( " = ", FILE);						\
 	assemble_name (FILE, LABEL2);					\
-	fprintf (FILE, "\n");						\
+	fputc ( '\n', FILE);						\
  } while (0)
 
 #undef ASM_OUTPUT_DEFINE_LABEL_DIFFERENCE_SYMBOL
@@ -248,8 +306,3 @@ while (0)
 /* Tell function_prologue in mips.c that we have already output the .ent/.end
    pseudo-ops.  */
 #define FUNCTION_NAME_ALREADY_DECLARED
-
-/* Output #ident as a .ident.  */
-#undef ASM_OUTPUT_IDENT
-#define ASM_OUTPUT_IDENT(FILE, NAME) \
-  fprintf (FILE, "\t%s\t\"%s\"\n", IDENT_ASM_OP, NAME);
--- gcc/config/mips/little.h.linux	Wed Aug  1 14:04:44 2001
+++ gcc/config/mips/little.h	Wed Aug  1 16:09:31 2001
@@ -0,0 +1,22 @@
+/* Definition of little endian mips machine for GNU compiler.
+
+   Copyright (C) 2001 Free Software Foundation, Inc.
+
+This file is part of GNU CC.
+
+GNU CC is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2, or (at your option)
+any later version.
+
+GNU CC is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with GNU CC; see the file COPYING.  If not, write to
+the Free Software Foundation, 59 Temple Place - Suite 330,
+Boston, MA 02111-1307, USA.  */
+
+#define TARGET_ENDIAN_DEFAULT 0
--- gcc/config/mips/mips-protos.h.linux	Sun Jul 15 18:30:29 2001
+++ gcc/config/mips/mips-protos.h	Mon Aug  6 11:38:33 2001
@@ -60,6 +60,7 @@ extern void		mips_va_start PARAMS ((int,
 #endif /* RTX_CODE */
 extern struct rtx_def  *mips_va_arg PARAMS ((tree, tree));
 extern void		mips_select_section PARAMS ((tree, int));
+extern void		mips_unique_section PARAMS ((tree, int));
 #endif /* TREE_CODE */
 
 #ifdef RTX_CODE
--- gcc/config/mips/mips.c.linux	Thu Jul 26 10:13:51 2001
+++ gcc/config/mips/mips.c	Mon Aug  6 11:40:23 2001
@@ -9800,3 +9800,75 @@ mips_parse_cpu (cpu_string)
 
   return cpu;
 }
+
+/* Cover function for UNIQUE_SECTION.  */
+
+void
+mips_unique_section (decl, reloc)
+     tree decl;
+     int reloc;
+{
+  int len, size, sec;
+  char *name, *string, *prefix;
+  static char *prefixes[4][2] = {
+    { ".text.", ".gnu.linkonce.t." },
+    { ".rodata.", ".gnu.linkonce.r." },
+    { ".data.", ".gnu.linkonce.d." },
+    { ".sdata.", ".gnu.linkonce.s." }
+  };
+
+  name = IDENTIFIER_POINTER (DECL_ASSEMBLER_NAME (decl));
+  size = int_size_in_bytes (TREE_TYPE (decl));
+
+  /* Determine the base section we are interested in:
+     0=text, 1=rodata, 2=data, 3=sdata, [4=bss].  */
+  if (TREE_CODE (decl) == FUNCTION_DECL)
+    sec = 0;
+  else if (DECL_INITIAL (decl) == 0
+           || DECL_INITIAL (decl) == error_mark_node)
+    sec = 2;
+  else if ((TARGET_EMBEDDED_PIC || TARGET_MIPS16)
+      && TREE_CODE (decl) == STRING_CST
+      && !flag_writable_strings)
+    {
+      /* For embedded position independent code, put constant
+	 strings in the text section, because the data section
+	 is limited to 64K in size.  For mips16 code, put
+	 strings in the text section so that a PC relative load
+	 instruction can be used to get their address.  */
+      sec = 0;
+    }
+  else if (TARGET_EMBEDDED_DATA)
+    {
+      /* For embedded applications, always put an object in
+	 read-only data if possible, in order to reduce RAM
+	 usage.  */
+
+      if (DECL_READONLY_SECTION (decl, reloc))
+	sec = 1;
+      else if (size > 0 && size <= mips_section_threshold)
+	sec = 3;
+      else
+	sec = 2;
+    }
+  else
+    {
+      /* For hosted applications, always put an object in
+	 small data if possible, as this gives the best
+	 performance.  */
+
+      if (size > 0 && size <= mips_section_threshold)
+	sec = 3;
+      else if (DECL_READONLY_SECTION (decl, reloc))
+	sec = 1;
+      else
+	sec = 2;
+    }
+
+  prefix = prefixes[sec][DECL_ONE_ONLY (decl)];
+  len = strlen (name) + strlen (prefix);
+  string = alloca (len + 1);
+  sprintf (string, "%s%s", prefix, name);
+
+  DECL_SECTION_NAME (decl) = build_string (len, string);
+}
--- gcc/config/mips/mips.h.linux	Wed Aug  1 15:37:14 2001
+++ gcc/config/mips/mips.h	Mon Aug  6 11:27:03 2001
@@ -862,6 +862,7 @@ while (0)
 
 /* ASM_SPEC is the set of arguments to pass to the assembler.  */
 
+#undef ASM_SPEC
 #define ASM_SPEC "\
 %{!membedded-pic:%{G*}} %(endian_spec) %{mips1} %{mips2} %{mips3} %{mips4} \
 %{mips16:%{!mno-mips16:-mips16}} %{mno-mips16:-no-mips16} \
@@ -991,6 +992,7 @@ while (0)
 
 /* For C++ we need to ensure that _LANGUAGE_C_PLUS_PLUS is defined independent
    of the source file extension.  */
+#undef CPLUSPLUS_CPP_SPEC
 #define CPLUSPLUS_CPP_SPEC "\
 -D__LANGUAGE_C_PLUS_PLUS -D_LANGUAGE_C_PLUS_PLUS \
 %(cpp) \
@@ -3822,12 +3824,16 @@ while (0)
 /* Output to assembler file text saying following lines
    may contain character constants, extra white space, comments, etc.  */
 
+#ifndef ASM_APP_ON
 #define ASM_APP_ON " #APP\n"
+#endif
 
 /* Output to assembler file text saying following lines
    no longer contain unusual constructs.  */
 
+#ifndef ASM_APP_OFF
 #define ASM_APP_OFF " #NO_APP\n"
+#endif
 
 /* How to refer to registers in assembler output.
    This sequence is indexed by compiler's hard-register-number (see above).
@@ -4119,9 +4125,10 @@ while (0)
 #define LABEL_AFTER_LOC(STREAM)
 #endif
 
-#undef ASM_OUTPUT_SOURCE_LINE
+#ifndef ASM_OUTPUT_SOURCE_LINE
 #define ASM_OUTPUT_SOURCE_LINE(STREAM, LINE)				\
   mips_output_lineno (STREAM, LINE)
+#endif
 
 /* The MIPS implementation uses some labels for its own purpose.  The
    following lists what labels are created, and are all formed by the
@@ -4410,8 +4417,8 @@ do {									\
 /* Handle certain cpp directives used in header files on sysV.  */
 #define SCCS_DIRECTIVE
 
+#ifndef ASM_OUTPUT_IDENT
 /* Output #ident as a in the read-only data section.  */
-#undef ASM_OUTPUT_IDENT
 #define ASM_OUTPUT_IDENT(FILE, STRING)					\
 {									\
   const char *p = STRING;						\
@@ -4419,6 +4426,7 @@ do {									\
   rdata_section ();							\
   assemble_string (p, size);						\
 }
+#endif
 
 /* Default to -G 8 */
 #ifndef MIPS_DEFAULT_GVALUE

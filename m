Received:  by oss.sgi.com id <S42283AbQIHWaq>;
	Fri, 8 Sep 2000 15:30:46 -0700
Received: from u-182.karlsruhe.ipdial.viaginterkom.de ([62.180.10.182]:64262
        "EHLO u-182.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42227AbQIHWaZ>; Fri, 8 Sep 2000 15:30:25 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869120AbQIHS6L>;
        Fri, 8 Sep 2000 20:58:11 +0200
Date:   Fri, 8 Sep 2000 20:58:11 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ulf Carlsson <ulfc@engr.sgi.com>,
        Keith M Wesolowski <wesolows@foobazco.org>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Andreas Jaeger <aj@suse.de>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: One more gcc patch
Message-ID: <20000908205810.A11920@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ooops, this fixes a bug in the previous patch for gcc-current.  So this
patch does:

 - fix constructors which were not run for shared libs
 - fix warnings when building the compiler itself
 - Keith's gcse patch
 - gcc was generating code which was calling __main from the beginning of
   main which is wrong for Linux

  Ralf

diff -urN gcc-cygnus/gcc/config/mips/linux.h gcc/gcc/config/mips/linux.h
--- gcc-cygnus/gcc/config/mips/linux.h	Tue Aug 29 02:46:28 2000
+++ gcc/gcc/config/mips/linux.h	Sat Sep  9 17:06:28 2000
@@ -170,3 +170,20 @@
 %{mabi=64: -64} \
 %{!fno-PIC:%{!fno-pic:-KPIC}} \
 %{fno-PIC:-non_shared} %{fno-pic:-non_shared}"
+
+/* On svr4, we *do* have support for the .init and .fini sections, and we
+   can put stuff in there to be executed before and after `main'.  We let
+   crtstuff.c and other files know this by defining the following symbols.
+   The definitions say how to change sections to the .init and .fini
+   sections.  This is the same for all known svr4 assemblers.  */
+
+#define INIT_SECTION_ASM_OP     "\t.section\t.init"
+#define FINI_SECTION_ASM_OP     "\t.section\t.fini"
+
+/* Undef junk imported from mips/elf.h.  */
+#undef CTOR_LIST_BEGIN
+#undef CTOR_LIST_END
+#undef DTOR_LIST_BEGIN
+#undef DTOR_LIST_END
+
+#undef INVOKE__main
diff -urN gcc-cygnus/gcc/config/mips/mips.h gcc/gcc/config/mips/mips.h
--- gcc-cygnus/gcc/config/mips/mips.h	Tue Aug 29 02:46:28 2000
+++ gcc/gcc/config/mips/mips.h	Sat Sep  9 16:07:28 2000
@@ -1900,7 +1900,7 @@
 
 extern enum reg_class mips_char_to_class[];
 
-#define REG_CLASS_FROM_LETTER(C) mips_char_to_class[ (C) ]
+#define REG_CLASS_FROM_LETTER(C) mips_char_to_class[ (int) (C) ]
 
 /* The letters I, J, K, L, M, N, O, and P in a register constraint
    string can be used to stand for particular ranges of immediate
diff -urN gcc-cygnus/gcc/gcse.c gcc/gcc/gcse.c
--- gcc-cygnus/gcc/gcse.c	Mon Sep  4 03:00:56 2000
+++ gcc/gcc/gcse.c	Fri Sep  8 12:37:18 2000
@@ -1924,7 +1924,9 @@
 	  /* Don't GCSE something if we can't do a reg/reg copy.  */
 	  && can_copy_p [GET_MODE (dest)]
 	  /* Is SET_SRC something we want to gcse?  */
-	  && want_to_gcse_p (src))
+	  && want_to_gcse_p (src)
+	  /* Copy between modes is prohibited */
+	  && GET_MODE (src) == GET_MODE (dest))
 	{
 	  /* An expression is not anticipatable if its operands are
 	     modified before this insn.  */

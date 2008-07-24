Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2008 21:17:48 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:54913 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S28594551AbYGXURo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2008 21:17:44 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 8521798376;
	Thu, 24 Jul 2008 20:17:41 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id C6ECE98337;
	Thu, 24 Jul 2008 20:17:40 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1KM7Fs-0004XE-7N; Thu, 24 Jul 2008 16:17:40 -0400
Date:	Thu, 24 Jul 2008 16:17:39 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	binutils@sourceware.org, gcc@gcc.gnu.org
Cc:	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
Message-ID: <20080724201739.GA16724@caradoc.them.org>
Mail-Followup-To: binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
References: <87y74pxwyl.fsf@firetop.home> <20080724161619.GA18842@caradoc.them.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20080724161619.GA18842@caradoc.them.org>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2008 at 12:16:20PM -0400, Daniel Jacobowitz wrote:
> I have attached

Let's all pretend I attached this glibc patch, instead of the one in
my previous message, please.

-- 
Daniel Jacobowitz
CodeSourcery

--huq684BweRXVnRxX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="glibc-ports-nonpic.patch"

2008-07-24  Mark Shinwell  <shinwell@codesourcery.com>
	    Daniel Jacobowitz  <dan@codesourcery.com>
	    Richard Sandiford  <rdsandiford@googlemail.com>

	* sysdeps/mips/dl-lookup.c: New.
	* sysdeps/mips/do-lookup.h: New.
	* sysdeps/mips/dl-machine.h (ELF_MACHINE_NO_PLT): Remove
	definition.
	(ELF_MACHINE_JMP_SLOT): Alter definition and update comment.
	(elf_machine_type_class): Likewise.
	(ELF_MACHINE_PLT_REL): Define.
	(elf_machine_fixup_plt): New.
	(elf_machine_plt_value): New.
	(elf_machine_reloc): Handle jump slot and copy relocations.
	(elf_machine_lazy_rel): Point relocation place at PLT if
	required.
	(RESOLVE_GOTSYM): Take a relocation type argument.
	(elf_machine_got_rel): Bind lazy stubs directly to their target if
	!lazy.  Skip lazy binding for PLT symbols.
	(elf_machine_runtime_setup): Fill in .got.plt header.
	* sysdeps/mips/dl-trampoline.c (IFNEWABI): New macro.
	(_dl_runtime_pltresolve): New.
	* sysdeps/mips/bits/linkmap.h: New file.
	* sysdeps/mips/tls-macros.h: Load $gp as required.  Merge 32-bit and
	64-bit versions.

	* sysdeps/unix/sysv/linux/mips/mips32/sysdep.h (SYSCALL_ERROR_LABEL):
	Delete definition.
	* sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h (PSEUDO_CPLOAD,
	PSEUDO_ERRJMP, PSEUDO_SAVEGP, PSEUDO_LOADGP): Define.
	(PSEUDO): Use them.  Move outside __PIC__.
	(PSEUDO_JMP): New.
	(CENABLE, CDISABLE): Use it.

Index: sysdeps/unix/sysv/linux/mips/mips32/sysdep.h
===================================================================
--- sysdeps/unix/sysv/linux/mips/mips32/sysdep.h	(revision 213009)
+++ sysdeps/unix/sysv/linux/mips/mips32/sysdep.h	(working copy)
@@ -35,15 +35,7 @@
 # define SYS_ify(syscall_name)	__NR_/**/syscall_name
 #endif
 
-#ifdef __ASSEMBLER__
-
-/* We don't want the label for the error handler to be visible in the symbol
-   table when we define it here.  */
-#ifdef __PIC__
-# define SYSCALL_ERROR_LABEL 99b
-#endif
-
-#else   /* ! __ASSEMBLER__ */
+#ifndef __ASSEMBLER__
 
 /* Define a macro which expands into the inline wrapper code for a system
    call.  */
Index: sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h
===================================================================
--- sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h	(revision 213009)
+++ sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h	(working copy)
@@ -25,28 +25,38 @@
 
 #if !defined NOT_IN_libc || defined IS_IN_libpthread || defined IS_IN_librt
 
-#ifdef __PIC__
+# ifdef __PIC__
+#  define PSEUDO_CPLOAD .cpload t9;
+#  define PSEUDO_ERRJMP la t9, __syscall_error; jr t9;
+#  define PSEUDO_SAVEGP sw gp, 32(sp); cfi_rel_offset (gp, 32);
+#  define PSEUDO_LOADGP lw gp, 32(sp);
+# else
+#  define PSEUDO_CPLOAD
+#  define PSEUDO_ERRJMP j __syscall_error;
+#  define PSEUDO_SAVEGP
+#  define PSEUDO_LOADGP
+# endif
+
 # undef PSEUDO
 # define PSEUDO(name, syscall_name, args)				      \
       .align 2;								      \
   L(pseudo_start):							      \
       cfi_startproc;							      \
-  99: la t9,__syscall_error;						      \
-      jr t9;								      \
+  99: PSEUDO_ERRJMP							      \
   .type __##syscall_name##_nocancel, @function;				      \
   .globl __##syscall_name##_nocancel;					      \
   __##syscall_name##_nocancel:						      \
     .set noreorder;							      \
-    .cpload t9;								      \
+    PSEUDO_CPLOAD							      \
     li v0, SYS_ify(syscall_name);					      \
     syscall;								      \
     .set reorder;							      \
-    bne a3, zero, SYSCALL_ERROR_LABEL;			       		      \
+    bne a3, zero, 99b;					       		      \
     ret;								      \
   .size __##syscall_name##_nocancel,.-__##syscall_name##_nocancel;	      \
   ENTRY (name)								      \
     .set noreorder;							      \
-    .cpload t9;								      \
+    PSEUDO_CPLOAD							      \
     .set reorder;							      \
     SINGLE_THREAD_P(v1);						      \
     bne zero, v1, L(pseudo_cancel);					      \
@@ -54,17 +64,16 @@
     li v0, SYS_ify(syscall_name);					      \
     syscall;								      \
     .set reorder;							      \
-    bne a3, zero, SYSCALL_ERROR_LABEL;			       		      \
+    bne a3, zero, 99b;					       		      \
     ret;								      \
   L(pseudo_cancel):							      \
     SAVESTK_##args;						              \
     sw ra, 28(sp);							      \
     cfi_rel_offset (ra, 28);						      \
-    sw gp, 32(sp);							      \
-    cfi_rel_offset (gp, 32);						      \
+    PSEUDO_SAVEGP							      \
     PUSHARGS_##args;			/* save syscall args */	      	      \
     CENABLE;								      \
-    lw gp, 32(sp);							      \
+    PSEUDO_LOADGP							      \
     sw v0, 44(sp);			/* save mask */			      \
     POPARGS_##args;			/* restore syscall args */	      \
     .set noreorder;							      \
@@ -75,12 +84,12 @@
     sw a3, 40(sp);			/* save syscall error flag */	      \
     lw a0, 44(sp);			/* pass mask as arg1 */		      \
     CDISABLE;								      \
-    lw gp, 32(sp);							      \
+    PSEUDO_LOADGP							      \
     lw v0, 36(sp);			/* restore syscall result */          \
     lw a3, 40(sp);			/* restore syscall error flag */      \
     lw ra, 28(sp);			/* restore return address */	      \
     .set noreorder;							      \
-    bne a3, zero, SYSCALL_ERROR_LABEL;					      \
+    bne a3, zero, 99b;							      \
      RESTORESTK;						              \
   L(pseudo_end):							      \
     .set reorder;
@@ -88,8 +97,6 @@
 # undef PSEUDO_END
 # define PSEUDO_END(sym) cfi_endproc; .end sym; .size sym,.-sym
 
-#endif
-
 # define PUSHARGS_0	/* nothing to do */
 # define PUSHARGS_1	PUSHARGS_0 sw a0, 0(sp); cfi_rel_offset (a0, 0);
 # define PUSHARGS_2	PUSHARGS_1 sw a1, 4(sp); cfi_rel_offset (a1, 4);
@@ -136,19 +143,25 @@
 # define RESTORESTK 	addu sp, STKSPACE; cfi_adjust_cfa_offset(-STKSPACE)
 
 
+# ifdef __PIC__
 /* We use jalr rather than jal.  This means that the assembler will not
    automatically restore $gp (in case libc has multiple GOTs) so we must
    do it manually - which we have to do anyway since we don't use .cprestore.
    It also shuts up the assembler warning about not using .cprestore.  */
+#  define PSEUDO_JMP(sym) la t9, sym; jalr t9;
+# else
+#  define PSEUDO_JMP(sym) jal sym;
+# endif
+
 # ifdef IS_IN_libpthread
-#  define CENABLE	la t9, __pthread_enable_asynccancel; jalr t9;
-#  define CDISABLE	la t9, __pthread_disable_asynccancel; jalr t9;
+#  define CENABLE	PSEUDO_JMP (__pthread_enable_asynccancel)
+#  define CDISABLE	PSEUDO_JMP (__pthread_disable_asynccancel)
 # elif defined IS_IN_librt
-#  define CENABLE	la t9, __librt_enable_asynccancel; jalr t9;
-#  define CDISABLE	la t9, __librt_disable_asynccancel; jalr t9;
+#  define CENABLE	PSEUDO_JMP (__librt_enable_asynccancel)
+#  define CDISABLE	PSEUDO_JMP (__librt_disable_asynccancel)
 # else
-#  define CENABLE	la t9, __libc_enable_asynccancel; jalr t9;
-#  define CDISABLE	la t9, __libc_disable_asynccancel; jalr t9;
+#  define CENABLE	PSEUDO_JMP (__libc_enable_asynccancel)
+#  define CDISABLE	PSEUDO_JMP (__libc_disable_asynccancel)
 # endif
 
 # ifndef __ASSEMBLER__
Index: sysdeps/mips/do-lookup.h
===================================================================
--- sysdeps/mips/do-lookup.h	(revision 0)
+++ sysdeps/mips/do-lookup.h	(revision 0)
@@ -0,0 +1,37 @@
+/* MIPS-specific veneer to GLIBC's do-lookup.h.
+   Copyright (C) 2008 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+/* The semantics of zero/non-zero values of undefined symbols differs
+   depending on whether the non-PIC ABI is in use.  Under the non-PIC ABI,
+   a non-zero value indicates that there is an address reference to the
+   symbol and thus it must always be resolved (except when resolving a jump
+   slot relocation) to the PLT entry whose address is provided as the
+   symbol's value; a zero value indicates that this canonical-address
+   behaviour is not required.  Yet under the classic MIPS psABI, a zero value
+   indicates that there is an address reference to the function and the
+   dynamic linker must resolve the symbol immediately upon loading.  To
+   avoid conflict, symbols for which the dynamic linker must assume the
+   non-PIC ABI semantics are marked with the STO_MIPS_PLT flag.  The
+   following ugly hack causes the code in the platform-independent
+   do-lookup.h file to check this flag correctly.  */
+#define st_value st_shndx == SHN_UNDEF && !(sym->st_other & STO_MIPS_PLT)) \
+		 || (sym->st_value
+#include_next "do-lookup.h"
+#undef st_value
+
Index: sysdeps/mips/tls-macros.h
===================================================================
--- sysdeps/mips/tls-macros.h	(revision 213009)
+++ sysdeps/mips/tls-macros.h	(working copy)
@@ -1,44 +1,56 @@
 /* Macros to support TLS testing in times of missing compiler support.  */
 
-#if _MIPS_SIM != _ABI64
+#include <sys/cdefs.h>
+#include <sys/asm.h>
 
-/* These versions are for o32 and n32.  */
-
-# define TLS_GD(x)					\
-  ({ void *__result;					\
-     extern void *__tls_get_addr (void *);		\
-     asm ("addiu %0, $28, %%tlsgd(" #x ")"		\
-	  : "=r" (__result));				\
-     (int *)__tls_get_addr (__result); })
+#define __STRING2(X) __STRING(X)
+#define ADDU __STRING2(PTR_ADDU)
+#define ADDIU __STRING2(PTR_ADDIU)
+#define LW __STRING2(PTR_L)
+
+/* Load the GOT pointer, which may not be in $28 in a non-PIC
+   (abicalls pic0) function.  */
+#ifndef __PIC__
+# if _MIPS_SIM != _ABI64
+#  define LOAD_GP "move %[tmp], $28\n\tla $28, __gnu_local_gp\n\t"
+# else
+#  define LOAD_GP "move %[tmp], $28\n\tdla $28, __gnu_local_gp\n\t"
+# endif
+# define UNLOAD_GP "\n\tmove $28, %[tmp]"
 #else
+# define LOAD_GP
+# define UNLOAD_GP
+#endif
+
 # define TLS_GD(x)					\
-  ({ void *__result;					\
+  ({ void *__result, *__tmp;				\
      extern void *__tls_get_addr (void *);		\
-     asm ("daddiu %0, $28, %%tlsgd(" #x ")"		\
-	  : "=r" (__result));				\
+     asm (LOAD_GP ADDIU " %0, $28, %%tlsgd(" #x ")"	\
+	  UNLOAD_GP					\
+	  : "=r" (__result), [tmp] "=&r" (__tmp));	\
      (int *)__tls_get_addr (__result); })
-#endif
-
-#if _MIPS_SIM != _ABI64
 # define TLS_LD(x)					\
-  ({ void *__result;					\
+  ({ void *__result, *__tmp;				\
      extern void *__tls_get_addr (void *);		\
-     asm ("addiu %0, $28, %%tlsldm(" #x ")"		\
-	  : "=r" (__result));				\
+     asm (LOAD_GP ADDIU " %0, $28, %%tlsldm(" #x ")"	\
+	  UNLOAD_GP					\
+	  : "=r" (__result), [tmp] "=&r" (__tmp));	\
      __result = __tls_get_addr (__result);		\
      asm ("lui $3,%%dtprel_hi(" #x ")\n\t"		\
 	  "addiu $3,$3,%%dtprel_lo(" #x ")\n\t"		\
-	  "addu %0,%0,$3"				\
+	  ADDU " %0,%0,$3"				\
 	  : "+r" (__result) : : "$3");			\
      __result; })
 # define TLS_IE(x)					\
-  ({ void *__result;					\
+  ({ void *__result, *__tmp;				\
      asm (".set push\n\t.set mips32r2\n\t"		\
 	  "rdhwr\t%0,$29\n\t.set pop"			\
 	  : "=v" (__result));				\
-     asm ("lw $3,%%gottprel(" #x ")($28)\n\t"		\
-	  "addu %0,%0,$3"				\
-	  : "+r" (__result) : : "$3");			\
+     asm (LOAD_GP LW " $3,%%gottprel(" #x ")($28)\n\t"	\
+	  ADDU " %0,%0,$3"				\
+	  UNLOAD_GP					\
+	  : "+r" (__result), [tmp] "=&r" (__tmp)	\
+	  : : "$3");					\
      __result; })
 # define TLS_LE(x)					\
   ({ void *__result;					\
@@ -47,42 +59,6 @@
 	  : "=v" (__result));				\
      asm ("lui $3,%%tprel_hi(" #x ")\n\t"		\
 	  "addiu $3,$3,%%tprel_lo(" #x ")\n\t"		\
-	  "addu %0,%0,$3"				\
-	  : "+r" (__result) : : "$3");			\
-     __result; })
-
-#else
-
-/* These versions are for n64.  */
-
-# define TLS_LD(x)					\
-  ({ void *__result;					\
-     extern void *__tls_get_addr (void *);		\
-     asm ("daddiu %0, $28, %%tlsldm(" #x ")"		\
-	  : "=r" (__result));				\
-     __result = __tls_get_addr (__result);		\
-     asm ("lui $3,%%dtprel_hi(" #x ")\n\t"		\
-	  "daddiu $3,$3,%%dtprel_lo(" #x ")\n\t"	\
-	  "daddu %0,%0,$3"				\
-	  : "+r" (__result) : : "$3");			\
-     __result; })
-# define TLS_IE(x)					\
-  ({ void *__result;					\
-     asm (".set push\n\t.set mips32r2\n\t"		\
-	  "rdhwr\t%0,$29\n\t.set pop"			\
-	  : "=v" (__result));				\
-     asm ("ld $3,%%gottprel(" #x ")($28)\n\t"		\
-	  "daddu %0,%0,$3"				\
-	  : "+r" (__result) : : "$3");			\
-     __result; })
-# define TLS_LE(x)					\
-  ({ void *__result;					\
-     asm (".set push\n\t.set mips32r2\n\t"		\
-	  "rdhwr\t%0,$29\n\t.set pop"			\
-	  : "=v" (__result));				\
-     asm ("lui $3,%%tprel_hi(" #x ")\n\t"		\
-	  "daddiu $3,$3,%%tprel_lo(" #x ")\n\t"		\
-	  "daddu %0,%0,$3"				\
+	  ADDU " %0,%0,$3"				\
 	  : "+r" (__result) : : "$3");			\
      __result; })
-#endif
Index: sysdeps/mips/dl-machine.h
===================================================================
--- sysdeps/mips/dl-machine.h	(revision 213009)
+++ sysdeps/mips/dl-machine.h	(working copy)
@@ -25,8 +25,6 @@
 
 #define ELF_MACHINE_NAME "MIPS"
 
-#define ELF_MACHINE_NO_PLT
-
 #include <entry.h>
 
 #ifndef ENTRY_POINT
@@ -56,10 +54,14 @@
 #endif
 
 /* A reloc type used for ld.so cmdline arg lookups to reject PLT entries.
-   This makes no sense on MIPS but we have to define this to R_MIPS_REL32
-   to avoid the asserts in dl-lookup.c from blowing.  */
-#define ELF_MACHINE_JMP_SLOT			R_MIPS_REL32
-#define elf_machine_type_class(type)		ELF_RTYPE_CLASS_PLT
+   This only makes sense on MIPS when using PLTs, so choose the
+   PLT relocation (not encountered when not using PLTs).  */
+#define ELF_MACHINE_JMP_SLOT			R_MIPS_JUMP_SLOT
+#define elf_machine_type_class(type) \
+  ((((type) == ELF_MACHINE_JMP_SLOT) * ELF_RTYPE_CLASS_PLT)	\
+   | (((type) == R_MIPS_COPY) * ELF_RTYPE_CLASS_COPY))
+
+#define ELF_MACHINE_PLT_REL 1
 
 /* Translate a processor specific dynamic tag to the index
    in l_info array.  */
@@ -73,6 +75,15 @@ do { if ((l)->l_info[DT_MIPS (RLD_MAP)])
        (ElfW(Addr)) (r); \
    } while (0)
 
+/* Allow ABIVERSION == 1, meaning PLTs and copy relocations are
+   required.  */
+#define VALID_ELF_ABIVERSION(ver)	(ver == 0 || ver == 2)
+#define VALID_ELF_OSABI(osabi)		(osabi == ELFOSABI_SYSV)
+#define VALID_ELF_HEADER(hdr,exp,size) \
+  memcmp (hdr,exp,size-2) == 0 \
+  && VALID_ELF_OSABI (hdr[EI_OSABI]) \
+  && VALID_ELF_ABIVERSION (hdr[EI_ABIVERSION])
+
 /* Return nonzero iff ELF header is compatible with the running host.  */
 static inline int __attribute_used__
 elf_machine_matches_host (const ElfW(Ehdr) *ehdr)
@@ -294,6 +305,24 @@ do {									\
 #  define ARCH_LA_PLTEXIT mips_n64_gnu_pltexit
 # endif
 
+/* For a non-writable PLT, rewrite the .got.plt entry at RELOC_ADDR to
+   point at the symbol with address VALUE.  For a writable PLT, rewrite
+   the corresponding PLT entry instead.  */
+static inline ElfW(Addr)
+elf_machine_fixup_plt (struct link_map *map, lookup_t t,
+		       const ElfW(Rel) *reloc,
+		       ElfW(Addr) *reloc_addr, ElfW(Addr) value)
+{
+  return *reloc_addr = value;
+}
+
+static inline ElfW(Addr)
+elf_machine_plt_value (struct link_map *map, const ElfW(Rel) *reloc,
+		       ElfW(Addr) value)
+{
+  return value;
+}
+
 #endif /* !dl_machine_h */
 
 #ifdef RESOLVE_MAP
@@ -461,6 +490,57 @@ elf_machine_reloc (struct link_map *map,
 #endif
     case R_MIPS_NONE:		/* Alright, Wilbur.  */
       break;
+
+    case R_MIPS_JUMP_SLOT:
+      {
+	struct link_map *sym_map;
+	ElfW(Addr) value;
+
+	/* The addend for a jump slot relocation must always be zero:
+	   calls via the PLT always branch to the symbol's address and
+	   not to the address plus a non-zero offset.  */
+	if (r_addend != 0)
+	  _dl_signal_error (0, map->l_name, NULL,
+			    "found jump slot relocation with non-zero addend");
+
+	sym_map = RESOLVE_MAP (&sym, version, r_type);
+	value = sym_map == NULL ? 0 : sym_map->l_addr + sym->st_value;
+	*addr_field = value;
+
+	break;
+      }
+
+    case R_MIPS_COPY:
+      {
+	const ElfW(Sym) *const refsym = sym;
+	struct link_map *sym_map;
+	ElfW(Addr) value;
+
+	/* Calculate the address of the symbol.  */
+	sym_map = RESOLVE_MAP (&sym, version, r_type);
+	value = sym_map == NULL ? 0 : sym_map->l_addr + sym->st_value;
+
+	if (__builtin_expect (sym == NULL, 0))
+	  /* This can happen in trace mode if an object could not be
+	     found.  */
+	  break;
+	if (__builtin_expect (sym->st_size > refsym->st_size, 0)
+	    || (__builtin_expect (sym->st_size < refsym->st_size, 0)
+		&& GLRO(dl_verbose)))
+	  {
+	    const char *strtab;
+
+	    strtab = (const void *) D_PTR (map, l_info[DT_STRTAB]);
+	    _dl_error_printf ("\
+  %s: Symbol `%s' has different size in shared object, consider re-linking\n",
+			      rtld_progname ?: "<program name unknown>",
+			      strtab + refsym->st_name);
+	  }
+	memcpy (reloc_addr, (void *) value,
+	        MIN (sym->st_size, refsym->st_size));
+	break;
+      }
+
 #if _MIPS_SIM == _ABI64
     case R_MIPS_64:
       /* For full compliance with the ELF64 ABI, one must precede the
@@ -505,9 +585,23 @@ elf_machine_rel_relative (ElfW(Addr) l_a
 auto inline void
 __attribute__((always_inline))
 elf_machine_lazy_rel (struct link_map *map,
-		      ElfW(Addr) l_addr, const ElfW(Rela) *reloc)
+		      ElfW(Addr) l_addr, const ElfW(Rel) *reloc)
 {
-  /* Do nothing.  */
+  ElfW(Addr) *const reloc_addr = (void *) (l_addr + reloc->r_offset);
+  const unsigned int r_type = ELFW(R_TYPE) (reloc->r_info);
+  /* Check for unexpected PLT reloc type.  */
+  if (__builtin_expect (r_type == R_MIPS_JUMP_SLOT, 1))
+    {
+      if (__builtin_expect (map->l_mach.plt, 0) == 0)
+	{
+	  /* Nothing is required here since we only support lazy
+	     relocation in executables.  */
+	}
+      else
+	*reloc_addr = map->l_mach.plt;
+    }
+  else
+    _dl_reloc_bad_type (map, r_type, 1);
 }
 
 auto inline void
@@ -538,13 +632,13 @@ elf_machine_got_rel (struct link_map *ma
   const ElfW(Half) *vernum;
   int i, n, symidx;
 
-#define RESOLVE_GOTSYM(sym,vernum,sym_index)				  \
+#define RESOLVE_GOTSYM(sym,vernum,sym_index,reloc)			  \
     ({									  \
       const ElfW(Sym) *ref = sym;					  \
       const struct r_found_version *version				  \
         = vernum ? &map->l_versions[vernum[sym_index] & 0x7fff] : NULL;	  \
       struct link_map *sym_map;						  \
-      sym_map = RESOLVE_MAP (&ref, version, R_MIPS_REL32);		  \
+      sym_map = RESOLVE_MAP (&ref, version, reloc);			  \
       ref ? sym_map->l_addr + ref->st_value : 0;			  \
     })
 
@@ -585,25 +679,38 @@ elf_machine_got_rel (struct link_map *ma
     {
       if (sym->st_shndx == SHN_UNDEF)
 	{
-	  if (ELFW(ST_TYPE) (sym->st_info) == STT_FUNC
-	      && sym->st_value && lazy)
-	    *got = sym->st_value + map->l_addr;
+	  if (ELFW(ST_TYPE) (sym->st_info) == STT_FUNC && sym->st_value
+	      && !(sym->st_other & STO_MIPS_PLT))
+	    {
+	      if (lazy)
+		*got = sym->st_value + map->l_addr;
+	      else
+		/* This is a lazy-binding stub, so we don't need the
+		   canonical address.  */
+		*got = RESOLVE_GOTSYM (sym, vernum, symidx, R_MIPS_JUMP_SLOT);
+	    }
 	  else
-	    *got = RESOLVE_GOTSYM (sym, vernum, symidx);
+	    *got = RESOLVE_GOTSYM (sym, vernum, symidx, R_MIPS_32);
 	}
       else if (sym->st_shndx == SHN_COMMON)
-	*got = RESOLVE_GOTSYM (sym, vernum, symidx);
+	*got = RESOLVE_GOTSYM (sym, vernum, symidx, R_MIPS_32);
       else if (ELFW(ST_TYPE) (sym->st_info) == STT_FUNC
-	       && *got != sym->st_value
-	       && lazy)
-	*got += map->l_addr;
+	       && *got != sym->st_value)
+	{
+	  if (lazy)
+	    *got += map->l_addr;
+	  else
+	    /* This is a lazy-binding stub, so we don't need the
+	       canonical address.  */
+	    *got = RESOLVE_GOTSYM (sym, vernum, symidx, R_MIPS_JUMP_SLOT);
+	}
       else if (ELFW(ST_TYPE) (sym->st_info) == STT_SECTION)
 	{
 	  if (sym->st_other == 0)
 	    *got += map->l_addr;
 	}
       else
-	*got = RESOLVE_GOTSYM (sym, vernum, symidx);
+	*got = RESOLVE_GOTSYM (sym, vernum, symidx, R_MIPS_32);
 
       ++got;
       ++sym;
@@ -624,6 +731,7 @@ elf_machine_runtime_setup (struct link_m
 # ifndef RTLD_BOOTSTRAP
   ElfW(Addr) *got;
   extern void _dl_runtime_resolve (ElfW(Word));
+  extern void _dl_runtime_pltresolve (void);
   extern int _dl_mips_gnu_objects;
 
   if (lazy)
@@ -650,6 +758,20 @@ elf_machine_runtime_setup (struct link_m
   /* Relocate global offset table.  */
   elf_machine_got_rel (l, lazy);
 
+  /* If using PLTs, fill in the first two entries of .got.plt.  */
+  if (l->l_info[DT_JMPREL] && lazy)
+    {
+      ElfW(Addr) *gotplt;
+      gotplt = (ElfW(Addr) *) D_PTR (l, l_info[DT_MIPS (PLTGOT)]);
+      /* If a library is prelinked but we have to relocate anyway,
+	 we have to be able to undo the prelinking of .got.plt.
+	 The prelinker saved the address of .plt for us here.  */
+      if (gotplt[1])
+	l->l_mach.plt = gotplt[1] + l->l_addr;
+      gotplt[0] = (ElfW(Addr)) &_dl_runtime_pltresolve;
+      gotplt[1] = (ElfW(Addr)) l;
+    }
+
 # endif
   return lazy;
 }
Index: sysdeps/mips/dl-lookup.c
===================================================================
--- sysdeps/mips/dl-lookup.c	(revision 0)
+++ sysdeps/mips/dl-lookup.c	(revision 0)
@@ -0,0 +1,581 @@
+/* Look up a symbol in the loaded objects.
+   MIPS/Linux version - this is identical to the common version, but
+   because it is in sysdeps/mips, it gets sysdeps/mips/do-lookup.h.
+   Using <do-lookup.h> instead of "do-lookup.h" would work too.
+
+   Copyright (C) 1995-2005, 2006, 2007 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <alloca.h>
+#include <libintl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ldsodefs.h>
+#include <dl-hash.h>
+#include <dl-machine.h>
+#include <sysdep-cancel.h>
+#include <bits/libc-lock.h>
+#include <tls.h>
+
+#include <assert.h>
+
+#define VERSTAG(tag)	(DT_NUM + DT_THISPROCNUM + DT_VERSIONTAGIDX (tag))
+
+/* We need this string more than once.  */
+static const char undefined_msg[] = "undefined symbol: ";
+
+
+struct sym_val
+  {
+    const ElfW(Sym) *s;
+    struct link_map *m;
+  };
+
+
+#define make_string(string, rest...) \
+  ({									      \
+    const char *all[] = { string, ## rest };				      \
+    size_t len, cnt;							      \
+    char *result, *cp;							      \
+									      \
+    len = 1;								      \
+    for (cnt = 0; cnt < sizeof (all) / sizeof (all[0]); ++cnt)		      \
+      len += strlen (all[cnt]);						      \
+									      \
+    cp = result = alloca (len);						      \
+    for (cnt = 0; cnt < sizeof (all) / sizeof (all[0]); ++cnt)		      \
+      cp = __stpcpy (cp, all[cnt]);					      \
+									      \
+    result;								      \
+  })
+
+/* Statistics function.  */
+#ifdef SHARED
+# define bump_num_relocations() ++GL(dl_num_relocations)
+#else
+# define bump_num_relocations() ((void) 0)
+#endif
+
+
+/* The actual lookup code.  */
+#include "do-lookup.h"
+
+
+static uint_fast32_t
+dl_new_hash (const char *s)
+{
+  uint_fast32_t h = 5381;
+  for (unsigned char c = *s; c != '\0'; c = *++s)
+    h = h * 33 + c;
+  return h & 0xffffffff;
+}
+
+
+/* Add extra dependency on MAP to UNDEF_MAP.  */
+static int
+internal_function
+add_dependency (struct link_map *undef_map, struct link_map *map, int flags)
+{
+  struct link_map *runp;
+  unsigned int i;
+  int result = 0;
+
+  /* Avoid self-references and references to objects which cannot be
+     unloaded anyway.  */
+  if (undef_map == map)
+    return 0;
+
+  /* Avoid references to objects which cannot be unloaded anyway.  */
+  assert (map->l_type == lt_loaded);
+  if ((map->l_flags_1 & DF_1_NODELETE) != 0)
+    return 0;
+
+  struct link_map_reldeps *l_reldeps
+    = atomic_forced_read (undef_map->l_reldeps);
+
+  /* Make sure l_reldeps is read before l_initfini.  */
+  atomic_read_barrier ();
+
+  /* Determine whether UNDEF_MAP already has a reference to MAP.  First
+     look in the normal dependencies.  */
+  struct link_map **l_initfini = atomic_forced_read (undef_map->l_initfini);
+  if (l_initfini != NULL)
+    {
+      for (i = 0; l_initfini[i] != NULL; ++i)
+	if (l_initfini[i] == map)
+	  return 0;
+    }
+
+  /* No normal dependency.  See whether we already had to add it
+     to the special list of dynamic dependencies.  */
+  unsigned int l_reldepsact = 0;
+  if (l_reldeps != NULL)
+    {
+      struct link_map **list = &l_reldeps->list[0];
+      l_reldepsact = l_reldeps->act;
+      for (i = 0; i < l_reldepsact; ++i)
+	if (list[i] == map)
+	  return 0;
+    }
+
+  /* Save serial number of the target MAP.  */
+  unsigned long long serial = map->l_serial;
+
+  /* Make sure nobody can unload the object while we are at it.  */
+  if (__builtin_expect (flags & DL_LOOKUP_GSCOPE_LOCK, 0))
+    {
+      /* We can't just call __rtld_lock_lock_recursive (GL(dl_load_lock))
+	 here, that can result in ABBA deadlock.  */
+      THREAD_GSCOPE_RESET_FLAG ();
+      __rtld_lock_lock_recursive (GL(dl_load_lock));
+      /* While MAP value won't change, after THREAD_GSCOPE_RESET_FLAG ()
+	 it can e.g. point to unallocated memory.  So avoid the optimizer
+	 treating the above read from MAP->l_serial as ensurance it
+	 can safely dereference it.  */
+      map = atomic_forced_read (map);
+
+      /* From this point on it is unsafe to dereference MAP, until it
+	 has been found in one of the lists.  */
+
+      /* Redo the l_initfini check in case undef_map's l_initfini
+	 changed in the mean time.  */
+      if (undef_map->l_initfini != l_initfini
+	  && undef_map->l_initfini != NULL)
+	{
+	  l_initfini = undef_map->l_initfini;
+	  for (i = 0; l_initfini[i] != NULL; ++i)
+	    if (l_initfini[i] == map)
+	      goto out_check;
+	}
+
+      /* Redo the l_reldeps check if undef_map's l_reldeps changed in
+	 the mean time.  */
+      if (undef_map->l_reldeps != NULL)
+	{
+	  if (undef_map->l_reldeps != l_reldeps)
+	    {
+	      struct link_map **list = &undef_map->l_reldeps->list[0];
+	      l_reldepsact = undef_map->l_reldeps->act;
+	      for (i = 0; i < l_reldepsact; ++i)
+		if (list[i] == map)
+		  goto out_check;
+	    }
+	  else if (undef_map->l_reldeps->act > l_reldepsact)
+	    {
+	      struct link_map **list
+		= &undef_map->l_reldeps->list[0];
+	      i = l_reldepsact;
+	      l_reldepsact = undef_map->l_reldeps->act;
+	      for (; i < l_reldepsact; ++i)
+		if (list[i] == map)
+		  goto out_check;
+	    }
+	}
+    }
+  else
+    __rtld_lock_lock_recursive (GL(dl_load_lock));
+
+  /* The object is not yet in the dependency list.  Before we add
+     it make sure just one more time the object we are about to
+     reference is still available.  There is a brief period in
+     which the object could have been removed since we found the
+     definition.  */
+  runp = GL(dl_ns)[undef_map->l_ns]._ns_loaded;
+  while (runp != NULL && runp != map)
+    runp = runp->l_next;
+
+  if (runp != NULL)
+    {
+      /* The object is still available.  */
+
+      /* MAP could have been dlclosed, freed and then some other dlopened
+	 library could have the same link_map pointer.  */
+      if (map->l_serial != serial)
+	goto out_check;
+
+      /* Redo the NODELETE check, as when dl_load_lock wasn't held
+	 yet this could have changed.  */
+      if ((map->l_flags_1 & DF_1_NODELETE) != 0)
+	goto out;
+
+      /* If the object with the undefined reference cannot be removed ever
+	 just make sure the same is true for the object which contains the
+	 definition.  */
+      if (undef_map->l_type != lt_loaded
+	  || (undef_map->l_flags_1 & DF_1_NODELETE) != 0)
+	{
+	  map->l_flags_1 |= DF_1_NODELETE;
+	  goto out;
+	}
+
+      /* Add the reference now.  */
+      if (__builtin_expect (l_reldepsact >= undef_map->l_reldepsmax, 0))
+	{
+	  /* Allocate more memory for the dependency list.  Since this
+	     can never happen during the startup phase we can use
+	     `realloc'.  */
+	  struct link_map_reldeps *newp;
+	  unsigned int max
+	    = undef_map->l_reldepsmax ? undef_map->l_reldepsmax * 2 : 10;
+
+	  newp = malloc (sizeof (*newp) + max * sizeof (struct link_map *));
+	  if (newp == NULL)
+	    {
+	      /* If we didn't manage to allocate memory for the list this is
+		 no fatal problem.  We simply make sure the referenced object
+		 cannot be unloaded.  This is semantically the correct
+		 behavior.  */
+	      map->l_flags_1 |= DF_1_NODELETE;
+	      goto out;
+	    }
+	  else
+	    {
+	      if (l_reldepsact)
+		memcpy (&newp->list[0], &undef_map->l_reldeps->list[0],
+			l_reldepsact * sizeof (struct link_map *));
+	      newp->list[l_reldepsact] = map;
+	      newp->act = l_reldepsact + 1;
+	      atomic_write_barrier ();
+	      void *old = undef_map->l_reldeps;
+	      undef_map->l_reldeps = newp;
+	      undef_map->l_reldepsmax = max;
+	      if (old)
+		_dl_scope_free (old);
+	    }
+	}
+      else
+	{
+	  undef_map->l_reldeps->list[l_reldepsact] = map;
+	  atomic_write_barrier ();
+	  undef_map->l_reldeps->act = l_reldepsact + 1;
+	}
+
+      /* Display information if we are debugging.  */
+      if (__builtin_expect (GLRO(dl_debug_mask) & DL_DEBUG_FILES, 0))
+	_dl_debug_printf ("\
+\nfile=%s [%lu];  needed by %s [%lu] (relocation dependency)\n\n",
+			  map->l_name[0] ? map->l_name : rtld_progname,
+			  map->l_ns,
+			  undef_map->l_name[0]
+			  ? undef_map->l_name : rtld_progname,
+			  undef_map->l_ns);
+    }
+  else
+    /* Whoa, that was bad luck.  We have to search again.  */
+    result = -1;
+
+ out:
+  /* Release the lock.  */
+  __rtld_lock_unlock_recursive (GL(dl_load_lock));
+
+  if (__builtin_expect (flags & DL_LOOKUP_GSCOPE_LOCK, 0))
+    THREAD_GSCOPE_SET_FLAG ();
+
+  return result;
+
+ out_check:
+  if (map->l_serial != serial)
+    result = -1;
+  goto out;
+}
+
+static void
+internal_function
+_dl_debug_bindings (const char *undef_name, struct link_map *undef_map,
+		    const ElfW(Sym) **ref, struct sym_val *value,
+		    const struct r_found_version *version, int type_class,
+		    int protected);
+
+
+/* Search loaded objects' symbol tables for a definition of the symbol
+   UNDEF_NAME, perhaps with a requested version for the symbol.
+
+   We must never have calls to the audit functions inside this function
+   or in any function which gets called.  If this would happen the audit
+   code might create a thread which can throw off all the scope locking.  */
+lookup_t
+internal_function
+_dl_lookup_symbol_x (const char *undef_name, struct link_map *undef_map,
+		     const ElfW(Sym) **ref,
+		     struct r_scope_elem *symbol_scope[],
+		     const struct r_found_version *version,
+		     int type_class, int flags, struct link_map *skip_map)
+{
+  const uint_fast32_t new_hash = dl_new_hash (undef_name);
+  unsigned long int old_hash = 0xffffffff;
+  struct sym_val current_value = { NULL, NULL };
+  struct r_scope_elem **scope = symbol_scope;
+
+  bump_num_relocations ();
+
+  /* No other flag than DL_LOOKUP_ADD_DEPENDENCY or DL_LOOKUP_GSCOPE_LOCK
+     is allowed if we look up a versioned symbol.  */
+  assert (version == NULL
+	  || (flags & ~(DL_LOOKUP_ADD_DEPENDENCY | DL_LOOKUP_GSCOPE_LOCK))
+	     == 0);
+
+  size_t i = 0;
+  if (__builtin_expect (skip_map != NULL, 0))
+    /* Search the relevant loaded objects for a definition.  */
+    while ((*scope)->r_list[i] != skip_map)
+      ++i;
+
+  /* Search the relevant loaded objects for a definition.  */
+  for (size_t start = i; *scope != NULL; start = 0, ++scope)
+    {
+      int res = do_lookup_x (undef_name, new_hash, &old_hash, *ref,
+			     &current_value, *scope, start, version, flags,
+			     skip_map, type_class);
+      if (res > 0)
+	break;
+
+      if (__builtin_expect (res, 0) < 0 && skip_map == NULL)
+	{
+	  /* Oh, oh.  The file named in the relocation entry does not
+	     contain the needed symbol.  This code is never reached
+	     for unversioned lookups.  */
+	  assert (version != NULL);
+	  const char *reference_name = undef_map ? undef_map->l_name : NULL;
+
+	  /* XXX We cannot translate the message.  */
+	  _dl_signal_cerror (0, (reference_name[0]
+				 ? reference_name
+				 : (rtld_progname ?: "<main program>")),
+			     N_("relocation error"),
+			     make_string ("symbol ", undef_name, ", version ",
+					  version->name,
+					  " not defined in file ",
+					  version->filename,
+					  " with link time reference",
+					  res == -2
+					  ? " (no version symbols)" : ""));
+	  *ref = NULL;
+	  return 0;
+	}
+    }
+
+  if (__builtin_expect (current_value.s == NULL, 0))
+    {
+      if ((*ref == NULL || ELFW(ST_BIND) ((*ref)->st_info) != STB_WEAK)
+	  && skip_map == NULL)
+	{
+	  /* We could find no value for a strong reference.  */
+	  const char *reference_name = undef_map ? undef_map->l_name : "";
+	  const char *versionstr = version ? ", version " : "";
+	  const char *versionname = (version && version->name
+				     ? version->name : "");
+
+	  /* XXX We cannot translate the message.  */
+	  _dl_signal_cerror (0, (reference_name[0]
+				 ? reference_name
+				 : (rtld_progname ?: "<main program>")),
+			     N_("symbol lookup error"),
+			     make_string (undefined_msg, undef_name,
+					  versionstr, versionname));
+	}
+      *ref = NULL;
+      return 0;
+    }
+
+  int protected = (*ref
+		   && ELFW(ST_VISIBILITY) ((*ref)->st_other) == STV_PROTECTED);
+  if (__builtin_expect (protected != 0, 0))
+    {
+      /* It is very tricky.  We need to figure out what value to
+         return for the protected symbol.  */
+      if (type_class == ELF_RTYPE_CLASS_PLT)
+	{
+	  if (current_value.s != NULL && current_value.m != undef_map)
+	    {
+	      current_value.s = *ref;
+	      current_value.m = undef_map;
+	    }
+	}
+      else
+	{
+	  struct sym_val protected_value = { NULL, NULL };
+
+	  for (scope = symbol_scope; *scope != NULL; i = 0, ++scope)
+	    if (do_lookup_x (undef_name, new_hash, &old_hash, *ref,
+			     &protected_value, *scope, i, version, flags,
+			     skip_map, ELF_RTYPE_CLASS_PLT) != 0)
+	      break;
+
+	  if (protected_value.s != NULL && protected_value.m != undef_map)
+	    {
+	      current_value.s = *ref;
+	      current_value.m = undef_map;
+	    }
+	}
+    }
+
+  /* We have to check whether this would bind UNDEF_MAP to an object
+     in the global scope which was dynamically loaded.  In this case
+     we have to prevent the latter from being unloaded unless the
+     UNDEF_MAP object is also unloaded.  */
+  if (__builtin_expect (current_value.m->l_type == lt_loaded, 0)
+      /* Don't do this for explicit lookups as opposed to implicit
+	 runtime lookups.  */
+      && (flags & DL_LOOKUP_ADD_DEPENDENCY) != 0
+      /* Add UNDEF_MAP to the dependencies.  */
+      && add_dependency (undef_map, current_value.m, flags) < 0)
+      /* Something went wrong.  Perhaps the object we tried to reference
+	 was just removed.  Try finding another definition.  */
+      return _dl_lookup_symbol_x (undef_name, undef_map, ref,
+				  (flags & DL_LOOKUP_GSCOPE_LOCK)
+				  ? undef_map->l_scope : symbol_scope,
+				  version, type_class, flags, skip_map);
+
+  /* The object is used.  */
+  current_value.m->l_used = 1;
+
+  if (__builtin_expect (GLRO(dl_debug_mask)
+			& (DL_DEBUG_BINDINGS|DL_DEBUG_PRELINK), 0))
+    _dl_debug_bindings (undef_name, undef_map, ref,
+			&current_value, version, type_class, protected);
+
+  *ref = current_value.s;
+  return LOOKUP_VALUE (current_value.m);
+}
+
+
+/* Cache the location of MAP's hash table.  */
+
+void
+internal_function
+_dl_setup_hash (struct link_map *map)
+{
+  Elf_Symndx *hash;
+  Elf_Symndx nchain;
+
+  if (__builtin_expect (map->l_info[DT_ADDRTAGIDX (DT_GNU_HASH) + DT_NUM
+  				    + DT_THISPROCNUM + DT_VERSIONTAGNUM
+				    + DT_EXTRANUM + DT_VALNUM] != NULL, 1))
+    {
+      Elf32_Word *hash32
+	= (void *) D_PTR (map, l_info[DT_ADDRTAGIDX (DT_GNU_HASH) + DT_NUM
+				      + DT_THISPROCNUM + DT_VERSIONTAGNUM
+				      + DT_EXTRANUM + DT_VALNUM]);
+      map->l_nbuckets = *hash32++;
+      Elf32_Word symbias = *hash32++;
+      Elf32_Word bitmask_nwords = *hash32++;
+      /* Must be a power of two.  */
+      assert ((bitmask_nwords & (bitmask_nwords - 1)) == 0);
+      map->l_gnu_bitmask_idxbits = bitmask_nwords - 1;
+      map->l_gnu_shift = *hash32++;
+
+      map->l_gnu_bitmask = (ElfW(Addr) *) hash32;
+      hash32 += __ELF_NATIVE_CLASS / 32 * bitmask_nwords;
+
+      map->l_gnu_buckets = hash32;
+      hash32 += map->l_nbuckets;
+      map->l_gnu_chain_zero = hash32 - symbias;
+      return;
+    }
+
+  if (!map->l_info[DT_HASH])
+    return;
+  hash = (void *) D_PTR (map, l_info[DT_HASH]);
+
+  map->l_nbuckets = *hash++;
+  nchain = *hash++;
+  map->l_buckets = hash;
+  hash += map->l_nbuckets;
+  map->l_chain = hash;
+}
+
+
+static void
+internal_function
+_dl_debug_bindings (const char *undef_name, struct link_map *undef_map,
+		    const ElfW(Sym) **ref, struct sym_val *value,
+		    const struct r_found_version *version, int type_class,
+		    int protected)
+{
+  const char *reference_name = undef_map->l_name;
+
+  if (GLRO(dl_debug_mask) & DL_DEBUG_BINDINGS)
+    {
+      _dl_debug_printf ("binding file %s [%lu] to %s [%lu]: %s symbol `%s'",
+			(reference_name[0]
+			 ? reference_name
+			 : (rtld_progname ?: "<main program>")),
+			undef_map->l_ns,
+			value->m->l_name[0] ? value->m->l_name : rtld_progname,
+			value->m->l_ns,
+			protected ? "protected" : "normal", undef_name);
+      if (version)
+	_dl_debug_printf_c (" [%s]\n", version->name);
+      else
+	_dl_debug_printf_c ("\n");
+    }
+#ifdef SHARED
+  if (GLRO(dl_debug_mask) & DL_DEBUG_PRELINK)
+    {
+      int conflict = 0;
+      struct sym_val val = { NULL, NULL };
+
+      if ((GLRO(dl_trace_prelink_map) == NULL
+	   || GLRO(dl_trace_prelink_map) == GL(dl_ns)[LM_ID_BASE]._ns_loaded)
+	  && undef_map != GL(dl_ns)[LM_ID_BASE]._ns_loaded)
+	{
+	  const uint_fast32_t new_hash = dl_new_hash (undef_name);
+	  unsigned long int old_hash = 0xffffffff;
+
+	  do_lookup_x (undef_name, new_hash, &old_hash, *ref, &val,
+		       undef_map->l_local_scope[0], 0, version, 0, NULL,
+		       type_class);
+
+	  if (val.s != value->s || val.m != value->m)
+	    conflict = 1;
+	}
+
+      if (value->s
+	  && (__builtin_expect (ELFW(ST_TYPE) (value->s->st_info)
+				== STT_TLS, 0)))
+	type_class = 4;
+
+      if (conflict
+	  || GLRO(dl_trace_prelink_map) == undef_map
+	  || GLRO(dl_trace_prelink_map) == NULL
+	  || type_class == 4)
+	{
+	  _dl_printf ("%s 0x%0*Zx 0x%0*Zx -> 0x%0*Zx 0x%0*Zx ",
+		      conflict ? "conflict" : "lookup",
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) undef_map->l_map_start,
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) (((ElfW(Addr)) *ref) - undef_map->l_map_start),
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) (value->s ? value->m->l_map_start : 0),
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) (value->s ? value->s->st_value : 0));
+
+	  if (conflict)
+	    _dl_printf ("x 0x%0*Zx 0x%0*Zx ",
+			(int) sizeof (ElfW(Addr)) * 2,
+			(size_t) (val.s ? val.m->l_map_start : 0),
+			(int) sizeof (ElfW(Addr)) * 2,
+			(size_t) (val.s ? val.s->st_value : 0));
+
+	  _dl_printf ("/%x %s\n", type_class, undef_name);
+	}
+    }
+#endif
+}
Index: sysdeps/mips/dl-trampoline.c
===================================================================
--- sysdeps/mips/dl-trampoline.c	(revision 213009)
+++ sysdeps/mips/dl-trampoline.c	(working copy)
@@ -201,6 +201,7 @@ __dl_runtime_resolve (ElfW(Word) sym_ind
 "
 
 #define IFABIO32(X) X
+#define IFNEWABI(X)
 
 #else /* _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64 */
 
@@ -231,6 +232,7 @@ __dl_runtime_resolve (ElfW(Word) sym_ind
 "
 
 #define IFABIO32(X)
+#define IFNEWABI(X) X
 
 #endif
 
@@ -270,3 +272,56 @@ _dl_runtime_resolve:\n\
 	.end	_dl_runtime_resolve\n\
 	.previous\n\
 ");
+
+/* Assembler veneer called from the PLT header code when using PLTs.
+
+   Code in each PLT entry and the PLT header fills in the arguments to
+   this function:
+
+   - $15 (o32 t7, n32/n64 t3) - caller's return address
+   - $24 (t8) - PLT entry index
+   - $25 (t9) - address of _dl_runtime_pltresolve
+   - o32 $28 (gp), n32/n64 $14 (t2) - address of .got.plt
+
+   Different registers are used for .got.plt because the ABI was
+   originally designed for o32, where gp was available (call
+   clobbered).  On n32/n64 gp is call saved.
+
+   _dl_fixup needs:
+
+   - $4 (a0) - link map address
+   - $5 (a1) - .rel.plt offset (== PLT entry index * 8)  */
+
+asm ("\n\
+	.text\n\
+	.align	2\n\
+	.globl	_dl_runtime_pltresolve\n\
+	.type	_dl_runtime_pltresolve,@function\n\
+	.ent	_dl_runtime_pltresolve\n\
+_dl_runtime_pltresolve:\n\
+	.frame	$29, " STRINGXP(ELF_DL_FRAME_SIZE) ", $31\n\
+	.set noreorder\n\
+	# Save arguments and sp value in stack.\n\
+	" STRINGXP(PTR_SUBIU) "  $29, " STRINGXP(ELF_DL_FRAME_SIZE) "\n\
+        " IFABIO32(STRINGXP(PTR_L) "     $10, " STRINGXP(PTRSIZE) "($28)") "\n\
+        " IFNEWABI(STRINGXP(PTR_L) "     $10, " STRINGXP(PTRSIZE) "($14)") "\n\
+	# Modify t9 ($25) so as to point .cpload instruction.\n\
+	" IFABIO32(STRINGXP(PTR_ADDIU) "	$25, 12\n") "\
+	# Compute GP.\n\
+	" STRINGXP(SETUP_GP) "\n\
+	" STRINGXV(SETUP_GP64 (0, _dl_runtime_pltresolve)) "\n\
+	.set reorder\n\
+	" IFABIO32(STRINGXP(CPRESTORE(32))) "\n\
+	" ELF_DL_SAVE_ARG_REGS "\
+	move	$4, $10\n\
+        sll     $5, $24, " STRINGXP(PTRLOG) " + 1\n\
+	jal	_dl_fixup\n\
+	" ELF_DL_RESTORE_ARG_REGS "\
+	" STRINGXP(RESTORE_GP64) "\n\
+	" STRINGXP(PTR_ADDIU) "	$29, " STRINGXP(ELF_DL_FRAME_SIZE) "\n\
+	move	$25, $2\n\
+	jr	$25\n\
+	.end	_dl_runtime_pltresolve\n\
+	.previous\n\
+");
+
Index: sysdeps/mips/bits/linkmap.h
===================================================================
--- sysdeps/mips/bits/linkmap.h	(revision 0)
+++ sysdeps/mips/bits/linkmap.h	(revision 0)
@@ -0,0 +1,4 @@
+struct link_map_machine
+  {
+    ElfW(Addr) plt; /* Address of .plt */
+  };

--huq684BweRXVnRxX--

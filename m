Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9E6utx29067
	for linux-mips-outgoing; Sat, 13 Oct 2001 23:56:55 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9E6uUD29061
	for <linux-mips@oss.sgi.com>; Sat, 13 Oct 2001 23:56:30 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id 0EAAA125C0; Sat, 13 Oct 2001 23:56:24 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 3C6A4EBA5; Sat, 13 Oct 2001 23:56:21 -0700 (PDT)
Date: Sat, 13 Oct 2001 23:56:21 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: binutils@sourceware.cygnus.com, gcc@gcc.gnu.org,
   GNU C Library <libc-alpha@sourceware.cygnus.com>,
   Kenneth Albanowski <kjahds@kjahds.com>, Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   "Steven J. Hill" <sjhill@cotw.com>, linux-gcc@vger.kernel.org,
   amodra@bigpond.net.au
Subject: binutils 2.11.92.0.6 (Re: binutils 2.11.92.0.5 is broken)
Message-ID: <20011013235621.A15807@lucon.org>
References: <200110131452.f9DEq7Q0032358@dandelion.com> <20011013190034.A27019@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011013190034.A27019@lucon.org>; from hjl@lucon.org on Sat, Oct 13, 2001 at 07:00:34PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Oct 13, 2001 at 07:00:34PM -0700, H . J . Lu wrote:
> On Sat, Oct 13, 2001 at 07:52:07AM -0700, Leonard Zubkoff wrote:
> > HJ,
> > 
> > In recompiling my whole system with your latest binutils-2.11.92.0.5, I
> > received the following error while linking telnetd from the netkit-telnet-0.17
> > package:
> > 
> > gcc  telnetd.o state.o termstat.o slc.o sys_term.o utility.o global.o setproctitle.o -lutil -lutil -o telnetd
> > /usr/bin/ld: BFD internal error, aborting at elf32-i386.c line 646 in elf_i386_copy_indirect_symbol
> > 
> > /usr/bin/ld: Please report this bug.
> > 
> > collect2: ld returned 1 exit status
> > 
> > Thought you'd want to know...
> > 
> 
> Hi Alan,
> 
> This patch
> 
> http://sources.redhat.com/ml/binutils/2001-10/msg00035.html
> 
> is incomplete. You cannot do any backend processing when
> 
> if (dir == ind->weakdef)
> 
> I will double check all backend xxx_hash_copy_indirect.
> 
> I am planning to make binutils 2.11.92.0.6 within a week.
> 
> Sorry for that.
> 
> 

Here is a proposed patch for binutils 2.11.92.0.6. I will run more
tests before releasing it. Please test it as much as you can.

Thanks.


H.J.
---
2001-10-13  H.J. Lu <hjl@gnu.org>

	* elf32-hppa.c (elf32_hppa_copy_indirect_symbol): Don't abort
	if this is a weakdef.
	* elf32-i386.c (elf_i386_copy_indirect_symbol): Likewise.
	* elf64-ppc.c (ppc64_elf_copy_indirect_symbol): Likewise.

	* elf32-ppc.c (ppc_elf_adjust_dynamic_symbol): Set plt.offset
	to -1 and clear the ELF_LINK_HASH_NEEDS_PLT bit if the symbol
	is not a function.
	* elf32-hppa.c (elf32_hppa_adjust_dynamic_symbol): Likewise.
	* elf32-s390.c (elf_s390_adjust_dynamic_symbol): Likewise.
	* elf64-s390.c (elf_s390_adjust_dynamic_symbol): Likewise.
	* elf64-x86-64.c (elf64_x86_64_adjust_dynamic_symbol):
	Likewise.

Index: elf32-hppa.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf32-hppa.c,v
retrieving revision 1.41
diff -u -p -r1.41 elf32-hppa.c
--- elf32-hppa.c	2001/10/03 15:55:57	1.41
+++ elf32-hppa.c	2001/10/14 06:43:23
@@ -1147,7 +1147,7 @@ elf32_hppa_copy_indirect_symbol (dir, in
       edir->dyn_relocs = eind->dyn_relocs;
       eind->dyn_relocs = NULL;
     }
-  else if (eind->dyn_relocs != NULL)
+  else if (dir != ind->weakdef && eind->dyn_relocs != NULL)
     abort ();
 
   _bfd_elf_link_hash_copy_indirect (dir, ind);
@@ -1843,6 +1843,11 @@ elf32_hppa_adjust_dynamic_symbol (info, 
 	}
 
       return true;
+    }
+  else
+    {
+      h->plt.offset = (bfd_vma) -1;
+      h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
     }
 
   /* If this is a weak symbol, and there is a real definition, the
Index: elf32-i386.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf32-i386.c,v
retrieving revision 1.42
diff -u -p -r1.42 elf32-i386.c
--- elf32-i386.c	2001/10/03 15:55:57	1.42
+++ elf32-i386.c	2001/10/14 06:36:15
@@ -642,7 +642,7 @@ elf_i386_copy_indirect_symbol (dir, ind)
       edir->dyn_relocs = eind->dyn_relocs;
       eind->dyn_relocs = NULL;
     }
-  else if (eind->dyn_relocs != NULL)
+  else if (dir != ind->weakdef && eind->dyn_relocs != NULL)
     abort ();
 
   _bfd_elf_link_hash_copy_indirect (dir, ind);
Index: elf32-mips.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf32-mips.c,v
retrieving revision 1.46
retrieving revision 1.47
diff -u -p -r1.46 -r1.47
--- elf32-mips.c	2001/10/05 20:31:11	1.46
+++ elf32-mips.c	2001/10/11 18:15:44	1.47
@@ -6319,8 +6319,10 @@ mips_elf_calculate_relocation (abfd,
       if ((info->shared
 	   || (elf_hash_table (info)->dynamic_sections_created
 	       && h != NULL
-	       && ((h->root.elf_link_hash_flags & ELF_LINK_HASH_DEF_DYNAMIC)
-		   != 0)))
+	       && ((h->root.elf_link_hash_flags
+		    & ELF_LINK_HASH_DEF_DYNAMIC) != 0)
+	       && ((h->root.elf_link_hash_flags
+		    & ELF_LINK_HASH_DEF_REGULAR) == 0)))
 	  && (input_section->flags & SEC_ALLOC) != 0)
 	{
 	  /* If we're creating a shared library, or this relocation is
Index: elf32-ppc.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf32-ppc.c,v
retrieving revision 1.23
diff -u -p -r1.23 elf32-ppc.c
--- elf32-ppc.c	2001/10/07 23:29:41	1.23
+++ elf32-ppc.c	2001/10/14 05:58:40
@@ -1797,6 +1797,11 @@ ppc_elf_adjust_dynamic_symbol (info, h)
 
       return true;
     }
+  else
+    {
+      h->plt.offset = (bfd_vma) -1;
+      h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
+    }
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: elf32-s390.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf32-s390.c,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 elf32-s390.c
--- elf32-s390.c	2001/09/29 16:26:18	1.1.1.8
+++ elf32-s390.c	2001/10/14 06:09:42
@@ -998,6 +998,11 @@ elf_s390_adjust_dynamic_symbol (info, h)
 
       return true;
     }
+  else
+    {
+      h->plt.offset = (bfd_vma) -1;
+      h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
+    }
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: elf64-ppc.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf64-ppc.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 elf64-ppc.c
--- elf64-ppc.c	2001/10/03 15:30:41	1.1.1.5
+++ elf64-ppc.c	2001/10/14 06:36:37
@@ -1799,7 +1799,7 @@ ppc64_elf_copy_indirect_symbol (dir, ind
       edir->dyn_relocs = eind->dyn_relocs;
       eind->dyn_relocs = NULL;
     }
-  else if (eind->dyn_relocs != NULL)
+  else if (dir != ind->weakdef && eind->dyn_relocs != NULL)
     abort ();
 
   _bfd_elf_link_hash_copy_indirect (dir, ind);
Index: elf64-s390.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf64-s390.c,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 elf64-s390.c
--- elf64-s390.c	2001/09/29 16:26:20	1.1.1.8
+++ elf64-s390.c	2001/10/14 06:10:26
@@ -976,6 +976,11 @@ elf_s390_adjust_dynamic_symbol (info, h)
 
       return true;
     }
+  else
+    {
+      h->plt.offset = (bfd_vma) -1;
+      h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
+    }
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: elf64-x86-64.c
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elf64-x86-64.c,v
retrieving revision 1.1.1.22
diff -u -p -r1.1.1.22 elf64-x86-64.c
--- elf64-x86-64.c	2001/09/29 16:26:21	1.1.1.22
+++ elf64-x86-64.c	2001/10/14 06:10:46
@@ -854,6 +854,11 @@ elf64_x86_64_adjust_dynamic_symbol (info
 
       return true;
     }
+  else
+    {
+      h->plt.offset = (bfd_vma) -1;
+      h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
+    }
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: elflink.h
===================================================================
RCS file: /work/cvs/gnu/binutils/bfd/elflink.h,v
retrieving revision 1.82
retrieving revision 1.83
diff -u -p -r1.82 -r1.83
--- elflink.h	2001/10/05 20:32:13	1.82
+++ elflink.h	2001/10/11 18:15:44	1.83
@@ -909,8 +909,11 @@ elf_merge_symbol (abfd, info, name, sym,
 
      As above, we again permit a common symbol in a regular object to
      override a definition in a shared object if the shared object
-     symbol is a function or is weak.  */
+     symbol is a function or is weak.
 
+     As above, we permit a non-weak definition in a shared object to
+     override a weak definition in a regular object.  */
+
   if (! newdyn
       && (newdef
 	  || (bfd_is_com_section (sec)
@@ -919,7 +922,8 @@ elf_merge_symbol (abfd, info, name, sym,
       && olddyn
       && olddef
       && (h->elf_link_hash_flags & ELF_LINK_HASH_DEF_DYNAMIC) != 0
-      && bind != STB_WEAK)
+      && (bind != STB_WEAK
+	  || h->root.type == bfd_link_hash_defweak))
     {
       /* Change the hash table entry to undefined, and let
 	 _bfd_generic_link_add_one_symbol do the right thing with the
@@ -1022,13 +1026,14 @@ elf_merge_symbol (abfd, info, name, sym,
       *sym_hash = h;
     }
 
-  /* Handle the special case of a definition in a shared object
-     followed by a weak definition in a regular object.  In this case
-     we prefer to definition in the shared object.  To make this work
-     we have to tell the caller to not treat the new symbol as a
-     definition.  */
+  /* Handle the special case of a non-weak definition in a shared
+     object followed by a weak definition in a regular object.  In
+     this case we prefer to definition in the shared object.  To make
+     this work we have to tell the caller to not treat the new symbol
+     as a definition.  */
   if (olddef
       && olddyn
+      && h->root.type != bfd_link_hash_defweak
       && newdef
       && ! newdyn
       && bind == STB_WEAK)

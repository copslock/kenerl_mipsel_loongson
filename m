Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9F7GQq30033
	for linux-mips-outgoing; Mon, 15 Oct 2001 00:16:26 -0700
Received: from mta01ps.bigpond.com (mta01ps.bigpond.com [144.135.25.133] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9F7G0D30020
	for <linux-mips@oss.sgi.com>; Mon, 15 Oct 2001 00:16:00 -0700
Received: from bubble.local ([144.135.25.72]) by
          mta01ps.bigpond.com (Netscape Messaging Server 4.15) with SMTP
          id GL8KH000.A2A for <linux-mips@oss.sgi.com>; Mon, 15 Oct 2001
          17:22:12 +1000 
Received: from 144.136.192.57 ([144.136.192.57]) by PSMAM02.mailsvc.email.bigpond.com(MailRouter V2.9k 8383/2813303); 15 Oct 2001 17:22:07
Received: (qmail 9481 invoked by uid 179); 15 Oct 2001 07:15:39 -0000
Date: Mon, 15 Oct 2001 16:45:39 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: "H . J . Lu" <hjl@lucon.org>, "Leonard N. Zubkoff" <lnz@dandelion.com>,
   binutils@sourceware.cygnus.com, gcc@gcc.gnu.org,
   GNU C Library <libc-alpha@sourceware.cygnus.com>,
   Kenneth Albanowski <kjahds@kjahds.com>, Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   "Steven J. Hill" <sjhill@cotw.com>, linux-gcc@vger.kernel.org
Subject: Re: binutils 2.11.92.0.6 (Re: binutils 2.11.92.0.5 is broken)
Message-ID: <20011015164539.I1015@bubble.sa.bigpond.net.au>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	"Leonard N. Zubkoff" <lnz@dandelion.com>,
	binutils@sourceware.cygnus.com, gcc@gcc.gnu.org,
	GNU C Library <libc-alpha@sourceware.cygnus.com>,
	Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>,
	Andy Dougherty <doughera@lafcol.lafayette.edu>,
	Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
	Ron Guilmette <rfg@monkeys.com>,
	"Polstra; John" <linux-binutils-in@polstra.com>,
	"Hazelwood; Galen" <galenh@micron.net>,
	Ralf Baechle <ralf@informatik.uni-koblenz.de>,
	Linas Vepstas <linas@linas.org>,
	Feher Janos <aries@hal2000.terra.vein.hu>,
	"Steven J. Hill" <sjhill@cotw.com>, linux-gcc@vger.kernel.org
References: <200110131452.f9DEq7Q0032358@dandelion.com> <20011013190034.A27019@lucon.org> <20011013235621.A15807@lucon.org> <20011015093317.B1015@bubble.sa.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011015093317.B1015@bubble.sa.bigpond.net.au>; from amodra@bigpond.net.au on Mon, Oct 15, 2001 at 09:33:17AM +0930
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm about to commit this to fix the problems introduced by the new
reference counting scheme.

2001-10-15  Alan Modra  <amodra@bigpond.net.au>
	    H.J. Lu  <hjl@gnu.org>

	* elf32-hppa.c (elf32_hppa_copy_indirect_symbol): Merge dyn_reloc
	counts for aliases instead of aborting.
	* elf32-i386.c (elf_i386_copy_indirect_symbol): Likewise.
	* elf64-ppc.c (ppc64_elf_copy_indirect_symbol): Likewise.

	* elf32-hppa.c (elf32_hppa_adjust_dynamic_symbol): Set plt.offset
	to -1 for non-function symbols.
	* elf32-ppc.c (ppc_elf_adjust_dynamic_symbol): Likewise.
	* elf32-s390.c (elf_s390_adjust_dynamic_symbol): Likewise.
	* elf64-ppc.c (ppc64_elf_adjust_dynamic_symbol): Likewise.
	* elf64-s390.c (elf_s390_adjust_dynamic_symbol): Likewise.
	* elf64-x86-64.c (elf64_x86_64_adjust_dynamic_symbol): Likewise.
	* elf32-i386.c (elf_i386_adjust_dynamic_symbol): Refer to
	plt.offset instead of plt.refcount when setting to -1.

-- 
Alan Modra

Index: bfd/elf32-hppa.c
===================================================================
RCS file: /cvs/src/src/bfd/elf32-hppa.c,v
retrieving revision 1.52
diff -u -p -r1.52 elf32-hppa.c
--- elf32-hppa.c	2001/10/03 08:33:18	1.52
+++ elf32-hppa.c	2001/10/15 05:12:07
@@ -1142,13 +1142,41 @@ elf32_hppa_copy_indirect_symbol (dir, in
   edir = (struct elf32_hppa_link_hash_entry *) dir;
   eind = (struct elf32_hppa_link_hash_entry *) ind;
 
-  if (edir->dyn_relocs == NULL)
+  if (eind->dyn_relocs != NULL)
     {
+      if (edir->dyn_relocs != NULL)
+	{
+	  struct elf32_hppa_dyn_reloc_entry **pp;
+	  struct elf32_hppa_dyn_reloc_entry *p;
+
+	  if (dir != ind->weakdef)
+	    abort ();
+
+	  /* Add reloc counts against the weak sym to the strong sym
+	     list.  Merge any entries against the same section.  */
+	  for (pp = &eind->dyn_relocs; (p = *pp) != NULL; )
+	    {
+	      struct elf32_hppa_dyn_reloc_entry *q;
+
+	      for (q = edir->dyn_relocs; q != NULL; q = q->next)
+		if (q->sec == p->sec)
+		  {
+#if RELATIVE_DYNRELOCS
+		    q->relative_count += p->relative_count;
+#endif
+		    q->count += p->count;
+		    *pp = p->next;
+		    break;
+		  }
+	      if (q == NULL)
+		pp = &p->next;
+	    }
+	  *pp = edir->dyn_relocs;
+	}
+
       edir->dyn_relocs = eind->dyn_relocs;
       eind->dyn_relocs = NULL;
     }
-  else if (eind->dyn_relocs != NULL)
-    abort ();
 
   _bfd_elf_link_hash_copy_indirect (dir, ind);
 }
@@ -1844,6 +1872,8 @@ elf32_hppa_adjust_dynamic_symbol (info, 
 
       return true;
     }
+  else
+    h->plt.offset = (bfd_vma) -1;
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: bfd/elf32-i386.c
===================================================================
RCS file: /cvs/src/src/bfd/elf32-i386.c,v
retrieving revision 1.54
diff -u -p -r1.54 elf32-i386.c
--- elf32-i386.c	2001/10/03 15:11:46	1.54
+++ elf32-i386.c	2001/10/15 05:12:07
@@ -637,13 +637,39 @@ elf_i386_copy_indirect_symbol (dir, ind)
   edir = (struct elf_i386_link_hash_entry *) dir;
   eind = (struct elf_i386_link_hash_entry *) ind;
 
-  if (edir->dyn_relocs == NULL)
+  if (eind->dyn_relocs != NULL)
     {
+      if (edir->dyn_relocs != NULL)
+	{
+	  struct elf_i386_dyn_relocs **pp;
+	  struct elf_i386_dyn_relocs *p;
+
+	  if (dir != ind->weakdef)
+	    abort ();
+
+	  /* Add reloc counts against the weak sym to the strong sym
+	     list.  Merge any entries against the same section.  */
+	  for (pp = &eind->dyn_relocs; (p = *pp) != NULL; )
+	    {
+	      struct elf_i386_dyn_relocs *q;
+
+	      for (q = edir->dyn_relocs; q != NULL; q = q->next)
+		if (q->sec == p->sec)
+		  {
+		    q->pc_count += p->pc_count;
+		    q->count += p->count;
+		    *pp = p->next;
+		    break;
+		  }
+	      if (q == NULL)
+		pp = &p->next;
+	    }
+	  *pp = edir->dyn_relocs;
+	}
+
       edir->dyn_relocs = eind->dyn_relocs;
       eind->dyn_relocs = NULL;
     }
-  else if (eind->dyn_relocs != NULL)
-    abort ();
 
   _bfd_elf_link_hash_copy_indirect (dir, ind);
 }
@@ -1086,7 +1112,7 @@ elf_i386_adjust_dynamic_symbol (info, h)
 	     object, or if all references were garbage collected.  In
 	     such a case, we don't actually need to build a procedure
 	     linkage table, and we can just do a PC32 reloc instead.  */
-	  h->plt.refcount = -1;
+	  h->plt.offset = (bfd_vma) -1;
 	  h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
 	}
 
@@ -1098,7 +1124,7 @@ elf_i386_adjust_dynamic_symbol (info, h)
        check_relocs.  We can't decide accurately between function and
        non-function syms in check-relocs;  Objects loaded later in
        the link may change h->type.  So fix it now.  */
-    h->plt.refcount = -1;
+    h->plt.offset = (bfd_vma) -1;
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: bfd/elf32-ppc.c
===================================================================
RCS file: /cvs/src/src/bfd/elf32-ppc.c,v
retrieving revision 1.32
diff -u -p -r1.32 elf32-ppc.c
--- elf32-ppc.c	2001/09/29 06:21:59	1.32
+++ elf32-ppc.c	2001/10/15 05:12:09
@@ -1797,6 +1797,8 @@ ppc_elf_adjust_dynamic_symbol (info, h)
 
       return true;
     }
+  else
+    h->plt.offset = (bfd_vma) -1;
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: bfd/elf32-s390.c
===================================================================
RCS file: /cvs/src/src/bfd/elf32-s390.c,v
retrieving revision 1.9
diff -u -p -r1.9 elf32-s390.c
--- elf32-s390.c	2001/09/29 06:21:59	1.9
+++ elf32-s390.c	2001/10/15 05:12:11
@@ -998,6 +998,8 @@ elf_s390_adjust_dynamic_symbol (info, h)
 
       return true;
     }
+  else
+    h->plt.offset = (bfd_vma) -1;
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: bfd/elf64-ppc.c
===================================================================
RCS file: /cvs/src/src/bfd/elf64-ppc.c,v
retrieving revision 1.7
diff -u -p -r1.7 elf64-ppc.c
--- elf64-ppc.c	2001/10/03 08:33:18	1.7
+++ elf64-ppc.c	2001/10/15 05:12:13
@@ -1794,13 +1794,39 @@ ppc64_elf_copy_indirect_symbol (dir, ind
   edir = (struct ppc_link_hash_entry *) dir;
   eind = (struct ppc_link_hash_entry *) ind;
 
-  if (edir->dyn_relocs == NULL)
+  if (eind->dyn_relocs != NULL)
     {
+      if (edir->dyn_relocs != NULL)
+	{
+	  struct ppc_dyn_relocs **pp;
+	  struct ppc_dyn_relocs *p;
+
+	  if (dir != ind->weakdef)
+	    abort ();
+
+	  /* Add reloc counts against the weak sym to the strong sym
+	     list.  Merge any entries against the same section.  */
+	  for (pp = &eind->dyn_relocs; (p = *pp) != NULL; )
+	    {
+	      struct ppc_dyn_relocs *q;
+
+	      for (q = edir->dyn_relocs; q != NULL; q = q->next)
+		if (q->sec == p->sec)
+		  {
+		    q->pc_count += p->pc_count;
+		    q->count += p->count;
+		    *pp = p->next;
+		    break;
+		  }
+	      if (q == NULL)
+		pp = &p->next;
+	    }
+	  *pp = edir->dyn_relocs;
+	}
+
       edir->dyn_relocs = eind->dyn_relocs;
       eind->dyn_relocs = NULL;
     }
-  else if (eind->dyn_relocs != NULL)
-    abort ();
 
   _bfd_elf_link_hash_copy_indirect (dir, ind);
 }
@@ -2366,6 +2392,8 @@ ppc64_elf_adjust_dynamic_symbol (info, h
 	}
       return true;
     }
+  else
+    h->plt.offset = (bfd_vma) -1;
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: bfd/elf64-s390.c
===================================================================
RCS file: /cvs/src/src/bfd/elf64-s390.c,v
retrieving revision 1.9
diff -u -p -r1.9 elf64-s390.c
--- elf64-s390.c	2001/09/29 06:21:59	1.9
+++ elf64-s390.c	2001/10/15 05:12:15
@@ -976,6 +976,8 @@ elf_s390_adjust_dynamic_symbol (info, h)
 
       return true;
     }
+  else
+    h->plt.offset = (bfd_vma) -1;
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the
Index: bfd/elf64-x86-64.c
===================================================================
RCS file: /cvs/src/src/bfd/elf64-x86-64.c,v
retrieving revision 1.29
diff -u -p -r1.29 elf64-x86-64.c
--- elf64-x86-64.c	2001/09/29 06:21:59	1.29
+++ elf64-x86-64.c	2001/10/15 05:12:17
@@ -854,6 +854,8 @@ elf64_x86_64_adjust_dynamic_symbol (info
 
       return true;
     }
+  else
+    h->plt.offset = (bfd_vma) -1;
 
   /* If this is a weak symbol, and there is a real definition, the
      processor independent code will have arranged for us to see the

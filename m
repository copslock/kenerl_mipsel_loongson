Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56LK7A06382
	for linux-mips-outgoing; Wed, 6 Jun 2001 14:20:07 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56LK6h06378
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 14:20:06 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 9A2AE125BC; Wed,  6 Jun 2001 14:20:05 -0700 (PDT)
Date: Wed, 6 Jun 2001 14:20:05 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com
Cc: linux-mips@oss.sgi.com
Subject: A patch for ELF section symbols
Message-ID: <20010606142005.A27310@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On mips, both _gp_disp and _DYNAMIC_LINKING/_DYNAMIC_LINK are
explicitly marked as glocal section symbols. We should keep them
during objcopy.


H.J.
----
2001-06-06  H.J. Lu  <hjl@gnu.org>

	* elf.c (swap_out_syms): Keep names for global section symbols.

--- binutils/bfd/elf.c.mips	Tue May 15 20:03:57 2001
+++ binutils/bfd/elf.c	Tue May 15 21:20:49 2001
@@ -4395,9 +4395,9 @@ swap_out_syms (abfd, sttp, relocatable_p
 	flagword flags = syms[idx]->flags;
 	int type;
 
-	if ((flags & BSF_SECTION_SYM) != 0)
+	if ((flags & (BSF_SECTION_SYM | BSF_GLOBAL)) == BSF_SECTION_SYM)
 	  {
-	    /* Section symbols have no name.  */
+	    /* Local section symbols have no name.  */
 	    sym.st_name = 0;
 	  }
 	else
@@ -4506,7 +4506,12 @@ swap_out_syms (abfd, sttp, relocatable_p
           type = (*bed->elf_backend_get_symbol_type) (&type_ptr->internal_elf_sym, type);
 
 	if (flags & BSF_SECTION_SYM)
-	  sym.st_info = ELF_ST_INFO (STB_LOCAL, STT_SECTION);
+	  {
+	    if (flags & BSF_GLOBAL)
+	      sym.st_info = ELF_ST_INFO (STB_GLOBAL, STT_SECTION);
+	    else
+	      sym.st_info = ELF_ST_INFO (STB_LOCAL, STT_SECTION);
+	  }
 	else if (bfd_is_com_section (syms[idx]->section))
 	  sym.st_info = ELF_ST_INFO (STB_GLOBAL, type);
 	else if (bfd_is_und_section (syms[idx]->section))

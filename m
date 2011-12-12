Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2011 21:24:54 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14721 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903738Ab1LLUYs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Dec 2011 21:24:48 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ee663660000>; Mon, 12 Dec 2011 12:26:14 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 12 Dec 2011 12:24:45 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 12 Dec 2011 12:24:45 -0800
Message-ID: <4EE6630C.2070101@cavium.com>
Date:   Mon, 12 Dec 2011 12:24:44 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     binutils <binutils@sourceware.org>, Alan Modra <amodra@gmail.com>,
        rdsandiford@googlemail.com
CC:     Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [Patch v2]: Fix ld pr11138 FAILures on mips*.
References: <4EE27012.5030508@cavium.com>       <20111210003928.GC2461@bubble.grove.modra.org>  <4EE2ACB9.9010301@cavium.com> <87y5ukenkn.fsf@firetop.home>
In-Reply-To: <87y5ukenkn.fsf@firetop.home>
Content-Type: multipart/mixed;
 boundary="------------000303080504020901090505"
X-OriginalArrivalTime: 12 Dec 2011 20:24:45.0141 (UTC) FILETIME=[16472850:01CCB90C]
X-archive-position: 32087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9628

This is a multi-part message in MIME format.
--------------000303080504020901090505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/2011 02:19 AM, Richard Sandiford wrote:
> David Daney<david.daney@cavium.com>  writes:
>> I will wait a couple of days to give Richard a chance to object.
>
> Looks good to me too.  Thanks for doing this.  I think it should go
> on the 2.22 branch as well.
>

FYI, this is what I committed to both MAIN and the 2.22 branch.  I fixed 
the formatting things noted by Alan, and took the liberty of adding a 
missing "break;" statement.

2011-12-10  David Daney  <david.daney@cavium.com>

	* elfxx-mips.c (mips_elf_link_hash_table.rld_value): Remove.
	(mips_elf_link_hash_table.rld_symbol): New field;
	(MIPS_ELF_RLD_MAP_SIZE): New macro.
	(_bfd_mips_elf_add_symbol_hook): Remember __rld_obj_head symbol
	in rld_symbol.
	(_bfd_mips_elf_create_dynamic_sections): Remember __rld_map symbol
	in rld_symbol.
	(_bfd_mips_elf_size_dynamic_sections): Set correct size for .rld_map.
	(_bfd_mips_elf_finish_dynamic_symbol): Remove .rld_map handling.
	(_bfd_mips_elf_finish_dynamic_sections): Use rld_symbol to
	calculate DT_MIPS_RLD_MAP value.
	(_bfd_mips_elf_link_hash_table_create): Initialize rld_symbol,
	quit initializing rld_value.

--------------000303080504020901090505
Content-Type: text/plain;
 name="elfxx-mips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="elfxx-mips.patch"

Index: elfxx-mips.c
===================================================================
RCS file: /cvs/src/src/bfd/elfxx-mips.c,v
retrieving revision 1.297
retrieving revision 1.298
diff -u -p -r1.297 -r1.298
--- elfxx-mips.c	8 Dec 2011 20:47:24 -0000	1.297
+++ elfxx-mips.c	11 Dec 2011 02:05:40 -0000	1.298
@@ -436,8 +436,8 @@ struct mips_elf_link_hash_table
      entry is set to the address of __rld_obj_head as in IRIX5.  */
   bfd_boolean use_rld_obj_head;
 
-  /* This is the value of the __rld_map or __rld_obj_head symbol.  */
-  bfd_vma rld_value;
+  /* The  __rld_map or __rld_obj_head symbol. */
+  struct elf_link_hash_entry *rld_symbol;
 
   /* This is set if we see any mips16 stub sections.  */
   bfd_boolean mips16_stubs_seen;
@@ -768,6 +768,10 @@ static bfd *reldyn_sorting_bfd;
 #define MIPS_ELF_GOT_SIZE(abfd) \
   (get_elf_backend_data (abfd)->s->arch_size / 8)
 
+/* The size of the .rld_map section. */
+#define MIPS_ELF_RLD_MAP_SIZE(abfd) \
+  (get_elf_backend_data (abfd)->s->arch_size / 8)
+
 /* The size of a symbol-table entry.  */
 #define MIPS_ELF_SYM_SIZE(abfd) \
   (get_elf_backend_data (abfd)->s->sizeof_sym)
@@ -7082,6 +7086,7 @@ _bfd_mips_elf_add_symbol_hook (bfd *abfd
 	return FALSE;
 
       mips_elf_hash_table (info)->use_rld_obj_head = TRUE;
+      mips_elf_hash_table (info)->rld_symbol = h;
     }
 
   /* If this is a mips16 text symbol, add 1 to the value to make it
@@ -7267,6 +7272,7 @@ _bfd_mips_elf_create_dynamic_sections (b
 
 	  if (! bfd_elf_link_record_dynamic_symbol (info, h))
 	    return FALSE;
+	  mips_elf_hash_table (info)->rld_symbol = h;
 	}
     }
 
@@ -9028,7 +9034,7 @@ _bfd_mips_elf_size_dynamic_sections (bfd
 	{
 	  /* We add a room for __rld_map.  It will be filled in by the
 	     rtld to contain a pointer to the _r_debug structure.  */
-	  s->size += 4;
+	  s->size += MIPS_ELF_RLD_MAP_SIZE (output_bfd);
 	}
       else if (SGI_COMPAT (output_bfd)
 	       && CONST_STRNEQ (name, ".compact_rel"))
@@ -10031,31 +10037,6 @@ _bfd_mips_elf_finish_dynamic_symbol (bfd
   if (IRIX_COMPAT (output_bfd) == ict_irix6)
     mips_elf_irix6_finish_dynamic_symbol (output_bfd, name, sym);
 
-  if (! info->shared)
-    {
-      if (! mips_elf_hash_table (info)->use_rld_obj_head
-	  && (strcmp (name, "__rld_map") == 0
-	      || strcmp (name, "__RLD_MAP") == 0))
-	{
-	  asection *s = bfd_get_section_by_name (dynobj, ".rld_map");
-	  BFD_ASSERT (s != NULL);
-	  sym->st_value = s->output_section->vma + s->output_offset;
-	  bfd_put_32 (output_bfd, 0, s->contents);
-	  if (mips_elf_hash_table (info)->rld_value == 0)
-	    mips_elf_hash_table (info)->rld_value = sym->st_value;
-	}
-      else if (mips_elf_hash_table (info)->use_rld_obj_head
-	       && strcmp (name, "__rld_obj_head") == 0)
-	{
-	  /* IRIX6 does not use a .rld_map section.  */
-	  if (IRIX_COMPAT (output_bfd) == ict_irix5
-              || IRIX_COMPAT (output_bfd) == ict_none)
-	    BFD_ASSERT (bfd_get_section_by_name (dynobj, ".rld_map")
-			!= NULL);
-	  mips_elf_hash_table (info)->rld_value = sym->st_value;
-	}
-    }
-
   /* Keep dynamic MIPS16 symbols odd.  This allows the dynamic linker to
      treat MIPS16 symbols like any other.  */
   if (ELF_ST_IS_MIPS16 (sym->st_other))
@@ -10518,7 +10499,19 @@ _bfd_mips_elf_finish_dynamic_sections (b
 	      break;
 
 	    case DT_MIPS_RLD_MAP:
-	      dyn.d_un.d_ptr = mips_elf_hash_table (info)->rld_value;
+	      {
+		struct elf_link_hash_entry *h;
+		h = mips_elf_hash_table (info)->rld_symbol;
+		if (!h)
+		  {
+		    dyn_to_skip = MIPS_ELF_DYN_SIZE (dynobj);
+		    swap_out_p = FALSE;
+		    break;
+		  }
+		s = h->root.u.def.section;
+		dyn.d_un.d_ptr = (s->output_section->vma + s->output_offset
+				  + h->root.u.def.value);
+	      }
 	      break;
 
 	    case DT_MIPS_OPTIONS:
@@ -12801,7 +12794,7 @@ _bfd_mips_elf_link_hash_table_create (bf
   ret->procedure_count = 0;
   ret->compact_rel_size = 0;
   ret->use_rld_obj_head = FALSE;
-  ret->rld_value = 0;
+  ret->rld_symbol = NULL;
   ret->mips16_stubs_seen = FALSE;
   ret->use_plts_and_copy_relocs = FALSE;
   ret->is_vxworks = FALSE;

--------------000303080504020901090505--

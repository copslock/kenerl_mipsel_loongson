Received:  by oss.sgi.com id <S554067AbRA1QXu>;
	Sun, 28 Jan 2001 08:23:50 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:26119 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554051AbRA1QXe>;
	Sun, 28 Jan 2001 08:23:34 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8852E7F8; Sun, 28 Jan 2001 17:23:31 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 15204EE9C; Sun, 28 Jan 2001 17:24:01 +0100 (CET)
Date:   Sun, 28 Jan 2001 17:24:01 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [RESUME] R3000 swapping problems
Message-ID: <20010128172401.B19010@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing
Message-ID: <20010128162401.1BNZU_qM4Ep35e6EglkjROFAeSvlTpcYbyWel_rnJIg@z>


Hi,
after a weekend research i am a bit stuck in my understanding of the
R3000 swapping problems 

When changing

Index: include/asm-mips/pgtable.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.48
diff -u -r1.48 pgtable.h
--- include/asm-mips/pgtable.h	2000/12/03 15:30:52	1.48
+++ include/asm-mips/pgtable.h	2001/01/28 16:08:17
@@ -457,8 +457,8 @@
 				unsigned long address, pte_t pte);
 
 #define SWP_TYPE(x)		(((x).val >> 1) & 0x3f)
-#define SWP_OFFSET(x)		((x).val >> 8)
-#define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#define SWP_OFFSET(x)		((x).val >> 10)
+#define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 10) })
 #define pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)	((pte_t) { (x).val })


The R3k machine (Decstation 5000/120) does survive swapping. The 
idea is that the bits 9 & 10 on the R3k are

#define _PAGE_VALID                 (1<<9)
#define _PAGE_SILENT_READ           (1<<9)  /* synonym                 */
#define _PAGE_DIRTY                 (1<<10) /* The MIPS dirty bit      */
#define _PAGE_SILENT_WRITE          (1<<10)

Whereas this on R4k is 

#define _PAGE_VALID                 (1<<7)
#define _PAGE_SILENT_READ           (1<<7)  /* synonym                 */
#define _PAGE_DIRTY                 (1<<8)  /* The MIPS dirty bit      */
#define _PAGE_SILENT_WRITE          (1<<8)

OTOH when following the code paths the pte gets completely replaced
with the swap entry and not bitmasked/and/ored with the original 
pte or the ptes flags. So i find no dependencie to the SWP_ macros.

Swapin is in mm/memory.c:do_swap_page

   1039         pte = mk_pte(page, vma->vm_page_prot);
   1040 
   1041         /*
   1042          * Freeze the "shared"ness of the page, ie page_count + swap_count.
   1043          * Must lock page before transferring our swap count to already
   1044          * obtained page count.
   1045          */
   1046         lock_page(page);
   1047         swap_free(entry);
   1048         if (write_access && !is_page_shared(page))
   1049                 pte = pte_mkwrite(pte_mkdirty(pte));
   1050         UnlockPage(page);
   1051 
   1052         set_pte(page_table, pte);
   1053 
   1054         /* No need to invalidate - it was non-present before */
   1055         update_mmu_cache(vma, address, pte);
   1056         return 1;       /* Minor fault */

The swapout code is in mm/vmscan.c:try_to_swap_out

    144         entry = get_swap_page();
    145         if (!entry.val)
    146                 goto out_unlock_restore; /* No swap space left */
    147 
    148         /* Add it to the swap cache and mark it dirty */
    149         add_to_swap_cache(page, entry);
    150         set_page_dirty(page);
    151         goto set_swap_pte;

     98 set_swap_pte:
     99                 swap_duplicate(entry);
    100                 set_pte(page_table, swp_entry_to_pte(entry));
    101 drop_pte:
    102                 UnlockPage(page);
    103                 mm->rss--;
    104                 deactivate_page(page);
    105                 page_cache_release(page);
    106 out_failed:
    107                 return 0;
    108         }

When adding debug code there i can see the flags getting restored
correctly on swapping in.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?


--a8sldprk+5E/pDEv--

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjx20BoACgkQHb1edYOZ4bsuqACfRLnpV5dU47MKJZ+YeOJJxKIr
nIwAniKUWBwQSdtkfFrhsGcVp55OpYh+
=M11q
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--

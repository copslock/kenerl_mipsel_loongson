Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 01:38:34 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:52708 "EHLO
	demo.mitica") by linux-mips.org with ESMTP id <S8225322AbSLRBhL>;
	Wed, 18 Dec 2002 01:37:11 +0000
Received: by demo.mitica (Postfix, from userid 501)
	id 31829D657; Wed, 18 Dec 2002 02:43:07 +0100 (CET)
To: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: c-r4k.c, new gcc's don't like empty labels
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 18 Dec 2002 02:43:07 +0100
Message-ID: <m2bs3kqez8.fsf@demo.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi
        patch is trivial to eliminate warnings from the compiler

Later, Juan.

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.13
diff -u -r1.3.2.13 c-r4k.c
--- arch/mips/mm/c-r4k.c	11 Dec 2002 14:23:12 -0000	1.3.2.13
+++ arch/mips/mm/c-r4k.c	18 Dec 2002 00:49:18 -0000
@@ -465,7 +465,7 @@
 		blast_scache16_page_indexed(page);
 	} else
 		blast_scache16_page(page);
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_s32d16i16(struct vm_area_struct *vma,
@@ -511,7 +511,7 @@
 		blast_scache32_page_indexed(page);
 	} else
 		blast_scache32_page(page);
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_s64d16i16(struct vm_area_struct *vma,
@@ -557,7 +557,7 @@
 		blast_scache64_page_indexed(page);
 	} else
 		blast_scache64_page(page);
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_s128d16i16(struct vm_area_struct *vma,
@@ -604,7 +604,7 @@
 		blast_scache128_page_indexed(page);
 	} else
 		blast_scache128_page(page);
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_s32d32i32(struct vm_area_struct *vma,
@@ -651,7 +651,7 @@
 		blast_scache32_page_indexed(page);
 	} else
 		blast_scache32_page(page);
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_s64d32i32(struct vm_area_struct *vma,
@@ -698,7 +698,7 @@
 		blast_scache64_page_indexed(page);
 	} else
 		blast_scache64_page(page);
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_s128d32i32(struct vm_area_struct *vma,
@@ -744,7 +744,7 @@
 		blast_scache128_page_indexed(page);
 	} else
 		blast_scache128_page(page);
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_d16i16(struct vm_area_struct *vma,
@@ -789,7 +789,7 @@
 		page = (KSEG0 + (page & (dcache_size - 1)));
 		blast_dcache16_page_indexed(page);
 	}
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_d32i32(struct vm_area_struct *vma,
@@ -835,7 +835,7 @@
 		page = (KSEG0 + (page & (dcache_size - 1)));
 		blast_dcache32_page_indexed(page);
 	}
-out:
+out:;
 }
 
 static void r4k_flush_cache_page_d32i32_r4600(struct vm_area_struct *vma,
@@ -881,7 +881,7 @@
 		blast_dcache32_page_indexed(page);
 		blast_dcache32_page_indexed(page ^ dcache_waybit);
 	}
-out:
+out:;
 }
 
 static void r4k_flush_page_to_ram_s16(struct page *page)


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

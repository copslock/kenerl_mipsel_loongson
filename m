Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 18:09:33 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:2106 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S8133723AbWEXQJX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 18:09:23 +0200
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with NetIQ MailMarshal (v6,0,3,8)
	id <B447485340000>; Wed, 24 May 2006 12:09:25 -0400
Received: from [192.168.16.29] ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 24 May 2006 09:09:15 -0700
Message-ID: <44748527.3090103@caviumnetworks.com>
Date:	Wed, 24 May 2006 09:09:11 -0700
From:	Chad Reese <creese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20060504 Debian/1.7.8-1sarge6
X-Accept-Language: en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Patch for sparsemem support
References: <4470CAFE.5000404@caviumnetworks.com> <20060524014131.GB3205@linux-mips.org>
In-Reply-To: <20060524014131.GB3205@linux-mips.org>
Content-Type: multipart/mixed;
 boundary="------------020004000901020800020106"
X-OriginalArrivalTime: 24 May 2006 16:09:15.0901 (UTC) FILETIME=[6799C2D0:01C67F4C]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020004000901020800020106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Resend of previous patch

I've attached the patch compressed with gzip and as clear text. 
Hopefully one of them will survive whatever corruption occurred last time.

Chad

---

The patch below allows sparsemem to work for Mips64. This is my first 
foray into the boot memory handling code, so hopefully I haven't made 
any serious blunders. Unfortunately the Octeon processor I made the 
changes for isn't currently in the linux-mips.org tree. This means there 
isn't an example of sparsemem usage yet. I plan to work at fixing this soon.

Other than various ifdef changes, the most important change was moving 
memory_present() in arch/mips/kernel/setup.c. When you're using 
sparsemem extreme, this function does an allocate for bootmem. This 
would always fail since init_bootmem hasn't been called yet. I moved 
memory_present after free_bootmem. This only marks actual memory ranges 
as present instead of the entire address space.

This patch was made against 2.6.16.16

Signed-off-by: Chad Reese  <creese@caviumnetworks.com>

  arch/mips/kernel/setup.c     |    3 +--
  arch/mips/mm/init.c          |    2 +-
  include/asm-mips/page.h      |    2 ++
  include/asm-mips/sparsemem.h |   14 ++++++++++++++
  include/linux/mm.h           |    2 +-
  include/linux/mmzone.h       |    1 +
  6 files changed, 20 insertions(+), 4 deletions(-)

Ralf Baechle wrote:
> On Sun, May 21, 2006 at 01:18:06PM -0700, Chad Reese wrote:
> 
> Looks ok - but the patch is corrupt, can you resend?
> 
>   Ralf
> 

--------------020004000901020800020106
Content-Type: text/x-patch;
 name="sparsemem_support_mips_fixed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparsemem_support_mips_fixed.patch"

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d9293c5..406afce 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -358,8 +358,6 @@ static inline void bootmem_init(void)
 	}
 #endif

-	memory_present(0, first_usable_pfn, max_low_pfn);
-
 	/* Initialize the boot-time allocator with low memory only.  */
 	bootmap_size = init_bootmem(first_usable_pfn, max_low_pfn);

@@ -413,6 +411,7 @@ static inline void bootmem_init(void)

 		/* Register lowmem ranges */
 		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
+		memory_present(0, curr_pfn, curr_pfn + size - 1);
 	}

 	/* Reserve the bootmap memory.  */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 0ff9a34..f151373 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -228,7 +228,7 @@ void __init mem_init(void)
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
 		if (page_is_ram(tmp)) {
 			ram++;
-			if (PageReserved(mem_map+tmp))
+			if (PageReserved(pfn_to_page(tmp)))
 				reservedpages++;
 		}

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 399d731..103290a 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -145,11 +145,13 @@ typedef struct { unsigned long pgprot; }

 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)

+#ifndef CONFIG_SPARSEMEM
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif
+#endif

 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
diff --git a/include/asm-mips/sparsemem.h b/include/asm-mips/sparsemem.h
new file mode 100644
index 0000000..795ac6c
--- /dev/null
+++ b/include/asm-mips/sparsemem.h
@@ -0,0 +1,14 @@
+#ifndef _MIPS_SPARSEMEM_H
+#define _MIPS_SPARSEMEM_H
+#ifdef CONFIG_SPARSEMEM
+
+/*
+ * SECTION_SIZE_BITS		2^N: how big each section will be
+ * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
+ */
+#define SECTION_SIZE_BITS       28
+#define MAX_PHYSMEM_BITS        35
+
+#endif /* CONFIG_SPARSEMEM */
+#endif /* _MIPS_SPARSEMEM_H */
+
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 279446e..a1c4788 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -506,7 +506,7 @@ static inline void set_page_links(struct
 	set_page_section(page, pfn_to_section_nr(pfn));
 }

-#ifndef CONFIG_DISCONTIGMEM
+#if !defined(CONFIG_DISCONTIGMEM) && !defined(CONFIG_SPARSEMEM)
 /* The array of struct pages - for discontigmem use pgdat->lmem_map */
 extern struct page *mem_map;
 #endif
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ebfc238..807616f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/seqlock.h>
 #include <asm/atomic.h>
+#include <asm/page.h>

 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER


--------------020004000901020800020106
Content-Type: application/x-tar;
 name="sparsemem_support_mips_fixed.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sparsemem_support_mips_fixed.patch.gz"

H4sIAFiDdEQAA41WW2+jRhR+hl9xqkgrHAwY392k0e4mTmJpY1u2K7X70NEYBnsUGFzATrKr
/veeGfD90vrBwLnPd745Mz4PArCsGc+AOjTx5k7EF6nzyhLBQidl2XJhezA9q9K58Nk7+J1q
p+Y1bLteadLAY+BWKs16Xbcs60Jc3TTNS7E/fwar1miX22DKRxNQkGY04x5wEXLBYBVzH6Zx
nEUsIlzwzJCSkg7aPzpcMeHzQNctDbVx8kEWCUuZyIxKGQKepBlZpnQaMrIIRBki+k7C+E1+
lG50C0M419DDkJyG/AeDbM5UJivjEQMahrFHsziBN57NAR0hTwKxCD9sgGsHI6jK6IKkMsBv
IAskRbXGf1WgVl93a7hss+665db/Xz1mlsWP2IynGUtkdWgBCRUzluaVaUHC2KaW4WOfDJ//
HBveMklU/jJsZLL4EhZkaidwXDts38AEtVwLXHSSjcihHKFPstriiLgUkOVo+aeZGEWOXNkB
CTfSgn+VIOjQWt22A7fh1lq1c/zb+h1Sb6uRuFerbQTczB8oUEgThTEcUS1AFhhZtMAOV25A
vtzu9lKJTFNaajwAY0FnjPCUJDSSXqUS/JQqDb9NE5mn5WZDNCsw8w2ZEwEzlb3sxLEJZiJZ
TGT0PKxKiGELA6lIZQKUYk/24ObCC5c+c2gaWQoNaWzPEaAzmgL2Wqfjt2qubbuVWrVTofuw
n/PNoT+nlfC79UbZdcFUz5psQPaxYD4LcAMkSy+Dn7AUKZ8J5iO5xQwWs0USZzcgyXaFdnJ3
FIC8Ut9PJDoljZAVNdQr3N7C8MtTl4yfe48T3DHmFQ+ETHA/6D/2nsh4+GU07r50XzDevqbf
7T6Ql9+/TXrDb13SHzx0x0c5VRNUynXncFcoQWnHVvJAGgdCcQKNjb1VlYxcjlupiLLnjqlW
OJr8PJG2XpiiHtqKpLQZgeZ6FG68VzzJNpUqiErabvEEH4Uc7u72sNqPIU2KOnbC5IILQS7T
L13QJGW46NMc3FHrgr3hMA8ZRLG/OXaKoZD/bLvVaVCv6SlaOj5bOWIZhudouBtccrFSriAR
y24dabilCXnpDcdblpBnVBWwnFLx4CS3TN10rnUTrmHcvZ/0Bn0y7n3vkq+9yVjTqn/1f4U5
HixTPgNGvTmkzMt4LPDICUOYMuX48uUPNaZlpgO/aIk+xan0xsCjAuYUJzAXOIRpBrhSTwVx
tsUf1QH5r9re2hymLEyg1pALyqkGOPEPl5sn2qiPcFL608zA4275jjN6jw9bYdHwaqtTrzeZ
bVPXq7fa7dPjaMdtnwI7Ctn4RqUpz4D8cfrsxYuK2i4ERa+pkQ8nHLAbedExtY/L6+lQCInI
x5I8JXFuWQdz5qE3xrdJ70kRBZXwS46/b5ywKMGnT0cGG2xx0yLgEzx5aZJQvKNsBqk6FXDA
yDPM56kXi4zP5GVhmeKImfk0s+7C9QyTNwf2jjcKsesO14X+ZjNvLvbwRyzYyT7miqKXbBp4
1VrbttuVVtNtBpd7Wbie7mehzA8WeZ3Cf9lROdpzU7jNbdUNYH53rEjZ33jfez3Q4cxw8A4Y
cU8qzH1Ffpzd6Qr6R7xtrbdiRAWqIrxAIe6yNrzDLX3/Y3unLK6PB4R4HIzuu0Ruvu+Dfncw
euiOdP1fQf8/48ALAAA=
--------------020004000901020800020106--

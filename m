Received:  by oss.sgi.com id <S553722AbQJSTDg>;
	Thu, 19 Oct 2000 12:03:36 -0700
Received: from mail.ivm.net ([62.204.1.4]:56440 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553717AbQJSTDG>;
	Thu, 19 Oct 2000 12:03:06 -0700
Received: from franz.no.dom (port54.duesseldorf.ivm.de [195.247.65.54])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA06675;
	Thu, 19 Oct 2000 20:56:17 +0200
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001019205554.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20001019121432.E9832@lug-owl.de>
Date:   Thu, 19 Oct 2000 20:55:54 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: RE: Swap on DECStation
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

On 19-Oct-00 Jan-Benedict Glaw wrote:
> - *But* only running two processes which malloc() a large memory
>   region (read: 10MB each on my 5000/120 w/ 8MB RAM *but* enough
>   swap to provide that virtual memory) will lock up the box quite
>   predictably...

Yes, swapping is broken on R23000 boxen since quite some time and I haven't had the time
to track this down. However, reverting a change in include/asmmips/pgtable.h seems to
help:

--- snip ---
--- pgtable.h.orig      Sat Jul  1 12:27:34 2000
+++ pgtable.h   Sat Jul  1 17:25:21 2000
@@ -443,9 +443,9 @@
 extern void update_mmu_cache(struct vm_area_struct *vma,
                                unsigned long address, pte_t pte);
 
-#define SWP_TYPE(x)            (((x).val >> 1) & 0x3f)
-#define SWP_OFFSET(x)          ((x).val >> 8)
-#define SWP_ENTRY(type,offset) ((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#define SWP_TYPE(x)            (((x).val >> 8) & 0x7f)
+#define SWP_OFFSET(x)          ((x).val >> 15)
+#define SWP_ENTRY(type,offset) ((swp_entry_t) { ((type) << 8) | ((offset) << 15) })
 #define pte_to_swp_entry(pte)  ((swp_entry_t) { pte_val(pte) })
--- snip ---

Thanks to Richard van den Berg <R.vandenBerg@inter.NL.net> for pointing this out.

-- 
Regards,
Harald

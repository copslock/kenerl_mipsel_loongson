Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 16:58:29 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.176]:58030 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493247AbZF3O6W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jun 2009 16:58:22 +0200
Received: by wa-out-1112.google.com with SMTP id n4so30963wag.0
        for <multiple recipients>; Tue, 30 Jun 2009 07:53:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=z1ubBzBjlWu97Fc/ijakw01jlpL7gckf1Qe8t4o6bCY=;
        b=Ral3DNR3uUtPZtys1Oe8D5EqucaFsf5riKCJ+0kE1oxnxhhu16CFBm8QRl8bwKIUYq
         nUYSUprpXe/YFv61cB+A3dsQosi8NBWxGTK4pz42Q6TPVmWxdaCsWzAN/vWZ/B85dvax
         0pdeFZ0ynR/U64BDIT9/frVyGmVCOWxnjrBNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LZ8NkiOzu+/w+NBDkohRa9tCjE3qBa8ecJJilyHLnWvqekwkMD4lY7m1fLCXG7qQXK
         p0Bqfwk3dXRTNvyvHyZ3Zn7JeaLdJ5NeLHcIiflJCCOD+Lxi1EOwPRK9rea1sbZmrENy
         tr4tPRRmIqeio3Izoj2QCpqvBsL9jFGihRUZI=
Received: by 10.114.167.3 with SMTP id p3mr13485169wae.142.1246373590769;
        Tue, 30 Jun 2009 07:53:10 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id l37sm176024waf.40.2009.06.30.07.53.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 07:53:09 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Cc:	Pavel Machek <pavel@ucw.cz>, Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH] [MIPS] Hibernation: only save pages in system ram
Date:	Tue, 30 Jun 2009 22:52:50 +0800
Message-Id: <1246373570-21090-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.3.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

when using hibernation(STD) with CONFIG_FLATMEM in linux-mips-64bit, it
fails for the current mips-specific hibernation implementation save the
pages in all of the memory space(except the nosave section) and make
there will be not enough memory left to the STD task itself, and then
fail. in reality, we only need to save the pages in system rams.

here is the reason why it fail:

kernel/power/snapshot.c:

static void mark_nosave_pages(struct memory_bitmap *bm)
{
		...
		if (pfn_valid(pfn)) {
			...
		}
}

arch/mips/include/asm/page.h:

	...
	#ifdef CONFIG_FLATMEM

	#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)

	#elif defined(CONFIG_SPARSEMEM)

	/* pfn_valid is defined in linux/mmzone.h */
	...

we can rewrite pfn_valid(pfn) to fix this problem, but I really do not
want to touch such a widely-used macro, so, I used another solution:

static struct page *saveable_page(struct zone *zone, unsigned long pfn)
{
	...
	if ( .... pfn_is_nosave(pfn)
		return NULL;
	...
}

and pfn_is_nosave is implemented in arch/mips/power/cpu.c, so, hacking
this one is better.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/power/cpu.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
index 7995df4..ef472e3 100644
--- a/arch/mips/power/cpu.c
+++ b/arch/mips/power/cpu.c
@@ -10,6 +10,7 @@
 #include <asm/suspend.h>
 #include <asm/fpu.h>
 #include <asm/dsp.h>
+#include <asm/bootinfo.h>
 
 static u32 saved_status;
 struct pt_regs saved_regs;
@@ -34,10 +35,26 @@ void restore_processor_state(void)
 		restore_dsp(current);
 }
 
+int pfn_in_system_ram(unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type == BOOT_MEM_RAM) {
+			if ((pfn >= (boot_mem_map.map[i].addr >> PAGE_SHIFT)) &&
+				((pfn) < ((boot_mem_map.map[i].addr +
+					boot_mem_map.map[i].size) >> PAGE_SHIFT)))
+				return 1;
+		}
+	}
+	return 0;
+}
+
 int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
 	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
 
-	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+	return ((pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn))
+			|| !pfn_in_system_ram(pfn);
 }
-- 
1.6.0.4

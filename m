Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 23:15:47 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36284
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994030AbdCMWOhChXpm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 23:14:37 +0100
Received: by mail-wm0-x244.google.com with SMTP id v190so12126090wme.3;
        Mon, 13 Mar 2017 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MuWNNuk3vxLpp54L6i+g8NdgOGb/dhWpwMswypTTuV0=;
        b=Sbc5FX0fwRxSmjxoI2AYNY6jCdAlnKBBPQIIh7vJluPM2Z7sK4GhVIGpo9pUxLeZt0
         OVKcYUC6U+H2P6UbB5ANhubIcMw3ArLged7kMbVeNjh+WDxAgwUPJfGwwWXl3Ikmdk4R
         kTg2mxRBFdRwY3dIYJLpWQof2BSOkNj27QvdCo12cFVyynWAXKqduDbfj+bx8xRNLkvy
         29Z7+X9HETkiZZrcW0x1bXRyXT+rctMYlunEj6i9JmqizEad4uSemTvMH7aZ2s4JsFPj
         bDb6Hb5+4sWXl/kZY6rR3pBmdrg6Fv43BPkDaMJ/plzzzwtA0HqA+eJKX1m3NsBmB+Ix
         HqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MuWNNuk3vxLpp54L6i+g8NdgOGb/dhWpwMswypTTuV0=;
        b=XgyEyeO5yCzHDWd+CJproymr3XLMRaIZZ0Jifflwr2uR2TxvyyFY/P61jY8K0Aim4v
         YdlEvaAxASwzppPYg1Q4QHmzdllZENuZ6rEv2G8yVSfR4myMzO3VY21napmza2CCajzT
         RsOTvY1iKRD/2OvNIpPHTm3mhrUpFr3I3/xNnRaSz2DovauYYmDH1ixdmcQk6mwTjdBU
         YvbM0CDeP5xdOj9m/8Ohd7Rw6o3Rik/AqGCVddqF/FJAVkSLStH0pd/mlyH4h9H2mgtZ
         iucCnaNMvBszDw0cWvOHRzzEJ58HPAJ0Qd81iNf2SKaXFj2veFL8K5/B+92kmu58XlJL
         3RRw==
X-Gm-Message-State: AFeK/H2FsuE+GolEWj3NPTCZVSlVlwgDj0Q231EzL38wtGz3UlfyRilOECMvqLWWbGsLuQ==
X-Received: by 10.28.69.202 with SMTP id l71mr12714512wmi.68.1489443270117;
        Mon, 13 Mar 2017 15:14:30 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id z88sm26694011wrb.26.2017.03.13.15.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 15:14:29 -0700 (PDT)
From:   Till Smejkal <till.smejkal@googlemail.com>
X-Google-Original-From: Till Smejkal <till.smejkal@gmail.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 03/13] mm: Rename 'unmap_region' and add mm_struct argument
Date:   Mon, 13 Mar 2017 15:14:05 -0700
Message-Id: <20170313221415.9375-4-till.smejkal@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313221415.9375-1-till.smejkal@gmail.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: till.smejkal@googlemail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Rename the 'unmap_region' function to 'munmap_region' so that it uses the
same naming pattern as the do_mmap <-> mmap_region couple. In addition
also make the new 'munmap_region' function publicly available to all other
kernel sources.

In addition, also add to the function the mm_struct it should operate on
as additional argument. Before, the function simply used the memory map of
the current task. However, with the introduction of first class virtual
address spaces, munmap_region need also be able to operate on other memory
maps than just the current task's one. Accordingly, add a new argument to
the function so that one can define explicitly which memory map should be
used.

Signed-off-by: Till Smejkal <till.smejkal@gmail.com>
---
 include/linux/mm.h |  4 ++++
 mm/mmap.c          | 14 +++++---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb11be77545f..71a90604d21f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2023,6 +2023,10 @@ extern unsigned long do_mmap(struct mm_struct *mm, struct file *file,
 	unsigned long addr, unsigned long len, unsigned long prot,
 	unsigned long flags, vm_flags_t vm_flags, unsigned long pgoff,
 	unsigned long *populate);
+
+extern void munmap_region(struct mm_struct *mm, struct vm_area_struct *vma,
+			  struct vm_area_struct *prev, unsigned long start,
+			  unsigned long end);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
 static inline unsigned long
diff --git a/mm/mmap.c b/mm/mmap.c
index 70028bf7b58d..ea79bc4da5b7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -70,10 +70,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
-
 /* description of effects of mapping type and prot in current implementation.
  * this is due to the limited x86 page protection hardware.  The expected
  * behavior is in parens:
@@ -1731,7 +1727,7 @@ unsigned long mmap_region(struct mm_struct *mm, struct file *file,
 	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	munmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
 	charged = 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -2447,9 +2443,9 @@ static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end)
+void munmap_region(struct mm_struct *mm, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, unsigned long start,
+		unsigned long end)
 {
 	struct vm_area_struct *next = prev ? prev->vm_next : mm->mmap;
 	struct mmu_gather tlb;
@@ -2654,7 +2650,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len)
 	 * Remove the vma's, and unmap the actual pages
 	 */
 	detach_vmas_to_be_unmapped(mm, vma, prev, end);
-	unmap_region(mm, vma, prev, start, end);
+	munmap_region(mm, vma, prev, start, end);
 
 	arch_unmap(mm, vma, start, end);
 
-- 
2.12.0

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 23:15:21 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36280
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993990AbdCMWOcGR41m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 23:14:32 +0100
Received: by mail-wm0-x244.google.com with SMTP id v190so12125941wme.3;
        Mon, 13 Mar 2017 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S0upfSdZufs1E8OQBrpOcxd5FLskulElvUhgO1Wl3wU=;
        b=jCXgItCCNfcmySMt1lzfCoLn7OmnJyWkm3cFsRYC2K8Ij9+56VoOhMDBHnNudHZFb+
         FM31o9mmQYMtWqyjd5aF2lz1B83kwkUc57uo2NqTlMRN2gmxZKyT1AX8wmomL8DHu+gQ
         wKLtXB4/StVo+nbdmgFrVt5lLwHCdEDFtPxLbZu5km46xqrUGcpp2cGVDxWEXbnQ7/1V
         DihZ8qpJw8yC4a6ixN4YTJYq5p4Ifc2uhLSMcgW5+xL5FIkwn8I8oeCHwyNntS1CWqtH
         rZqPvsyyF4ZTAgdVhzqFWfbSuc5uNI9/FSsIUsbc0l4fnDTjlTywa3JrI9SwT9jdTeXc
         DWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S0upfSdZufs1E8OQBrpOcxd5FLskulElvUhgO1Wl3wU=;
        b=RUKh81vnsbiNNswWOzlRiuTryzaFb6TP4pyVesTxrgwbHJ1Y2FpVjADMwMhl5kFhsl
         VN0pTk4YkSgxfX/A5eNfieQ1pzQL8cYQ/huCqPo0Gvm9g4v86etxldlz9sTQs1N42FCj
         JBZ67rzQXPHLAoiWvYoRYJ4FxF/Kcbv9m+LbgAtER2jAR3MBC/HUP3ZCPcU8wBnGFQkA
         whQnll+qhu6wkTAHvSJeKH/EwN3stt5r8fe8OWbBW/N5uVUta4yfiraBH2N3RB6ikyx+
         WE9xSaH+hL7GdGMxqkOb5oDfrP6F22dAxH5aynKHjh0YsA8JH6I9GJpA7YPsCa7m2BsR
         i+bQ==
X-Gm-Message-State: AFeK/H05D4jiEnKBFbrxQ2+AeT/aME6S6SS1bzhPU56ecUB0CLAXYel6JTl0LBeHZ+Nyhw==
X-Received: by 10.28.203.204 with SMTP id b195mr12636968wmg.51.1489443266680;
        Mon, 13 Mar 2017 15:14:26 -0700 (PDT)
Received: from localhost (login1.zih.tu-dresden.de. [141.76.16.140])
        by smtp.googlemail.com with ESMTPSA id k8sm26453956wre.19.2017.03.13.15.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Mar 2017 15:14:26 -0700 (PDT)
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
Subject: [RFC PATCH 02/13] mm: Add mm_struct argument to 'do_mmap' and 'do_mmap_pgoff'
Date:   Mon, 13 Mar 2017 15:14:04 -0700
Message-Id: <20170313221415.9375-3-till.smejkal@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170313221415.9375-1-till.smejkal@gmail.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
Return-Path: <till.smejkal@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57170
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

Add to the 'do_mmap' and 'do_mmap_pgoff' functions the mm_struct they
should operate on as additional argument. Before, both functions simply
used the memory map of the current task. However, with the introduction of
first class virtual address spaces, these functions also need to be usable
for other memory maps than just the one of the current process. Hence,
explicitly define during the function call which memory map to use.

Signed-off-by: Till Smejkal <till.smejkal@gmail.com>
---
 arch/x86/mm/mpx.c  |  4 ++--
 fs/aio.c           |  4 ++--
 include/linux/mm.h | 11 ++++++-----
 ipc/shm.c          |  3 ++-
 mm/mmap.c          | 16 ++++++++--------
 mm/nommu.c         |  7 ++++---
 mm/util.c          |  2 +-
 7 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
index af59f808742f..99c664a97c35 100644
--- a/arch/x86/mm/mpx.c
+++ b/arch/x86/mm/mpx.c
@@ -50,8 +50,8 @@ static unsigned long mpx_mmap(unsigned long len)
 		return -EINVAL;
 
 	down_write(&mm->mmap_sem);
-	addr = do_mmap(NULL, 0, len, PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE, VM_MPX, 0, &populate);
+	addr = do_mmap(mm, NULL, 0, len, PROT_READ | PROT_WRITE,
+		       MAP_ANONYMOUS | MAP_PRIVATE, VM_MPX, 0, &populate);
 	up_write(&mm->mmap_sem);
 	if (populate)
 		mm_populate(addr, populate);
diff --git a/fs/aio.c b/fs/aio.c
index 873b4ca82ccb..df9bba5a2aff 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -510,8 +510,8 @@ static int aio_setup_ring(struct kioctx *ctx)
 		return -EINTR;
 	}
 
-	ctx->mmap_base = do_mmap_pgoff(ctx->aio_ring_file, 0, ctx->mmap_size,
-				       PROT_READ | PROT_WRITE,
+	ctx->mmap_base = do_mmap_pgoff(current->mm, ctx->aio_ring_file, 0,
+				       ctx->mmap_size, PROT_READ | PROT_WRITE,
 				       MAP_SHARED, 0, &unused);
 	up_write(&mm->mmap_sem);
 	if (IS_ERR((void *)ctx->mmap_base)) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa483d2ff3eb..fb11be77545f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2019,17 +2019,18 @@ extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned lo
 extern unsigned long mmap_region(struct mm_struct *mm, struct file *file,
 				 unsigned long addr, unsigned long len,
 				 vm_flags_t vm_flags, unsigned long pgoff);
-extern unsigned long do_mmap(struct file *file, unsigned long addr,
-	unsigned long len, unsigned long prot, unsigned long flags,
-	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate);
+extern unsigned long do_mmap(struct mm_struct *mm, struct file *file,
+	unsigned long addr, unsigned long len, unsigned long prot,
+	unsigned long flags, vm_flags_t vm_flags, unsigned long pgoff,
+	unsigned long *populate);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
 static inline unsigned long
-do_mmap_pgoff(struct file *file, unsigned long addr,
+do_mmap_pgoff(struct mm_struct *mm, struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate)
 {
-	return do_mmap(file, addr, len, prot, flags, 0, pgoff, populate);
+	return do_mmap(mm, file, addr, len, prot, flags, 0, pgoff, populate);
 }
 
 #ifdef CONFIG_MMU
diff --git a/ipc/shm.c b/ipc/shm.c
index 81203e8ba013..64c21fb32ca9 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1222,7 +1222,8 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr,
 			goto invalid;
 	}
 
-	addr = do_mmap_pgoff(file, addr, size, prot, flags, 0, &populate);
+	addr = do_mmap_pgoff(mm, file, addr, size, prot, flags, 0,
+			     &populate);
 	*raddr = addr;
 	err = 0;
 	if (IS_ERR_VALUE(addr))
diff --git a/mm/mmap.c b/mm/mmap.c
index 5ac276ac9807..70028bf7b58d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1299,14 +1299,14 @@ static inline int mlock_future_check(struct mm_struct *mm,
 }
 
 /*
- * The caller must hold down_write(&current->mm->mmap_sem).
+ * The caller must hold down_write(&mm->mmap_sem).
  */
-unsigned long do_mmap(struct file *file, unsigned long addr,
-			unsigned long len, unsigned long prot,
-			unsigned long flags, vm_flags_t vm_flags,
-			unsigned long pgoff, unsigned long *populate)
+unsigned long do_mmap(struct mm_struct *mm, struct file *file,
+		      unsigned long addr, unsigned long len,
+		      unsigned long prot, unsigned long flags,
+		      vm_flags_t vm_flags, unsigned long pgoff,
+		      unsigned long *populate)
 {
-	struct mm_struct *mm = current->mm;
 	int pkey = 0;
 
 	*populate = 0;
@@ -2779,8 +2779,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	}
 
 	file = get_file(vma->vm_file);
-	ret = do_mmap_pgoff(vma->vm_file, start, size,
-			prot, flags, pgoff, &populate);
+	ret = do_mmap_pgoff(mm, vma->vm_file, start, size,
+			    prot, flags, pgoff, &populate);
 	fput(file);
 out:
 	up_write(&mm->mmap_sem);
diff --git a/mm/nommu.c b/mm/nommu.c
index 24f9f5f39145..54825d29f50b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1198,7 +1198,8 @@ static int do_mmap_private(struct vm_area_struct *vma,
 /*
  * handle mapping creation for uClinux
  */
-unsigned long do_mmap(struct file *file,
+unsigned long do_mmap(struct mm_struct *mm,
+			struct file *file,
 			unsigned long addr,
 			unsigned long len,
 			unsigned long prot,
@@ -1375,10 +1376,10 @@ unsigned long do_mmap(struct file *file,
 	/* okay... we have a mapping; now we have to register it */
 	result = vma->vm_start;
 
-	current->mm->total_vm += len >> PAGE_SHIFT;
+	mm->total_vm += len >> PAGE_SHIFT;
 
 share:
-	add_vma_to_mm(current->mm, vma);
+	add_vma_to_mm(mm, vma);
 
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
diff --git a/mm/util.c b/mm/util.c
index 3cb2164f4099..46d05eef9a6b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -302,7 +302,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	if (!ret) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
-		ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
+		ret = do_mmap_pgoff(mm, file, addr, len, prot, flag, pgoff,
 				    &populate);
 		up_write(&mm->mmap_sem);
 		if (populate)
-- 
2.12.0

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 17:37:36 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:34132
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbeCVQhB02Vh7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Mar 2018 17:37:01 +0100
Received: by mail-lf0-x241.google.com with SMTP id c78-v6so9441394lfh.1;
        Thu, 22 Mar 2018 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=TJxRecHNFs3nmAw3aBotwnp/kPcYVxq9wVj7Mf8ZHKw=;
        b=h1u01+BbPLauWniMhfezBsPSl/2y2obwKs6F0u3Gi5Cllhir2lgbXieTPReF4w9x4/
         k7kl5Ryrm4/d2yswIUDKhIFUc3EJ2Z2nuxISbSuHLIa0Bos+czfrXxnyNeFARCHV2hj9
         NiC2wZEFHH3+jyVM6DjVp20OpkbR8kRC/tekE8biN9WuCjpPpvRpu7+iVar+tCaWBlLN
         mwE9N62UF0N7g52KvGc96Wx0suqVsG8oMrfIWr6f4sIgpupHgEmUBko7eOMtJs12ZKyb
         iBreNMyK8WBzuxdXsWXE8o3qGav4OykvWcPGCNkAPdXjdCj+S7ufxBe1aoA/BWIg3xOD
         vL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=TJxRecHNFs3nmAw3aBotwnp/kPcYVxq9wVj7Mf8ZHKw=;
        b=Atiu8xtCA2XHCUT7PrG5KYasmkzha+hB6826DkAOFBZo63L8j9BGyf2X1MZqWrb19H
         xap4K/KpAzqx/wJLp33lH+3KIRNtrbZc7koiIMV6BHHroenQcewhPmJDJfLCgORLURVh
         OKzL4AYJGrzQ9VYx8xvub/s85y3gvLZiDD1tv2YVQ5GdzD9DTbAQBOpAUK17+t45+PaE
         cAyzltV7EvGxcOkXZxDhel5p6aS9NhVY/1j/ODDGt7YlkDiL4NiQkgZv2rnz98ZRZL7r
         YCZCXQY1BdovvujrRrNyluPgSYFraeOLNd4RN0isWG5XBM9qehn6s+tJuPV0sBFjfENU
         +sag==
X-Gm-Message-State: AElRT7FiQ6ZPRy37quJy8iiJ1eyWDUZMcvQEgq0zLEMitbPa/tRhcTTG
        Ly/mTOmy1EMtwSPXdhWr8JA=
X-Google-Smtp-Source: AG47ELvNOG9PT+pQp9FtItM7KOqORizxFQ0vqAkedCa+HLq7LUL915BY01VxlS8Lly357PpM1JRZ4g==
X-Received: by 2002:a19:2c85:: with SMTP id s127-v6mr15467642lfs.18.1521736614799;
        Thu, 22 Mar 2018 09:36:54 -0700 (PDT)
Received: from crasher.ptsecurity.ru ([31.44.93.25])
        by smtp.gmail.com with ESMTPSA id q66sm1016261ljq.75.2018.03.22.09.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Mar 2018 09:36:53 -0700 (PDT)
From:   Ilya Smith <blackzert@gmail.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        nyc@holomorphy.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        blackzert@gmail.com, gregkh@linuxfoundation.org,
        deepa.kernel@gmail.com, mhocko@suse.com, hughd@google.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        akpm@linux-foundation.org, steve.capper@arm.com,
        punit.agrawal@arm.com, paul.burton@mips.com,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        keescook@chromium.org, bhsharma@redhat.com, riel@redhat.com,
        nitin.m.gupta@oracle.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, jglisse@redhat.com,
        willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v2 2/2] Architecture defined limit on memory region random shift.
Date:   Thu, 22 Mar 2018 19:36:38 +0300
Message-Id: <1521736598-12812-3-git-send-email-blackzert@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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

Signed-off-by: Ilya Smith <blackzert@gmail.com>
---
 arch/alpha/kernel/osf_sys.c         | 1 +
 arch/arc/mm/mmap.c                  | 1 +
 arch/arm/mm/mmap.c                  | 2 ++
 arch/frv/mm/elf-fdpic.c             | 1 +
 arch/ia64/kernel/sys_ia64.c         | 1 +
 arch/ia64/mm/hugetlbpage.c          | 1 +
 arch/metag/mm/hugetlbpage.c         | 1 +
 arch/mips/mm/mmap.c                 | 1 +
 arch/parisc/kernel/sys_parisc.c     | 2 ++
 arch/powerpc/mm/hugetlbpage-radix.c | 1 +
 arch/powerpc/mm/mmap.c              | 2 ++
 arch/powerpc/mm/slice.c             | 2 ++
 arch/s390/mm/mmap.c                 | 2 ++
 arch/sh/mm/mmap.c                   | 2 ++
 arch/sparc/kernel/sys_sparc_32.c    | 1 +
 arch/sparc/kernel/sys_sparc_64.c    | 2 ++
 arch/sparc/mm/hugetlbpage.c         | 2 ++
 arch/tile/mm/hugetlbpage.c          | 2 ++
 arch/x86/kernel/sys_x86_64.c        | 4 ++++
 arch/x86/mm/hugetlbpage.c           | 4 ++++
 fs/hugetlbfs/inode.c                | 1 +
 include/linux/mm.h                  | 1 +
 mm/mmap.c                           | 3 ++-
 23 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index fa1a392..0ab9f31 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1301,6 +1301,7 @@ arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 	info.high_limit = limit;
 	info.align_mask = 0;
 	info.align_offset = 0;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 2e13683..45225fc 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -75,5 +75,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.high_limit = TASK_SIZE;
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index eb1de66..1eb660c 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -101,6 +101,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.high_limit = TASK_SIZE;
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -152,6 +153,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.high_limit = mm->mmap_base;
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/frv/mm/elf-fdpic.c b/arch/frv/mm/elf-fdpic.c
index 46aa289..a2ce2ce 100644
--- a/arch/frv/mm/elf-fdpic.c
+++ b/arch/frv/mm/elf-fdpic.c
@@ -86,6 +86,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	info.high_limit = (current->mm->start_stack - 0x00200000);
 	info.align_mask = 0;
 	info.align_offset = 0;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
 		goto success;
diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index 085adfc..15fa4fb 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -64,6 +64,7 @@ arch_get_unmapped_area (struct file *filp, unsigned long addr, unsigned long len
 	info.high_limit = TASK_SIZE;
 	info.align_mask = align_mask;
 	info.align_offset = 0;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index d16e419..ec7822d 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -162,6 +162,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, u
 	info.high_limit = HPAGE_REGION_BASE + RGN_MAP_LIMIT;
 	info.align_mask = PAGE_MASK & (HPAGE_SIZE - 1);
 	info.align_offset = 0;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/metag/mm/hugetlbpage.c b/arch/metag/mm/hugetlbpage.c
index 012ee4c..babd325 100644
--- a/arch/metag/mm/hugetlbpage.c
+++ b/arch/metag/mm/hugetlbpage.c
@@ -191,6 +191,7 @@ hugetlb_get_unmapped_area_new_pmd(unsigned long len)
 	info.high_limit = TASK_SIZE;
 	info.align_mask = PAGE_MASK & HUGEPT_MASK;
 	info.align_offset = 0;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 33d3251..5a3d384 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -122,6 +122,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	info.flags = 0;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 378a754..abf4b05 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -130,6 +130,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.high_limit = mmap_upper_limit();
 	info.align_mask = last_mmap ? (PAGE_MASK & (SHM_COLOUR - 1)) : 0;
 	info.align_offset = shared_align_offset(last_mmap, pgoff);
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 found_addr:
@@ -192,6 +193,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.high_limit = mm->mmap_base;
 	info.align_mask = last_mmap ? (PAGE_MASK & (SHM_COLOUR - 1)) : 0;
 	info.align_offset = shared_align_offset(last_mmap, pgoff);
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
 		goto found_addr;
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 2486bee..1d61a88 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -87,6 +87,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = 0;
 
 	return vm_unmapped_area(&info);
 }
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index d503f34..7fe98c7 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -136,6 +136,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = high_limit;
 	info.align_mask = 0;
+	info.random_shift = 0;
 
 	return vm_unmapped_area(&info);
 }
@@ -180,6 +181,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
 	info.align_mask = 0;
+	info.random_shift = 0;
 
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 23ec2c5..2005845 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -284,6 +284,7 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 	info.length = len;
 	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
 	info.align_offset = 0;
+	info.random_shift = 0;
 
 	addr = TASK_UNMAPPED_BASE;
 	/*
@@ -330,6 +331,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 	info.length = len;
 	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
 	info.align_offset = 0;
+	info.random_shift = 0;
 
 	addr = mm->mmap_base;
 	/*
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 831bdcf..141823f 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -95,6 +95,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
+	info.random_shift = 0;
 	if (filp || (flags & MAP_SHARED))
 		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
 	else
@@ -146,6 +147,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = mm->mmap_base;
+	info.random_shift = 0;
 	if (filp || (flags & MAP_SHARED))
 		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
 	else
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index 6a1a129..d9206c2 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -74,6 +74,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.high_limit = TASK_SIZE;
 	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -124,6 +125,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.high_limit = mm->mmap_base;
 	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 990703b7..af664ba3 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -66,6 +66,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	info.align_mask = (flags & MAP_SHARED) ?
 		(PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 55416db..3d12e3d 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -131,6 +131,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
 	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
@@ -194,6 +195,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.high_limit = mm->mmap_base;
 	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 0112d69..6d0c032 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -43,6 +43,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
@@ -75,6 +76,7 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.high_limit = mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/tile/mm/hugetlbpage.c b/arch/tile/mm/hugetlbpage.c
index 0986d42..2b3a9b6 100644
--- a/arch/tile/mm/hugetlbpage.c
+++ b/arch/tile/mm/hugetlbpage.c
@@ -176,6 +176,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 	info.high_limit = TASK_SIZE;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -193,6 +194,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	info.high_limit = current->mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 676774b..0eda047 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -163,6 +163,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.high_limit = end;
 	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = in_compat_syscall() ?
+		256 : 0x1000000;
 	if (filp) {
 		info.align_mask = get_align_mask();
 		info.align_offset += get_align_bits();
@@ -224,6 +226,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 
 	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	info.random_shift = in_compat_syscall() ?
+		256 : 0x1000000;
 	if (filp) {
 		info.align_mask = get_align_mask();
 		info.align_offset += get_align_bits();
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 00b2966..f4f6436 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -97,6 +97,8 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = in_compat_syscall() ?
+		256 : 0x1000000;
 	return vm_unmapped_area(&info);
 }
 
@@ -121,6 +123,8 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = in_compat_syscall() ?
+		256 : 0x1000000;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 8fe1b0a..83e962e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -200,6 +200,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	info.high_limit = TASK_SIZE;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c716257..f869e6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2252,6 +2252,7 @@ struct vm_unmapped_area_info {
 	unsigned long high_limit;
 	unsigned long align_mask;
 	unsigned long align_offset;
+	unsigned long random_shift;
 };
 
 #ifndef CONFIG_MMU
diff --git a/mm/mmap.c b/mm/mmap.c
index ba9cebb..425fa09 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1938,7 +1938,7 @@ unsigned long unmapped_area_random(struct vm_unmapped_area_info *info)
 	if (gap_end ==  gap_start)
 		return gap_start;
 	addr = entropy[1] % (min((gap_end - gap_start) >> PAGE_SHIFT,
-							 0x10000UL));
+							 info->random_shift));
 	addr = gap_end - (addr << PAGE_SHIFT);
 	addr += (info->align_offset - addr) & info->align_mask;
 	return addr;
@@ -2186,6 +2186,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	info.align_mask = 0;
+	info.random_shift = 0;
 	return vm_unmapped_area(&info);
 }
 #endif
-- 
2.7.4

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 02:23:52 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33910 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993004AbcJMAUrukdX4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 02:20:47 +0200
Received: by mail-lf0-f65.google.com with SMTP id x23so3968583lfi.1
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 17:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YtCTnPnKl7iOzKo94LN8YtKRwhKeaOyj++/afSUhTg8=;
        b=T8lGnI3g8EgzPX2ur/FmxLhX1Qvi3z2z14HovnNxNT9T+DGUy5gnRVABy/tTPZEVvl
         EPWDDhpc+byHt3iebnB2GFt7XZLRBjUOgtPQv3EYC8Bfs2sUxGz5zGpd3znmoG5VqTE6
         TQBXyofuyuKOgD800XXdIUh0HCjQkWgvGxj7ioFI3i/L+sPN9RDdQhlUizfivrDQBmVJ
         q+rLPIbHiUlJ2RTIS6QfINu+iXFjzirMlJnbFyvTNtBTXUTvY8f2lor/ezyHKvgwVbSm
         MW9sFjSoZiKtiFp5HuoT0YL2qW/HlfMTH52tMfkF4apqGUcq7Ryf4RFvqiWkzH44RapR
         oX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtCTnPnKl7iOzKo94LN8YtKRwhKeaOyj++/afSUhTg8=;
        b=d6Zms7Vw7UEbMsm5PuYCUEkQwaJd6XH9QY4dwnlvzWSFpOxBqoF+t/biIRbW1tUr+/
         nyEuiISUsusyKcyZOillmJfEmUItXDBwnMQvvTYtYNBj2c6oe5nxWhOswOx9axGOszUY
         lP4nsYW7k5usWzSTOLlzWZ6nUhE7fO415cNIQww4wo2QlnHCowJtstVkq3QvEVlGlFIr
         ocrkMtOUw7qlU1/B299hcfapAtyLJSEsB1V9HxMElGxUA1slSPU3kaVmyCPkVyOAYO7w
         xKR8QQukakYqQ1lkIDUevj6Fc1eoa6RJ8C49J2csRTj4f5wo55s00sDF1NlPaqkYr79+
         7C6g==
X-Gm-Message-State: AA6/9RlAQL59FPplS0FzkvkD3uGLEQcBAzCwMQv+4vFUlFgpKkTobM6waECPhhCZBO7DKQ==
X-Received: by 10.28.175.77 with SMTP id y74mr17295wme.114.1476318042381;
        Wed, 12 Oct 2016 17:20:42 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id v3sm17413357wjm.4.2016.10.12.17.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 17:20:40 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 08/10] mm: replace __access_remote_vm() write parameter with gup_flags
Date:   Thu, 13 Oct 2016 01:20:18 +0100
Message-Id: <20161013002020.3062-9-lstoakes@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lstoakes@gmail.com
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

This patch removes the write parameter from __access_remote_vm() and replaces it
with a gup_flags parameter as use of this function previously _implied_
FOLL_FORCE, whereas after this patch callers explicitly pass this flag.

We make this explicit as use of FOLL_FORCE can result in surprising behaviour
(and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/memory.c | 23 +++++++++++++++--------
 mm/nommu.c  |  9 ++++++---
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 20a9adb..79ebed3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3869,14 +3869,11 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
  * given task for page fault accounting.
  */
 static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, int write)
+		unsigned long addr, void *buf, int len, unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
 	void *old_buf = buf;
-	unsigned int flags = FOLL_FORCE;
-
-	if (write)
-		flags |= FOLL_WRITE;
+	int write = gup_flags & FOLL_WRITE;
 
 	down_read(&mm->mmap_sem);
 	/* ignore errors, just check how much was successfully transferred */
@@ -3886,7 +3883,7 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 		struct page *page = NULL;
 
 		ret = get_user_pages_remote(tsk, mm, addr, 1,
-				flags, &page, &vma);
+				gup_flags, &page, &vma);
 		if (ret <= 0) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
@@ -3945,7 +3942,12 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, int write)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len, write);
+	unsigned int flags = FOLL_FORCE;
+
+	if (write)
+		flags |= FOLL_WRITE;
+
+	return __access_remote_vm(NULL, mm, addr, buf, len, flags);
 }
 
 /*
@@ -3958,12 +3960,17 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr,
 {
 	struct mm_struct *mm;
 	int ret;
+	unsigned int flags = FOLL_FORCE;
 
 	mm = get_task_mm(tsk);
 	if (!mm)
 		return 0;
 
-	ret = __access_remote_vm(tsk, mm, addr, buf, len, write);
+	if (write)
+		flags |= FOLL_WRITE;
+
+	ret = __access_remote_vm(tsk, mm, addr, buf, len, flags);
+
 	mmput(mm);
 
 	return ret;
diff --git a/mm/nommu.c b/mm/nommu.c
index 70cb844..bde7df3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1809,9 +1809,10 @@ void filemap_map_pages(struct fault_env *fe,
 EXPORT_SYMBOL(filemap_map_pages);
 
 static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, int write)
+		unsigned long addr, void *buf, int len, unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
+	int write = gup_flags & FOLL_WRITE;
 
 	down_read(&mm->mmap_sem);
 
@@ -1853,7 +1854,8 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, int write)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len, write);
+	return __access_remote_vm(NULL, mm, addr, buf, len,
+			write ? FOLL_WRITE : 0);
 }
 
 /*
@@ -1871,7 +1873,8 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
 	if (!mm)
 		return 0;
 
-	len = __access_remote_vm(tsk, mm, addr, buf, len, write);
+	len = __access_remote_vm(tsk, mm, addr, buf, len,
+			write ? FOLL_WRITE : 0);
 
 	mmput(mm);
 	return len;
-- 
2.10.0

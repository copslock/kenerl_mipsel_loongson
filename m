Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 09:01:50 +0100 (BST)
Received: from smtp-out.google.com ([216.239.45.13]:61480 "EHLO
	smtp-out.google.com") by ftp.linux-mips.org with ESMTP
	id S20022063AbXGVIBs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jul 2007 09:01:48 +0100
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id l6M81jGE003470;
	Sun, 22 Jul 2007 01:01:45 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:message-id:
	mime-version:content-type;
	b=EKwLVE4bnPzcQEPafqMygbkBgfXi5y3OOnTVfbJ8DixQi0Ut9PFfGgoE0xepVPjhs
	bceIOCiO6UjKR8MdsxuNQ==
Received: from localhost (chino.kir.corp.google.com [172.29.12.61])
	by zps37.corp.google.com with ESMTP id l6M81drX022610;
	Sun, 22 Jul 2007 01:01:40 -0700
Received: by localhost (Postfix, from userid 24081)
	id 83009E4049; Sun, 22 Jul 2007 01:01:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 822E4E4046;
	Sun, 22 Jul 2007 01:01:39 -0700 (PDT)
Date:	Sun, 22 Jul 2007 01:01:39 -0700 (PDT)
From:	David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [patch] mips: replace __attribute_used__ with __used
Message-ID: <alpine.DEB.0.99.0707220101130.4908@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips

Replaces the deprecated __attribute_used__ with __used.  Also makes some
style adjustments to abide by the kernel coding conventions.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/mips/kernel/gdb-stub.c |    4 ++--
 arch/mips/kernel/linux32.c  |    2 +-
 arch/mips/kernel/rtlx.c     |    2 +-
 arch/mips/kernel/syscall.c  |    4 ++--
 arch/mips/kernel/vpe.c      |    3 +--
 arch/mips/mm/c-sb1.c        |    2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/gdb-stub.c b/arch/mips/kernel/gdb-stub.c
--- a/arch/mips/kernel/gdb-stub.c
+++ b/arch/mips/kernel/gdb-stub.c
@@ -1099,12 +1099,12 @@ void adel(void)
  * malloc is needed by gdb client in "call func()", even a private one
  * will make gdb happy
  */
-static void * __attribute_used__ malloc(size_t size)
+static void __used *malloc(size_t size)
 {
 	return kmalloc(size, GFP_ATOMIC);
 }
 
-static void __attribute_used__ free (void *where)
+static void __used free(void *where)
 {
 	kfree(where);
 }
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -567,7 +567,7 @@ asmlinkage long sys32_fadvise64_64(int fd, int __pad,
 }
 
 save_static_function(sys32_clone);
-__attribute_used__ noinline static int
+static int noinline __used
 _sys32_clone(nabi_no_regargs struct pt_regs regs)
 {
 	unsigned long clone_flags;
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -85,7 +85,7 @@ static irqreturn_t rtlx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static __attribute_used__ void dump_rtlx(void)
+static void __used dump_rtlx(void)
 {
 	int i;
 
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -167,14 +167,14 @@ sys_mmap2(unsigned long addr, unsigned long len, unsigned long prot,
 }
 
 save_static_function(sys_fork);
-__attribute_used__ noinline static int
+static int __used noinline
 _sys_fork(nabi_no_regargs struct pt_regs regs)
 {
 	return do_fork(SIGCHLD, regs.regs[29], &regs, 0, NULL, NULL);
 }
 
 save_static_function(sys_clone);
-__attribute_used__ noinline static int
+static int __used noinline
 _sys_clone(nabi_no_regargs struct pt_regs regs)
 {
 	unsigned long clone_flags;
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -154,7 +154,6 @@ struct {
 };
 
 static void release_progmem(void *ptr);
-/* static __attribute_used__ void dump_vpe(struct vpe * v); */
 extern void save_gp_address(unsigned int secbase, unsigned int rel);
 
 /* get the vpe associated with this minor */
@@ -1024,7 +1023,7 @@ static int vpe_elfload(struct vpe * v)
 	return 0;
 }
 
-__attribute_used__ void dump_vpe(struct vpe * v)
+void __used dump_vpe(struct vpe * v)
 {
 	struct tc *t;
 
diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -272,7 +272,7 @@ void sb1_flush_cache_data_page(unsigned long)
 /*
  * Invalidate all caches on this CPU
  */
-static void __attribute_used__ local_sb1___flush_cache_all(void)
+static void __used local_sb1___flush_cache_all(void)
 {
 	__sb1_writeback_inv_dcache_all();
 	__sb1_flush_icache_all();

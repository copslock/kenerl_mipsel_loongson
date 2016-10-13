Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 02:24:45 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34989 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993006AbcJMAUvr5C54 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 02:20:51 +0200
Received: by mail-lf0-f65.google.com with SMTP id x79so9728277lff.2
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 17:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qojlXsi/UR22SGdotBs1vH7Cmw0dHzyT1P4EET5YhyY=;
        b=wEHOZ2+5jgPN2Kb9W2Ebjrz7Jk1hHSHl0z3cyRPcTv/81tsY5Ly+pDgIiKsYwSZ4e6
         NrUWBddKIcDgvSeNOy4Cz8y8eDU28mSHL+T3ofkF71vXMRt+VlEXoHR1ahh2IZL9Y1Nl
         SUkhcFWUEd6LFwflsyDyLDC48vKjG5Ui5FWYUs+AsY6Hyb2VlbSeojS5ruApTNKuqhw5
         zy8XEyG7c0lTpz8GPPAfM8wiXceeqhFc934VE9k5quCFnrtsE28L37YS4ftv7Z7DBdtk
         MZksGWv1qeJOE6+swzHD9VJPb8/jFKcwqoiiMroZeHoxkqi269+DuP8SSyn8UPPfVCaA
         cJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qojlXsi/UR22SGdotBs1vH7Cmw0dHzyT1P4EET5YhyY=;
        b=Ve1RAgxtgjJg9c3bBij/LWlkugESblxkaotNBKV2RgtuAljpHZrJ30GJJXqvldW7iv
         Ho2yQLIREySKLyq02QD6Z5mhQ4kSPpsyPsHo0aTGL3B/NtbBb+86E/9lYZ9+Nt68b6Vf
         HZLWM/UdU1/4BaaOwfGqfESTuLxu8PGuyDW/KzQoFm0J67O1WaCnXwxFs0QehFC1AiYX
         6EhCY4G7xGqmk+UqeMqa6aMEzbm1+Qj2ZSzX6kB4/Z2LqI0X74T1bIIUh4k6gCx5rg2b
         kyhdSxdNqQlYB+zNQwoOXme9D/duDOOIJbmeRXnngfUF4RVBtF3i3rDY7P1khPCgWGtW
         yT3w==
X-Gm-Message-State: AA6/9RkekmlhZrq8jHjU9J/EmjAa3L+5quU4nnrd1Q2NpuVXgIRJVRwBN/gYzxN3H7tdSw==
X-Received: by 10.194.168.129 with SMTP id zw1mr5109508wjb.26.1476318046212;
        Wed, 12 Oct 2016 17:20:46 -0700 (PDT)
Received: from localhost (cpc94060-newt37-2-0-cust185.19-3.cable.virginm.net. [92.234.204.186])
        by smtp.gmail.com with ESMTPSA id au8sm17328573wjc.12.2016.10.12.17.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 17:20:44 -0700 (PDT)
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
Subject: [PATCH 10/10] mm: replace access_process_vm() write parameter with gup_flags
Date:   Thu, 13 Oct 2016 01:20:20 +0100
Message-Id: <20161013002020.3062-11-lstoakes@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161013002020.3062-1-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
Return-Path: <lstoakes@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55412
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

This patch removes the write parameter from access_process_vm() and replaces it
with a gup_flags parameter as use of this function previously _implied_
FOLL_FORCE, whereas after this patch callers explicitly pass this flag.

We make this explicit as use of FOLL_FORCE can result in surprising behaviour
(and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 arch/alpha/kernel/ptrace.c         |  9 ++++++---
 arch/blackfin/kernel/ptrace.c      |  5 +++--
 arch/cris/arch-v32/kernel/ptrace.c |  4 ++--
 arch/ia64/kernel/ptrace.c          | 14 +++++++++-----
 arch/m32r/kernel/ptrace.c          | 15 ++++++++++-----
 arch/mips/kernel/ptrace32.c        |  5 +++--
 arch/powerpc/kernel/ptrace32.c     |  5 +++--
 arch/score/kernel/ptrace.c         | 10 ++++++----
 arch/sparc/kernel/ptrace_64.c      | 24 ++++++++++++++++--------
 arch/x86/kernel/step.c             |  3 ++-
 arch/x86/um/ptrace_32.c            |  3 ++-
 arch/x86/um/ptrace_64.c            |  3 ++-
 include/linux/mm.h                 |  3 ++-
 kernel/ptrace.c                    | 16 ++++++++++------
 mm/memory.c                        |  8 ++------
 mm/nommu.c                         |  6 +++---
 mm/util.c                          |  5 +++--
 17 files changed, 84 insertions(+), 54 deletions(-)

diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index d9ee817..940dfb4 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -157,14 +157,16 @@ put_reg(struct task_struct *task, unsigned long regno, unsigned long data)
 static inline int
 read_int(struct task_struct *task, unsigned long addr, int * data)
 {
-	int copied = access_process_vm(task, addr, data, sizeof(int), 0);
+	int copied = access_process_vm(task, addr, data, sizeof(int),
+			FOLL_FORCE);
 	return (copied == sizeof(int)) ? 0 : -EIO;
 }
 
 static inline int
 write_int(struct task_struct *task, unsigned long addr, int data)
 {
-	int copied = access_process_vm(task, addr, &data, sizeof(int), 1);
+	int copied = access_process_vm(task, addr, &data, sizeof(int),
+			FOLL_FORCE | FOLL_WRITE);
 	return (copied == sizeof(int)) ? 0 : -EIO;
 }
 
@@ -281,7 +283,8 @@ long arch_ptrace(struct task_struct *child, long request,
 	/* When I and D space are separate, these will need to be fixed.  */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
 	case PTRACE_PEEKDATA:
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp),
+				FOLL_FORCE);
 		ret = -EIO;
 		if (copied != sizeof(tmp))
 			break;
diff --git a/arch/blackfin/kernel/ptrace.c b/arch/blackfin/kernel/ptrace.c
index 8b8fe67..8d79286 100644
--- a/arch/blackfin/kernel/ptrace.c
+++ b/arch/blackfin/kernel/ptrace.c
@@ -271,7 +271,7 @@ long arch_ptrace(struct task_struct *child, long request,
 			case BFIN_MEM_ACCESS_CORE:
 			case BFIN_MEM_ACCESS_CORE_ONLY:
 				copied = access_process_vm(child, addr, &tmp,
-				                           to_copy, 0);
+							   to_copy, FOLL_FORCE);
 				if (copied)
 					break;
 
@@ -324,7 +324,8 @@ long arch_ptrace(struct task_struct *child, long request,
 			case BFIN_MEM_ACCESS_CORE:
 			case BFIN_MEM_ACCESS_CORE_ONLY:
 				copied = access_process_vm(child, addr, &data,
-				                           to_copy, 1);
+				                           to_copy,
+							   FOLL_FORCE | FOLL_WRITE);
 				break;
 			case BFIN_MEM_ACCESS_DMA:
 				if (safe_dma_memcpy(paddr, &data, to_copy))
diff --git a/arch/cris/arch-v32/kernel/ptrace.c b/arch/cris/arch-v32/kernel/ptrace.c
index f085229..f0df654 100644
--- a/arch/cris/arch-v32/kernel/ptrace.c
+++ b/arch/cris/arch-v32/kernel/ptrace.c
@@ -147,7 +147,7 @@ long arch_ptrace(struct task_struct *child, long request,
 				/* The trampoline page is globally mapped, no page table to traverse.*/
 				tmp = *(unsigned long*)addr;
 			} else {
-				copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+				copied = access_process_vm(child, addr, &tmp, sizeof(tmp), FOLL_FORCE);
 
 				if (copied != sizeof(tmp))
 					break;
@@ -279,7 +279,7 @@ static int insn_size(struct task_struct *child, unsigned long pc)
   int opsize = 0;
 
   /* Read the opcode at pc (do what PTRACE_PEEKTEXT would do). */
-  copied = access_process_vm(child, pc, &opcode, sizeof(opcode), 0);
+  copied = access_process_vm(child, pc, &opcode, sizeof(opcode), FOLL_FORCE);
   if (copied != sizeof(opcode))
     return 0;
 
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 6f54d51..31aa8c0 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -453,7 +453,7 @@ ia64_peek (struct task_struct *child, struct switch_stack *child_stack,
 			return 0;
 		}
 	}
-	copied = access_process_vm(child, addr, &ret, sizeof(ret), 0);
+	copied = access_process_vm(child, addr, &ret, sizeof(ret), FOLL_FORCE);
 	if (copied != sizeof(ret))
 		return -EIO;
 	*val = ret;
@@ -489,7 +489,8 @@ ia64_poke (struct task_struct *child, struct switch_stack *child_stack,
 				*ia64_rse_skip_regs(krbs, regnum) = val;
 			}
 		}
-	} else if (access_process_vm(child, addr, &val, sizeof(val), 1)
+	} else if (access_process_vm(child, addr, &val, sizeof(val),
+				FOLL_FORCE | FOLL_WRITE)
 		   != sizeof(val))
 		return -EIO;
 	return 0;
@@ -543,7 +544,8 @@ ia64_sync_user_rbs (struct task_struct *child, struct switch_stack *sw,
 		ret = ia64_peek(child, sw, user_rbs_end, addr, &val);
 		if (ret < 0)
 			return ret;
-		if (access_process_vm(child, addr, &val, sizeof(val), 1)
+		if (access_process_vm(child, addr, &val, sizeof(val),
+				FOLL_FORCE | FOLL_WRITE)
 		    != sizeof(val))
 			return -EIO;
 	}
@@ -559,7 +561,8 @@ ia64_sync_kernel_rbs (struct task_struct *child, struct switch_stack *sw,
 
 	/* now copy word for word from user rbs to kernel rbs: */
 	for (addr = user_rbs_start; addr < user_rbs_end; addr += 8) {
-		if (access_process_vm(child, addr, &val, sizeof(val), 0)
+		if (access_process_vm(child, addr, &val, sizeof(val),
+				FOLL_FORCE)
 				!= sizeof(val))
 			return -EIO;
 
@@ -1156,7 +1159,8 @@ arch_ptrace (struct task_struct *child, long request,
 	case PTRACE_PEEKTEXT:
 	case PTRACE_PEEKDATA:
 		/* read word at location addr */
-		if (access_process_vm(child, addr, &data, sizeof(data), 0)
+		if (access_process_vm(child, addr, &data, sizeof(data),
+				FOLL_FORCE)
 		    != sizeof(data))
 			return -EIO;
 		/* ensure return value is not mistaken for error code */
diff --git a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
index 51f5e9a..c145605 100644
--- a/arch/m32r/kernel/ptrace.c
+++ b/arch/m32r/kernel/ptrace.c
@@ -493,7 +493,8 @@ unregister_all_debug_traps(struct task_struct *child)
 	int i;
 
 	for (i = 0; i < p->nr_trap; i++)
-		access_process_vm(child, p->addr[i], &p->insn[i], sizeof(p->insn[i]), 1);
+		access_process_vm(child, p->addr[i], &p->insn[i], sizeof(p->insn[i]),
+				FOLL_FORCE | FOLL_WRITE);
 	p->nr_trap = 0;
 }
 
@@ -537,7 +538,8 @@ embed_debug_trap(struct task_struct *child, unsigned long next_pc)
 	unsigned long next_insn, code;
 	unsigned long addr = next_pc & ~3;
 
-	if (access_process_vm(child, addr, &next_insn, sizeof(next_insn), 0)
+	if (access_process_vm(child, addr, &next_insn, sizeof(next_insn),
+			FOLL_FORCE)
 	    != sizeof(next_insn)) {
 		return -1; /* error */
 	}
@@ -546,7 +548,8 @@ embed_debug_trap(struct task_struct *child, unsigned long next_pc)
 	if (register_debug_trap(child, next_pc, next_insn, &code)) {
 		return -1; /* error */
 	}
-	if (access_process_vm(child, addr, &code, sizeof(code), 1)
+	if (access_process_vm(child, addr, &code, sizeof(code),
+			FOLL_FORCE | FOLL_WRITE)
 	    != sizeof(code)) {
 		return -1; /* error */
 	}
@@ -562,7 +565,8 @@ withdraw_debug_trap(struct pt_regs *regs)
  	addr = (regs->bpc - 2) & ~3;
 	regs->bpc -= 2;
 	if (unregister_debug_trap(current, addr, &code)) {
-	    access_process_vm(current, addr, &code, sizeof(code), 1);
+	    access_process_vm(current, addr, &code, sizeof(code),
+		    FOLL_FORCE | FOLL_WRITE);
 	    invalidate_cache();
 	}
 }
@@ -589,7 +593,8 @@ void user_enable_single_step(struct task_struct *child)
 	/* Compute next pc.  */
 	pc = get_stack_long(child, PT_BPC);
 
-	if (access_process_vm(child, pc&~3, &insn, sizeof(insn), 0)
+	if (access_process_vm(child, pc&~3, &insn, sizeof(insn),
+			FOLL_FORCE)
 	    != sizeof(insn))
 		return;
 
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 283b5a1..7e71a4e 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -70,7 +70,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 
 		copied = access_process_vm(child, (u64)addrOthers, &tmp,
-				sizeof(tmp), 0);
+				sizeof(tmp), FOLL_FORCE);
 		if (copied != sizeof(tmp))
 			break;
 		ret = put_user(tmp, (u32 __user *) (unsigned long) data);
@@ -179,7 +179,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 		ret = 0;
 		if (access_process_vm(child, (u64)addrOthers, &data,
-					sizeof(data), 1) == sizeof(data))
+					sizeof(data),
+					FOLL_FORCE | FOLL_WRITE) == sizeof(data))
 			break;
 		ret = -EIO;
 		break;
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index f52b7db3..010b7b3 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -74,7 +74,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 
 		copied = access_process_vm(child, (u64)addrOthers, &tmp,
-				sizeof(tmp), 0);
+				sizeof(tmp), FOLL_FORCE);
 		if (copied != sizeof(tmp))
 			break;
 		ret = put_user(tmp, (u32 __user *)data);
@@ -179,7 +179,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			break;
 		ret = 0;
 		if (access_process_vm(child, (u64)addrOthers, &tmp,
-					sizeof(tmp), 1) == sizeof(tmp))
+					sizeof(tmp),
+					FOLL_FORCE | FOLL_WRITE) == sizeof(tmp))
 			break;
 		ret = -EIO;
 		break;
diff --git a/arch/score/kernel/ptrace.c b/arch/score/kernel/ptrace.c
index 5583618..4f7314d 100644
--- a/arch/score/kernel/ptrace.c
+++ b/arch/score/kernel/ptrace.c
@@ -131,7 +131,7 @@ read_tsk_long(struct task_struct *child,
 {
 	int copied;
 
-	copied = access_process_vm(child, addr, res, sizeof(*res), 0);
+	copied = access_process_vm(child, addr, res, sizeof(*res), FOLL_FORCE);
 
 	return copied != sizeof(*res) ? -EIO : 0;
 }
@@ -142,7 +142,7 @@ read_tsk_short(struct task_struct *child,
 {
 	int copied;
 
-	copied = access_process_vm(child, addr, res, sizeof(*res), 0);
+	copied = access_process_vm(child, addr, res, sizeof(*res), FOLL_FORCE);
 
 	return copied != sizeof(*res) ? -EIO : 0;
 }
@@ -153,7 +153,8 @@ write_tsk_short(struct task_struct *child,
 {
 	int copied;
 
-	copied = access_process_vm(child, addr, &val, sizeof(val), 1);
+	copied = access_process_vm(child, addr, &val, sizeof(val),
+			FOLL_FORCE | FOLL_WRITE);
 
 	return copied != sizeof(val) ? -EIO : 0;
 }
@@ -164,7 +165,8 @@ write_tsk_long(struct task_struct *child,
 {
 	int copied;
 
-	copied = access_process_vm(child, addr, &val, sizeof(val), 1);
+	copied = access_process_vm(child, addr, &val, sizeof(val),
+			FOLL_FORCE | FOLL_WRITE);
 
 	return copied != sizeof(val) ? -EIO : 0;
 }
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 9ddc492..ac082dd 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -127,7 +127,8 @@ static int get_from_target(struct task_struct *target, unsigned long uaddr,
 		if (copy_from_user(kbuf, (void __user *) uaddr, len))
 			return -EFAULT;
 	} else {
-		int len2 = access_process_vm(target, uaddr, kbuf, len, 0);
+		int len2 = access_process_vm(target, uaddr, kbuf, len,
+				FOLL_FORCE);
 		if (len2 != len)
 			return -EFAULT;
 	}
@@ -141,7 +142,8 @@ static int set_to_target(struct task_struct *target, unsigned long uaddr,
 		if (copy_to_user((void __user *) uaddr, kbuf, len))
 			return -EFAULT;
 	} else {
-		int len2 = access_process_vm(target, uaddr, kbuf, len, 1);
+		int len2 = access_process_vm(target, uaddr, kbuf, len,
+				FOLL_FORCE | FOLL_WRITE);
 		if (len2 != len)
 			return -EFAULT;
 	}
@@ -505,7 +507,8 @@ static int genregs32_get(struct task_struct *target,
 				if (access_process_vm(target,
 						      (unsigned long)
 						      &reg_window[pos],
-						      k, sizeof(*k), 0)
+						      k, sizeof(*k),
+						      FOLL_FORCE)
 				    != sizeof(*k))
 					return -EFAULT;
 				k++;
@@ -531,12 +534,14 @@ static int genregs32_get(struct task_struct *target,
 				if (access_process_vm(target,
 						      (unsigned long)
 						      &reg_window[pos],
-						      &reg, sizeof(reg), 0)
+						      &reg, sizeof(reg),
+						      FOLL_FORCE)
 				    != sizeof(reg))
 					return -EFAULT;
 				if (access_process_vm(target,
 						      (unsigned long) u,
-						      &reg, sizeof(reg), 1)
+						      &reg, sizeof(reg),
+						      FOLL_FORCE | FOLL_WRITE)
 				    != sizeof(reg))
 					return -EFAULT;
 				pos++;
@@ -615,7 +620,8 @@ static int genregs32_set(struct task_struct *target,
 						      (unsigned long)
 						      &reg_window[pos],
 						      (void *) k,
-						      sizeof(*k), 1)
+						      sizeof(*k),
+						      FOLL_FORCE | FOLL_WRITE)
 				    != sizeof(*k))
 					return -EFAULT;
 				k++;
@@ -642,13 +648,15 @@ static int genregs32_set(struct task_struct *target,
 				if (access_process_vm(target,
 						      (unsigned long)
 						      u,
-						      &reg, sizeof(reg), 0)
+						      &reg, sizeof(reg),
+						      FOLL_FORCE)
 				    != sizeof(reg))
 					return -EFAULT;
 				if (access_process_vm(target,
 						      (unsigned long)
 						      &reg_window[pos],
-						      &reg, sizeof(reg), 1)
+						      &reg, sizeof(reg),
+						      FOLL_FORCE | FOLL_WRITE)
 				    != sizeof(reg))
 					return -EFAULT;
 				pos++;
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index c9a0738..a23ce84 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -57,7 +57,8 @@ static int is_setting_trap_flag(struct task_struct *child, struct pt_regs *regs)
 	unsigned char opcode[15];
 	unsigned long addr = convert_ip_to_linear(child, regs);
 
-	copied = access_process_vm(child, addr, opcode, sizeof(opcode), 0);
+	copied = access_process_vm(child, addr, opcode, sizeof(opcode),
+			FOLL_FORCE);
 	for (i = 0; i < copied; i++) {
 		switch (opcode[i]) {
 		/* popf and iret */
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 5766ead..60a5a5a 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -36,7 +36,8 @@ int is_syscall(unsigned long addr)
 		 * slow, but that doesn't matter, since it will be called only
 		 * in case of singlestepping, if copy_from_user failed.
 		 */
-		n = access_process_vm(current, addr, &instr, sizeof(instr), 0);
+		n = access_process_vm(current, addr, &instr, sizeof(instr),
+				FOLL_FORCE);
 		if (n != sizeof(instr)) {
 			printk(KERN_ERR "is_syscall : failed to read "
 			       "instruction from 0x%lx\n", addr);
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index 0b5c184..e30202b 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -212,7 +212,8 @@ int is_syscall(unsigned long addr)
 		 * slow, but that doesn't matter, since it will be called only
 		 * in case of singlestepping, if copy_from_user failed.
 		 */
-		n = access_process_vm(current, addr, &instr, sizeof(instr), 0);
+		n = access_process_vm(current, addr, &instr, sizeof(instr),
+				FOLL_FORCE);
 		if (n != sizeof(instr)) {
 			printk("is_syscall : failed to read instruction from "
 			       "0x%lx\n", addr);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3e5234e..7beda79 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1266,7 +1266,8 @@ static inline int fixup_user_fault(struct task_struct *tsk,
 }
 #endif
 
-extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
+extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len,
+		unsigned int gup_flags);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2a99027..e6474f7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -537,7 +537,7 @@ int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst
 		int this_len, retval;
 
 		this_len = (len > sizeof(buf)) ? sizeof(buf) : len;
-		retval = access_process_vm(tsk, src, buf, this_len, 0);
+		retval = access_process_vm(tsk, src, buf, this_len, FOLL_FORCE);
 		if (!retval) {
 			if (copied)
 				break;
@@ -564,7 +564,8 @@ int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long ds
 		this_len = (len > sizeof(buf)) ? sizeof(buf) : len;
 		if (copy_from_user(buf, src, this_len))
 			return -EFAULT;
-		retval = access_process_vm(tsk, dst, buf, this_len, 1);
+		retval = access_process_vm(tsk, dst, buf, this_len,
+				FOLL_FORCE | FOLL_WRITE);
 		if (!retval) {
 			if (copied)
 				break;
@@ -1127,7 +1128,7 @@ int generic_ptrace_peekdata(struct task_struct *tsk, unsigned long addr,
 	unsigned long tmp;
 	int copied;
 
-	copied = access_process_vm(tsk, addr, &tmp, sizeof(tmp), 0);
+	copied = access_process_vm(tsk, addr, &tmp, sizeof(tmp), FOLL_FORCE);
 	if (copied != sizeof(tmp))
 		return -EIO;
 	return put_user(tmp, (unsigned long __user *)data);
@@ -1138,7 +1139,8 @@ int generic_ptrace_pokedata(struct task_struct *tsk, unsigned long addr,
 {
 	int copied;
 
-	copied = access_process_vm(tsk, addr, &data, sizeof(data), 1);
+	copied = access_process_vm(tsk, addr, &data, sizeof(data),
+			FOLL_FORCE | FOLL_WRITE);
 	return (copied == sizeof(data)) ? 0 : -EIO;
 }
 
@@ -1155,7 +1157,8 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 	switch (request) {
 	case PTRACE_PEEKTEXT:
 	case PTRACE_PEEKDATA:
-		ret = access_process_vm(child, addr, &word, sizeof(word), 0);
+		ret = access_process_vm(child, addr, &word, sizeof(word),
+				FOLL_FORCE);
 		if (ret != sizeof(word))
 			ret = -EIO;
 		else
@@ -1164,7 +1167,8 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 
 	case PTRACE_POKETEXT:
 	case PTRACE_POKEDATA:
-		ret = access_process_vm(child, addr, &data, sizeof(data), 1);
+		ret = access_process_vm(child, addr, &data, sizeof(data),
+				FOLL_FORCE | FOLL_WRITE);
 		ret = (ret != sizeof(data) ? -EIO : 0);
 		break;
 
diff --git a/mm/memory.c b/mm/memory.c
index bac2d99..e18c57b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3951,20 +3951,16 @@ int access_remote_vm(struct mm_struct *mm, unsigned long addr,
  * Do not walk the page table directly, use get_user_pages
  */
 int access_process_vm(struct task_struct *tsk, unsigned long addr,
-		void *buf, int len, int write)
+		void *buf, int len, unsigned int gup_flags)
 {
 	struct mm_struct *mm;
 	int ret;
-	unsigned int flags = FOLL_FORCE;
 
 	mm = get_task_mm(tsk);
 	if (!mm)
 		return 0;
 
-	if (write)
-		flags |= FOLL_WRITE;
-
-	ret = __access_remote_vm(tsk, mm, addr, buf, len, flags);
+	ret = __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 93d5bb5..db5fd17 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1861,7 +1861,8 @@ int access_remote_vm(struct mm_struct *mm, unsigned long addr,
  * Access another process' address space.
  * - source/target buffer must be kernel space
  */
-int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
+int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len,
+		unsigned int gup_flags)
 {
 	struct mm_struct *mm;
 
@@ -1872,8 +1873,7 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
 	if (!mm)
 		return 0;
 
-	len = __access_remote_vm(tsk, mm, addr, buf, len,
-			write ? FOLL_WRITE : 0);
+	len = __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
 
 	mmput(mm);
 	return len;
diff --git a/mm/util.c b/mm/util.c
index 4c685bd..952cbe7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -624,7 +624,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	if (len > buflen)
 		len = buflen;
 
-	res = access_process_vm(task, arg_start, buffer, len, 0);
+	res = access_process_vm(task, arg_start, buffer, len, FOLL_FORCE);
 
 	/*
 	 * If the nul at the end of args has been overwritten, then
@@ -639,7 +639,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 			if (len > buflen - res)
 				len = buflen - res;
 			res += access_process_vm(task, env_start,
-						 buffer+res, len, 0);
+						 buffer+res, len,
+						 FOLL_FORCE);
 			res = strnlen(buffer, res);
 		}
 	}
-- 
2.10.0

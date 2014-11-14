Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 16:21:19 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:32785 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013730AbaKNPSpIR9eL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Nov 2014 16:18:45 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 14 Nov 2014 07:18:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,386,1413270000"; 
   d="scan'208";a="622414827"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.23.232.122])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2014 07:18:32 -0800
Subject: [PATCH 11/11] x86, mpx: add documentation on Intel MPX
To:     hpa@zytor.com
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, Dave Hansen <dave@sr71.net>,
        dave.hansen@linux.intel.com
From:   Dave Hansen <dave@sr71.net>
Date:   Fri, 14 Nov 2014 07:18:32 -0800
References: <20141114151816.F56A3072@viggo.jf.intel.com>
In-Reply-To: <20141114151816.F56A3072@viggo.jf.intel.com>
Message-Id: <20141114151832.7FDB1720@viggo.jf.intel.com>
Return-Path: <dave@sr71.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@sr71.net
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


From: Dave Hansen <dave.hansen@linux.intel.com>


This patch adds the Documentation/x86/intel_mpx.txt file with some
information about Intel MPX.

Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/Documentation/x86/intel_mpx.txt |  234 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff -puN /dev/null Documentation/x86/intel_mpx.txt
--- /dev/null	2014-10-10 16:10:57.316716958 -0700
+++ b/Documentation/x86/intel_mpx.txt	2014-11-14 07:06:25.065735091 -0800
@@ -0,0 +1,234 @@
+1. Intel(R) MPX Overview
+========================
+
+Intel(R) Memory Protection Extensions (Intel(R) MPX) is a new capability
+introduced into Intel Architecture. Intel MPX provides hardware features
+that can be used in conjunction with compiler changes to check memory
+references, for those references whose compile-time normal intentions are
+usurped at runtime due to buffer overflow or underflow.
+
+For more information, please refer to Intel(R) Architecture Instruction
+Set Extensions Programming Reference, Chapter 9: Intel(R) Memory Protection
+Extensions.
+
+Note: Currently no hardware with MPX ISA is available but it is always
+possible to use SDE (Intel(R) Software Development Emulator) instead, which
+can be downloaded from
+http://software.intel.com/en-us/articles/intel-software-development-emulator
+
+
+2. How to get the advantage of MPX
+==================================
+
+For MPX to work, changes are required in the kernel, binutils and compiler.
+No source changes are required for applications, just a recompile.
+
+There are a lot of moving parts of this to all work right. The following
+is how we expect the compiler, application and kernel to work together.
+
+1) Application developer compiles with -fmpx. The compiler will add the
+   instrumentation as well as some setup code called early after the app
+   starts. New instruction prefixes are noops for old CPUs.
+2) That setup code allocates (virtual) space for the "bounds directory",
+   points the "bndcfgu" register to the directory and notifies the kernel
+   (via the new prctl(PR_MPX_ENABLE_MANAGEMENT)) that the app will be using
+   MPX.
+3) The kernel detects that the CPU has MPX, allows the new prctl() to
+   succeed, and notes the location of the bounds directory. Userspace is
+   expected to keep the bounds directory at that locationWe note it
+   instead of reading it each time because the 'xsave' operation needed
+   to access the bounds directory register is an expensive operation.
+4) If the application needs to spill bounds out of the 4 registers, it
+   issues a bndstx instruction. Since the bounds directory is empty at
+   this point, a bounds fault (#BR) is raised, the kernel allocates a
+   bounds table (in the user address space) and makes the relevant entry
+   in the bounds directory point to the new table.
+5) If the application violates the bounds specified in the bounds registers,
+   a separate kind of #BR is raised which will deliver a signal with
+   information about the violation in the 'struct siginfo'.
+6) Whenever memory is freed, we know that it can no longer contain valid
+   pointers, and we attempt to free the associated space in the bounds
+   tables. If an entire table becomes unused, we will attempt to free
+   the table and remove the entry in the directory.
+
+To summarize, there are essentially three things interacting here:
+
+GCC with -fmpx:
+ * enables annotation of code with MPX instructions and prefixes
+ * inserts code early in the application to call in to the "gcc runtime"
+GCC MPX Runtime:
+ * Checks for hardware MPX support in cpuid leaf
+ * allocates virtual space for the bounds directory (malloc() essentially)
+ * points the hardware BNDCFGU register at the directory
+ * calls a new prctl(PR_MPX_ENABLE_MANAGEMENT) to notify the kernel to
+   start managing the bounds directories
+Kernel MPX Code:
+ * Checks for hardware MPX support in cpuid leaf
+ * Handles #BR exceptions and sends SIGSEGV to the app when it violates
+   bounds, like during a buffer overflow.
+ * When bounds are spilled in to an unallocated bounds table, the kernel
+   notices in the #BR exception, allocates the virtual space, then
+   updates the bounds directory to point to the new table. It keeps
+   special track of the memory with a VM_MPX flag.
+ * Frees unused bounds tables at the time that the memory they described
+   is unmapped.
+
+
+3. How does MPX kernel code work
+================================
+
+Handling #BR faults caused by MPX
+---------------------------------
+
+When MPX is enabled, there are 2 new situations that can generate
+#BR faults.
+  * new bounds tables (BT) need to be allocated to save bounds.
+  * bounds violation caused by MPX instructions.
+
+We hook #BR handler to handle these two new situations.
+
+On-demand kernel allocation of bounds tables
+--------------------------------------------
+
+MPX only has 4 hardware registers for storing bounds information. If
+MPX-enabled code needs more than these 4 registers, it needs to spill
+them somewhere. It has two special instructions for this which allow
+the bounds to be moved between the bounds registers and some new "bounds
+tables".
+
+#BR exceptions are a new class of exceptions just for MPX. They are
+similar conceptually to a page fault and will be raised by the MPX
+hardware during both bounds violations or when the tables are not
+present. The kernel handles those #BR exceptions for not-present tables
+by carving the space out of the normal processes address space and then
+pointing the bounds-directory over to it.
+
+The tables need to be accessed and controlled by userspace because
+the instructions for moving bounds in and out of them are extremely
+frequent. They potentially happen every time a register points to
+memory. Any direct kernel involvement (like a syscall) to access the
+tables would obviously destroy performance.
+
+Why not do this in userspace? MPX does not strictly require anything in
+the kernel. It can theoretically be done completely from userspace. Here
+are a few ways this could be done. We don't think any of them are practical
+in the real-world, but here they are.
+
+Q: Can virtual space simply be reserved for the bounds tables so that we
+   never have to allocate them?
+A: MPX-enabled application will possibly create a lot of bounds tables in
+   process address space to save bounds information. These tables can take
+   up huge swaths of memory (as much as 80% of the memory on the system)
+   even if we clean them up aggressively. In the worst-case scenario, the
+   tables can be 4x the size of the data structure being tracked. IOW, a
+   1-page structure can require 4 bounds-table pages. An X-GB virtual
+   area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
+   If we were to preallocate them for the 128TB of user virtual address
+   space, we would need to reserve 512TB+2GB, which is larger than the
+   entire virtual address space today. This means they can not be reserved
+   ahead of time. Also, a single process's pre-popualated bounds directory
+   consumes 2GB of virtual *AND* physical memory. IOW, it's completely
+   infeasible to prepopulate bounds directories.
+
+Q: Can we preallocate bounds table space at the same time memory is
+   allocated which might contain pointers that might eventually need
+   bounds tables?
+A: This would work if we could hook the site of each and every memory
+   allocation syscall. This can be done for small, constrained applications.
+   But, it isn't practical at a larger scale since a given app has no
+   way of controlling how all the parts of the app might allocate memory
+   (think libraries). The kernel is really the only place to intercept
+   these calls.
+
+Q: Could a bounds fault be handed to userspace and the tables allocated
+   there in a signal handler intead of in the kernel?
+A: mmap() is not on the list of safe async handler functions and even
+   if mmap() would work it still requires locking or nasty tricks to
+   keep track of the allocation state there.
+
+Having ruled out all of the userspace-only approaches for managing
+bounds tables that we could think of, we create them on demand in
+the kernel.
+
+Decoding MPX instructions
+-------------------------
+
+If a #BR is generated due to a bounds violation caused by MPX.
+We need to decode MPX instructions to get violation address and
+set this address into extended struct siginfo.
+
+The _sigfault feild of struct siginfo is extended as follow:
+
+87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+88		struct {
+89			void __user *_addr; /* faulting insn/memory ref. */
+90 #ifdef __ARCH_SI_TRAPNO
+91			int _trapno;	/* TRAP # which caused the signal */
+92 #endif
+93			short _addr_lsb; /* LSB of the reported address */
+94			struct {
+95				void __user *_lower;
+96				void __user *_upper;
+97			} _addr_bnd;
+98		} _sigfault;
+
+The '_addr' field refers to violation address, and new '_addr_and'
+field refers to the upper/lower bounds when a #BR is caused.
+
+Glibc will be also updated to support this new siginfo. So user
+can get violation address and bounds when bounds violations occur.
+
+Cleanup unused bounds tables
+----------------------------
+
+When a BNDSTX instruction attempts to save bounds to a bounds directory
+entry marked as invalid, a #BR is generated. This is an indication that
+no bounds table exists for this entry. In this case the fault handler
+will allocate a new bounds table on demand.
+
+Since the kernel allocated those tables on-demand without userspace
+knowledge, it is also responsible for freeing them when the associated
+mappings go away.
+
+Here, the solution for this issue is to hook do_munmap() to check
+whether one process is MPX enabled. If yes, those bounds tables covered
+in the virtual address region which is being unmapped will be freed also.
+
+Adding new prctl commands
+-------------------------
+
+Two new prctl commands are added to enable and disable MPX bounds tables
+management in kernel.
+
+155	#define PR_MPX_ENABLE_MANAGEMENT	43
+156	#define PR_MPX_DISABLE_MANAGEMENT	44
+
+Runtime library in userspace is responsible for allocation of bounds
+directory. So kernel have to use XSAVE instruction to get the base
+of bounds directory from BNDCFG register.
+
+But XSAVE is expected to be very expensive. In order to do performance
+optimization, we have to get the base of bounds directory and save it
+into struct mm_struct to be used in future during PR_MPX_ENABLE_MANAGEMENT
+command execution.
+
+
+4. Special rules
+================
+
+1) If userspace is requesting help from the kernel to do the management
+of bounds tables, it may not create or modify entries in the bounds directory.
+
+Certainly users can allocate bounds tables and forcibly point the bounds
+directory at them through XSAVE instruction, and then set valid bit
+of bounds entry to have this entry valid.  But, the kernel will decline
+to assist in managing these tables.
+
+2) Userspace may not take multiple bounds directory entries and point
+them at the same bounds table.
+
+This is allowed architecturally.  See more information "Intel(R) Architecture
+Instruction Set Extensions Programming Reference" (9.3.4).
+
+However, if users did this, the kernel might be fooled in to unmaping an
+in-use bounds table since it does not recognize sharing.
_

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2015 15:14:54 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38206 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008316AbbFHNOwf891V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2015 15:14:52 +0200
Received: by wibdq8 with SMTP id dq8so84849571wib.1
        for <linux-mips@linux-mips.org>; Mon, 08 Jun 2015 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=tr6MQebOl177re8kJjSNhQQFK6xtOAs66B8Wp3aawr8=;
        b=JM4iNOIAKKJBzNkzHkObYE++N1plUkV2qVip85d09i4FGCSdJM3Oed3EHx0eWPv3o4
         BkWuM76SSckpvkZwFqLA4g/8wFGnyqCMGQFTLqHCZzCYpMalxNANttpFDzaue+pxsZiI
         ofXhfxmDoksJcTFduoIdozje8CROxoksnfzx4qGLklx9+WZERax5CykxcHOzCSr2ANDY
         UaUt9l+H4rxPdawi4nDaT+vr2kx4ZtF3njax+B0Mo2a5P+fHOIqktf3CYGO3tkrGCd2g
         Gmz8XEnJOD4cXMEz3cD8BBV2QsEuOdJfhmF18PBXyy+nabT21hEYKgasfF/IBc0jk1ZG
         ZHJA==
X-Received: by 10.180.107.38 with SMTP id gz6mr21980392wib.63.1433769287338;
        Mon, 08 Jun 2015 06:14:47 -0700 (PDT)
Received: from localhost ([47.59.123.37])
        by mx.google.com with ESMTPSA id ha4sm1006509wib.0.2015.06.08.06.14.46
        for <linux-mips@linux-mips.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 06:14:47 -0700 (PDT)
Message-ID: <55759543.1010408@gmail.com>
Date:   Mon, 08 Jun 2015 15:14:43 +0200
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Generic kernel features that need architecture(mips) support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <xose.vazquez@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xose.vazquez@gmail.com
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

Hi,

If there is anything wrong, please report it in this thread:
https://marc.info/?t=143332955700003


The meaning of entries in the tables is:

    | ok |  # feature supported by the architecture
    |TODO|  # feature not yet supported by the architecture
    | .. |  # feature cannot be supported by the hardware

#
# Kernel feature support matrix of the 'mips' architecture:
#
      core/ BPF-JIT              :  ok  |                        HAVE_BPF_JIT #  arch supports BPF JIT optimizations
      core/ generic-idle-thread  :  ok  |             GENERIC_SMP_IDLE_THREAD #  arch makes use of the generic SMP idle thread facility
      core/ jump-labels          :  ok  |                HAVE_ARCH_JUMP_LABEL #  arch supports live patched, high efficiency branches
      core/ tracehook            :  ok  |                 HAVE_ARCH_TRACEHOOK #  arch supports tracehook (ptrace) register handling APIs
     debug/ kgdb                 :  ok  |                      HAVE_ARCH_KGDB #  arch supports the kGDB kernel debugger
     debug/ kprobes              :  ok  |                        HAVE_KPROBES #  arch supports live patched kernel probe
     debug/ kretprobes           :  ok  |                     HAVE_KRETPROBES #  arch supports kernel function-return probes
     debug/ stackprotector       :  ok  |              HAVE_CC_STACKPROTECTOR #  arch supports compiler driven stack overflow protection
        io/ dma-api-debug        :  ok  |                  HAVE_DMA_API_DEBUG #  arch supports DMA debug facilities
        io/ dma-contiguous       :  ok  |                 HAVE_DMA_CONTIGUOUS #  arch supports the DMA CMA (continuous memory allocator)
        io/ dma_map_attrs        :  ok  |                      HAVE_DMA_ATTRS #  arch provides dma_*map*_attrs() APIs
   locking/ lockdep              :  ok  |                     LOCKDEP_SUPPORT #  arch supports the runtime locking correctness debug facility
   seccomp/ seccomp-filter       :  ok  |            HAVE_ARCH_SECCOMP_FILTER #  arch supports seccomp filters
      time/ arch-tick-broadcast  :  ok  |             ARCH_HAS_TICK_BROADCAST #  arch provides tick_broadcast()
      time/ clockevents          :  ok  |                 GENERIC_CLOCKEVENTS #  arch support generic clock events
      time/ context-tracking     :  ok  |               HAVE_CONTEXT_TRACKING #  arch supports context tracking for NO_HZ_FULL
      time/ irq-time-acct        :  ok  |            HAVE_IRQ_TIME_ACCOUNTING #  arch supports precise IRQ time accounting
      time/ modern-timekeeping   :  ok  |            !ARCH_USES_GETTIMEOFFSET #  arch does not use arch_gettimeoffset() anymore
      time/ virt-cpuacct         :  ok  |            HAVE_VIRT_CPU_ACCOUNTING #  arch supports precise virtual CPU time accounting
        vm/ ELF-ASLR             :  ok  |              ARCH_HAS_ELF_RANDOMIZE #  arch randomizes the stack, heap and binary images of ELF binaries
        vm/ numa-memblock        :  ok  |              HAVE_MEMBLOCK_NODE_MAP #  arch supports NUMA aware memblocks
        vm/ pmdp_splitting_flush :  ok  |    __HAVE_ARCH_PMDP_SPLITTING_FLUSH #  arch supports the pmdp_splitting_flush() VM API
        vm/ THP                  :  ok  |      HAVE_ARCH_TRANSPARENT_HUGEPAGE #  arch supports transparent hugepages
     debug/ gcov-profile-all     : TODO |           ARCH_HAS_GCOV_PROFILE_ALL #  arch supports whole-kernel GCOV code coverage profiling
     debug/ KASAN                : TODO |                     HAVE_ARCH_KASAN #  arch supports the KASAN runtime memory checker
     debug/ kprobes-on-ftrace    : TODO |              HAVE_KPROBES_ON_FTRACE #  arch supports combined kprobes and ftrace live patching
     debug/ optprobes            : TODO |                      HAVE_OPTPROBES #  arch supports live patched optprobes
     debug/ uprobes              : TODO |               ARCH_SUPPORTS_UPROBES #  arch supports live patched user probes
     debug/ user-ret-profiler    : TODO |           HAVE_USER_RETURN_NOTIFIER #  arch supports user-space return from system call profiler
        io/ sg-chain             : TODO |                   ARCH_HAS_SG_CHAIN #  arch supports chained scatter-gather lists
       lib/ strncasecmp          : TODO |             __HAVE_ARCH_STRNCASECMP #  arch provides an optimized strncasecmp() function
   locking/ cmpxchg-local        : TODO |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
   locking/ queued-rwlocks       : TODO |             ARCH_USE_QUEUED_RWLOCKS #  arch supports queued rwlocks
   locking/ queued-spinlocks     : TODO |           ARCH_USE_QUEUED_SPINLOCKS #  arch supports queued spinlocks
   locking/ rwsem-optimized      : TODO |               Optimized asm/rwsem.h #  arch provides optimized rwsem APIs
      perf/ kprobes-event        : TODO |      HAVE_REGS_AND_STACK_ACCESS_API #  arch supports kprobes with perf events
      perf/ perf-regs            : TODO |                      HAVE_PERF_REGS #  arch supports perf events register access
      perf/ perf-stackdump       : TODO |           HAVE_PERF_USER_STACK_DUMP #  arch supports perf events stack dumps
     sched/ numa-balancing       : TODO |        ARCH_SUPPORTS_NUMA_BALANCING #  arch supports NUMA balancing
        vm/ huge-vmap            : TODO |                 HAVE_ARCH_HUGE_VMAP #  arch supports the ioremap_pud_enabled() and ioremap_pmd_enabled() VM APIs
        vm/ ioremap_prot         : TODO |                   HAVE_IOREMAP_PROT #  arch has ioremap_prot()
        vm/ PG_uncached          : TODO |               ARCH_USES_PG_UNCACHED #  arch supports the PG_uncached page flag
        vm/ pte_special          : TODO |             __HAVE_ARCH_PTE_SPECIAL #  arch supports the pte_special()/pte_mkspecial() VM APIs

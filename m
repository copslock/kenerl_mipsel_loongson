Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 10:40:05 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:41387
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeINIjeTZUTi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 10:39:34 +0200
Received: by mail-pf1-x444.google.com with SMTP id h79-v6so3975344pfk.8
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T72UomyZXt1PiQ64Ik0aPNrd5zI55lqbjmjI/iCcF0E=;
        b=POpmwgw9puAQoiIXgTspK/9HL+4n/hS0BeCpl04HbAqq+upjOGPg3NYT0CReY/H6Jp
         xTyGOYUVNXunCv/EGlHELHU3RBR16hGmTbAcJTmgWb9LjYNWyRYl8edsMN+lqK68kt9o
         Gb21Dncs/0yIrQ9fo2JiTWwGaKqATm6nV63TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T72UomyZXt1PiQ64Ik0aPNrd5zI55lqbjmjI/iCcF0E=;
        b=pSFXhjHK1S7ZkWpicFOBse1Gl8RsBIednmIuH8pNuMJDQyi2D5pM2jdf6Uk3lYO6NW
         mPXNcPxryHtr3ZsTaYN+yOEyKjNR4H65N5miJGKS1p8vQhuXS+kX6W6UzlxUYv2wDW9Q
         PurGE4qBpNQQtPixkNNLWw5+T50lXjwuueoS+HnCWMTQa/lQ35+CBvhUccd5jmt8vgWm
         P0wL86aXo9hHohPrllTFkYkYxo3mEzcwIFxrSmTf0Ygaur4Ug8RhV/b+RfKS05tvwe3Q
         w4ENFPju4/2wmiFTxsMMeqF1k45VEOzCQmfBJ536Ku91ouzBwLwxO6HsRnuLbpppGv26
         fqgQ==
X-Gm-Message-State: APzg51DK54KUeQD5i0CLgCy56TmHSBlCUYnVZkynuYFPTbpQoUG1p9sA
        rcQ3RBVXB9mKUSeD9oqHKYPPoQ==
X-Google-Smtp-Source: ANB0VdZ4o7PiY0Qk08olIMUuc90YipdVY8JTHMCwBWn8s0OiNm+89n8//9EG3YfWoBjdPTkdgdbbLw==
X-Received: by 2002:a63:4a4b:: with SMTP id j11-v6mr10803228pgl.168.1536914366541;
        Fri, 14 Sep 2018 01:39:26 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id c1-v6sm11664289pfg.25.2018.09.14.01.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:39:26 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 3/3] mips: uapi header and system call table file generation
Date:   Fri, 14 Sep 2018 14:08:34 +0530
Message-Id: <1536914314-5026-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

System call table generation script must be run to generate
unistd_*.h and syscall_table_*.h files. This patch will have
changes which will invokes the script.

This patch will generate unistd_*.h and syscall_table_*.h files
by the syscall table generation script invoked by arch/sparc/
Makefile and the generated files against the removed files will
be identical.

The generated uapi header file will be included in uapi/asm/
unistd_*.h and generated system call table support file will
be included by arch/mips/kernel/syscall_table_*.S file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/Makefile                      |    3 +
 arch/mips/include/asm/Kbuild            |    4 +
 arch/mips/include/uapi/asm/Kbuild       |    3 +
 arch/mips/include/uapi/asm/unistd.h     | 1049 +------------------------------
 arch/mips/kernel/scall32-o32.S          |  385 +-----------
 arch/mips/kernel/scall64-64.S           |  334 +---------
 arch/mips/kernel/scall64-n32.S          |  337 +---------
 arch/mips/kernel/scall64-o32.S          |  374 +----------
 arch/mips/kernel/syscall_table_32_o32.S |    8 +
 arch/mips/kernel/syscall_table_64_64.S  |    9 +
 arch/mips/kernel/syscall_table_64_n32.S |    8 +
 arch/mips/kernel/syscall_table_64_o32.S |    9 +
 12 files changed, 57 insertions(+), 2466 deletions(-)
 create mode 100644 arch/mips/kernel/syscall_table_32_o32.S
 create mode 100644 arch/mips/kernel/syscall_table_64_64.S
 create mode 100644 arch/mips/kernel/syscall_table_64_n32.S
 create mode 100644 arch/mips/kernel/syscall_table_64_o32.S

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d74b374..d3d15cc 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -444,6 +444,9 @@ archclean:
 	$(Q)$(MAKE) $(clean)=arch/mips/boot/tools
 	$(Q)$(MAKE) $(clean)=arch/mips/lasat
 
+archheaders:
+	$(Q)$(MAKE) $(build)=arch/mips/kernel/syscalls all
+
 define archhelp
 	echo '  install              - install kernel into $(INSTALL_PATH)'
 	echo '  vmlinux.ecoff        - ECOFF boot image'
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 58351e4..100bba2 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -21,3 +21,7 @@ generic-y += unaligned.h
 generic-y += user.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
+generated-y += syscall_table_32_o32.h
+generated-y += syscall_table_64_o32.h
+generated-y += syscall_table_64_64.h
+generated-y += syscall_table_64_n32.h
\ No newline at end of file
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index 7a4becd..4efe053 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -3,3 +3,6 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
 generic-y += ipcbuf.h
+generated-y += unistd_32.h
+generated-y += unistd_64.h
+generated-y += unistd_n32.h
\ No newline at end of file
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f8bab34..57c06f0 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -20,377 +20,8 @@
 /*
  * Linux o32 style syscalls are in the range from 4000 to 4999.
  */
-#define __NR_Linux			4000
-#define __NR_syscall			(__NR_Linux +	0)
-#define __NR_exit			(__NR_Linux +	1)
-#define __NR_fork			(__NR_Linux +	2)
-#define __NR_read			(__NR_Linux +	3)
-#define __NR_write			(__NR_Linux +	4)
-#define __NR_open			(__NR_Linux +	5)
-#define __NR_close			(__NR_Linux +	6)
-#define __NR_waitpid			(__NR_Linux +	7)
-#define __NR_creat			(__NR_Linux +	8)
-#define __NR_link			(__NR_Linux +	9)
-#define __NR_unlink			(__NR_Linux +  10)
-#define __NR_execve			(__NR_Linux +  11)
-#define __NR_chdir			(__NR_Linux +  12)
-#define __NR_time			(__NR_Linux +  13)
-#define __NR_mknod			(__NR_Linux +  14)
-#define __NR_chmod			(__NR_Linux +  15)
-#define __NR_lchown			(__NR_Linux +  16)
-#define __NR_break			(__NR_Linux +  17)
-#define __NR_unused18			(__NR_Linux +  18)
-#define __NR_lseek			(__NR_Linux +  19)
-#define __NR_getpid			(__NR_Linux +  20)
-#define __NR_mount			(__NR_Linux +  21)
-#define __NR_umount			(__NR_Linux +  22)
-#define __NR_setuid			(__NR_Linux +  23)
-#define __NR_getuid			(__NR_Linux +  24)
-#define __NR_stime			(__NR_Linux +  25)
-#define __NR_ptrace			(__NR_Linux +  26)
-#define __NR_alarm			(__NR_Linux +  27)
-#define __NR_unused28			(__NR_Linux +  28)
-#define __NR_pause			(__NR_Linux +  29)
-#define __NR_utime			(__NR_Linux +  30)
-#define __NR_stty			(__NR_Linux +  31)
-#define __NR_gtty			(__NR_Linux +  32)
-#define __NR_access			(__NR_Linux +  33)
-#define __NR_nice			(__NR_Linux +  34)
-#define __NR_ftime			(__NR_Linux +  35)
-#define __NR_sync			(__NR_Linux +  36)
-#define __NR_kill			(__NR_Linux +  37)
-#define __NR_rename			(__NR_Linux +  38)
-#define __NR_mkdir			(__NR_Linux +  39)
-#define __NR_rmdir			(__NR_Linux +  40)
-#define __NR_dup			(__NR_Linux +  41)
-#define __NR_pipe			(__NR_Linux +  42)
-#define __NR_times			(__NR_Linux +  43)
-#define __NR_prof			(__NR_Linux +  44)
-#define __NR_brk			(__NR_Linux +  45)
-#define __NR_setgid			(__NR_Linux +  46)
-#define __NR_getgid			(__NR_Linux +  47)
-#define __NR_signal			(__NR_Linux +  48)
-#define __NR_geteuid			(__NR_Linux +  49)
-#define __NR_getegid			(__NR_Linux +  50)
-#define __NR_acct			(__NR_Linux +  51)
-#define __NR_umount2			(__NR_Linux +  52)
-#define __NR_lock			(__NR_Linux +  53)
-#define __NR_ioctl			(__NR_Linux +  54)
-#define __NR_fcntl			(__NR_Linux +  55)
-#define __NR_mpx			(__NR_Linux +  56)
-#define __NR_setpgid			(__NR_Linux +  57)
-#define __NR_ulimit			(__NR_Linux +  58)
-#define __NR_unused59			(__NR_Linux +  59)
-#define __NR_umask			(__NR_Linux +  60)
-#define __NR_chroot			(__NR_Linux +  61)
-#define __NR_ustat			(__NR_Linux +  62)
-#define __NR_dup2			(__NR_Linux +  63)
-#define __NR_getppid			(__NR_Linux +  64)
-#define __NR_getpgrp			(__NR_Linux +  65)
-#define __NR_setsid			(__NR_Linux +  66)
-#define __NR_sigaction			(__NR_Linux +  67)
-#define __NR_sgetmask			(__NR_Linux +  68)
-#define __NR_ssetmask			(__NR_Linux +  69)
-#define __NR_setreuid			(__NR_Linux +  70)
-#define __NR_setregid			(__NR_Linux +  71)
-#define __NR_sigsuspend			(__NR_Linux +  72)
-#define __NR_sigpending			(__NR_Linux +  73)
-#define __NR_sethostname		(__NR_Linux +  74)
-#define __NR_setrlimit			(__NR_Linux +  75)
-#define __NR_getrlimit			(__NR_Linux +  76)
-#define __NR_getrusage			(__NR_Linux +  77)
-#define __NR_gettimeofday		(__NR_Linux +  78)
-#define __NR_settimeofday		(__NR_Linux +  79)
-#define __NR_getgroups			(__NR_Linux +  80)
-#define __NR_setgroups			(__NR_Linux +  81)
-#define __NR_reserved82			(__NR_Linux +  82)
-#define __NR_symlink			(__NR_Linux +  83)
-#define __NR_unused84			(__NR_Linux +  84)
-#define __NR_readlink			(__NR_Linux +  85)
-#define __NR_uselib			(__NR_Linux +  86)
-#define __NR_swapon			(__NR_Linux +  87)
-#define __NR_reboot			(__NR_Linux +  88)
-#define __NR_readdir			(__NR_Linux +  89)
-#define __NR_mmap			(__NR_Linux +  90)
-#define __NR_munmap			(__NR_Linux +  91)
-#define __NR_truncate			(__NR_Linux +  92)
-#define __NR_ftruncate			(__NR_Linux +  93)
-#define __NR_fchmod			(__NR_Linux +  94)
-#define __NR_fchown			(__NR_Linux +  95)
-#define __NR_getpriority		(__NR_Linux +  96)
-#define __NR_setpriority		(__NR_Linux +  97)
-#define __NR_profil			(__NR_Linux +  98)
-#define __NR_statfs			(__NR_Linux +  99)
-#define __NR_fstatfs			(__NR_Linux + 100)
-#define __NR_ioperm			(__NR_Linux + 101)
-#define __NR_socketcall			(__NR_Linux + 102)
-#define __NR_syslog			(__NR_Linux + 103)
-#define __NR_setitimer			(__NR_Linux + 104)
-#define __NR_getitimer			(__NR_Linux + 105)
-#define __NR_stat			(__NR_Linux + 106)
-#define __NR_lstat			(__NR_Linux + 107)
-#define __NR_fstat			(__NR_Linux + 108)
-#define __NR_unused109			(__NR_Linux + 109)
-#define __NR_iopl			(__NR_Linux + 110)
-#define __NR_vhangup			(__NR_Linux + 111)
-#define __NR_idle			(__NR_Linux + 112)
-#define __NR_vm86			(__NR_Linux + 113)
-#define __NR_wait4			(__NR_Linux + 114)
-#define __NR_swapoff			(__NR_Linux + 115)
-#define __NR_sysinfo			(__NR_Linux + 116)
-#define __NR_ipc			(__NR_Linux + 117)
-#define __NR_fsync			(__NR_Linux + 118)
-#define __NR_sigreturn			(__NR_Linux + 119)
-#define __NR_clone			(__NR_Linux + 120)
-#define __NR_setdomainname		(__NR_Linux + 121)
-#define __NR_uname			(__NR_Linux + 122)
-#define __NR_modify_ldt			(__NR_Linux + 123)
-#define __NR_adjtimex			(__NR_Linux + 124)
-#define __NR_mprotect			(__NR_Linux + 125)
-#define __NR_sigprocmask		(__NR_Linux + 126)
-#define __NR_create_module		(__NR_Linux + 127)
-#define __NR_init_module		(__NR_Linux + 128)
-#define __NR_delete_module		(__NR_Linux + 129)
-#define __NR_get_kernel_syms		(__NR_Linux + 130)
-#define __NR_quotactl			(__NR_Linux + 131)
-#define __NR_getpgid			(__NR_Linux + 132)
-#define __NR_fchdir			(__NR_Linux + 133)
-#define __NR_bdflush			(__NR_Linux + 134)
-#define __NR_sysfs			(__NR_Linux + 135)
-#define __NR_personality		(__NR_Linux + 136)
-#define __NR_afs_syscall		(__NR_Linux + 137) /* Syscall for Andrew File System */
-#define __NR_setfsuid			(__NR_Linux + 138)
-#define __NR_setfsgid			(__NR_Linux + 139)
-#define __NR__llseek			(__NR_Linux + 140)
-#define __NR_getdents			(__NR_Linux + 141)
-#define __NR__newselect			(__NR_Linux + 142)
-#define __NR_flock			(__NR_Linux + 143)
-#define __NR_msync			(__NR_Linux + 144)
-#define __NR_readv			(__NR_Linux + 145)
-#define __NR_writev			(__NR_Linux + 146)
-#define __NR_cacheflush			(__NR_Linux + 147)
-#define __NR_cachectl			(__NR_Linux + 148)
-#define __NR_sysmips			(__NR_Linux + 149)
-#define __NR_unused150			(__NR_Linux + 150)
-#define __NR_getsid			(__NR_Linux + 151)
-#define __NR_fdatasync			(__NR_Linux + 152)
-#define __NR__sysctl			(__NR_Linux + 153)
-#define __NR_mlock			(__NR_Linux + 154)
-#define __NR_munlock			(__NR_Linux + 155)
-#define __NR_mlockall			(__NR_Linux + 156)
-#define __NR_munlockall			(__NR_Linux + 157)
-#define __NR_sched_setparam		(__NR_Linux + 158)
-#define __NR_sched_getparam		(__NR_Linux + 159)
-#define __NR_sched_setscheduler		(__NR_Linux + 160)
-#define __NR_sched_getscheduler		(__NR_Linux + 161)
-#define __NR_sched_yield		(__NR_Linux + 162)
-#define __NR_sched_get_priority_max	(__NR_Linux + 163)
-#define __NR_sched_get_priority_min	(__NR_Linux + 164)
-#define __NR_sched_rr_get_interval	(__NR_Linux + 165)
-#define __NR_nanosleep			(__NR_Linux + 166)
-#define __NR_mremap			(__NR_Linux + 167)
-#define __NR_accept			(__NR_Linux + 168)
-#define __NR_bind			(__NR_Linux + 169)
-#define __NR_connect			(__NR_Linux + 170)
-#define __NR_getpeername		(__NR_Linux + 171)
-#define __NR_getsockname		(__NR_Linux + 172)
-#define __NR_getsockopt			(__NR_Linux + 173)
-#define __NR_listen			(__NR_Linux + 174)
-#define __NR_recv			(__NR_Linux + 175)
-#define __NR_recvfrom			(__NR_Linux + 176)
-#define __NR_recvmsg			(__NR_Linux + 177)
-#define __NR_send			(__NR_Linux + 178)
-#define __NR_sendmsg			(__NR_Linux + 179)
-#define __NR_sendto			(__NR_Linux + 180)
-#define __NR_setsockopt			(__NR_Linux + 181)
-#define __NR_shutdown			(__NR_Linux + 182)
-#define __NR_socket			(__NR_Linux + 183)
-#define __NR_socketpair			(__NR_Linux + 184)
-#define __NR_setresuid			(__NR_Linux + 185)
-#define __NR_getresuid			(__NR_Linux + 186)
-#define __NR_query_module		(__NR_Linux + 187)
-#define __NR_poll			(__NR_Linux + 188)
-#define __NR_nfsservctl			(__NR_Linux + 189)
-#define __NR_setresgid			(__NR_Linux + 190)
-#define __NR_getresgid			(__NR_Linux + 191)
-#define __NR_prctl			(__NR_Linux + 192)
-#define __NR_rt_sigreturn		(__NR_Linux + 193)
-#define __NR_rt_sigaction		(__NR_Linux + 194)
-#define __NR_rt_sigprocmask		(__NR_Linux + 195)
-#define __NR_rt_sigpending		(__NR_Linux + 196)
-#define __NR_rt_sigtimedwait		(__NR_Linux + 197)
-#define __NR_rt_sigqueueinfo		(__NR_Linux + 198)
-#define __NR_rt_sigsuspend		(__NR_Linux + 199)
-#define __NR_pread64			(__NR_Linux + 200)
-#define __NR_pwrite64			(__NR_Linux + 201)
-#define __NR_chown			(__NR_Linux + 202)
-#define __NR_getcwd			(__NR_Linux + 203)
-#define __NR_capget			(__NR_Linux + 204)
-#define __NR_capset			(__NR_Linux + 205)
-#define __NR_sigaltstack		(__NR_Linux + 206)
-#define __NR_sendfile			(__NR_Linux + 207)
-#define __NR_getpmsg			(__NR_Linux + 208)
-#define __NR_putpmsg			(__NR_Linux + 209)
-#define __NR_mmap2			(__NR_Linux + 210)
-#define __NR_truncate64			(__NR_Linux + 211)
-#define __NR_ftruncate64		(__NR_Linux + 212)
-#define __NR_stat64			(__NR_Linux + 213)
-#define __NR_lstat64			(__NR_Linux + 214)
-#define __NR_fstat64			(__NR_Linux + 215)
-#define __NR_pivot_root			(__NR_Linux + 216)
-#define __NR_mincore			(__NR_Linux + 217)
-#define __NR_madvise			(__NR_Linux + 218)
-#define __NR_getdents64			(__NR_Linux + 219)
-#define __NR_fcntl64			(__NR_Linux + 220)
-#define __NR_reserved221		(__NR_Linux + 221)
-#define __NR_gettid			(__NR_Linux + 222)
-#define __NR_readahead			(__NR_Linux + 223)
-#define __NR_setxattr			(__NR_Linux + 224)
-#define __NR_lsetxattr			(__NR_Linux + 225)
-#define __NR_fsetxattr			(__NR_Linux + 226)
-#define __NR_getxattr			(__NR_Linux + 227)
-#define __NR_lgetxattr			(__NR_Linux + 228)
-#define __NR_fgetxattr			(__NR_Linux + 229)
-#define __NR_listxattr			(__NR_Linux + 230)
-#define __NR_llistxattr			(__NR_Linux + 231)
-#define __NR_flistxattr			(__NR_Linux + 232)
-#define __NR_removexattr		(__NR_Linux + 233)
-#define __NR_lremovexattr		(__NR_Linux + 234)
-#define __NR_fremovexattr		(__NR_Linux + 235)
-#define __NR_tkill			(__NR_Linux + 236)
-#define __NR_sendfile64			(__NR_Linux + 237)
-#define __NR_futex			(__NR_Linux + 238)
-#define __NR_sched_setaffinity		(__NR_Linux + 239)
-#define __NR_sched_getaffinity		(__NR_Linux + 240)
-#define __NR_io_setup			(__NR_Linux + 241)
-#define __NR_io_destroy			(__NR_Linux + 242)
-#define __NR_io_getevents		(__NR_Linux + 243)
-#define __NR_io_submit			(__NR_Linux + 244)
-#define __NR_io_cancel			(__NR_Linux + 245)
-#define __NR_exit_group			(__NR_Linux + 246)
-#define __NR_lookup_dcookie		(__NR_Linux + 247)
-#define __NR_epoll_create		(__NR_Linux + 248)
-#define __NR_epoll_ctl			(__NR_Linux + 249)
-#define __NR_epoll_wait			(__NR_Linux + 250)
-#define __NR_remap_file_pages		(__NR_Linux + 251)
-#define __NR_set_tid_address		(__NR_Linux + 252)
-#define __NR_restart_syscall		(__NR_Linux + 253)
-#define __NR_fadvise64			(__NR_Linux + 254)
-#define __NR_statfs64			(__NR_Linux + 255)
-#define __NR_fstatfs64			(__NR_Linux + 256)
-#define __NR_timer_create		(__NR_Linux + 257)
-#define __NR_timer_settime		(__NR_Linux + 258)
-#define __NR_timer_gettime		(__NR_Linux + 259)
-#define __NR_timer_getoverrun		(__NR_Linux + 260)
-#define __NR_timer_delete		(__NR_Linux + 261)
-#define __NR_clock_settime		(__NR_Linux + 262)
-#define __NR_clock_gettime		(__NR_Linux + 263)
-#define __NR_clock_getres		(__NR_Linux + 264)
-#define __NR_clock_nanosleep		(__NR_Linux + 265)
-#define __NR_tgkill			(__NR_Linux + 266)
-#define __NR_utimes			(__NR_Linux + 267)
-#define __NR_mbind			(__NR_Linux + 268)
-#define __NR_get_mempolicy		(__NR_Linux + 269)
-#define __NR_set_mempolicy		(__NR_Linux + 270)
-#define __NR_mq_open			(__NR_Linux + 271)
-#define __NR_mq_unlink			(__NR_Linux + 272)
-#define __NR_mq_timedsend		(__NR_Linux + 273)
-#define __NR_mq_timedreceive		(__NR_Linux + 274)
-#define __NR_mq_notify			(__NR_Linux + 275)
-#define __NR_mq_getsetattr		(__NR_Linux + 276)
-#define __NR_vserver			(__NR_Linux + 277)
-#define __NR_waitid			(__NR_Linux + 278)
-/* #define __NR_sys_setaltroot		(__NR_Linux + 279) */
-#define __NR_add_key			(__NR_Linux + 280)
-#define __NR_request_key		(__NR_Linux + 281)
-#define __NR_keyctl			(__NR_Linux + 282)
-#define __NR_set_thread_area		(__NR_Linux + 283)
-#define __NR_inotify_init		(__NR_Linux + 284)
-#define __NR_inotify_add_watch		(__NR_Linux + 285)
-#define __NR_inotify_rm_watch		(__NR_Linux + 286)
-#define __NR_migrate_pages		(__NR_Linux + 287)
-#define __NR_openat			(__NR_Linux + 288)
-#define __NR_mkdirat			(__NR_Linux + 289)
-#define __NR_mknodat			(__NR_Linux + 290)
-#define __NR_fchownat			(__NR_Linux + 291)
-#define __NR_futimesat			(__NR_Linux + 292)
-#define __NR_fstatat64			(__NR_Linux + 293)
-#define __NR_unlinkat			(__NR_Linux + 294)
-#define __NR_renameat			(__NR_Linux + 295)
-#define __NR_linkat			(__NR_Linux + 296)
-#define __NR_symlinkat			(__NR_Linux + 297)
-#define __NR_readlinkat			(__NR_Linux + 298)
-#define __NR_fchmodat			(__NR_Linux + 299)
-#define __NR_faccessat			(__NR_Linux + 300)
-#define __NR_pselect6			(__NR_Linux + 301)
-#define __NR_ppoll			(__NR_Linux + 302)
-#define __NR_unshare			(__NR_Linux + 303)
-#define __NR_splice			(__NR_Linux + 304)
-#define __NR_sync_file_range		(__NR_Linux + 305)
-#define __NR_tee			(__NR_Linux + 306)
-#define __NR_vmsplice			(__NR_Linux + 307)
-#define __NR_move_pages			(__NR_Linux + 308)
-#define __NR_set_robust_list		(__NR_Linux + 309)
-#define __NR_get_robust_list		(__NR_Linux + 310)
-#define __NR_kexec_load			(__NR_Linux + 311)
-#define __NR_getcpu			(__NR_Linux + 312)
-#define __NR_epoll_pwait		(__NR_Linux + 313)
-#define __NR_ioprio_set			(__NR_Linux + 314)
-#define __NR_ioprio_get			(__NR_Linux + 315)
-#define __NR_utimensat			(__NR_Linux + 316)
-#define __NR_signalfd			(__NR_Linux + 317)
-#define __NR_timerfd			(__NR_Linux + 318)
-#define __NR_eventfd			(__NR_Linux + 319)
-#define __NR_fallocate			(__NR_Linux + 320)
-#define __NR_timerfd_create		(__NR_Linux + 321)
-#define __NR_timerfd_gettime		(__NR_Linux + 322)
-#define __NR_timerfd_settime		(__NR_Linux + 323)
-#define __NR_signalfd4			(__NR_Linux + 324)
-#define __NR_eventfd2			(__NR_Linux + 325)
-#define __NR_epoll_create1		(__NR_Linux + 326)
-#define __NR_dup3			(__NR_Linux + 327)
-#define __NR_pipe2			(__NR_Linux + 328)
-#define __NR_inotify_init1		(__NR_Linux + 329)
-#define __NR_preadv			(__NR_Linux + 330)
-#define __NR_pwritev			(__NR_Linux + 331)
-#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 332)
-#define __NR_perf_event_open		(__NR_Linux + 333)
-#define __NR_accept4			(__NR_Linux + 334)
-#define __NR_recvmmsg			(__NR_Linux + 335)
-#define __NR_fanotify_init		(__NR_Linux + 336)
-#define __NR_fanotify_mark		(__NR_Linux + 337)
-#define __NR_prlimit64			(__NR_Linux + 338)
-#define __NR_name_to_handle_at		(__NR_Linux + 339)
-#define __NR_open_by_handle_at		(__NR_Linux + 340)
-#define __NR_clock_adjtime		(__NR_Linux + 341)
-#define __NR_syncfs			(__NR_Linux + 342)
-#define __NR_sendmmsg			(__NR_Linux + 343)
-#define __NR_setns			(__NR_Linux + 344)
-#define __NR_process_vm_readv		(__NR_Linux + 345)
-#define __NR_process_vm_writev		(__NR_Linux + 346)
-#define __NR_kcmp			(__NR_Linux + 347)
-#define __NR_finit_module		(__NR_Linux + 348)
-#define __NR_sched_setattr		(__NR_Linux + 349)
-#define __NR_sched_getattr		(__NR_Linux + 350)
-#define __NR_renameat2			(__NR_Linux + 351)
-#define __NR_seccomp			(__NR_Linux + 352)
-#define __NR_getrandom			(__NR_Linux + 353)
-#define __NR_memfd_create		(__NR_Linux + 354)
-#define __NR_bpf			(__NR_Linux + 355)
-#define __NR_execveat			(__NR_Linux + 356)
-#define __NR_userfaultfd		(__NR_Linux + 357)
-#define __NR_membarrier			(__NR_Linux + 358)
-#define __NR_mlock2			(__NR_Linux + 359)
-#define __NR_copy_file_range		(__NR_Linux + 360)
-#define __NR_preadv2			(__NR_Linux + 361)
-#define __NR_pwritev2			(__NR_Linux + 362)
-#define __NR_pkey_mprotect		(__NR_Linux + 363)
-#define __NR_pkey_alloc			(__NR_Linux + 364)
-#define __NR_pkey_free			(__NR_Linux + 365)
-#define __NR_statx			(__NR_Linux + 366)
-#define __NR_rseq			(__NR_Linux + 367)
-#define __NR_io_pgetevents		(__NR_Linux + 368)
-#define __NR_syscalls                   368
+#define __NR_Linux 4000
+#include <asm/unistd_32.h>
 
 /*
  * Offset of the last Linux o32 flavoured syscall
@@ -400,349 +31,20 @@
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls         __NR_syscalls
+#define __NR_O32_Linux_syscalls		__NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
 /*
  * Linux 64-bit syscalls are in the range from 5000 to 5999.
  */
-#define __NR_Linux			5000
-#define __NR_read			(__NR_Linux +	0)
-#define __NR_write			(__NR_Linux +	1)
-#define __NR_open			(__NR_Linux +	2)
-#define __NR_close			(__NR_Linux +	3)
-#define __NR_stat			(__NR_Linux +	4)
-#define __NR_fstat			(__NR_Linux +	5)
-#define __NR_lstat			(__NR_Linux +	6)
-#define __NR_poll			(__NR_Linux +	7)
-#define __NR_lseek			(__NR_Linux +	8)
-#define __NR_mmap			(__NR_Linux +	9)
-#define __NR_mprotect			(__NR_Linux +  10)
-#define __NR_munmap			(__NR_Linux +  11)
-#define __NR_brk			(__NR_Linux +  12)
-#define __NR_rt_sigaction		(__NR_Linux +  13)
-#define __NR_rt_sigprocmask		(__NR_Linux +  14)
-#define __NR_ioctl			(__NR_Linux +  15)
-#define __NR_pread64			(__NR_Linux +  16)
-#define __NR_pwrite64			(__NR_Linux +  17)
-#define __NR_readv			(__NR_Linux +  18)
-#define __NR_writev			(__NR_Linux +  19)
-#define __NR_access			(__NR_Linux +  20)
-#define __NR_pipe			(__NR_Linux +  21)
-#define __NR__newselect			(__NR_Linux +  22)
-#define __NR_sched_yield		(__NR_Linux +  23)
-#define __NR_mremap			(__NR_Linux +  24)
-#define __NR_msync			(__NR_Linux +  25)
-#define __NR_mincore			(__NR_Linux +  26)
-#define __NR_madvise			(__NR_Linux +  27)
-#define __NR_shmget			(__NR_Linux +  28)
-#define __NR_shmat			(__NR_Linux +  29)
-#define __NR_shmctl			(__NR_Linux +  30)
-#define __NR_dup			(__NR_Linux +  31)
-#define __NR_dup2			(__NR_Linux +  32)
-#define __NR_pause			(__NR_Linux +  33)
-#define __NR_nanosleep			(__NR_Linux +  34)
-#define __NR_getitimer			(__NR_Linux +  35)
-#define __NR_setitimer			(__NR_Linux +  36)
-#define __NR_alarm			(__NR_Linux +  37)
-#define __NR_getpid			(__NR_Linux +  38)
-#define __NR_sendfile			(__NR_Linux +  39)
-#define __NR_socket			(__NR_Linux +  40)
-#define __NR_connect			(__NR_Linux +  41)
-#define __NR_accept			(__NR_Linux +  42)
-#define __NR_sendto			(__NR_Linux +  43)
-#define __NR_recvfrom			(__NR_Linux +  44)
-#define __NR_sendmsg			(__NR_Linux +  45)
-#define __NR_recvmsg			(__NR_Linux +  46)
-#define __NR_shutdown			(__NR_Linux +  47)
-#define __NR_bind			(__NR_Linux +  48)
-#define __NR_listen			(__NR_Linux +  49)
-#define __NR_getsockname		(__NR_Linux +  50)
-#define __NR_getpeername		(__NR_Linux +  51)
-#define __NR_socketpair			(__NR_Linux +  52)
-#define __NR_setsockopt			(__NR_Linux +  53)
-#define __NR_getsockopt			(__NR_Linux +  54)
-#define __NR_clone			(__NR_Linux +  55)
-#define __NR_fork			(__NR_Linux +  56)
-#define __NR_execve			(__NR_Linux +  57)
-#define __NR_exit			(__NR_Linux +  58)
-#define __NR_wait4			(__NR_Linux +  59)
-#define __NR_kill			(__NR_Linux +  60)
-#define __NR_uname			(__NR_Linux +  61)
-#define __NR_semget			(__NR_Linux +  62)
-#define __NR_semop			(__NR_Linux +  63)
-#define __NR_semctl			(__NR_Linux +  64)
-#define __NR_shmdt			(__NR_Linux +  65)
-#define __NR_msgget			(__NR_Linux +  66)
-#define __NR_msgsnd			(__NR_Linux +  67)
-#define __NR_msgrcv			(__NR_Linux +  68)
-#define __NR_msgctl			(__NR_Linux +  69)
-#define __NR_fcntl			(__NR_Linux +  70)
-#define __NR_flock			(__NR_Linux +  71)
-#define __NR_fsync			(__NR_Linux +  72)
-#define __NR_fdatasync			(__NR_Linux +  73)
-#define __NR_truncate			(__NR_Linux +  74)
-#define __NR_ftruncate			(__NR_Linux +  75)
-#define __NR_getdents			(__NR_Linux +  76)
-#define __NR_getcwd			(__NR_Linux +  77)
-#define __NR_chdir			(__NR_Linux +  78)
-#define __NR_fchdir			(__NR_Linux +  79)
-#define __NR_rename			(__NR_Linux +  80)
-#define __NR_mkdir			(__NR_Linux +  81)
-#define __NR_rmdir			(__NR_Linux +  82)
-#define __NR_creat			(__NR_Linux +  83)
-#define __NR_link			(__NR_Linux +  84)
-#define __NR_unlink			(__NR_Linux +  85)
-#define __NR_symlink			(__NR_Linux +  86)
-#define __NR_readlink			(__NR_Linux +  87)
-#define __NR_chmod			(__NR_Linux +  88)
-#define __NR_fchmod			(__NR_Linux +  89)
-#define __NR_chown			(__NR_Linux +  90)
-#define __NR_fchown			(__NR_Linux +  91)
-#define __NR_lchown			(__NR_Linux +  92)
-#define __NR_umask			(__NR_Linux +  93)
-#define __NR_gettimeofday		(__NR_Linux +  94)
-#define __NR_getrlimit			(__NR_Linux +  95)
-#define __NR_getrusage			(__NR_Linux +  96)
-#define __NR_sysinfo			(__NR_Linux +  97)
-#define __NR_times			(__NR_Linux +  98)
-#define __NR_ptrace			(__NR_Linux +  99)
-#define __NR_getuid			(__NR_Linux + 100)
-#define __NR_syslog			(__NR_Linux + 101)
-#define __NR_getgid			(__NR_Linux + 102)
-#define __NR_setuid			(__NR_Linux + 103)
-#define __NR_setgid			(__NR_Linux + 104)
-#define __NR_geteuid			(__NR_Linux + 105)
-#define __NR_getegid			(__NR_Linux + 106)
-#define __NR_setpgid			(__NR_Linux + 107)
-#define __NR_getppid			(__NR_Linux + 108)
-#define __NR_getpgrp			(__NR_Linux + 109)
-#define __NR_setsid			(__NR_Linux + 110)
-#define __NR_setreuid			(__NR_Linux + 111)
-#define __NR_setregid			(__NR_Linux + 112)
-#define __NR_getgroups			(__NR_Linux + 113)
-#define __NR_setgroups			(__NR_Linux + 114)
-#define __NR_setresuid			(__NR_Linux + 115)
-#define __NR_getresuid			(__NR_Linux + 116)
-#define __NR_setresgid			(__NR_Linux + 117)
-#define __NR_getresgid			(__NR_Linux + 118)
-#define __NR_getpgid			(__NR_Linux + 119)
-#define __NR_setfsuid			(__NR_Linux + 120)
-#define __NR_setfsgid			(__NR_Linux + 121)
-#define __NR_getsid			(__NR_Linux + 122)
-#define __NR_capget			(__NR_Linux + 123)
-#define __NR_capset			(__NR_Linux + 124)
-#define __NR_rt_sigpending		(__NR_Linux + 125)
-#define __NR_rt_sigtimedwait		(__NR_Linux + 126)
-#define __NR_rt_sigqueueinfo		(__NR_Linux + 127)
-#define __NR_rt_sigsuspend		(__NR_Linux + 128)
-#define __NR_sigaltstack		(__NR_Linux + 129)
-#define __NR_utime			(__NR_Linux + 130)
-#define __NR_mknod			(__NR_Linux + 131)
-#define __NR_personality		(__NR_Linux + 132)
-#define __NR_ustat			(__NR_Linux + 133)
-#define __NR_statfs			(__NR_Linux + 134)
-#define __NR_fstatfs			(__NR_Linux + 135)
-#define __NR_sysfs			(__NR_Linux + 136)
-#define __NR_getpriority		(__NR_Linux + 137)
-#define __NR_setpriority		(__NR_Linux + 138)
-#define __NR_sched_setparam		(__NR_Linux + 139)
-#define __NR_sched_getparam		(__NR_Linux + 140)
-#define __NR_sched_setscheduler		(__NR_Linux + 141)
-#define __NR_sched_getscheduler		(__NR_Linux + 142)
-#define __NR_sched_get_priority_max	(__NR_Linux + 143)
-#define __NR_sched_get_priority_min	(__NR_Linux + 144)
-#define __NR_sched_rr_get_interval	(__NR_Linux + 145)
-#define __NR_mlock			(__NR_Linux + 146)
-#define __NR_munlock			(__NR_Linux + 147)
-#define __NR_mlockall			(__NR_Linux + 148)
-#define __NR_munlockall			(__NR_Linux + 149)
-#define __NR_vhangup			(__NR_Linux + 150)
-#define __NR_pivot_root			(__NR_Linux + 151)
-#define __NR__sysctl			(__NR_Linux + 152)
-#define __NR_prctl			(__NR_Linux + 153)
-#define __NR_adjtimex			(__NR_Linux + 154)
-#define __NR_setrlimit			(__NR_Linux + 155)
-#define __NR_chroot			(__NR_Linux + 156)
-#define __NR_sync			(__NR_Linux + 157)
-#define __NR_acct			(__NR_Linux + 158)
-#define __NR_settimeofday		(__NR_Linux + 159)
-#define __NR_mount			(__NR_Linux + 160)
-#define __NR_umount2			(__NR_Linux + 161)
-#define __NR_swapon			(__NR_Linux + 162)
-#define __NR_swapoff			(__NR_Linux + 163)
-#define __NR_reboot			(__NR_Linux + 164)
-#define __NR_sethostname		(__NR_Linux + 165)
-#define __NR_setdomainname		(__NR_Linux + 166)
-#define __NR_create_module		(__NR_Linux + 167)
-#define __NR_init_module		(__NR_Linux + 168)
-#define __NR_delete_module		(__NR_Linux + 169)
-#define __NR_get_kernel_syms		(__NR_Linux + 170)
-#define __NR_query_module		(__NR_Linux + 171)
-#define __NR_quotactl			(__NR_Linux + 172)
-#define __NR_nfsservctl			(__NR_Linux + 173)
-#define __NR_getpmsg			(__NR_Linux + 174)
-#define __NR_putpmsg			(__NR_Linux + 175)
-#define __NR_afs_syscall		(__NR_Linux + 176)
-#define __NR_reserved177		(__NR_Linux + 177)
-#define __NR_gettid			(__NR_Linux + 178)
-#define __NR_readahead			(__NR_Linux + 179)
-#define __NR_setxattr			(__NR_Linux + 180)
-#define __NR_lsetxattr			(__NR_Linux + 181)
-#define __NR_fsetxattr			(__NR_Linux + 182)
-#define __NR_getxattr			(__NR_Linux + 183)
-#define __NR_lgetxattr			(__NR_Linux + 184)
-#define __NR_fgetxattr			(__NR_Linux + 185)
-#define __NR_listxattr			(__NR_Linux + 186)
-#define __NR_llistxattr			(__NR_Linux + 187)
-#define __NR_flistxattr			(__NR_Linux + 188)
-#define __NR_removexattr		(__NR_Linux + 189)
-#define __NR_lremovexattr		(__NR_Linux + 190)
-#define __NR_fremovexattr		(__NR_Linux + 191)
-#define __NR_tkill			(__NR_Linux + 192)
-#define __NR_reserved193		(__NR_Linux + 193)
-#define __NR_futex			(__NR_Linux + 194)
-#define __NR_sched_setaffinity		(__NR_Linux + 195)
-#define __NR_sched_getaffinity		(__NR_Linux + 196)
-#define __NR_cacheflush			(__NR_Linux + 197)
-#define __NR_cachectl			(__NR_Linux + 198)
-#define __NR_sysmips			(__NR_Linux + 199)
-#define __NR_io_setup			(__NR_Linux + 200)
-#define __NR_io_destroy			(__NR_Linux + 201)
-#define __NR_io_getevents		(__NR_Linux + 202)
-#define __NR_io_submit			(__NR_Linux + 203)
-#define __NR_io_cancel			(__NR_Linux + 204)
-#define __NR_exit_group			(__NR_Linux + 205)
-#define __NR_lookup_dcookie		(__NR_Linux + 206)
-#define __NR_epoll_create		(__NR_Linux + 207)
-#define __NR_epoll_ctl			(__NR_Linux + 208)
-#define __NR_epoll_wait			(__NR_Linux + 209)
-#define __NR_remap_file_pages		(__NR_Linux + 210)
-#define __NR_rt_sigreturn		(__NR_Linux + 211)
-#define __NR_set_tid_address		(__NR_Linux + 212)
-#define __NR_restart_syscall		(__NR_Linux + 213)
-#define __NR_semtimedop			(__NR_Linux + 214)
-#define __NR_fadvise64			(__NR_Linux + 215)
-#define __NR_timer_create		(__NR_Linux + 216)
-#define __NR_timer_settime		(__NR_Linux + 217)
-#define __NR_timer_gettime		(__NR_Linux + 218)
-#define __NR_timer_getoverrun		(__NR_Linux + 219)
-#define __NR_timer_delete		(__NR_Linux + 220)
-#define __NR_clock_settime		(__NR_Linux + 221)
-#define __NR_clock_gettime		(__NR_Linux + 222)
-#define __NR_clock_getres		(__NR_Linux + 223)
-#define __NR_clock_nanosleep		(__NR_Linux + 224)
-#define __NR_tgkill			(__NR_Linux + 225)
-#define __NR_utimes			(__NR_Linux + 226)
-#define __NR_mbind			(__NR_Linux + 227)
-#define __NR_get_mempolicy		(__NR_Linux + 228)
-#define __NR_set_mempolicy		(__NR_Linux + 229)
-#define __NR_mq_open			(__NR_Linux + 230)
-#define __NR_mq_unlink			(__NR_Linux + 231)
-#define __NR_mq_timedsend		(__NR_Linux + 232)
-#define __NR_mq_timedreceive		(__NR_Linux + 233)
-#define __NR_mq_notify			(__NR_Linux + 234)
-#define __NR_mq_getsetattr		(__NR_Linux + 235)
-#define __NR_vserver			(__NR_Linux + 236)
-#define __NR_waitid			(__NR_Linux + 237)
-/* #define __NR_sys_setaltroot		(__NR_Linux + 238) */
-#define __NR_add_key			(__NR_Linux + 239)
-#define __NR_request_key		(__NR_Linux + 240)
-#define __NR_keyctl			(__NR_Linux + 241)
-#define __NR_set_thread_area		(__NR_Linux + 242)
-#define __NR_inotify_init		(__NR_Linux + 243)
-#define __NR_inotify_add_watch		(__NR_Linux + 244)
-#define __NR_inotify_rm_watch		(__NR_Linux + 245)
-#define __NR_migrate_pages		(__NR_Linux + 246)
-#define __NR_openat			(__NR_Linux + 247)
-#define __NR_mkdirat			(__NR_Linux + 248)
-#define __NR_mknodat			(__NR_Linux + 249)
-#define __NR_fchownat			(__NR_Linux + 250)
-#define __NR_futimesat			(__NR_Linux + 251)
-#define __NR_newfstatat			(__NR_Linux + 252)
-#define __NR_unlinkat			(__NR_Linux + 253)
-#define __NR_renameat			(__NR_Linux + 254)
-#define __NR_linkat			(__NR_Linux + 255)
-#define __NR_symlinkat			(__NR_Linux + 256)
-#define __NR_readlinkat			(__NR_Linux + 257)
-#define __NR_fchmodat			(__NR_Linux + 258)
-#define __NR_faccessat			(__NR_Linux + 259)
-#define __NR_pselect6			(__NR_Linux + 260)
-#define __NR_ppoll			(__NR_Linux + 261)
-#define __NR_unshare			(__NR_Linux + 262)
-#define __NR_splice			(__NR_Linux + 263)
-#define __NR_sync_file_range		(__NR_Linux + 264)
-#define __NR_tee			(__NR_Linux + 265)
-#define __NR_vmsplice			(__NR_Linux + 266)
-#define __NR_move_pages			(__NR_Linux + 267)
-#define __NR_set_robust_list		(__NR_Linux + 268)
-#define __NR_get_robust_list		(__NR_Linux + 269)
-#define __NR_kexec_load			(__NR_Linux + 270)
-#define __NR_getcpu			(__NR_Linux + 271)
-#define __NR_epoll_pwait		(__NR_Linux + 272)
-#define __NR_ioprio_set			(__NR_Linux + 273)
-#define __NR_ioprio_get			(__NR_Linux + 274)
-#define __NR_utimensat			(__NR_Linux + 275)
-#define __NR_signalfd			(__NR_Linux + 276)
-#define __NR_timerfd			(__NR_Linux + 277)
-#define __NR_eventfd			(__NR_Linux + 278)
-#define __NR_fallocate			(__NR_Linux + 279)
-#define __NR_timerfd_create		(__NR_Linux + 280)
-#define __NR_timerfd_gettime		(__NR_Linux + 281)
-#define __NR_timerfd_settime		(__NR_Linux + 282)
-#define __NR_signalfd4			(__NR_Linux + 283)
-#define __NR_eventfd2			(__NR_Linux + 284)
-#define __NR_epoll_create1		(__NR_Linux + 285)
-#define __NR_dup3			(__NR_Linux + 286)
-#define __NR_pipe2			(__NR_Linux + 287)
-#define __NR_inotify_init1		(__NR_Linux + 288)
-#define __NR_preadv			(__NR_Linux + 289)
-#define __NR_pwritev			(__NR_Linux + 290)
-#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 291)
-#define __NR_perf_event_open		(__NR_Linux + 292)
-#define __NR_accept4			(__NR_Linux + 293)
-#define __NR_recvmmsg			(__NR_Linux + 294)
-#define __NR_fanotify_init		(__NR_Linux + 295)
-#define __NR_fanotify_mark		(__NR_Linux + 296)
-#define __NR_prlimit64			(__NR_Linux + 297)
-#define __NR_name_to_handle_at		(__NR_Linux + 298)
-#define __NR_open_by_handle_at		(__NR_Linux + 299)
-#define __NR_clock_adjtime		(__NR_Linux + 300)
-#define __NR_syncfs			(__NR_Linux + 301)
-#define __NR_sendmmsg			(__NR_Linux + 302)
-#define __NR_setns			(__NR_Linux + 303)
-#define __NR_process_vm_readv		(__NR_Linux + 304)
-#define __NR_process_vm_writev		(__NR_Linux + 305)
-#define __NR_kcmp			(__NR_Linux + 306)
-#define __NR_finit_module		(__NR_Linux + 307)
-#define __NR_getdents64			(__NR_Linux + 308)
-#define __NR_sched_setattr		(__NR_Linux + 309)
-#define __NR_sched_getattr		(__NR_Linux + 310)
-#define __NR_renameat2			(__NR_Linux + 311)
-#define __NR_seccomp			(__NR_Linux + 312)
-#define __NR_getrandom			(__NR_Linux + 313)
-#define __NR_memfd_create		(__NR_Linux + 314)
-#define __NR_bpf			(__NR_Linux + 315)
-#define __NR_execveat			(__NR_Linux + 316)
-#define __NR_userfaultfd		(__NR_Linux + 317)
-#define __NR_membarrier			(__NR_Linux + 318)
-#define __NR_mlock2			(__NR_Linux + 319)
-#define __NR_copy_file_range		(__NR_Linux + 320)
-#define __NR_preadv2			(__NR_Linux + 321)
-#define __NR_pwritev2			(__NR_Linux + 322)
-#define __NR_pkey_mprotect		(__NR_Linux + 323)
-#define __NR_pkey_alloc			(__NR_Linux + 324)
-#define __NR_pkey_free			(__NR_Linux + 325)
-#define __NR_statx			(__NR_Linux + 326)
-#define __NR_rseq			(__NR_Linux + 327)
-#define __NR_io_pgetevents		(__NR_Linux + 328)
-#define __NR_syscalls                   328
+#define __NR_Linux 5000
+#include <asm/unistd_64.h>
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		__NR_syscalls
+#define __NR_Linux_syscalls             __NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
@@ -754,346 +56,13 @@
 /*
  * Linux N32 syscalls are in the range from 6000 to 6999.
  */
-#define __NR_Linux			6000
-#define __NR_read			(__NR_Linux +	0)
-#define __NR_write			(__NR_Linux +	1)
-#define __NR_open			(__NR_Linux +	2)
-#define __NR_close			(__NR_Linux +	3)
-#define __NR_stat			(__NR_Linux +	4)
-#define __NR_fstat			(__NR_Linux +	5)
-#define __NR_lstat			(__NR_Linux +	6)
-#define __NR_poll			(__NR_Linux +	7)
-#define __NR_lseek			(__NR_Linux +	8)
-#define __NR_mmap			(__NR_Linux +	9)
-#define __NR_mprotect			(__NR_Linux +  10)
-#define __NR_munmap			(__NR_Linux +  11)
-#define __NR_brk			(__NR_Linux +  12)
-#define __NR_rt_sigaction		(__NR_Linux +  13)
-#define __NR_rt_sigprocmask		(__NR_Linux +  14)
-#define __NR_ioctl			(__NR_Linux +  15)
-#define __NR_pread64			(__NR_Linux +  16)
-#define __NR_pwrite64			(__NR_Linux +  17)
-#define __NR_readv			(__NR_Linux +  18)
-#define __NR_writev			(__NR_Linux +  19)
-#define __NR_access			(__NR_Linux +  20)
-#define __NR_pipe			(__NR_Linux +  21)
-#define __NR__newselect			(__NR_Linux +  22)
-#define __NR_sched_yield		(__NR_Linux +  23)
-#define __NR_mremap			(__NR_Linux +  24)
-#define __NR_msync			(__NR_Linux +  25)
-#define __NR_mincore			(__NR_Linux +  26)
-#define __NR_madvise			(__NR_Linux +  27)
-#define __NR_shmget			(__NR_Linux +  28)
-#define __NR_shmat			(__NR_Linux +  29)
-#define __NR_shmctl			(__NR_Linux +  30)
-#define __NR_dup			(__NR_Linux +  31)
-#define __NR_dup2			(__NR_Linux +  32)
-#define __NR_pause			(__NR_Linux +  33)
-#define __NR_nanosleep			(__NR_Linux +  34)
-#define __NR_getitimer			(__NR_Linux +  35)
-#define __NR_setitimer			(__NR_Linux +  36)
-#define __NR_alarm			(__NR_Linux +  37)
-#define __NR_getpid			(__NR_Linux +  38)
-#define __NR_sendfile			(__NR_Linux +  39)
-#define __NR_socket			(__NR_Linux +  40)
-#define __NR_connect			(__NR_Linux +  41)
-#define __NR_accept			(__NR_Linux +  42)
-#define __NR_sendto			(__NR_Linux +  43)
-#define __NR_recvfrom			(__NR_Linux +  44)
-#define __NR_sendmsg			(__NR_Linux +  45)
-#define __NR_recvmsg			(__NR_Linux +  46)
-#define __NR_shutdown			(__NR_Linux +  47)
-#define __NR_bind			(__NR_Linux +  48)
-#define __NR_listen			(__NR_Linux +  49)
-#define __NR_getsockname		(__NR_Linux +  50)
-#define __NR_getpeername		(__NR_Linux +  51)
-#define __NR_socketpair			(__NR_Linux +  52)
-#define __NR_setsockopt			(__NR_Linux +  53)
-#define __NR_getsockopt			(__NR_Linux +  54)
-#define __NR_clone			(__NR_Linux +  55)
-#define __NR_fork			(__NR_Linux +  56)
-#define __NR_execve			(__NR_Linux +  57)
-#define __NR_exit			(__NR_Linux +  58)
-#define __NR_wait4			(__NR_Linux +  59)
-#define __NR_kill			(__NR_Linux +  60)
-#define __NR_uname			(__NR_Linux +  61)
-#define __NR_semget			(__NR_Linux +  62)
-#define __NR_semop			(__NR_Linux +  63)
-#define __NR_semctl			(__NR_Linux +  64)
-#define __NR_shmdt			(__NR_Linux +  65)
-#define __NR_msgget			(__NR_Linux +  66)
-#define __NR_msgsnd			(__NR_Linux +  67)
-#define __NR_msgrcv			(__NR_Linux +  68)
-#define __NR_msgctl			(__NR_Linux +  69)
-#define __NR_fcntl			(__NR_Linux +  70)
-#define __NR_flock			(__NR_Linux +  71)
-#define __NR_fsync			(__NR_Linux +  72)
-#define __NR_fdatasync			(__NR_Linux +  73)
-#define __NR_truncate			(__NR_Linux +  74)
-#define __NR_ftruncate			(__NR_Linux +  75)
-#define __NR_getdents			(__NR_Linux +  76)
-#define __NR_getcwd			(__NR_Linux +  77)
-#define __NR_chdir			(__NR_Linux +  78)
-#define __NR_fchdir			(__NR_Linux +  79)
-#define __NR_rename			(__NR_Linux +  80)
-#define __NR_mkdir			(__NR_Linux +  81)
-#define __NR_rmdir			(__NR_Linux +  82)
-#define __NR_creat			(__NR_Linux +  83)
-#define __NR_link			(__NR_Linux +  84)
-#define __NR_unlink			(__NR_Linux +  85)
-#define __NR_symlink			(__NR_Linux +  86)
-#define __NR_readlink			(__NR_Linux +  87)
-#define __NR_chmod			(__NR_Linux +  88)
-#define __NR_fchmod			(__NR_Linux +  89)
-#define __NR_chown			(__NR_Linux +  90)
-#define __NR_fchown			(__NR_Linux +  91)
-#define __NR_lchown			(__NR_Linux +  92)
-#define __NR_umask			(__NR_Linux +  93)
-#define __NR_gettimeofday		(__NR_Linux +  94)
-#define __NR_getrlimit			(__NR_Linux +  95)
-#define __NR_getrusage			(__NR_Linux +  96)
-#define __NR_sysinfo			(__NR_Linux +  97)
-#define __NR_times			(__NR_Linux +  98)
-#define __NR_ptrace			(__NR_Linux +  99)
-#define __NR_getuid			(__NR_Linux + 100)
-#define __NR_syslog			(__NR_Linux + 101)
-#define __NR_getgid			(__NR_Linux + 102)
-#define __NR_setuid			(__NR_Linux + 103)
-#define __NR_setgid			(__NR_Linux + 104)
-#define __NR_geteuid			(__NR_Linux + 105)
-#define __NR_getegid			(__NR_Linux + 106)
-#define __NR_setpgid			(__NR_Linux + 107)
-#define __NR_getppid			(__NR_Linux + 108)
-#define __NR_getpgrp			(__NR_Linux + 109)
-#define __NR_setsid			(__NR_Linux + 110)
-#define __NR_setreuid			(__NR_Linux + 111)
-#define __NR_setregid			(__NR_Linux + 112)
-#define __NR_getgroups			(__NR_Linux + 113)
-#define __NR_setgroups			(__NR_Linux + 114)
-#define __NR_setresuid			(__NR_Linux + 115)
-#define __NR_getresuid			(__NR_Linux + 116)
-#define __NR_setresgid			(__NR_Linux + 117)
-#define __NR_getresgid			(__NR_Linux + 118)
-#define __NR_getpgid			(__NR_Linux + 119)
-#define __NR_setfsuid			(__NR_Linux + 120)
-#define __NR_setfsgid			(__NR_Linux + 121)
-#define __NR_getsid			(__NR_Linux + 122)
-#define __NR_capget			(__NR_Linux + 123)
-#define __NR_capset			(__NR_Linux + 124)
-#define __NR_rt_sigpending		(__NR_Linux + 125)
-#define __NR_rt_sigtimedwait		(__NR_Linux + 126)
-#define __NR_rt_sigqueueinfo		(__NR_Linux + 127)
-#define __NR_rt_sigsuspend		(__NR_Linux + 128)
-#define __NR_sigaltstack		(__NR_Linux + 129)
-#define __NR_utime			(__NR_Linux + 130)
-#define __NR_mknod			(__NR_Linux + 131)
-#define __NR_personality		(__NR_Linux + 132)
-#define __NR_ustat			(__NR_Linux + 133)
-#define __NR_statfs			(__NR_Linux + 134)
-#define __NR_fstatfs			(__NR_Linux + 135)
-#define __NR_sysfs			(__NR_Linux + 136)
-#define __NR_getpriority		(__NR_Linux + 137)
-#define __NR_setpriority		(__NR_Linux + 138)
-#define __NR_sched_setparam		(__NR_Linux + 139)
-#define __NR_sched_getparam		(__NR_Linux + 140)
-#define __NR_sched_setscheduler		(__NR_Linux + 141)
-#define __NR_sched_getscheduler		(__NR_Linux + 142)
-#define __NR_sched_get_priority_max	(__NR_Linux + 143)
-#define __NR_sched_get_priority_min	(__NR_Linux + 144)
-#define __NR_sched_rr_get_interval	(__NR_Linux + 145)
-#define __NR_mlock			(__NR_Linux + 146)
-#define __NR_munlock			(__NR_Linux + 147)
-#define __NR_mlockall			(__NR_Linux + 148)
-#define __NR_munlockall			(__NR_Linux + 149)
-#define __NR_vhangup			(__NR_Linux + 150)
-#define __NR_pivot_root			(__NR_Linux + 151)
-#define __NR__sysctl			(__NR_Linux + 152)
-#define __NR_prctl			(__NR_Linux + 153)
-#define __NR_adjtimex			(__NR_Linux + 154)
-#define __NR_setrlimit			(__NR_Linux + 155)
-#define __NR_chroot			(__NR_Linux + 156)
-#define __NR_sync			(__NR_Linux + 157)
-#define __NR_acct			(__NR_Linux + 158)
-#define __NR_settimeofday		(__NR_Linux + 159)
-#define __NR_mount			(__NR_Linux + 160)
-#define __NR_umount2			(__NR_Linux + 161)
-#define __NR_swapon			(__NR_Linux + 162)
-#define __NR_swapoff			(__NR_Linux + 163)
-#define __NR_reboot			(__NR_Linux + 164)
-#define __NR_sethostname		(__NR_Linux + 165)
-#define __NR_setdomainname		(__NR_Linux + 166)
-#define __NR_create_module		(__NR_Linux + 167)
-#define __NR_init_module		(__NR_Linux + 168)
-#define __NR_delete_module		(__NR_Linux + 169)
-#define __NR_get_kernel_syms		(__NR_Linux + 170)
-#define __NR_query_module		(__NR_Linux + 171)
-#define __NR_quotactl			(__NR_Linux + 172)
-#define __NR_nfsservctl			(__NR_Linux + 173)
-#define __NR_getpmsg			(__NR_Linux + 174)
-#define __NR_putpmsg			(__NR_Linux + 175)
-#define __NR_afs_syscall		(__NR_Linux + 176)
-#define __NR_reserved177		(__NR_Linux + 177)
-#define __NR_gettid			(__NR_Linux + 178)
-#define __NR_readahead			(__NR_Linux + 179)
-#define __NR_setxattr			(__NR_Linux + 180)
-#define __NR_lsetxattr			(__NR_Linux + 181)
-#define __NR_fsetxattr			(__NR_Linux + 182)
-#define __NR_getxattr			(__NR_Linux + 183)
-#define __NR_lgetxattr			(__NR_Linux + 184)
-#define __NR_fgetxattr			(__NR_Linux + 185)
-#define __NR_listxattr			(__NR_Linux + 186)
-#define __NR_llistxattr			(__NR_Linux + 187)
-#define __NR_flistxattr			(__NR_Linux + 188)
-#define __NR_removexattr		(__NR_Linux + 189)
-#define __NR_lremovexattr		(__NR_Linux + 190)
-#define __NR_fremovexattr		(__NR_Linux + 191)
-#define __NR_tkill			(__NR_Linux + 192)
-#define __NR_reserved193		(__NR_Linux + 193)
-#define __NR_futex			(__NR_Linux + 194)
-#define __NR_sched_setaffinity		(__NR_Linux + 195)
-#define __NR_sched_getaffinity		(__NR_Linux + 196)
-#define __NR_cacheflush			(__NR_Linux + 197)
-#define __NR_cachectl			(__NR_Linux + 198)
-#define __NR_sysmips			(__NR_Linux + 199)
-#define __NR_io_setup			(__NR_Linux + 200)
-#define __NR_io_destroy			(__NR_Linux + 201)
-#define __NR_io_getevents		(__NR_Linux + 202)
-#define __NR_io_submit			(__NR_Linux + 203)
-#define __NR_io_cancel			(__NR_Linux + 204)
-#define __NR_exit_group			(__NR_Linux + 205)
-#define __NR_lookup_dcookie		(__NR_Linux + 206)
-#define __NR_epoll_create		(__NR_Linux + 207)
-#define __NR_epoll_ctl			(__NR_Linux + 208)
-#define __NR_epoll_wait			(__NR_Linux + 209)
-#define __NR_remap_file_pages		(__NR_Linux + 210)
-#define __NR_rt_sigreturn		(__NR_Linux + 211)
-#define __NR_fcntl64			(__NR_Linux + 212)
-#define __NR_set_tid_address		(__NR_Linux + 213)
-#define __NR_restart_syscall		(__NR_Linux + 214)
-#define __NR_semtimedop			(__NR_Linux + 215)
-#define __NR_fadvise64			(__NR_Linux + 216)
-#define __NR_statfs64			(__NR_Linux + 217)
-#define __NR_fstatfs64			(__NR_Linux + 218)
-#define __NR_sendfile64			(__NR_Linux + 219)
-#define __NR_timer_create		(__NR_Linux + 220)
-#define __NR_timer_settime		(__NR_Linux + 221)
-#define __NR_timer_gettime		(__NR_Linux + 222)
-#define __NR_timer_getoverrun		(__NR_Linux + 223)
-#define __NR_timer_delete		(__NR_Linux + 224)
-#define __NR_clock_settime		(__NR_Linux + 225)
-#define __NR_clock_gettime		(__NR_Linux + 226)
-#define __NR_clock_getres		(__NR_Linux + 227)
-#define __NR_clock_nanosleep		(__NR_Linux + 228)
-#define __NR_tgkill			(__NR_Linux + 229)
-#define __NR_utimes			(__NR_Linux + 230)
-#define __NR_mbind			(__NR_Linux + 231)
-#define __NR_get_mempolicy		(__NR_Linux + 232)
-#define __NR_set_mempolicy		(__NR_Linux + 233)
-#define __NR_mq_open			(__NR_Linux + 234)
-#define __NR_mq_unlink			(__NR_Linux + 235)
-#define __NR_mq_timedsend		(__NR_Linux + 236)
-#define __NR_mq_timedreceive		(__NR_Linux + 237)
-#define __NR_mq_notify			(__NR_Linux + 238)
-#define __NR_mq_getsetattr		(__NR_Linux + 239)
-#define __NR_vserver			(__NR_Linux + 240)
-#define __NR_waitid			(__NR_Linux + 241)
-/* #define __NR_sys_setaltroot		(__NR_Linux + 242) */
-#define __NR_add_key			(__NR_Linux + 243)
-#define __NR_request_key		(__NR_Linux + 244)
-#define __NR_keyctl			(__NR_Linux + 245)
-#define __NR_set_thread_area		(__NR_Linux + 246)
-#define __NR_inotify_init		(__NR_Linux + 247)
-#define __NR_inotify_add_watch		(__NR_Linux + 248)
-#define __NR_inotify_rm_watch		(__NR_Linux + 249)
-#define __NR_migrate_pages		(__NR_Linux + 250)
-#define __NR_openat			(__NR_Linux + 251)
-#define __NR_mkdirat			(__NR_Linux + 252)
-#define __NR_mknodat			(__NR_Linux + 253)
-#define __NR_fchownat			(__NR_Linux + 254)
-#define __NR_futimesat			(__NR_Linux + 255)
-#define __NR_newfstatat			(__NR_Linux + 256)
-#define __NR_unlinkat			(__NR_Linux + 257)
-#define __NR_renameat			(__NR_Linux + 258)
-#define __NR_linkat			(__NR_Linux + 259)
-#define __NR_symlinkat			(__NR_Linux + 260)
-#define __NR_readlinkat			(__NR_Linux + 261)
-#define __NR_fchmodat			(__NR_Linux + 262)
-#define __NR_faccessat			(__NR_Linux + 263)
-#define __NR_pselect6			(__NR_Linux + 264)
-#define __NR_ppoll			(__NR_Linux + 265)
-#define __NR_unshare			(__NR_Linux + 266)
-#define __NR_splice			(__NR_Linux + 267)
-#define __NR_sync_file_range		(__NR_Linux + 268)
-#define __NR_tee			(__NR_Linux + 269)
-#define __NR_vmsplice			(__NR_Linux + 270)
-#define __NR_move_pages			(__NR_Linux + 271)
-#define __NR_set_robust_list		(__NR_Linux + 272)
-#define __NR_get_robust_list		(__NR_Linux + 273)
-#define __NR_kexec_load			(__NR_Linux + 274)
-#define __NR_getcpu			(__NR_Linux + 275)
-#define __NR_epoll_pwait		(__NR_Linux + 276)
-#define __NR_ioprio_set			(__NR_Linux + 277)
-#define __NR_ioprio_get			(__NR_Linux + 278)
-#define __NR_utimensat			(__NR_Linux + 279)
-#define __NR_signalfd			(__NR_Linux + 280)
-#define __NR_timerfd			(__NR_Linux + 281)
-#define __NR_eventfd			(__NR_Linux + 282)
-#define __NR_fallocate			(__NR_Linux + 283)
-#define __NR_timerfd_create		(__NR_Linux + 284)
-#define __NR_timerfd_gettime		(__NR_Linux + 285)
-#define __NR_timerfd_settime		(__NR_Linux + 286)
-#define __NR_signalfd4			(__NR_Linux + 287)
-#define __NR_eventfd2			(__NR_Linux + 288)
-#define __NR_epoll_create1		(__NR_Linux + 289)
-#define __NR_dup3			(__NR_Linux + 290)
-#define __NR_pipe2			(__NR_Linux + 291)
-#define __NR_inotify_init1		(__NR_Linux + 292)
-#define __NR_preadv			(__NR_Linux + 293)
-#define __NR_pwritev			(__NR_Linux + 294)
-#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 295)
-#define __NR_perf_event_open		(__NR_Linux + 296)
-#define __NR_accept4			(__NR_Linux + 297)
-#define __NR_recvmmsg			(__NR_Linux + 298)
-#define __NR_getdents64			(__NR_Linux + 299)
-#define __NR_fanotify_init		(__NR_Linux + 300)
-#define __NR_fanotify_mark		(__NR_Linux + 301)
-#define __NR_prlimit64			(__NR_Linux + 302)
-#define __NR_name_to_handle_at		(__NR_Linux + 303)
-#define __NR_open_by_handle_at		(__NR_Linux + 304)
-#define __NR_clock_adjtime		(__NR_Linux + 305)
-#define __NR_syncfs			(__NR_Linux + 306)
-#define __NR_sendmmsg			(__NR_Linux + 307)
-#define __NR_setns			(__NR_Linux + 308)
-#define __NR_process_vm_readv		(__NR_Linux + 309)
-#define __NR_process_vm_writev		(__NR_Linux + 310)
-#define __NR_kcmp			(__NR_Linux + 311)
-#define __NR_finit_module		(__NR_Linux + 312)
-#define __NR_sched_setattr		(__NR_Linux + 313)
-#define __NR_sched_getattr		(__NR_Linux + 314)
-#define __NR_renameat2			(__NR_Linux + 315)
-#define __NR_seccomp			(__NR_Linux + 316)
-#define __NR_getrandom			(__NR_Linux + 317)
-#define __NR_memfd_create		(__NR_Linux + 318)
-#define __NR_bpf			(__NR_Linux + 319)
-#define __NR_execveat			(__NR_Linux + 320)
-#define __NR_userfaultfd		(__NR_Linux + 321)
-#define __NR_membarrier			(__NR_Linux + 322)
-#define __NR_mlock2			(__NR_Linux + 323)
-#define __NR_copy_file_range		(__NR_Linux + 324)
-#define __NR_preadv2			(__NR_Linux + 325)
-#define __NR_pwritev2			(__NR_Linux + 326)
-#define __NR_pkey_mprotect		(__NR_Linux + 327)
-#define __NR_pkey_alloc			(__NR_Linux + 328)
-#define __NR_pkey_free			(__NR_Linux + 329)
-#define __NR_statx			(__NR_Linux + 330)
-#define __NR_rseq			(__NR_Linux + 331)
-#define __NR_io_pgetevents		(__NR_Linux + 332)
-#define __NR_syscalls                   332
+#define __NR_Linux 6000
+#include <asm/unistd_n32.h>
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		__NR_syscalls
+#define __NR_Linux_syscalls             __NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 91d3c8c..6cefc4d 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -208,387 +208,4 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys_syscall)
 
-	.align	2
-	.type	sys_call_table, @object
-EXPORT(sys_call_table)
-	PTR	sys_syscall			/* 4000 */
-	PTR	sys_exit
-	PTR	__sys_fork
-	PTR	sys_read
-	PTR	sys_write
-	PTR	sys_open			/* 4005 */
-	PTR	sys_close
-	PTR	sys_waitpid
-	PTR	sys_creat
-	PTR	sys_link
-	PTR	sys_unlink			/* 4010 */
-	PTR	sys_execve
-	PTR	sys_chdir
-	PTR	sys_time
-	PTR	sys_mknod
-	PTR	sys_chmod			/* 4015 */
-	PTR	sys_lchown
-	PTR	sys_ni_syscall
-	PTR	sys_ni_syscall			/* was sys_stat */
-	PTR	sys_lseek
-	PTR	sys_getpid			/* 4020 */
-	PTR	sys_mount
-	PTR	sys_oldumount
-	PTR	sys_setuid
-	PTR	sys_getuid
-	PTR	sys_stime			/* 4025 */
-	PTR	sys_ptrace
-	PTR	sys_alarm
-	PTR	sys_ni_syscall			/* was sys_fstat */
-	PTR	sys_pause
-	PTR	sys_utime			/* 4030 */
-	PTR	sys_ni_syscall
-	PTR	sys_ni_syscall
-	PTR	sys_access
-	PTR	sys_nice
-	PTR	sys_ni_syscall			/* 4035 */
-	PTR	sys_sync
-	PTR	sys_kill
-	PTR	sys_rename
-	PTR	sys_mkdir
-	PTR	sys_rmdir			/* 4040 */
-	PTR	sys_dup
-	PTR	sysm_pipe
-	PTR	sys_times
-	PTR	sys_ni_syscall
-	PTR	sys_brk				/* 4045 */
-	PTR	sys_setgid
-	PTR	sys_getgid
-	PTR	sys_ni_syscall			/* was signal(2) */
-	PTR	sys_geteuid
-	PTR	sys_getegid			/* 4050 */
-	PTR	sys_acct
-	PTR	sys_umount
-	PTR	sys_ni_syscall
-	PTR	sys_ioctl
-	PTR	sys_fcntl			/* 4055 */
-	PTR	sys_ni_syscall
-	PTR	sys_setpgid
-	PTR	sys_ni_syscall
-	PTR	sys_olduname
-	PTR	sys_umask			/* 4060 */
-	PTR	sys_chroot
-	PTR	sys_ustat
-	PTR	sys_dup2
-	PTR	sys_getppid
-	PTR	sys_getpgrp			/* 4065 */
-	PTR	sys_setsid
-	PTR	sys_sigaction
-	PTR	sys_sgetmask
-	PTR	sys_ssetmask
-	PTR	sys_setreuid			/* 4070 */
-	PTR	sys_setregid
-	PTR	sys_sigsuspend
-	PTR	sys_sigpending
-	PTR	sys_sethostname
-	PTR	sys_setrlimit			/* 4075 */
-	PTR	sys_getrlimit
-	PTR	sys_getrusage
-	PTR	sys_gettimeofday
-	PTR	sys_settimeofday
-	PTR	sys_getgroups			/* 4080 */
-	PTR	sys_setgroups
-	PTR	sys_ni_syscall			/* old_select */
-	PTR	sys_symlink
-	PTR	sys_ni_syscall			/* was sys_lstat */
-	PTR	sys_readlink			/* 4085 */
-	PTR	sys_uselib
-	PTR	sys_swapon
-	PTR	sys_reboot
-	PTR	sys_old_readdir
-	PTR	sys_mips_mmap			/* 4090 */
-	PTR	sys_munmap
-	PTR	sys_truncate
-	PTR	sys_ftruncate
-	PTR	sys_fchmod
-	PTR	sys_fchown			/* 4095 */
-	PTR	sys_getpriority
-	PTR	sys_setpriority
-	PTR	sys_ni_syscall
-	PTR	sys_statfs
-	PTR	sys_fstatfs			/* 4100 */
-	PTR	sys_ni_syscall			/* was ioperm(2) */
-	PTR	sys_socketcall
-	PTR	sys_syslog
-	PTR	sys_setitimer
-	PTR	sys_getitimer			/* 4105 */
-	PTR	sys_newstat
-	PTR	sys_newlstat
-	PTR	sys_newfstat
-	PTR	sys_uname
-	PTR	sys_ni_syscall			/* 4110 was iopl(2) */
-	PTR	sys_vhangup
-	PTR	sys_ni_syscall			/* was sys_idle() */
-	PTR	sys_ni_syscall			/* was sys_vm86 */
-	PTR	sys_wait4
-	PTR	sys_swapoff			/* 4115 */
-	PTR	sys_sysinfo
-	PTR	sys_ipc
-	PTR	sys_fsync
-	PTR	sys_sigreturn
-	PTR	__sys_clone			/* 4120 */
-	PTR	sys_setdomainname
-	PTR	sys_newuname
-	PTR	sys_ni_syscall			/* sys_modify_ldt */
-	PTR	sys_adjtimex
-	PTR	sys_mprotect			/* 4125 */
-	PTR	sys_sigprocmask
-	PTR	sys_ni_syscall			/* was create_module */
-	PTR	sys_init_module
-	PTR	sys_delete_module
-	PTR	sys_ni_syscall			/* 4130 was get_kernel_syms */
-	PTR	sys_quotactl
-	PTR	sys_getpgid
-	PTR	sys_fchdir
-	PTR	sys_bdflush
-	PTR	sys_sysfs			/* 4135 */
-	PTR	sys_personality
-	PTR	sys_ni_syscall			/* for afs_syscall */
-	PTR	sys_setfsuid
-	PTR	sys_setfsgid
-	PTR	sys_llseek			/* 4140 */
-	PTR	sys_getdents
-	PTR	sys_select
-	PTR	sys_flock
-	PTR	sys_msync
-	PTR	sys_readv			/* 4145 */
-	PTR	sys_writev
-	PTR	sys_cacheflush
-	PTR	sys_cachectl
-	PTR	__sys_sysmips
-	PTR	sys_ni_syscall			/* 4150 */
-	PTR	sys_getsid
-	PTR	sys_fdatasync
-	PTR	sys_sysctl
-	PTR	sys_mlock
-	PTR	sys_munlock			/* 4155 */
-	PTR	sys_mlockall
-	PTR	sys_munlockall
-	PTR	sys_sched_setparam
-	PTR	sys_sched_getparam
-	PTR	sys_sched_setscheduler		/* 4160 */
-	PTR	sys_sched_getscheduler
-	PTR	sys_sched_yield
-	PTR	sys_sched_get_priority_max
-	PTR	sys_sched_get_priority_min
-	PTR	sys_sched_rr_get_interval	/* 4165 */
-	PTR	sys_nanosleep
-	PTR	sys_mremap
-	PTR	sys_accept
-	PTR	sys_bind
-	PTR	sys_connect			/* 4170 */
-	PTR	sys_getpeername
-	PTR	sys_getsockname
-	PTR	sys_getsockopt
-	PTR	sys_listen
-	PTR	sys_recv			/* 4175 */
-	PTR	sys_recvfrom
-	PTR	sys_recvmsg
-	PTR	sys_send
-	PTR	sys_sendmsg
-	PTR	sys_sendto			/* 4180 */
-	PTR	sys_setsockopt
-	PTR	sys_shutdown
-	PTR	sys_socket
-	PTR	sys_socketpair
-	PTR	sys_setresuid			/* 4185 */
-	PTR	sys_getresuid
-	PTR	sys_ni_syscall			/* was sys_query_module */
-	PTR	sys_poll
-	PTR	sys_ni_syscall			/* was nfsservctl */
-	PTR	sys_setresgid			/* 4190 */
-	PTR	sys_getresgid
-	PTR	sys_prctl
-	PTR	sys_rt_sigreturn
-	PTR	sys_rt_sigaction
-	PTR	sys_rt_sigprocmask		/* 4195 */
-	PTR	sys_rt_sigpending
-	PTR	sys_rt_sigtimedwait
-	PTR	sys_rt_sigqueueinfo
-	PTR	sys_rt_sigsuspend
-	PTR	sys_pread64			/* 4200 */
-	PTR	sys_pwrite64
-	PTR	sys_chown
-	PTR	sys_getcwd
-	PTR	sys_capget
-	PTR	sys_capset			/* 4205 */
-	PTR	sys_sigaltstack
-	PTR	sys_sendfile
-	PTR	sys_ni_syscall
-	PTR	sys_ni_syscall
-	PTR	sys_mips_mmap2			/* 4210 */
-	PTR	sys_truncate64
-	PTR	sys_ftruncate64
-	PTR	sys_stat64
-	PTR	sys_lstat64
-	PTR	sys_fstat64			/* 4215 */
-	PTR	sys_pivot_root
-	PTR	sys_mincore
-	PTR	sys_madvise
-	PTR	sys_getdents64
-	PTR	sys_fcntl64			/* 4220 */
-	PTR	sys_ni_syscall
-	PTR	sys_gettid
-	PTR	sys_readahead
-	PTR	sys_setxattr
-	PTR	sys_lsetxattr			/* 4225 */
-	PTR	sys_fsetxattr
-	PTR	sys_getxattr
-	PTR	sys_lgetxattr
-	PTR	sys_fgetxattr
-	PTR	sys_listxattr			/* 4230 */
-	PTR	sys_llistxattr
-	PTR	sys_flistxattr
-	PTR	sys_removexattr
-	PTR	sys_lremovexattr
-	PTR	sys_fremovexattr		/* 4235 */
-	PTR	sys_tkill
-	PTR	sys_sendfile64
-	PTR	sys_futex
-#ifdef CONFIG_MIPS_MT_FPAFF
-	/*
-	 * For FPU affinity scheduling on MIPS MT processors, we need to
-	 * intercept sys_sched_xxxaffinity() calls until we get a proper hook
-	 * in kernel/sched/core.c.  Considered only temporary we only support
-	 * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
-	 * atm.
-	 */
-	PTR	mipsmt_sys_sched_setaffinity
-	PTR	mipsmt_sys_sched_getaffinity
-#else
-	PTR	sys_sched_setaffinity
-	PTR	sys_sched_getaffinity		/* 4240 */
-#endif /* CONFIG_MIPS_MT_FPAFF */
-	PTR	sys_io_setup
-	PTR	sys_io_destroy
-	PTR	sys_io_getevents
-	PTR	sys_io_submit
-	PTR	sys_io_cancel			/* 4245 */
-	PTR	sys_exit_group
-	PTR	sys_lookup_dcookie
-	PTR	sys_epoll_create
-	PTR	sys_epoll_ctl
-	PTR	sys_epoll_wait			/* 4250 */
-	PTR	sys_remap_file_pages
-	PTR	sys_set_tid_address
-	PTR	sys_restart_syscall
-	PTR	sys_fadvise64_64
-	PTR	sys_statfs64			/* 4255 */
-	PTR	sys_fstatfs64
-	PTR	sys_timer_create
-	PTR	sys_timer_settime
-	PTR	sys_timer_gettime
-	PTR	sys_timer_getoverrun		/* 4260 */
-	PTR	sys_timer_delete
-	PTR	sys_clock_settime
-	PTR	sys_clock_gettime
-	PTR	sys_clock_getres
-	PTR	sys_clock_nanosleep		/* 4265 */
-	PTR	sys_tgkill
-	PTR	sys_utimes
-	PTR	sys_mbind
-	PTR	sys_get_mempolicy
-	PTR	sys_set_mempolicy		/* 4270 */
-	PTR	sys_mq_open
-	PTR	sys_mq_unlink
-	PTR	sys_mq_timedsend
-	PTR	sys_mq_timedreceive
-	PTR	sys_mq_notify			/* 4275 */
-	PTR	sys_mq_getsetattr
-	PTR	sys_ni_syscall			/* sys_vserver */
-	PTR	sys_waitid
-	PTR	sys_ni_syscall			/* available, was setaltroot */
-	PTR	sys_add_key			/* 4280 */
-	PTR	sys_request_key
-	PTR	sys_keyctl
-	PTR	sys_set_thread_area
-	PTR	sys_inotify_init
-	PTR	sys_inotify_add_watch		/* 4285 */
-	PTR	sys_inotify_rm_watch
-	PTR	sys_migrate_pages
-	PTR	sys_openat
-	PTR	sys_mkdirat
-	PTR	sys_mknodat			/* 4290 */
-	PTR	sys_fchownat
-	PTR	sys_futimesat
-	PTR	sys_fstatat64
-	PTR	sys_unlinkat
-	PTR	sys_renameat			/* 4295 */
-	PTR	sys_linkat
-	PTR	sys_symlinkat
-	PTR	sys_readlinkat
-	PTR	sys_fchmodat
-	PTR	sys_faccessat			/* 4300 */
-	PTR	sys_pselect6
-	PTR	sys_ppoll
-	PTR	sys_unshare
-	PTR	sys_splice
-	PTR	sys_sync_file_range		/* 4305 */
-	PTR	sys_tee
-	PTR	sys_vmsplice
-	PTR	sys_move_pages
-	PTR	sys_set_robust_list
-	PTR	sys_get_robust_list		/* 4310 */
-	PTR	sys_kexec_load
-	PTR	sys_getcpu
-	PTR	sys_epoll_pwait
-	PTR	sys_ioprio_set
-	PTR	sys_ioprio_get			/* 4315 */
-	PTR	sys_utimensat
-	PTR	sys_signalfd
-	PTR	sys_ni_syscall			/* was timerfd */
-	PTR	sys_eventfd
-	PTR	sys_fallocate			/* 4320 */
-	PTR	sys_timerfd_create
-	PTR	sys_timerfd_gettime
-	PTR	sys_timerfd_settime
-	PTR	sys_signalfd4
-	PTR	sys_eventfd2			/* 4325 */
-	PTR	sys_epoll_create1
-	PTR	sys_dup3
-	PTR	sys_pipe2
-	PTR	sys_inotify_init1
-	PTR	sys_preadv			/* 4330 */
-	PTR	sys_pwritev
-	PTR	sys_rt_tgsigqueueinfo
-	PTR	sys_perf_event_open
-	PTR	sys_accept4
-	PTR	sys_recvmmsg			/* 4335 */
-	PTR	sys_fanotify_init
-	PTR	sys_fanotify_mark
-	PTR	sys_prlimit64
-	PTR	sys_name_to_handle_at
-	PTR	sys_open_by_handle_at		/* 4340 */
-	PTR	sys_clock_adjtime
-	PTR	sys_syncfs
-	PTR	sys_sendmmsg
-	PTR	sys_setns
-	PTR	sys_process_vm_readv		/* 4345 */
-	PTR	sys_process_vm_writev
-	PTR	sys_kcmp
-	PTR	sys_finit_module
-	PTR	sys_sched_setattr
-	PTR	sys_sched_getattr		/* 4350 */
-	PTR	sys_renameat2
-	PTR	sys_seccomp
-	PTR	sys_getrandom
-	PTR	sys_memfd_create
-	PTR	sys_bpf				/* 4355 */
-	PTR	sys_execveat
-	PTR	sys_userfaultfd
-	PTR	sys_membarrier
-	PTR	sys_mlock2
-	PTR	sys_copy_file_range		/* 4360 */
-	PTR	sys_preadv2
-	PTR	sys_pwritev2
-	PTR	sys_pkey_mprotect
-	PTR	sys_pkey_alloc
-	PTR	sys_pkey_free			/* 4365 */
-	PTR	sys_statx
-	PTR	sys_rseq
-	PTR	sys_io_pgetevents
+#include "syscall_table_32_o32.S"
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 358d959..bcc31de 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -109,336 +109,4 @@ illegal_syscall:
 	j	n64_syscall_exit
 	END(handle_sys64)
 
-	.align	3
-	.type	sys_call_table, @object
-EXPORT(sys_call_table)
-	PTR	sys_read			/* 5000 */
-	PTR	sys_write
-	PTR	sys_open
-	PTR	sys_close
-	PTR	sys_newstat
-	PTR	sys_newfstat			/* 5005 */
-	PTR	sys_newlstat
-	PTR	sys_poll
-	PTR	sys_lseek
-	PTR	sys_mips_mmap
-	PTR	sys_mprotect			/* 5010 */
-	PTR	sys_munmap
-	PTR	sys_brk
-	PTR	sys_rt_sigaction
-	PTR	sys_rt_sigprocmask
-	PTR	sys_ioctl			/* 5015 */
-	PTR	sys_pread64
-	PTR	sys_pwrite64
-	PTR	sys_readv
-	PTR	sys_writev
-	PTR	sys_access			/* 5020 */
-	PTR	sysm_pipe
-	PTR	sys_select
-	PTR	sys_sched_yield
-	PTR	sys_mremap
-	PTR	sys_msync			/* 5025 */
-	PTR	sys_mincore
-	PTR	sys_madvise
-	PTR	sys_shmget
-	PTR	sys_shmat
-	PTR	sys_shmctl			/* 5030 */
-	PTR	sys_dup
-	PTR	sys_dup2
-	PTR	sys_pause
-	PTR	sys_nanosleep
-	PTR	sys_getitimer			/* 5035 */
-	PTR	sys_setitimer
-	PTR	sys_alarm
-	PTR	sys_getpid
-	PTR	sys_sendfile64
-	PTR	sys_socket			/* 5040 */
-	PTR	sys_connect
-	PTR	sys_accept
-	PTR	sys_sendto
-	PTR	sys_recvfrom
-	PTR	sys_sendmsg			/* 5045 */
-	PTR	sys_recvmsg
-	PTR	sys_shutdown
-	PTR	sys_bind
-	PTR	sys_listen
-	PTR	sys_getsockname			/* 5050 */
-	PTR	sys_getpeername
-	PTR	sys_socketpair
-	PTR	sys_setsockopt
-	PTR	sys_getsockopt
-	PTR	__sys_clone			/* 5055 */
-	PTR	__sys_fork
-	PTR	sys_execve
-	PTR	sys_exit
-	PTR	sys_wait4
-	PTR	sys_kill			/* 5060 */
-	PTR	sys_newuname
-	PTR	sys_semget
-	PTR	sys_semop
-	PTR	sys_semctl
-	PTR	sys_shmdt			/* 5065 */
-	PTR	sys_msgget
-	PTR	sys_msgsnd
-	PTR	sys_msgrcv
-	PTR	sys_msgctl
-	PTR	sys_fcntl			/* 5070 */
-	PTR	sys_flock
-	PTR	sys_fsync
-	PTR	sys_fdatasync
-	PTR	sys_truncate
-	PTR	sys_ftruncate			/* 5075 */
-	PTR	sys_getdents
-	PTR	sys_getcwd
-	PTR	sys_chdir
-	PTR	sys_fchdir
-	PTR	sys_rename			/* 5080 */
-	PTR	sys_mkdir
-	PTR	sys_rmdir
-	PTR	sys_creat
-	PTR	sys_link
-	PTR	sys_unlink			/* 5085 */
-	PTR	sys_symlink
-	PTR	sys_readlink
-	PTR	sys_chmod
-	PTR	sys_fchmod
-	PTR	sys_chown			/* 5090 */
-	PTR	sys_fchown
-	PTR	sys_lchown
-	PTR	sys_umask
-	PTR	sys_gettimeofday
-	PTR	sys_getrlimit			/* 5095 */
-	PTR	sys_getrusage
-	PTR	sys_sysinfo
-	PTR	sys_times
-	PTR	sys_ptrace
-	PTR	sys_getuid			/* 5100 */
-	PTR	sys_syslog
-	PTR	sys_getgid
-	PTR	sys_setuid
-	PTR	sys_setgid
-	PTR	sys_geteuid			/* 5105 */
-	PTR	sys_getegid
-	PTR	sys_setpgid
-	PTR	sys_getppid
-	PTR	sys_getpgrp
-	PTR	sys_setsid			/* 5110 */
-	PTR	sys_setreuid
-	PTR	sys_setregid
-	PTR	sys_getgroups
-	PTR	sys_setgroups
-	PTR	sys_setresuid			/* 5115 */
-	PTR	sys_getresuid
-	PTR	sys_setresgid
-	PTR	sys_getresgid
-	PTR	sys_getpgid
-	PTR	sys_setfsuid			/* 5120 */
-	PTR	sys_setfsgid
-	PTR	sys_getsid
-	PTR	sys_capget
-	PTR	sys_capset
-	PTR	sys_rt_sigpending		/* 5125 */
-	PTR	sys_rt_sigtimedwait
-	PTR	sys_rt_sigqueueinfo
-	PTR	sys_rt_sigsuspend
-	PTR	sys_sigaltstack
-	PTR	sys_utime			/* 5130 */
-	PTR	sys_mknod
-	PTR	sys_personality
-	PTR	sys_ustat
-	PTR	sys_statfs
-	PTR	sys_fstatfs			/* 5135 */
-	PTR	sys_sysfs
-	PTR	sys_getpriority
-	PTR	sys_setpriority
-	PTR	sys_sched_setparam
-	PTR	sys_sched_getparam		/* 5140 */
-	PTR	sys_sched_setscheduler
-	PTR	sys_sched_getscheduler
-	PTR	sys_sched_get_priority_max
-	PTR	sys_sched_get_priority_min
-	PTR	sys_sched_rr_get_interval	/* 5145 */
-	PTR	sys_mlock
-	PTR	sys_munlock
-	PTR	sys_mlockall
-	PTR	sys_munlockall
-	PTR	sys_vhangup			/* 5150 */
-	PTR	sys_pivot_root
-	PTR	sys_sysctl
-	PTR	sys_prctl
-	PTR	sys_adjtimex
-	PTR	sys_setrlimit			/* 5155 */
-	PTR	sys_chroot
-	PTR	sys_sync
-	PTR	sys_acct
-	PTR	sys_settimeofday
-	PTR	sys_mount			/* 5160 */
-	PTR	sys_umount
-	PTR	sys_swapon
-	PTR	sys_swapoff
-	PTR	sys_reboot
-	PTR	sys_sethostname			/* 5165 */
-	PTR	sys_setdomainname
-	PTR	sys_ni_syscall			/* was create_module */
-	PTR	sys_init_module
-	PTR	sys_delete_module
-	PTR	sys_ni_syscall			/* 5170, was get_kernel_syms */
-	PTR	sys_ni_syscall			/* was query_module */
-	PTR	sys_quotactl
-	PTR	sys_ni_syscall			/* was nfsservctl */
-	PTR	sys_ni_syscall			/* res. for getpmsg */
-	PTR	sys_ni_syscall			/* 5175	 for putpmsg */
-	PTR	sys_ni_syscall			/* res. for afs_syscall */
-	PTR	sys_ni_syscall			/* res. for security */
-	PTR	sys_gettid
-	PTR	sys_readahead
-	PTR	sys_setxattr			/* 5180 */
-	PTR	sys_lsetxattr
-	PTR	sys_fsetxattr
-	PTR	sys_getxattr
-	PTR	sys_lgetxattr
-	PTR	sys_fgetxattr			/* 5185 */
-	PTR	sys_listxattr
-	PTR	sys_llistxattr
-	PTR	sys_flistxattr
-	PTR	sys_removexattr
-	PTR	sys_lremovexattr		/* 5190 */
-	PTR	sys_fremovexattr
-	PTR	sys_tkill
-	PTR	sys_ni_syscall
-	PTR	sys_futex
-	PTR	sys_sched_setaffinity		/* 5195 */
-	PTR	sys_sched_getaffinity
-	PTR	sys_cacheflush
-	PTR	sys_cachectl
-	PTR	__sys_sysmips
-	PTR	sys_io_setup			/* 5200 */
-	PTR	sys_io_destroy
-	PTR	sys_io_getevents
-	PTR	sys_io_submit
-	PTR	sys_io_cancel
-	PTR	sys_exit_group			/* 5205 */
-	PTR	sys_lookup_dcookie
-	PTR	sys_epoll_create
-	PTR	sys_epoll_ctl
-	PTR	sys_epoll_wait
-	PTR	sys_remap_file_pages		/* 5210 */
-	PTR	sys_rt_sigreturn
-	PTR	sys_set_tid_address
-	PTR	sys_restart_syscall
-	PTR	sys_semtimedop
-	PTR	sys_fadvise64_64		/* 5215 */
-	PTR	sys_timer_create
-	PTR	sys_timer_settime
-	PTR	sys_timer_gettime
-	PTR	sys_timer_getoverrun
-	PTR	sys_timer_delete		/* 5220 */
-	PTR	sys_clock_settime
-	PTR	sys_clock_gettime
-	PTR	sys_clock_getres
-	PTR	sys_clock_nanosleep
-	PTR	sys_tgkill			/* 5225 */
-	PTR	sys_utimes
-	PTR	sys_mbind
-	PTR	sys_get_mempolicy
-	PTR	sys_set_mempolicy
-	PTR	sys_mq_open			/* 5230 */
-	PTR	sys_mq_unlink
-	PTR	sys_mq_timedsend
-	PTR	sys_mq_timedreceive
-	PTR	sys_mq_notify
-	PTR	sys_mq_getsetattr		/* 5235 */
-	PTR	sys_ni_syscall			/* sys_vserver */
-	PTR	sys_waitid
-	PTR	sys_ni_syscall			/* available, was setaltroot */
-	PTR	sys_add_key
-	PTR	sys_request_key			/* 5240 */
-	PTR	sys_keyctl
-	PTR	sys_set_thread_area
-	PTR	sys_inotify_init
-	PTR	sys_inotify_add_watch
-	PTR	sys_inotify_rm_watch		/* 5245 */
-	PTR	sys_migrate_pages
-	PTR	sys_openat
-	PTR	sys_mkdirat
-	PTR	sys_mknodat
-	PTR	sys_fchownat			/* 5250 */
-	PTR	sys_futimesat
-	PTR	sys_newfstatat
-	PTR	sys_unlinkat
-	PTR	sys_renameat
-	PTR	sys_linkat			/* 5255 */
-	PTR	sys_symlinkat
-	PTR	sys_readlinkat
-	PTR	sys_fchmodat
-	PTR	sys_faccessat
-	PTR	sys_pselect6			/* 5260 */
-	PTR	sys_ppoll
-	PTR	sys_unshare
-	PTR	sys_splice
-	PTR	sys_sync_file_range
-	PTR	sys_tee				/* 5265 */
-	PTR	sys_vmsplice
-	PTR	sys_move_pages
-	PTR	sys_set_robust_list
-	PTR	sys_get_robust_list
-	PTR	sys_kexec_load			/* 5270 */
-	PTR	sys_getcpu
-	PTR	sys_epoll_pwait
-	PTR	sys_ioprio_set
-	PTR	sys_ioprio_get
-	PTR	sys_utimensat			/* 5275 */
-	PTR	sys_signalfd
-	PTR	sys_ni_syscall			/* was timerfd */
-	PTR	sys_eventfd
-	PTR	sys_fallocate
-	PTR	sys_timerfd_create		/* 5280 */
-	PTR	sys_timerfd_gettime
-	PTR	sys_timerfd_settime
-	PTR	sys_signalfd4
-	PTR	sys_eventfd2
-	PTR	sys_epoll_create1		/* 5285 */
-	PTR	sys_dup3
-	PTR	sys_pipe2
-	PTR	sys_inotify_init1
-	PTR	sys_preadv
-	PTR	sys_pwritev			/* 5290 */
-	PTR	sys_rt_tgsigqueueinfo
-	PTR	sys_perf_event_open
-	PTR	sys_accept4
-	PTR	sys_recvmmsg
-	PTR	sys_fanotify_init		/* 5295 */
-	PTR	sys_fanotify_mark
-	PTR	sys_prlimit64
-	PTR	sys_name_to_handle_at
-	PTR	sys_open_by_handle_at
-	PTR	sys_clock_adjtime		/* 5300 */
-	PTR	sys_syncfs
-	PTR	sys_sendmmsg
-	PTR	sys_setns
-	PTR	sys_process_vm_readv
-	PTR	sys_process_vm_writev		/* 5305 */
-	PTR	sys_kcmp
-	PTR	sys_finit_module
-	PTR	sys_getdents64
-	PTR	sys_sched_setattr
-	PTR	sys_sched_getattr		/* 5310 */
-	PTR	sys_renameat2
-	PTR	sys_seccomp
-	PTR	sys_getrandom
-	PTR	sys_memfd_create
-	PTR	sys_bpf				/* 5315 */
-	PTR	sys_execveat
-	PTR	sys_userfaultfd
-	PTR	sys_membarrier
-	PTR	sys_mlock2
-	PTR	sys_copy_file_range		/* 5320 */
-	PTR	sys_preadv2
-	PTR	sys_pwritev2
-	PTR	sys_pkey_mprotect
-	PTR	sys_pkey_alloc
-	PTR	sys_pkey_free			/* 5325 */
-	PTR	sys_statx
-	PTR	sys_rseq
-	PTR	sys_io_pgetevents
-	.size	sys_call_table,.-sys_call_table
+#include "syscall_table_64_64.S"
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c65eaac..33c0376 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -101,339 +101,4 @@ not_n32_scall:
 
 	END(handle_sysn32)
 
-	.type	sysn32_call_table, @object
-EXPORT(sysn32_call_table)
-	PTR	sys_read			/* 6000 */
-	PTR	sys_write
-	PTR	sys_open
-	PTR	sys_close
-	PTR	sys_newstat
-	PTR	sys_newfstat			/* 6005 */
-	PTR	sys_newlstat
-	PTR	sys_poll
-	PTR	sys_lseek
-	PTR	sys_mips_mmap
-	PTR	sys_mprotect			/* 6010 */
-	PTR	sys_munmap
-	PTR	sys_brk
-	PTR	compat_sys_rt_sigaction
-	PTR	compat_sys_rt_sigprocmask
-	PTR	compat_sys_ioctl		/* 6015 */
-	PTR	sys_pread64
-	PTR	sys_pwrite64
-	PTR	compat_sys_readv
-	PTR	compat_sys_writev
-	PTR	sys_access			/* 6020 */
-	PTR	sysm_pipe
-	PTR	compat_sys_select
-	PTR	sys_sched_yield
-	PTR	sys_mremap
-	PTR	sys_msync			/* 6025 */
-	PTR	sys_mincore
-	PTR	sys_madvise
-	PTR	sys_shmget
-	PTR	sys_shmat
-	PTR	compat_sys_shmctl			/* 6030 */
-	PTR	sys_dup
-	PTR	sys_dup2
-	PTR	sys_pause
-	PTR	compat_sys_nanosleep
-	PTR	compat_sys_getitimer		/* 6035 */
-	PTR	compat_sys_setitimer
-	PTR	sys_alarm
-	PTR	sys_getpid
-	PTR	compat_sys_sendfile
-	PTR	sys_socket			/* 6040 */
-	PTR	sys_connect
-	PTR	sys_accept
-	PTR	sys_sendto
-	PTR	compat_sys_recvfrom
-	PTR	compat_sys_sendmsg		/* 6045 */
-	PTR	compat_sys_recvmsg
-	PTR	sys_shutdown
-	PTR	sys_bind
-	PTR	sys_listen
-	PTR	sys_getsockname			/* 6050 */
-	PTR	sys_getpeername
-	PTR	sys_socketpair
-	PTR	compat_sys_setsockopt
-	PTR	compat_sys_getsockopt
-	PTR	__sys_clone			/* 6055 */
-	PTR	__sys_fork
-	PTR	compat_sys_execve
-	PTR	sys_exit
-	PTR	compat_sys_wait4
-	PTR	sys_kill			/* 6060 */
-	PTR	sys_newuname
-	PTR	sys_semget
-	PTR	sys_semop
-	PTR	compat_sys_semctl
-	PTR	sys_shmdt			/* 6065 */
-	PTR	sys_msgget
-	PTR	compat_sys_msgsnd
-	PTR	compat_sys_msgrcv
-	PTR	compat_sys_msgctl
-	PTR	compat_sys_fcntl		/* 6070 */
-	PTR	sys_flock
-	PTR	sys_fsync
-	PTR	sys_fdatasync
-	PTR	sys_truncate
-	PTR	sys_ftruncate			/* 6075 */
-	PTR	compat_sys_getdents
-	PTR	sys_getcwd
-	PTR	sys_chdir
-	PTR	sys_fchdir
-	PTR	sys_rename			/* 6080 */
-	PTR	sys_mkdir
-	PTR	sys_rmdir
-	PTR	sys_creat
-	PTR	sys_link
-	PTR	sys_unlink			/* 6085 */
-	PTR	sys_symlink
-	PTR	sys_readlink
-	PTR	sys_chmod
-	PTR	sys_fchmod
-	PTR	sys_chown			/* 6090 */
-	PTR	sys_fchown
-	PTR	sys_lchown
-	PTR	sys_umask
-	PTR	compat_sys_gettimeofday
-	PTR	compat_sys_getrlimit		/* 6095 */
-	PTR	compat_sys_getrusage
-	PTR	compat_sys_sysinfo
-	PTR	compat_sys_times
-	PTR	compat_sys_ptrace
-	PTR	sys_getuid			/* 6100 */
-	PTR	sys_syslog
-	PTR	sys_getgid
-	PTR	sys_setuid
-	PTR	sys_setgid
-	PTR	sys_geteuid			/* 6105 */
-	PTR	sys_getegid
-	PTR	sys_setpgid
-	PTR	sys_getppid
-	PTR	sys_getpgrp
-	PTR	sys_setsid			/* 6110 */
-	PTR	sys_setreuid
-	PTR	sys_setregid
-	PTR	sys_getgroups
-	PTR	sys_setgroups
-	PTR	sys_setresuid			/* 6115 */
-	PTR	sys_getresuid
-	PTR	sys_setresgid
-	PTR	sys_getresgid
-	PTR	sys_getpgid
-	PTR	sys_setfsuid			/* 6120 */
-	PTR	sys_setfsgid
-	PTR	sys_getsid
-	PTR	sys_capget
-	PTR	sys_capset
-	PTR	compat_sys_rt_sigpending	/* 6125 */
-	PTR	compat_sys_rt_sigtimedwait
-	PTR	compat_sys_rt_sigqueueinfo
-	PTR	compat_sys_rt_sigsuspend
-	PTR	compat_sys_sigaltstack
-	PTR	compat_sys_utime		/* 6130 */
-	PTR	sys_mknod
-	PTR	sys_32_personality
-	PTR	compat_sys_ustat
-	PTR	compat_sys_statfs
-	PTR	compat_sys_fstatfs		/* 6135 */
-	PTR	sys_sysfs
-	PTR	sys_getpriority
-	PTR	sys_setpriority
-	PTR	sys_sched_setparam
-	PTR	sys_sched_getparam		/* 6140 */
-	PTR	sys_sched_setscheduler
-	PTR	sys_sched_getscheduler
-	PTR	sys_sched_get_priority_max
-	PTR	sys_sched_get_priority_min
-	PTR	compat_sys_sched_rr_get_interval	/* 6145 */
-	PTR	sys_mlock
-	PTR	sys_munlock
-	PTR	sys_mlockall
-	PTR	sys_munlockall
-	PTR	sys_vhangup			/* 6150 */
-	PTR	sys_pivot_root
-	PTR	compat_sys_sysctl
-	PTR	sys_prctl
-	PTR	compat_sys_adjtimex
-	PTR	compat_sys_setrlimit		/* 6155 */
-	PTR	sys_chroot
-	PTR	sys_sync
-	PTR	sys_acct
-	PTR	compat_sys_settimeofday
-	PTR	compat_sys_mount		/* 6160 */
-	PTR	sys_umount
-	PTR	sys_swapon
-	PTR	sys_swapoff
-	PTR	sys_reboot
-	PTR	sys_sethostname			/* 6165 */
-	PTR	sys_setdomainname
-	PTR	sys_ni_syscall			/* was create_module */
-	PTR	sys_init_module
-	PTR	sys_delete_module
-	PTR	sys_ni_syscall			/* 6170, was get_kernel_syms */
-	PTR	sys_ni_syscall			/* was query_module */
-	PTR	sys_quotactl
-	PTR	sys_ni_syscall			/* was nfsservctl */
-	PTR	sys_ni_syscall			/* res. for getpmsg */
-	PTR	sys_ni_syscall			/* 6175	 for putpmsg */
-	PTR	sys_ni_syscall			/* res. for afs_syscall */
-	PTR	sys_ni_syscall			/* res. for security */
-	PTR	sys_gettid
-	PTR	sys_readahead
-	PTR	sys_setxattr			/* 6180 */
-	PTR	sys_lsetxattr
-	PTR	sys_fsetxattr
-	PTR	sys_getxattr
-	PTR	sys_lgetxattr
-	PTR	sys_fgetxattr			/* 6185 */
-	PTR	sys_listxattr
-	PTR	sys_llistxattr
-	PTR	sys_flistxattr
-	PTR	sys_removexattr
-	PTR	sys_lremovexattr		/* 6190 */
-	PTR	sys_fremovexattr
-	PTR	sys_tkill
-	PTR	sys_ni_syscall
-	PTR	compat_sys_futex
-	PTR	compat_sys_sched_setaffinity	/* 6195 */
-	PTR	compat_sys_sched_getaffinity
-	PTR	sys_cacheflush
-	PTR	sys_cachectl
-	PTR	__sys_sysmips
-	PTR	compat_sys_io_setup			/* 6200 */
-	PTR	sys_io_destroy
-	PTR	compat_sys_io_getevents
-	PTR	compat_sys_io_submit
-	PTR	sys_io_cancel
-	PTR	sys_exit_group			/* 6205 */
-	PTR	sys_lookup_dcookie
-	PTR	sys_epoll_create
-	PTR	sys_epoll_ctl
-	PTR	sys_epoll_wait
-	PTR	sys_remap_file_pages		/* 6210 */
-	PTR	sysn32_rt_sigreturn
-	PTR	compat_sys_fcntl64
-	PTR	sys_set_tid_address
-	PTR	sys_restart_syscall
-	PTR	compat_sys_semtimedop			/* 6215 */
-	PTR	sys_fadvise64_64
-	PTR	compat_sys_statfs64
-	PTR	compat_sys_fstatfs64
-	PTR	sys_sendfile64
-	PTR	compat_sys_timer_create		/* 6220 */
-	PTR	compat_sys_timer_settime
-	PTR	compat_sys_timer_gettime
-	PTR	sys_timer_getoverrun
-	PTR	sys_timer_delete
-	PTR	compat_sys_clock_settime		/* 6225 */
-	PTR	compat_sys_clock_gettime
-	PTR	compat_sys_clock_getres
-	PTR	compat_sys_clock_nanosleep
-	PTR	sys_tgkill
-	PTR	compat_sys_utimes		/* 6230 */
-	PTR	compat_sys_mbind
-	PTR	compat_sys_get_mempolicy
-	PTR	compat_sys_set_mempolicy
-	PTR	compat_sys_mq_open
-	PTR	sys_mq_unlink			/* 6235 */
-	PTR	compat_sys_mq_timedsend
-	PTR	compat_sys_mq_timedreceive
-	PTR	compat_sys_mq_notify
-	PTR	compat_sys_mq_getsetattr
-	PTR	sys_ni_syscall			/* 6240, sys_vserver */
-	PTR	compat_sys_waitid
-	PTR	sys_ni_syscall			/* available, was setaltroot */
-	PTR	sys_add_key
-	PTR	sys_request_key
-	PTR	compat_sys_keyctl		/* 6245 */
-	PTR	sys_set_thread_area
-	PTR	sys_inotify_init
-	PTR	sys_inotify_add_watch
-	PTR	sys_inotify_rm_watch
-	PTR	compat_sys_migrate_pages	/* 6250 */
-	PTR	sys_openat
-	PTR	sys_mkdirat
-	PTR	sys_mknodat
-	PTR	sys_fchownat
-	PTR	compat_sys_futimesat		/* 6255 */
-	PTR	sys_newfstatat
-	PTR	sys_unlinkat
-	PTR	sys_renameat
-	PTR	sys_linkat
-	PTR	sys_symlinkat			/* 6260 */
-	PTR	sys_readlinkat
-	PTR	sys_fchmodat
-	PTR	sys_faccessat
-	PTR	compat_sys_pselect6
-	PTR	compat_sys_ppoll		/* 6265 */
-	PTR	sys_unshare
-	PTR	sys_splice
-	PTR	sys_sync_file_range
-	PTR	sys_tee
-	PTR	compat_sys_vmsplice		/* 6270 */
-	PTR	compat_sys_move_pages
-	PTR	compat_sys_set_robust_list
-	PTR	compat_sys_get_robust_list
-	PTR	compat_sys_kexec_load
-	PTR	sys_getcpu			/* 6275 */
-	PTR	compat_sys_epoll_pwait
-	PTR	sys_ioprio_set
-	PTR	sys_ioprio_get
-	PTR	compat_sys_utimensat
-	PTR	compat_sys_signalfd		/* 6280 */
-	PTR	sys_ni_syscall			/* was timerfd */
-	PTR	sys_eventfd
-	PTR	sys_fallocate
-	PTR	sys_timerfd_create
-	PTR	compat_sys_timerfd_gettime	/* 6285 */
-	PTR	compat_sys_timerfd_settime
-	PTR	compat_sys_signalfd4
-	PTR	sys_eventfd2
-	PTR	sys_epoll_create1
-	PTR	sys_dup3			/* 6290 */
-	PTR	sys_pipe2
-	PTR	sys_inotify_init1
-	PTR	compat_sys_preadv
-	PTR	compat_sys_pwritev
-	PTR	compat_sys_rt_tgsigqueueinfo	/* 6295 */
-	PTR	sys_perf_event_open
-	PTR	sys_accept4
-	PTR	compat_sys_recvmmsg
-	PTR	sys_getdents64
-	PTR	sys_fanotify_init		/* 6300 */
-	PTR	sys_fanotify_mark
-	PTR	sys_prlimit64
-	PTR	sys_name_to_handle_at
-	PTR	sys_open_by_handle_at
-	PTR	compat_sys_clock_adjtime	/* 6305 */
-	PTR	sys_syncfs
-	PTR	compat_sys_sendmmsg
-	PTR	sys_setns
-	PTR	compat_sys_process_vm_readv
-	PTR	compat_sys_process_vm_writev	/* 6310 */
-	PTR	sys_kcmp
-	PTR	sys_finit_module
-	PTR	sys_sched_setattr
-	PTR	sys_sched_getattr
-	PTR	sys_renameat2			/* 6315 */
-	PTR	sys_seccomp
-	PTR	sys_getrandom
-	PTR	sys_memfd_create
-	PTR	sys_bpf
-	PTR	compat_sys_execveat		/* 6320 */
-	PTR	sys_userfaultfd
-	PTR	sys_membarrier
-	PTR	sys_mlock2
-	PTR	sys_copy_file_range
-	PTR	compat_sys_preadv2		/* 6325 */
-	PTR	compat_sys_pwritev2
-	PTR	sys_pkey_mprotect
-	PTR	sys_pkey_alloc
-	PTR	sys_pkey_free
-	PTR	sys_statx			/* 6330 */
-	PTR	sys_rseq
-	PTR	compat_sys_io_pgetevents
-	.size	sysn32_call_table,.-sysn32_call_table
+#include "syscall_table_64_n32.S"
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 73913f0..35359bd 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -213,376 +213,4 @@ einval: li	v0, -ENOSYS
 	jr	ra
 	END(sys32_syscall)
 
-	.align	3
-	.type	sys32_call_table,@object
-EXPORT(sys32_call_table)
-	PTR	sys32_syscall			/* 4000 */
-	PTR	sys_exit
-	PTR	__sys_fork
-	PTR	sys_read
-	PTR	sys_write
-	PTR	compat_sys_open			/* 4005 */
-	PTR	sys_close
-	PTR	sys_waitpid
-	PTR	sys_creat
-	PTR	sys_link
-	PTR	sys_unlink			/* 4010 */
-	PTR	compat_sys_execve
-	PTR	sys_chdir
-	PTR	compat_sys_time
-	PTR	sys_mknod
-	PTR	sys_chmod			/* 4015 */
-	PTR	sys_lchown
-	PTR	sys_ni_syscall
-	PTR	sys_ni_syscall			/* was sys_stat */
-	PTR	sys_lseek
-	PTR	sys_getpid			/* 4020 */
-	PTR	compat_sys_mount
-	PTR	sys_oldumount
-	PTR	sys_setuid
-	PTR	sys_getuid
-	PTR	compat_sys_stime		/* 4025 */
-	PTR	compat_sys_ptrace
-	PTR	sys_alarm
-	PTR	sys_ni_syscall			/* was sys_fstat */
-	PTR	sys_pause
-	PTR	compat_sys_utime		/* 4030 */
-	PTR	sys_ni_syscall
-	PTR	sys_ni_syscall
-	PTR	sys_access
-	PTR	sys_nice
-	PTR	sys_ni_syscall			/* 4035 */
-	PTR	sys_sync
-	PTR	sys_kill
-	PTR	sys_rename
-	PTR	sys_mkdir
-	PTR	sys_rmdir			/* 4040 */
-	PTR	sys_dup
-	PTR	sysm_pipe
-	PTR	compat_sys_times
-	PTR	sys_ni_syscall
-	PTR	sys_brk				/* 4045 */
-	PTR	sys_setgid
-	PTR	sys_getgid
-	PTR	sys_ni_syscall			/* was signal	2 */
-	PTR	sys_geteuid
-	PTR	sys_getegid			/* 4050 */
-	PTR	sys_acct
-	PTR	sys_umount
-	PTR	sys_ni_syscall
-	PTR	compat_sys_ioctl
-	PTR	compat_sys_fcntl		/* 4055 */
-	PTR	sys_ni_syscall
-	PTR	sys_setpgid
-	PTR	sys_ni_syscall
-	PTR	sys_olduname
-	PTR	sys_umask			/* 4060 */
-	PTR	sys_chroot
-	PTR	compat_sys_ustat
-	PTR	sys_dup2
-	PTR	sys_getppid
-	PTR	sys_getpgrp			/* 4065 */
-	PTR	sys_setsid
-	PTR	sys_32_sigaction
-	PTR	sys_sgetmask
-	PTR	sys_ssetmask
-	PTR	sys_setreuid			/* 4070 */
-	PTR	sys_setregid
-	PTR	sys32_sigsuspend
-	PTR	compat_sys_sigpending
-	PTR	sys_sethostname
-	PTR	compat_sys_setrlimit		/* 4075 */
-	PTR	compat_sys_getrlimit
-	PTR	compat_sys_getrusage
-	PTR	compat_sys_gettimeofday
-	PTR	compat_sys_settimeofday
-	PTR	sys_getgroups			/* 4080 */
-	PTR	sys_setgroups
-	PTR	sys_ni_syscall			/* old_select */
-	PTR	sys_symlink
-	PTR	sys_ni_syscall			/* was sys_lstat */
-	PTR	sys_readlink			/* 4085 */
-	PTR	sys_uselib
-	PTR	sys_swapon
-	PTR	sys_reboot
-	PTR	compat_sys_old_readdir
-	PTR	sys_mips_mmap			/* 4090 */
-	PTR	sys_munmap
-	PTR	compat_sys_truncate
-	PTR	compat_sys_ftruncate
-	PTR	sys_fchmod
-	PTR	sys_fchown			/* 4095 */
-	PTR	sys_getpriority
-	PTR	sys_setpriority
-	PTR	sys_ni_syscall
-	PTR	compat_sys_statfs
-	PTR	compat_sys_fstatfs		/* 4100 */
-	PTR	sys_ni_syscall			/* sys_ioperm */
-	PTR	compat_sys_socketcall
-	PTR	sys_syslog
-	PTR	compat_sys_setitimer
-	PTR	compat_sys_getitimer		/* 4105 */
-	PTR	compat_sys_newstat
-	PTR	compat_sys_newlstat
-	PTR	compat_sys_newfstat
-	PTR	sys_uname
-	PTR	sys_ni_syscall			/* sys_ioperm  *//* 4110 */
-	PTR	sys_vhangup
-	PTR	sys_ni_syscall			/* was sys_idle	 */
-	PTR	sys_ni_syscall			/* sys_vm86 */
-	PTR	compat_sys_wait4
-	PTR	sys_swapoff			/* 4115 */
-	PTR	compat_sys_sysinfo
-	PTR	compat_sys_ipc
-	PTR	sys_fsync
-	PTR	sys32_sigreturn
-	PTR	__sys_clone			/* 4120 */
-	PTR	sys_setdomainname
-	PTR	sys_newuname
-	PTR	sys_ni_syscall			/* sys_modify_ldt */
-	PTR	compat_sys_adjtimex
-	PTR	sys_mprotect			/* 4125 */
-	PTR	compat_sys_sigprocmask
-	PTR	sys_ni_syscall			/* was creat_module */
-	PTR	sys_init_module
-	PTR	sys_delete_module
-	PTR	sys_ni_syscall			/* 4130, get_kernel_syms */
-	PTR	sys_quotactl
-	PTR	sys_getpgid
-	PTR	sys_fchdir
-	PTR	sys_bdflush
-	PTR	sys_sysfs			/* 4135 */
-	PTR	sys_32_personality
-	PTR	sys_ni_syscall			/* for afs_syscall */
-	PTR	sys_setfsuid
-	PTR	sys_setfsgid
-	PTR	sys_32_llseek			/* 4140 */
-	PTR	compat_sys_getdents
-	PTR	compat_sys_select
-	PTR	sys_flock
-	PTR	sys_msync
-	PTR	compat_sys_readv		/* 4145 */
-	PTR	compat_sys_writev
-	PTR	sys_cacheflush
-	PTR	sys_cachectl
-	PTR	__sys_sysmips
-	PTR	sys_ni_syscall			/* 4150 */
-	PTR	sys_getsid
-	PTR	sys_fdatasync
-	PTR	compat_sys_sysctl
-	PTR	sys_mlock
-	PTR	sys_munlock			/* 4155 */
-	PTR	sys_mlockall
-	PTR	sys_munlockall
-	PTR	sys_sched_setparam
-	PTR	sys_sched_getparam
-	PTR	sys_sched_setscheduler		/* 4160 */
-	PTR	sys_sched_getscheduler
-	PTR	sys_sched_yield
-	PTR	sys_sched_get_priority_max
-	PTR	sys_sched_get_priority_min
-	PTR	compat_sys_sched_rr_get_interval	/* 4165 */
-	PTR	compat_sys_nanosleep
-	PTR	sys_mremap
-	PTR	sys_accept
-	PTR	sys_bind
-	PTR	sys_connect			/* 4170 */
-	PTR	sys_getpeername
-	PTR	sys_getsockname
-	PTR	compat_sys_getsockopt
-	PTR	sys_listen
-	PTR	compat_sys_recv			/* 4175 */
-	PTR	compat_sys_recvfrom
-	PTR	compat_sys_recvmsg
-	PTR	sys_send
-	PTR	compat_sys_sendmsg
-	PTR	sys_sendto			/* 4180 */
-	PTR	compat_sys_setsockopt
-	PTR	sys_shutdown
-	PTR	sys_socket
-	PTR	sys_socketpair
-	PTR	sys_setresuid			/* 4185 */
-	PTR	sys_getresuid
-	PTR	sys_ni_syscall			/* was query_module */
-	PTR	sys_poll
-	PTR	sys_ni_syscall			/* was nfsservctl */
-	PTR	sys_setresgid			/* 4190 */
-	PTR	sys_getresgid
-	PTR	sys_prctl
-	PTR	sys32_rt_sigreturn
-	PTR	compat_sys_rt_sigaction
-	PTR	compat_sys_rt_sigprocmask	/* 4195 */
-	PTR	compat_sys_rt_sigpending
-	PTR	compat_sys_rt_sigtimedwait
-	PTR	compat_sys_rt_sigqueueinfo
-	PTR	compat_sys_rt_sigsuspend
-	PTR	sys_32_pread			/* 4200 */
-	PTR	sys_32_pwrite
-	PTR	sys_chown
-	PTR	sys_getcwd
-	PTR	sys_capget
-	PTR	sys_capset			/* 4205 */
-	PTR	compat_sys_sigaltstack
-	PTR	compat_sys_sendfile
-	PTR	sys_ni_syscall
-	PTR	sys_ni_syscall
-	PTR	sys_mips_mmap2			/* 4210 */
-	PTR	sys_32_truncate64
-	PTR	sys_32_ftruncate64
-	PTR	sys_newstat
-	PTR	sys_newlstat
-	PTR	sys_newfstat			/* 4215 */
-	PTR	sys_pivot_root
-	PTR	sys_mincore
-	PTR	sys_madvise
-	PTR	sys_getdents64
-	PTR	compat_sys_fcntl64		/* 4220 */
-	PTR	sys_ni_syscall
-	PTR	sys_gettid
-	PTR	sys32_readahead
-	PTR	sys_setxattr
-	PTR	sys_lsetxattr			/* 4225 */
-	PTR	sys_fsetxattr
-	PTR	sys_getxattr
-	PTR	sys_lgetxattr
-	PTR	sys_fgetxattr
-	PTR	sys_listxattr			/* 4230 */
-	PTR	sys_llistxattr
-	PTR	sys_flistxattr
-	PTR	sys_removexattr
-	PTR	sys_lremovexattr
-	PTR	sys_fremovexattr		/* 4235 */
-	PTR	sys_tkill
-	PTR	sys_sendfile64
-	PTR	compat_sys_futex
-	PTR	compat_sys_sched_setaffinity
-	PTR	compat_sys_sched_getaffinity	/* 4240 */
-	PTR	compat_sys_io_setup
-	PTR	sys_io_destroy
-	PTR	compat_sys_io_getevents
-	PTR	compat_sys_io_submit
-	PTR	sys_io_cancel			/* 4245 */
-	PTR	sys_exit_group
-	PTR	compat_sys_lookup_dcookie
-	PTR	sys_epoll_create
-	PTR	sys_epoll_ctl
-	PTR	sys_epoll_wait			/* 4250 */
-	PTR	sys_remap_file_pages
-	PTR	sys_set_tid_address
-	PTR	sys_restart_syscall
-	PTR	sys32_fadvise64_64
-	PTR	compat_sys_statfs64		/* 4255 */
-	PTR	compat_sys_fstatfs64
-	PTR	compat_sys_timer_create
-	PTR	compat_sys_timer_settime
-	PTR	compat_sys_timer_gettime
-	PTR	sys_timer_getoverrun		/* 4260 */
-	PTR	sys_timer_delete
-	PTR	compat_sys_clock_settime
-	PTR	compat_sys_clock_gettime
-	PTR	compat_sys_clock_getres
-	PTR	compat_sys_clock_nanosleep	/* 4265 */
-	PTR	sys_tgkill
-	PTR	compat_sys_utimes
-	PTR	compat_sys_mbind
-	PTR	compat_sys_get_mempolicy
-	PTR	compat_sys_set_mempolicy	/* 4270 */
-	PTR	compat_sys_mq_open
-	PTR	sys_mq_unlink
-	PTR	compat_sys_mq_timedsend
-	PTR	compat_sys_mq_timedreceive
-	PTR	compat_sys_mq_notify		/* 4275 */
-	PTR	compat_sys_mq_getsetattr
-	PTR	sys_ni_syscall			/* sys_vserver */
-	PTR	compat_sys_waitid
-	PTR	sys_ni_syscall			/* available, was setaltroot */
-	PTR	sys_add_key			/* 4280 */
-	PTR	sys_request_key
-	PTR	compat_sys_keyctl
-	PTR	sys_set_thread_area
-	PTR	sys_inotify_init
-	PTR	sys_inotify_add_watch		/* 4285 */
-	PTR	sys_inotify_rm_watch
-	PTR	compat_sys_migrate_pages
-	PTR	compat_sys_openat
-	PTR	sys_mkdirat
-	PTR	sys_mknodat			/* 4290 */
-	PTR	sys_fchownat
-	PTR	compat_sys_futimesat
-	PTR	sys_newfstatat
-	PTR	sys_unlinkat
-	PTR	sys_renameat			/* 4295 */
-	PTR	sys_linkat
-	PTR	sys_symlinkat
-	PTR	sys_readlinkat
-	PTR	sys_fchmodat
-	PTR	sys_faccessat			/* 4300 */
-	PTR	compat_sys_pselect6
-	PTR	compat_sys_ppoll
-	PTR	sys_unshare
-	PTR	sys_splice
-	PTR	sys32_sync_file_range		/* 4305 */
-	PTR	sys_tee
-	PTR	compat_sys_vmsplice
-	PTR	compat_sys_move_pages
-	PTR	compat_sys_set_robust_list
-	PTR	compat_sys_get_robust_list	/* 4310 */
-	PTR	compat_sys_kexec_load
-	PTR	sys_getcpu
-	PTR	compat_sys_epoll_pwait
-	PTR	sys_ioprio_set
-	PTR	sys_ioprio_get			/* 4315 */
-	PTR	compat_sys_utimensat
-	PTR	compat_sys_signalfd
-	PTR	sys_ni_syscall			/* was timerfd */
-	PTR	sys_eventfd
-	PTR	sys32_fallocate			/* 4320 */
-	PTR	sys_timerfd_create
-	PTR	compat_sys_timerfd_gettime
-	PTR	compat_sys_timerfd_settime
-	PTR	compat_sys_signalfd4
-	PTR	sys_eventfd2			/* 4325 */
-	PTR	sys_epoll_create1
-	PTR	sys_dup3
-	PTR	sys_pipe2
-	PTR	sys_inotify_init1
-	PTR	compat_sys_preadv		/* 4330 */
-	PTR	compat_sys_pwritev
-	PTR	compat_sys_rt_tgsigqueueinfo
-	PTR	sys_perf_event_open
-	PTR	sys_accept4
-	PTR	compat_sys_recvmmsg		/* 4335 */
-	PTR	sys_fanotify_init
-	PTR	compat_sys_fanotify_mark
-	PTR	sys_prlimit64
-	PTR	sys_name_to_handle_at
-	PTR	compat_sys_open_by_handle_at	/* 4340 */
-	PTR	compat_sys_clock_adjtime
-	PTR	sys_syncfs
-	PTR	compat_sys_sendmmsg
-	PTR	sys_setns
-	PTR	compat_sys_process_vm_readv	/* 4345 */
-	PTR	compat_sys_process_vm_writev
-	PTR	sys_kcmp
-	PTR	sys_finit_module
-	PTR	sys_sched_setattr
-	PTR	sys_sched_getattr		/* 4350 */
-	PTR	sys_renameat2
-	PTR	sys_seccomp
-	PTR	sys_getrandom
-	PTR	sys_memfd_create
-	PTR	sys_bpf				/* 4355 */
-	PTR	compat_sys_execveat
-	PTR	sys_userfaultfd
-	PTR	sys_membarrier
-	PTR	sys_mlock2
-	PTR	sys_copy_file_range		/* 4360 */
-	PTR	compat_sys_preadv2
-	PTR	compat_sys_pwritev2
-	PTR	sys_pkey_mprotect
-	PTR	sys_pkey_alloc
-	PTR	sys_pkey_free			/* 4365 */
-	PTR	sys_statx
-	PTR	sys_rseq
-	PTR	compat_sys_io_pgetevents
-	.size	sys32_call_table,.-sys32_call_table
+#include "syscall_table_64_o32.S"
diff --git a/arch/mips/kernel/syscall_table_32_o32.S b/arch/mips/kernel/syscall_table_32_o32.S
new file mode 100644
index 0000000..88c4bc6
--- /dev/null
+++ b/arch/mips/kernel/syscall_table_32_o32.S
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define __SYSCALL(nr, entry, nargs) PTR entry
+	
+.align	2
+.type	sys_call_table, @object
+EXPORT(sys_call_table)
+#include <asm/syscall_table_32_o32.h>
diff --git a/arch/mips/kernel/syscall_table_64_64.S b/arch/mips/kernel/syscall_table_64_64.S
new file mode 100644
index 0000000..ae9d930
--- /dev/null
+++ b/arch/mips/kernel/syscall_table_64_64.S
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define __SYSCALL(nr, entry, nargs) PTR entry
+	
+.align	3
+.type	sys_call_table, @object
+EXPORT(sys_call_table)
+#include <asm/syscall_table_64_64.h>
+.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/syscall_table_64_n32.S b/arch/mips/kernel/syscall_table_64_n32.S
new file mode 100644
index 0000000..50e9f09
--- /dev/null
+++ b/arch/mips/kernel/syscall_table_64_n32.S
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define __SYSCALL(nr, entry, nargs) PTR entry
+	
+.type	sysn32_call_table, @object
+EXPORT(sysn32_call_table)
+#include <asm/syscall_table_64_n32.h>
+.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/syscall_table_64_o32.S b/arch/mips/kernel/syscall_table_64_o32.S
new file mode 100644
index 0000000..4b294ba
--- /dev/null
+++ b/arch/mips/kernel/syscall_table_64_o32.S
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define __SYSCALL(nr, entry, nargs) PTR entry
+	
+.align	3
+.type	sys32_call_table,@object
+EXPORT(sys32_call_table)
+#include <asm/syscall_table_64_o32.h>
+.size	sys32_call_table,.-sys32_call_table
-- 
1.9.1

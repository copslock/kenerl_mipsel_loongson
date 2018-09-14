Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 10:39:45 +0200 (CEST)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:46547
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994544AbeINIj1Wbnji (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 10:39:27 +0200
Received: by mail-pl1-x644.google.com with SMTP id t19-v6so3862592ply.13
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 01:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lywppv1tiwoh2tOKWVi15h5v9nGa/tiOsk2epy78WKM=;
        b=Nxsvgn/N3Ji+gb4TaHQ0WgX0wrSTezBxaNdPQH6RaV0VK1PB+aTcP54u3EcFPEkZ3q
         peUFARv3IyOyUcdMPwdXuxIcncfYBuNQd76gAhui4Bld+4MIctD2vOOUc5RPFQ2IRIFu
         9cFCcj1Ly1+2UluBD1qdDC7R4D47spocN7IkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lywppv1tiwoh2tOKWVi15h5v9nGa/tiOsk2epy78WKM=;
        b=Dj/UJrv784yDHqbcY12NtrsAjdNppZL7qUNT/xG97/zAmLBCeA7o0O3DPl5AXBQkZn
         OaUag4xE0Qa/XgNuP1JQjq/vCK+r4m3NzkXFXKvC4FULlznx1izEAHKq80q2lT73xNbV
         O7St7KimqtdhzmR5FHo/qZ4MLYHfGy/H/GAnTGvG7KKXbib2TA6MauWaQdJ5uLdBFARt
         et3xmLcRXIzaJw4xUbD4qj0T9/doIlrXh90hHGrfVlMaVx56lomXy0fDEBCwfzxbxA4d
         RoU0dFQpH2A846APXbAO7CjDi5RyLt4RWVs+Tls+2AwD3QX2QlZu091EKbF1BZT463Fu
         KfeQ==
X-Gm-Message-State: APzg51Bgj1s8aZyvD/3B9jeQ5wOxJZdLJJb7JPHS+B7HuBEeFTncpQN6
        M+VjEFwBC2xBvOh0WZ4lu+0ZSA==
X-Google-Smtp-Source: ANB0Vdb5ahcDFPpppb/HsP48wBayP6q8s4cXaXq8MMCpCouYFgElR/F4XtEw5vHZed8pg/aturqk+g==
X-Received: by 2002:a17:902:e190:: with SMTP id cd16-v6mr10992545plb.305.1536914359695;
        Fri, 14 Sep 2018 01:39:19 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id c1-v6sm11664289pfg.25.2018.09.14.01.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:39:19 -0700 (PDT)
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
Subject: [PATCH 2/3] mips: Add system call table generation support
Date:   Fri, 14 Sep 2018 14:08:33 +0530
Message-Id: <1536914314-5026-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66239
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

The system call tables are in different format in all
architecture and it will be difficult to manually add or
modify the system calls in the respective files. To make
it easy by keeping a script and which'll generate the
header file and syscall table file so this change will
unify them across all architectures.

The system call table generation script is added in
syscalls directory which contain the script to generate
both uapi header file system call table generation file
and syscall_32/64.tbl file which'll be the input for the
scripts.

syscall_32/64/n32.tbl contains the list of available system
calls along with system call number and corresponding entry
point. Add a new system call in this architecture will be
possible by adding new entry in the syscall_32/64/n32.tbl
file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
        - Compat entry name, if required.

syscallhdr.sh and syscalltbl.sh will generate uapi header-
unistd_32/64.h and syscall_table_*.h files respectively.
File syscall_table_*.h is included by syscall_table_*.S - the
real system call table. Both .sh files will parse the content
syscall.tbl to generate the header and table files.

ARM, s390 and x86 architecuture does have the similar support.
I leverage their implementation to come up with a generic
solution.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/kernel/syscalls/Makefile        |  62 +++++
 arch/mips/kernel/syscalls/README.md       |  16 ++
 arch/mips/kernel/syscalls/syscall_32.tbl  | 375 ++++++++++++++++++++++++++++++
 arch/mips/kernel/syscalls/syscall_64.tbl  | 335 ++++++++++++++++++++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl | 339 +++++++++++++++++++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |  37 +++
 arch/mips/kernel/syscalls/syscalltbl.sh   |  44 ++++
 7 files changed, 1208 insertions(+)
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/README.md
 create mode 100644 arch/mips/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
new file mode 100644
index 0000000..5044724
--- /dev/null
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0
+out := arch/$(SRCARCH)/include/generated/asm
+uapi := arch/$(SRCARCH)/include/generated/uapi/asm
+
+_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
+	  $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+syscall32 := $(srctree)/$(src)/syscall_32.tbl
+syscall64 := $(srctree)/$(src)/syscall_64.tbl
+syscalln32 := $(srctree)/$(src)/syscall_n32.tbl
+
+syshdr := $(srctree)/$(src)/syscallhdr.sh
+systbl := $(srctree)/$(src)/syscalltbl.sh
+
+quiet_cmd_syshdr = SYSHDR  $@
+      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'  \
+		   '$(syshdr_abi_$(basetarget))'          \
+		   '$(syshdr_pfx_$(basetarget))'          \
+		   '$(syshdr_offset_$(basetarget))'
+
+quiet_cmd_systbl = SYSTBL  $@
+      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'  \
+		   '$(systbl_abi_$(basetarget))'
+
+syshdr_offset_unistd_32 := __NR_Linux
+$(uapi)/unistd_32.h: $(syscall32) $(syshdr)
+	$(call if_changed,syshdr)
+
+syshdr_offset_unistd_64 := __NR_Linux
+$(uapi)/unistd_64.h: $(syscall64) $(syshdr)
+	$(call if_changed,syshdr)
+
+syshdr_offset_unistd_n32 := __NR_Linux
+$(uapi)/unistd_n32.h: $(syscalln32) $(syshdr)
+	$(call if_changed,syshdr)
+
+systbl_abi_syscall_table_32_o32 := 32-o32
+$(out)/syscall_table_32_o32.h: $(syscall32) $(systbl)
+	$(call if_changed,systbl)
+
+systbl_abi_syscall_table_64_o32 := 64-o32
+$(out)/syscall_table_64_o32.h: $(syscall32) $(systbl)
+	$(call if_changed,systbl)
+
+systbl_abi_syscall_table_64_64 := 64-64
+$(out)/syscall_table_64_64.h: $(syscall64) $(systbl)
+	$(call if_changed,systbl)
+
+systbl_abi_syscall_table_64_n32 := 64-n32
+$(out)/syscall_table_64_n32.h: $(syscalln32) $(systbl)
+	$(call if_changed,systbl)
+
+uapisyshdr-y			+= unistd_32.h unistd_64.h unistd_n32.h
+syshdr-y			+= syscall_table_32_o32.h syscall_table_64_o32.h \
+                                   syscall_table_64_64.h syscall_table_64_n32.h
+
+targets	+= $(uapisyshdr-y) $(syshdr-y)
+
+PHONY += all
+all: $(addprefix $(uapi)/,$(uapisyshdr-y))
+all: $(addprefix $(out)/,$(syshdr-y))
+	@:
diff --git a/arch/mips/kernel/syscalls/README.md b/arch/mips/kernel/syscalls/README.md
new file mode 100644
index 0000000..1f51ad1
--- /dev/null
+++ b/arch/mips/kernel/syscalls/README.md
@@ -0,0 +1,16 @@
+# mips: system_call_table_generator
+
+- This architecture does have more than one ABI.
+  syscall.tbl contains the information like 
+    - system call number
+    - name 
+    - entry_64
+    - entry_32
+    - compat
+    - comments
+
+- The scripts syscallhdr.sh will generate uapi header- 
+  arch/powerpc/include/uapi/asm/unistd.h. 
+
+- The script syscalltbl.sh will generate syscalls.h 
+  which will be included by syscall_64/32/n32/o32.S file
diff --git a/arch/mips/kernel/syscalls/syscall_32.tbl b/arch/mips/kernel/syscalls/syscall_32.tbl
new file mode 100644
index 0000000..5db6827
--- /dev/null
+++ b/arch/mips/kernel/syscalls/syscall_32.tbl
@@ -0,0 +1,375 @@
+#
+# 32-bit system call numbers and entry vectors
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The abi is always "common" for this file.
+#
+0       32      syscall                         sys_syscall                     sys32_syscall
+1       32      exit                            sys_exit                        
+2       32      fork                            __sys_fork                      
+3       32      read                            sys_read                        
+4       32      write                           sys_write                       
+5       32      open                            sys_open                        compat_sys_open
+6       32      close                           sys_close                       
+7       32      waitpid                         sys_waitpid                     
+8       32      creat                           sys_creat                       
+9       32      link                            sys_link                        
+10      32      unlink                          sys_unlink                      
+11      32      execve                          sys_execve                      compat_sys_execve
+12      32      chdir                           sys_chdir                       
+13      32      time                            sys_time                        compat_sys_time
+14      32      mknod                           sys_mknod                       
+15      32      chmod                           sys_chmod                       
+16      32      lchown                          sys_lchown                      
+17      32      break                           sys_ni_syscall                  
+18      32      unused18                        sys_ni_syscall                  
+19      32      lseek                           sys_lseek                       
+20      32      getpid                          sys_getpid                      
+21      32      mount                           sys_mount                       compat_sys_mount
+22      32      umount                          sys_oldumount                   
+23      32      setuid                          sys_setuid                      
+24      32      getuid                          sys_getuid                      
+25      32      stime                           sys_stime                       compat_sys_stime
+26      32      ptrace                          sys_ptrace                      compat_sys_ptrace
+27      32      alarm                           sys_alarm                       
+28      32      unused28                        sys_ni_syscall                  
+29      32      pause                           sys_pause                       
+30      32      utime                           sys_utime                       compat_sys_utime
+31      32      stty                            sys_ni_syscall                  
+32      32      gtty                            sys_ni_syscall                  
+33      32      access                          sys_access                      
+34      32      nice                            sys_nice                        
+35      32      ftime                           sys_ni_syscall                  
+36      32      sync                            sys_sync                        
+37      32      kill                            sys_kill                        
+38      32      rename                          sys_rename                      
+39      32      mkdir                           sys_mkdir                       
+40      32      rmdir                           sys_rmdir                       
+41      32      dup                             sys_dup                         
+42      32      pipe                            sysm_pipe                       
+43      32      times                           sys_times                       compat_sys_times
+44      32      prof                            sys_ni_syscall                  
+45      32      brk                             sys_brk                         
+46      32      setgid                          sys_setgid                      
+47      32      getgid                          sys_getgid                      
+48      32      signal                          sys_ni_syscall                  
+49      32      geteuid                         sys_geteuid                     
+50      32      getegid                         sys_getegid                     
+51      32      acct                            sys_acct                        
+52      32      umount2                         sys_umount                      
+53      32      lock                            sys_ni_syscall                  
+54      32      ioctl                           sys_ioctl                       compat_sys_ioctl
+55      32      fcntl                           sys_fcntl                       compat_sys_fcntl
+56      32      mpx                             sys_ni_syscall                  
+57      32      setpgid                         sys_setpgid                     
+58      32      ulimit                          sys_ni_syscall                  
+59      32      unused59                        sys_olduname                    
+60      32      umask                           sys_umask                       
+61      32      chroot                          sys_chroot                      
+62      32      ustat                           sys_ustat                       compat_sys_ustat
+63      32      dup2                            sys_dup2                        
+64      32      getppid                         sys_getppid                     
+65      32      getpgrp                         sys_getpgrp                     
+66      32      setsid                          sys_setsid                      
+67      32      sigaction                       sys_sigaction                   sys_32_sigaction
+68      32      sgetmask                        sys_sgetmask                    
+69      32      ssetmask                        sys_ssetmask                    
+70      32      setreuid                        sys_setreuid                    
+71      32      setregid                        sys_setregid                    
+72      32      sigsuspend                      sys_sigsuspend                  sys32_sigsuspend
+73      32      sigpending                      sys_sigpending                  compat_sys_sigpending
+74      32      sethostname                     sys_sethostname                 
+75      32      setrlimit                       sys_setrlimit                   compat_sys_setrlimit
+76      32      getrlimit                       sys_getrlimit                   compat_sys_getrlimit
+77      32      getrusage                       sys_getrusage                   compat_sys_getrusage
+78      32      gettimeofday                    sys_gettimeofday                compat_sys_gettimeofday
+79      32      settimeofday                    sys_settimeofday                compat_sys_settimeofday
+80      32      getgroups                       sys_getgroups                   
+81      32      setgroups                       sys_setgroups                   
+82      32      reserved82                      sys_ni_syscall                  
+83      32      symlink                         sys_symlink                     
+84      32      unused84                        sys_ni_syscall                  
+85      32      readlink                        sys_readlink                    
+86      32      uselib                          sys_uselib                      
+87      32      swapon                          sys_swapon                      
+88      32      reboot                          sys_reboot                      
+89      32      readdir                         sys_old_readdir                 compat_sys_old_readdir
+90      32      mmap                            sys_mips_mmap                   
+91      32      munmap                          sys_munmap                      
+92      32      truncate                        sys_truncate                    compat_sys_truncate
+93      32      ftruncate                       sys_ftruncate                   compat_sys_ftruncate
+94      32      fchmod                          sys_fchmod                      
+95      32      fchown                          sys_fchown                      
+96      32      getpriority                     sys_getpriority                 
+97      32      setpriority                     sys_setpriority                 
+98      32      profil                          sys_ni_syscall                  
+99      32      statfs                          sys_statfs                      compat_sys_statfs
+100     32      fstatfs                         sys_fstatfs                     compat_sys_fstatfs
+101     32      ioperm                          sys_ni_syscall                  
+102     32      socketcall                      sys_socketcall                  compat_sys_socketcall
+103     32      syslog                          sys_syslog                      
+104     32      setitimer                       sys_setitimer                   compat_sys_setitimer
+105     32      getitimer                       sys_getitimer                   compat_sys_getitimer
+106     32      stat                            sys_newstat                     compat_sys_newstat
+107     32      lstat                           sys_newlstat                    compat_sys_newlstat
+108     32      fstat                           sys_newfstat                    compat_sys_newfstat
+109     32      unused109                       sys_uname                       
+110     32      iopl                            sys_ni_syscall                  
+111     32      vhangup                         sys_vhangup                     
+112     32      idle                            sys_ni_syscall                  
+113     32      vm86                            sys_ni_syscall                  
+114     32      wait4                           sys_wait4                       compat_sys_wait4
+115     32      swapoff                         sys_swapoff                     
+116     32      sysinfo                         sys_sysinfo                     compat_sys_sysinfo
+117     32      ipc                             sys_ipc                         compat_sys_ipc
+118     32      fsync                           sys_fsync                       
+119     32      sigreturn                       sys_sigreturn                   sys32_sigreturn
+120     32      clone                           __sys_clone                     
+121     32      setdomainname                   sys_setdomainname               
+122     32      uname                           sys_newuname                    
+123     32      modify_ldt                      sys_ni_syscall                  
+124     32      adjtimex                        sys_adjtimex                    compat_sys_adjtimex
+125     32      mprotect                        sys_mprotect                    
+126     32      sigprocmask                     sys_sigprocmask                 compat_sys_sigprocmask
+127     32      create_module                   sys_ni_syscall                  
+128     32      init_module                     sys_init_module                 
+129     32      delete_module                   sys_delete_module               
+130     32      get_kernel_syms                 sys_ni_syscall                  
+131     32      quotactl                        sys_quotactl                    
+132     32      getpgid                         sys_getpgid                     
+133     32      fchdir                          sys_fchdir                      
+134     32      bdflush                         sys_bdflush                     
+135     32      sysfs                           sys_sysfs                       
+136     32      personality                     sys_personality                 sys_32_personality
+137     32      afs_syscall                     sys_ni_syscall                  
+138     32      setfsuid                        sys_setfsuid                    
+139     32      setfsgid                        sys_setfsgid                    
+140     32      _llseek                         sys_llseek                      sys_32_llseek
+141     32      getdents                        sys_getdents                    compat_sys_getdents
+142     32      _newselect                      sys_select                      compat_sys_select
+143     32      flock                           sys_flock                       
+144     32      msync                           sys_msync                       
+145     32      readv                           sys_readv                       compat_sys_readv
+146     32      writev                          sys_writev                      compat_sys_writev
+147     32      cacheflush                      sys_cacheflush                  
+148     32      cachectl                        sys_cachectl                    
+149     32      sysmips                         __sys_sysmips                   
+150     32      unused150                       sys_ni_syscall                  
+151     32      getsid                          sys_getsid                      
+152     32      fdatasync                       sys_fdatasync                   
+153     32      _sysctl                         sys_sysctl                      compat_sys_sysctl
+154     32      mlock                           sys_mlock                       
+155     32      munlock                         sys_munlock                     
+156     32      mlockall                        sys_mlockall                    
+157     32      munlockall                      sys_munlockall                  
+158     32      sched_setparam                  sys_sched_setparam              
+159     32      sched_getparam                  sys_sched_getparam              
+160     32      sched_setscheduler              sys_sched_setscheduler          
+161     32      sched_getscheduler              sys_sched_getscheduler          
+162     32      sched_yield                     sys_sched_yield                 
+163     32      sched_get_priority_max          sys_sched_get_priority_max      
+164     32      sched_get_priority_min          sys_sched_get_priority_min      
+165     32      sched_rr_get_interval           sys_sched_rr_get_interval       compat_sys_sched_rr_get_interval
+166     32      nanosleep                       sys_nanosleep                   compat_sys_nanosleep
+167     32      mremap                          sys_mremap                      
+168     32      accept                          sys_accept                      
+169     32      bind                            sys_bind                        
+170     32      connect                         sys_connect                     
+171     32      getpeername                     sys_getpeername                 
+172     32      getsockname                     sys_getsockname                 
+173     32      getsockopt                      sys_getsockopt                  compat_sys_getsockopt
+174     32      listen                          sys_listen                      
+175     32      recv                            sys_recv                        compat_sys_recv
+176     32      recvfrom                        sys_recvfrom                    compat_sys_recvfrom
+177     32      recvmsg                         sys_recvmsg                     compat_sys_recvmsg
+178     32      send                            sys_send                        
+179     32      sendmsg                         sys_sendmsg                     compat_sys_sendmsg
+180     32      sendto                          sys_sendto                      
+181     32      setsockopt                      sys_setsockopt                  compat_sys_setsockopt
+182     32      shutdown                        sys_shutdown                    
+183     32      socket                          sys_socket                      
+184     32      socketpair                      sys_socketpair                  
+185     32      setresuid                       sys_setresuid                   
+186     32      getresuid                       sys_getresuid                   
+187     32      query_module                    sys_ni_syscall                  
+188     32      poll                            sys_poll                        
+189     32      nfsservctl                      sys_ni_syscall                  
+190     32      setresgid                       sys_setresgid                   
+191     32      getresgid                       sys_getresgid                   
+192     32      prctl                           sys_prctl                       
+193     32      rt_sigreturn                    sys_rt_sigreturn                sys32_rt_sigreturn
+194     32      rt_sigaction                    sys_rt_sigaction                compat_sys_rt_sigaction
+195     32      rt_sigprocmask                  sys_rt_sigprocmask              compat_sys_rt_sigprocmask
+196     32      rt_sigpending                   sys_rt_sigpending               compat_sys_rt_sigpending
+197     32      rt_sigtimedwait                 sys_rt_sigtimedwait             compat_sys_rt_sigtimedwait
+198     32      rt_sigqueueinfo                 sys_rt_sigqueueinfo             compat_sys_rt_sigqueueinfo
+199     32      rt_sigsuspend                   sys_rt_sigsuspend               compat_sys_rt_sigsuspend
+200     32      pread64                         sys_pread64                     sys_32_pread
+201     32      pwrite64                        sys_pwrite64                    sys_32_pwrite
+202     32      chown                           sys_chown                       
+203     32      getcwd                          sys_getcwd                      
+204     32      capget                          sys_capget                      
+205     32      capset                          sys_capset                      
+206     32      sigaltstack                     sys_sigaltstack                 compat_sys_sigaltstack
+207     32      sendfile                        sys_sendfile                    compat_sys_sendfile
+208     32      getpmsg                         sys_ni_syscall                  
+209     32      putpmsg                         sys_ni_syscall                  
+210     32      mmap2                           sys_mips_mmap2                  
+211     32      truncate64                      sys_truncate64                  sys_32_truncate64
+212     32      ftruncate64                     sys_ftruncate64                 sys_32_ftruncate64
+213     32      stat64                          sys_stat64                      sys_newstat
+214     32      lstat64                         sys_lstat64                     sys_newlstat
+215     32      fstat64                         sys_fstat64                     sys_newfstat
+216     32      pivot_root                      sys_pivot_root                  
+217     32      mincore                         sys_mincore                     
+218     32      madvise                         sys_madvise                     
+219     32      getdents64                      sys_getdents64                  
+220     32      fcntl64                         sys_fcntl64                     compat_sys_fcntl64
+221     32      reserved221                     sys_ni_syscall                  
+222     32      gettid                          sys_gettid                      
+223     32      readahead                       sys_readahead                   sys32_readahead
+224     32      setxattr                        sys_setxattr                    
+225     32      lsetxattr                       sys_lsetxattr                   
+226     32      fsetxattr                       sys_fsetxattr                   
+227     32      getxattr                        sys_getxattr                    
+228     32      lgetxattr                       sys_lgetxattr                   
+229     32      fgetxattr                       sys_fgetxattr                   
+230     32      listxattr                       sys_listxattr                   
+231     32      llistxattr                      sys_llistxattr                  
+232     32      flistxattr                      sys_flistxattr                  
+233     32      removexattr                     sys_removexattr                 
+234     32      lremovexattr                    sys_lremovexattr                
+235     32      fremovexattr                    sys_fremovexattr                
+236     32      tkill                           sys_tkill                       
+237     32      sendfile64                      sys_sendfile64                  
+238     32      futex                           sys_futex                       compat_sys_futex
+239     32      sched_setaffinity               mipsmt_sys_sched_setaffinity    compat_sys_sched_setaffinity
+240     32      sched_getaffinity               mipsmt_sys_sched_getaffinity    compat_sys_sched_getaffinity
+241     32      io_setup                        sys_io_setup                    compat_sys_io_setup
+242     32      io_destroy                      sys_io_destroy                  
+243     32      io_getevents                    sys_io_getevents                compat_sys_io_getevents
+244     32      io_submit                       sys_io_submit                   compat_sys_io_submit
+245     32      io_cancel                       sys_io_cancel                   
+246     32      exit_group                      sys_exit_group                  
+247     32      lookup_dcookie                  sys_lookup_dcookie              compat_sys_lookup_dcookie
+248     32      epoll_create                    sys_epoll_create                
+249     32      epoll_ctl                       sys_epoll_ctl                   
+250     32      epoll_wait                      sys_epoll_wait                  
+251     32      remap_file_pages                sys_remap_file_pages            
+252     32      set_tid_address                 sys_set_tid_address             
+253     32      restart_syscall                 sys_restart_syscall             
+254     32      fadvise64                       sys_fadvise64_64                sys32_fadvise64_64
+255     32      statfs64                        sys_statfs64                    compat_sys_statfs64
+256     32      fstatfs64                       sys_fstatfs64                   compat_sys_fstatfs64
+257     32      timer_create                    sys_timer_create                compat_sys_timer_create
+258     32      timer_settime                   sys_timer_settime               compat_sys_timer_settime
+259     32      timer_gettime                   sys_timer_gettime               compat_sys_timer_gettime
+260     32      timer_getoverrun                sys_timer_getoverrun            
+261     32      timer_delete                    sys_timer_delete                
+262     32      clock_settime                   sys_clock_settime               compat_sys_clock_settime
+263     32      clock_gettime                   sys_clock_gettime               compat_sys_clock_gettime
+264     32      clock_getres                    sys_clock_getres                compat_sys_clock_getres
+265     32      clock_nanosleep                 sys_clock_nanosleep             compat_sys_clock_nanosleep
+266     32      tgkill                          sys_tgkill                      
+267     32      utimes                          sys_utimes                      compat_sys_utimes
+268     32      mbind                           sys_mbind                       compat_sys_mbind
+269     32      get_mempolicy                   sys_get_mempolicy               compat_sys_get_mempolicy
+270     32      set_mempolicy                   sys_set_mempolicy               compat_sys_set_mempolicy
+271     32      mq_open                         sys_mq_open                     compat_sys_mq_open
+272     32      mq_unlink                       sys_mq_unlink                   
+273     32      mq_timedsend                    sys_mq_timedsend                compat_sys_mq_timedsend
+274     32      mq_timedreceive                 sys_mq_timedreceive             compat_sys_mq_timedreceive
+275     32      mq_notify                       sys_mq_notify                   compat_sys_mq_notify
+276     32      mq_getsetattr                   sys_mq_getsetattr               compat_sys_mq_getsetattr
+277     32      vserver                         sys_ni_syscall                  
+278     32      waitid                          sys_waitid                      compat_sys_waitid
+279     32      sys_setaltroot                  sys_ni_syscall                  
+280     32      add_key                         sys_add_key                     
+281     32      request_key                     sys_request_key                 
+282     32      keyctl                          sys_keyctl                      compat_sys_keyctl
+283     32      set_thread_area                 sys_set_thread_area             
+284     32      inotify_init                    sys_inotify_init                
+285     32      inotify_add_watch               sys_inotify_add_watch           
+286     32      inotify_rm_watch                sys_inotify_rm_watch            
+287     32      migrate_pages                   sys_migrate_pages               compat_sys_migrate_pages
+288     32      openat                          sys_openat                      compat_sys_openat
+289     32      mkdirat                         sys_mkdirat                     
+290     32      mknodat                         sys_mknodat                     
+291     32      fchownat                        sys_fchownat                    
+292     32      futimesat                       sys_futimesat                   compat_sys_futimesat
+293     32      fstatat64                       sys_fstatat64                   sys_newfstatat
+294     32      unlinkat                        sys_unlinkat                    
+295     32      renameat                        sys_renameat                    
+296     32      linkat                          sys_linkat                      
+297     32      symlinkat                       sys_symlinkat                   
+298     32      readlinkat                      sys_readlinkat                  
+299     32      fchmodat                        sys_fchmodat                    
+300     32      faccessat                       sys_faccessat                   
+301     32      pselect6                        sys_pselect6                    compat_sys_pselect6
+302     32      ppoll                           sys_ppoll                       compat_sys_ppoll
+303     32      unshare                         sys_unshare                     
+304     32      splice                          sys_splice                      
+305     32      sync_file_range                 sys_sync_file_range             sys32_sync_file_range
+306     32      tee                             sys_tee                         
+307     32      vmsplice                        sys_vmsplice                    compat_sys_vmsplice
+308     32      move_pages                      sys_move_pages                  compat_sys_move_pages
+309     32      set_robust_list                 sys_set_robust_list             compat_sys_set_robust_list
+310     32      get_robust_list                 sys_get_robust_list             compat_sys_get_robust_list
+311     32      kexec_load                      sys_kexec_load                  compat_sys_kexec_load
+312     32      getcpu                          sys_getcpu                      
+313     32      epoll_pwait                     sys_epoll_pwait                 compat_sys_epoll_pwait
+314     32      ioprio_set                      sys_ioprio_set                  
+315     32      ioprio_get                      sys_ioprio_get                  
+316     32      utimensat                       sys_utimensat                   compat_sys_utimensat
+317     32      signalfd                        sys_signalfd                    compat_sys_signalfd
+318     32      timerfd                         sys_ni_syscall                  
+319     32      eventfd                         sys_eventfd                     
+320     32      fallocate                       sys_fallocate                   sys32_fallocate
+321     32      timerfd_create                  sys_timerfd_create              
+322     32      timerfd_gettime                 sys_timerfd_gettime             compat_sys_timerfd_gettime
+323     32      timerfd_settime                 sys_timerfd_settime             compat_sys_timerfd_settime
+324     32      signalfd4                       sys_signalfd4                   compat_sys_signalfd4
+325     32      eventfd2                        sys_eventfd2                    
+326     32      epoll_create1                   sys_epoll_create1               
+327     32      dup3                            sys_dup3                        
+328     32      pipe2                           sys_pipe2                       
+329     32      inotify_init1                   sys_inotify_init1               
+330     32      preadv                          sys_preadv                      compat_sys_preadv
+331     32      pwritev                         sys_pwritev                     compat_sys_pwritev
+332     32      rt_tgsigqueueinfo               sys_rt_tgsigqueueinfo           compat_sys_rt_tgsigqueueinfo
+333     32      perf_event_open                 sys_perf_event_open             
+334     32      accept4                         sys_accept4                     
+335     32      recvmmsg                        sys_recvmmsg                    compat_sys_recvmmsg
+336     32      fanotify_init                   sys_fanotify_init               
+337     32      fanotify_mark                   sys_fanotify_mark               compat_sys_fanotify_mark
+338     32      prlimit64                       sys_prlimit64                   
+339     32      name_to_handle_at               sys_name_to_handle_at           
+340     32      open_by_handle_at               sys_open_by_handle_at           compat_sys_open_by_handle_at
+341     32      clock_adjtime                   sys_clock_adjtime               compat_sys_clock_adjtime
+342     32      syncfs                          sys_syncfs                      
+343     32      sendmmsg                        sys_sendmmsg                    compat_sys_sendmmsg
+344     32      setns                           sys_setns                       
+345     32      process_vm_readv                sys_process_vm_readv            compat_sys_process_vm_readv
+346     32      process_vm_writev               sys_process_vm_writev           compat_sys_process_vm_writev
+347     32      kcmp                            sys_kcmp                        
+348     32      finit_module                    sys_finit_module                
+349     32      sched_setattr                   sys_sched_setattr               
+350     32      sched_getattr                   sys_sched_getattr               
+351     32      renameat2                       sys_renameat2                   
+352     32      seccomp                         sys_seccomp                     
+353     32      getrandom                       sys_getrandom                   
+354     32      memfd_create                    sys_memfd_create                
+355     32      bpf                             sys_bpf                         
+356     32      execveat                        sys_execveat                    compat_sys_execveat
+357     32      userfaultfd                     sys_userfaultfd                 
+358     32      membarrier                      sys_membarrier                  
+359     32      mlock2                          sys_mlock2                      
+360     32      copy_file_range                 sys_copy_file_range             
+361     32      preadv2                         sys_preadv2                     compat_sys_preadv2
+362     32      pwritev2                        sys_pwritev2                    compat_sys_pwritev2
+363     32      pkey_mprotect                   sys_pkey_mprotect               
+364     32      pkey_alloc                      sys_pkey_alloc                  
+365     32      pkey_free                       sys_pkey_free                   
+366     32      statx                           sys_statx                       
diff --git a/arch/mips/kernel/syscalls/syscall_64.tbl b/arch/mips/kernel/syscalls/syscall_64.tbl
new file mode 100644
index 0000000..9c4b3a0
--- /dev/null
+++ b/arch/mips/kernel/syscalls/syscall_64.tbl
@@ -0,0 +1,335 @@
+#
+# 64-bit system call numbers and entry vectors
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The abi is "common" for this file.
+#
+0       64      read                            sys_read                        
+1       64      write                           sys_write                       
+2       64      open                            sys_open                        
+3       64      close                           sys_close                       
+4       64      stat                            sys_newstat                     
+5       64      fstat                           sys_newfstat                    
+6       64      lstat                           sys_newlstat                    
+7       64      poll                            sys_poll                        
+8       64      lseek                           sys_lseek                       
+9       64      mmap                            sys_mips_mmap                   
+10      64      mprotect                        sys_mprotect                    
+11      64      munmap                          sys_munmap                      
+12      64      brk                             sys_brk                         
+13      64      rt_sigaction                    sys_rt_sigaction                
+14      64      rt_sigprocmask                  sys_rt_sigprocmask              
+15      64      ioctl                           sys_ioctl                       
+16      64      pread64                         sys_pread64                     
+17      64      pwrite64                        sys_pwrite64                    
+18      64      readv                           sys_readv                       
+19      64      writev                          sys_writev                      
+20      64      access                          sys_access                      
+21      64      pipe                            sysm_pipe                       
+22      64      _newselect                      sys_select                      
+23      64      sched_yield                     sys_sched_yield                 
+24      64      mremap                          sys_mremap                      
+25      64      msync                           sys_msync                       
+26      64      mincore                         sys_mincore                     
+27      64      madvise                         sys_madvise                     
+28      64      shmget                          sys_shmget                      
+29      64      shmat                           sys_shmat                       
+30      64      shmctl                          sys_shmctl                      
+31      64      dup                             sys_dup                         
+32      64      dup2                            sys_dup2                        
+33      64      pause                           sys_pause                       
+34      64      nanosleep                       sys_nanosleep                   
+35      64      getitimer                       sys_getitimer                   
+36      64      setitimer                       sys_setitimer                   
+37      64      alarm                           sys_alarm                       
+38      64      getpid                          sys_getpid                      
+39      64      sendfile                        sys_sendfile64                  
+40      64      socket                          sys_socket                      
+41      64      connect                         sys_connect                     
+42      64      accept                          sys_accept                      
+43      64      sendto                          sys_sendto                      
+44      64      recvfrom                        sys_recvfrom                    
+45      64      sendmsg                         sys_sendmsg                     
+46      64      recvmsg                         sys_recvmsg                     
+47      64      shutdown                        sys_shutdown                    
+48      64      bind                            sys_bind                        
+49      64      listen                          sys_listen                      
+50      64      getsockname                     sys_getsockname                 
+51      64      getpeername                     sys_getpeername                 
+52      64      socketpair                      sys_socketpair                  
+53      64      setsockopt                      sys_setsockopt                  
+54      64      getsockopt                      sys_getsockopt                  
+55      64      clone                           __sys_clone                     
+56      64      fork                            __sys_fork                      
+57      64      execve                          sys_execve                      
+58      64      exit                            sys_exit                        
+59      64      wait4                           sys_wait4                       
+60      64      kill                            sys_kill                        
+61      64      uname                           sys_newuname                    
+62      64      semget                          sys_semget                      
+63      64      semop                           sys_semop                       
+64      64      semctl                          sys_semctl                      
+65      64      shmdt                           sys_shmdt                       
+66      64      msgget                          sys_msgget                      
+67      64      msgsnd                          sys_msgsnd                      
+68      64      msgrcv                          sys_msgrcv                      
+69      64      msgctl                          sys_msgctl                      
+70      64      fcntl                           sys_fcntl                       
+71      64      flock                           sys_flock                       
+72      64      fsync                           sys_fsync                       
+73      64      fdatasync                       sys_fdatasync                   
+74      64      truncate                        sys_truncate                    
+75      64      ftruncate                       sys_ftruncate                   
+76      64      getdents                        sys_getdents                    
+77      64      getcwd                          sys_getcwd                      
+78      64      chdir                           sys_chdir                       
+79      64      fchdir                          sys_fchdir                      
+80      64      rename                          sys_rename                      
+81      64      mkdir                           sys_mkdir                       
+82      64      rmdir                           sys_rmdir                       
+83      64      creat                           sys_creat                       
+84      64      link                            sys_link                        
+85      64      unlink                          sys_unlink                      
+86      64      symlink                         sys_symlink                     
+87      64      readlink                        sys_readlink                    
+88      64      chmod                           sys_chmod                       
+89      64      fchmod                          sys_fchmod                      
+90      64      chown                           sys_chown                       
+91      64      fchown                          sys_fchown                      
+92      64      lchown                          sys_lchown                      
+93      64      umask                           sys_umask                       
+94      64      gettimeofday                    sys_gettimeofday                
+95      64      getrlimit                       sys_getrlimit                   
+96      64      getrusage                       sys_getrusage                   
+97      64      sysinfo                         sys_sysinfo                     
+98      64      times                           sys_times                       
+99      64      ptrace                          sys_ptrace                      
+100     64      getuid                          sys_getuid                      
+101     64      syslog                          sys_syslog                      
+102     64      getgid                          sys_getgid                      
+103     64      setuid                          sys_setuid                      
+104     64      setgid                          sys_setgid                      
+105     64      geteuid                         sys_geteuid                     
+106     64      getegid                         sys_getegid                     
+107     64      setpgid                         sys_setpgid                     
+108     64      getppid                         sys_getppid                     
+109     64      getpgrp                         sys_getpgrp                     
+110     64      setsid                          sys_setsid                      
+111     64      setreuid                        sys_setreuid                    
+112     64      setregid                        sys_setregid                    
+113     64      getgroups                       sys_getgroups                   
+114     64      setgroups                       sys_setgroups                   
+115     64      setresuid                       sys_setresuid                   
+116     64      getresuid                       sys_getresuid                   
+117     64      setresgid                       sys_setresgid                   
+118     64      getresgid                       sys_getresgid                   
+119     64      getpgid                         sys_getpgid                     
+120     64      setfsuid                        sys_setfsuid                    
+121     64      setfsgid                        sys_setfsgid                    
+122     64      getsid                          sys_getsid                      
+123     64      capget                          sys_capget                      
+124     64      capset                          sys_capset                      
+125     64      rt_sigpending                   sys_rt_sigpending               
+126     64      rt_sigtimedwait                 sys_rt_sigtimedwait             
+127     64      rt_sigqueueinfo                 sys_rt_sigqueueinfo             
+128     64      rt_sigsuspend                   sys_rt_sigsuspend               
+129     64      sigaltstack                     sys_sigaltstack                 
+130     64      utime                           sys_utime                       
+131     64      mknod                           sys_mknod                       
+132     64      personality                     sys_personality                 
+133     64      ustat                           sys_ustat                       
+134     64      statfs                          sys_statfs                      
+135     64      fstatfs                         sys_fstatfs                     
+136     64      sysfs                           sys_sysfs                       
+137     64      getpriority                     sys_getpriority                 
+138     64      setpriority                     sys_setpriority                 
+139     64      sched_setparam                  sys_sched_setparam              
+140     64      sched_getparam                  sys_sched_getparam              
+141     64      sched_setscheduler              sys_sched_setscheduler          
+142     64      sched_getscheduler              sys_sched_getscheduler          
+143     64      sched_get_priority_max          sys_sched_get_priority_max      
+144     64      sched_get_priority_min          sys_sched_get_priority_min      
+145     64      sched_rr_get_interval           sys_sched_rr_get_interval       
+146     64      mlock                           sys_mlock                       
+147     64      munlock                         sys_munlock                     
+148     64      mlockall                        sys_mlockall                    
+149     64      munlockall                      sys_munlockall                  
+150     64      vhangup                         sys_vhangup                     
+151     64      pivot_root                      sys_pivot_root                  
+152     64      _sysctl                         sys_sysctl                      
+153     64      prctl                           sys_prctl                       
+154     64      adjtimex                        sys_adjtimex                    
+155     64      setrlimit                       sys_setrlimit                   
+156     64      chroot                          sys_chroot                      
+157     64      sync                            sys_sync                        
+158     64      acct                            sys_acct                        
+159     64      settimeofday                    sys_settimeofday                
+160     64      mount                           sys_mount                       
+161     64      umount2                         sys_umount                      
+162     64      swapon                          sys_swapon                      
+163     64      swapoff                         sys_swapoff                     
+164     64      reboot                          sys_reboot                      
+165     64      sethostname                     sys_sethostname                 
+166     64      setdomainname                   sys_setdomainname               
+167     64      create_module                   sys_ni_syscall                  
+168     64      init_module                     sys_init_module                 
+169     64      delete_module                   sys_delete_module               
+170     64      get_kernel_syms                 sys_ni_syscall                  
+171     64      query_module                    sys_ni_syscall                  
+172     64      quotactl                        sys_quotactl                    
+173     64      nfsservctl                      sys_ni_syscall                  
+174     64      getpmsg                         sys_ni_syscall                  
+175     64      putpmsg                         sys_ni_syscall                  
+176     64      afs_syscall                     sys_ni_syscall                  
+177     64      reserved177                     sys_ni_syscall                  
+178     64      gettid                          sys_gettid                      
+179     64      readahead                       sys_readahead                   
+180     64      setxattr                        sys_setxattr                    
+181     64      lsetxattr                       sys_lsetxattr                   
+182     64      fsetxattr                       sys_fsetxattr                   
+183     64      getxattr                        sys_getxattr                    
+184     64      lgetxattr                       sys_lgetxattr                   
+185     64      fgetxattr                       sys_fgetxattr                   
+186     64      listxattr                       sys_listxattr                   
+187     64      llistxattr                      sys_llistxattr                  
+188     64      flistxattr                      sys_flistxattr                  
+189     64      removexattr                     sys_removexattr                 
+190     64      lremovexattr                    sys_lremovexattr                
+191     64      fremovexattr                    sys_fremovexattr                
+192     64      tkill                           sys_tkill                       
+193     64      reserved193                     sys_ni_syscall                  
+194     64      futex                           sys_futex                       
+195     64      sched_setaffinity               sys_sched_setaffinity           
+196     64      sched_getaffinity               sys_sched_getaffinity           
+197     64      cacheflush                      sys_cacheflush                  
+198     64      cachectl                        sys_cachectl                    
+199     64      sysmips                         __sys_sysmips                   
+200     64      io_setup                        sys_io_setup                    
+201     64      io_destroy                      sys_io_destroy                  
+202     64      io_getevents                    sys_io_getevents                
+203     64      io_submit                       sys_io_submit                   
+204     64      io_cancel                       sys_io_cancel                   
+205     64      exit_group                      sys_exit_group                  
+206     64      lookup_dcookie                  sys_lookup_dcookie              
+207     64      epoll_create                    sys_epoll_create                
+208     64      epoll_ctl                       sys_epoll_ctl                   
+209     64      epoll_wait                      sys_epoll_wait                  
+210     64      remap_file_pages                sys_remap_file_pages            
+211     64      rt_sigreturn                    sys_rt_sigreturn                
+212     64      set_tid_address                 sys_set_tid_address             
+213     64      restart_syscall                 sys_restart_syscall             
+214     64      semtimedop                      sys_semtimedop                  
+215     64      fadvise64                       sys_fadvise64_64                
+216     64      timer_create                    sys_timer_create                
+217     64      timer_settime                   sys_timer_settime               
+218     64      timer_gettime                   sys_timer_gettime               
+219     64      timer_getoverrun                sys_timer_getoverrun            
+220     64      timer_delete                    sys_timer_delete                
+221     64      clock_settime                   sys_clock_settime               
+222     64      clock_gettime                   sys_clock_gettime               
+223     64      clock_getres                    sys_clock_getres                
+224     64      clock_nanosleep                 sys_clock_nanosleep             
+225     64      tgkill                          sys_tgkill                      
+226     64      utimes                          sys_utimes                      
+227     64      mbind                           sys_mbind                       
+228     64      get_mempolicy                   sys_get_mempolicy               
+229     64      set_mempolicy                   sys_set_mempolicy               
+230     64      mq_open                         sys_mq_open                     
+231     64      mq_unlink                       sys_mq_unlink                   
+232     64      mq_timedsend                    sys_mq_timedsend                
+233     64      mq_timedreceive                 sys_mq_timedreceive             
+234     64      mq_notify                       sys_mq_notify                   
+235     64      mq_getsetattr                   sys_mq_getsetattr               
+236     64      vserver                         sys_ni_syscall                  
+237     64      waitid                          sys_waitid                      
+238     64      sys_setaltroot                  sys_ni_syscall                  
+239     64      add_key                         sys_add_key                     
+240     64      request_key                     sys_request_key                 
+241     64      keyctl                          sys_keyctl                      
+242     64      set_thread_area                 sys_set_thread_area             
+243     64      inotify_init                    sys_inotify_init                
+244     64      inotify_add_watch               sys_inotify_add_watch           
+245     64      inotify_rm_watch                sys_inotify_rm_watch            
+246     64      migrate_pages                   sys_migrate_pages               
+247     64      openat                          sys_openat                      
+248     64      mkdirat                         sys_mkdirat                     
+249     64      mknodat                         sys_mknodat                     
+250     64      fchownat                        sys_fchownat                    
+251     64      futimesat                       sys_futimesat                   
+252     64      newfstatat                      sys_newfstatat                  
+253     64      unlinkat                        sys_unlinkat                    
+254     64      renameat                        sys_renameat                    
+255     64      linkat                          sys_linkat                      
+256     64      symlinkat                       sys_symlinkat                   
+257     64      readlinkat                      sys_readlinkat                  
+258     64      fchmodat                        sys_fchmodat                    
+259     64      faccessat                       sys_faccessat                   
+260     64      pselect6                        sys_pselect6                    
+261     64      ppoll                           sys_ppoll                       
+262     64      unshare                         sys_unshare                     
+263     64      splice                          sys_splice                      
+264     64      sync_file_range                 sys_sync_file_range             
+265     64      tee                             sys_tee                         
+266     64      vmsplice                        sys_vmsplice                    
+267     64      move_pages                      sys_move_pages                  
+268     64      set_robust_list                 sys_set_robust_list             
+269     64      get_robust_list                 sys_get_robust_list             
+270     64      kexec_load                      sys_kexec_load                  
+271     64      getcpu                          sys_getcpu                      
+272     64      epoll_pwait                     sys_epoll_pwait                 
+273     64      ioprio_set                      sys_ioprio_set                  
+274     64      ioprio_get                      sys_ioprio_get                  
+275     64      utimensat                       sys_utimensat                   
+276     64      signalfd                        sys_signalfd                    
+277     64      timerfd                         sys_ni_syscall                  
+278     64      eventfd                         sys_eventfd                     
+279     64      fallocate                       sys_fallocate                   
+280     64      timerfd_create                  sys_timerfd_create              
+281     64      timerfd_gettime                 sys_timerfd_gettime             
+282     64      timerfd_settime                 sys_timerfd_settime             
+283     64      signalfd4                       sys_signalfd4                   
+284     64      eventfd2                        sys_eventfd2                    
+285     64      epoll_create1                   sys_epoll_create1               
+286     64      dup3                            sys_dup3                        
+287     64      pipe2                           sys_pipe2                       
+288     64      inotify_init1                   sys_inotify_init1               
+289     64      preadv                          sys_preadv                      
+290     64      pwritev                         sys_pwritev                     
+291     64      rt_tgsigqueueinfo               sys_rt_tgsigqueueinfo           
+292     64      perf_event_open                 sys_perf_event_open             
+293     64      accept4                         sys_accept4                     
+294     64      recvmmsg                        sys_recvmmsg                    
+295     64      fanotify_init                   sys_fanotify_init               
+296     64      fanotify_mark                   sys_fanotify_mark               
+297     64      prlimit64                       sys_prlimit64                   
+298     64      name_to_handle_at               sys_name_to_handle_at           
+299     64      open_by_handle_at               sys_open_by_handle_at           
+300     64      clock_adjtime                   sys_clock_adjtime               
+301     64      syncfs                          sys_syncfs                      
+302     64      sendmmsg                        sys_sendmmsg                    
+303     64      setns                           sys_setns                       
+304     64      process_vm_readv                sys_process_vm_readv            
+305     64      process_vm_writev               sys_process_vm_writev           
+306     64      kcmp                            sys_kcmp                        
+307     64      finit_module                    sys_finit_module                
+308     64      getdents64                      sys_getdents64                  
+309     64      sched_setattr                   sys_sched_setattr               
+310     64      sched_getattr                   sys_sched_getattr               
+311     64      renameat2                       sys_renameat2                   
+312     64      seccomp                         sys_seccomp                     
+313     64      getrandom                       sys_getrandom                   
+314     64      memfd_create                    sys_memfd_create                
+315     64      bpf                             sys_bpf                         
+316     64      execveat                        sys_execveat                    
+317     64      userfaultfd                     sys_userfaultfd                 
+318     64      membarrier                      sys_membarrier                  
+319     64      mlock2                          sys_mlock2                      
+320     64      copy_file_range                 sys_copy_file_range             
+321     64      preadv2                         sys_preadv2                     
+322     64      pwritev2                        sys_pwritev2                    
+323     64      pkey_mprotect                   sys_pkey_mprotect               
+324     64      pkey_alloc                      sys_pkey_alloc                  
+325     64      pkey_free                       sys_pkey_free                   
+326     64      statx                           sys_statx                       
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
new file mode 100644
index 0000000..69d2205
--- /dev/null
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -0,0 +1,339 @@
+#
+# 32-bit native system call numbers and entry vectors
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The abi is always "common" for this file.
+#
+0       n32     read                            sys_read                        
+1       n32     write                           sys_write                       
+2       n32     open                            sys_open                        
+3       n32     close                           sys_close                       
+4       n32     stat                            sys_newstat                     
+5       n32     fstat                           sys_newfstat                    
+6       n32     lstat                           sys_newlstat                    
+7       n32     poll                            sys_poll                        
+8       n32     lseek                           sys_lseek                       
+9       n32     mmap                            sys_mips_mmap                   
+10      n32     mprotect                        sys_mprotect                    
+11      n32     munmap                          sys_munmap                      
+12      n32     brk                             sys_brk                         
+13      n32     rt_sigaction                    compat_sys_rt_sigaction         
+14      n32     rt_sigprocmask                  compat_sys_rt_sigprocmask       
+15      n32     ioctl                           compat_sys_ioctl                
+16      n32     pread64                         sys_pread64                     
+17      n32     pwrite64                        sys_pwrite64                    
+18      n32     readv                           compat_sys_readv                
+19      n32     writev                          compat_sys_writev               
+20      n32     access                          sys_access                      
+21      n32     pipe                            sysm_pipe                       
+22      n32     _newselect                      compat_sys_select               
+23      n32     sched_yield                     sys_sched_yield                 
+24      n32     mremap                          sys_mremap                      
+25      n32     msync                           sys_msync                       
+26      n32     mincore                         sys_mincore                     
+27      n32     madvise                         sys_madvise                     
+28      n32     shmget                          sys_shmget                      
+29      n32     shmat                           sys_shmat                       
+30      n32     shmctl                          compat_sys_shmctl               
+31      n32     dup                             sys_dup                         
+32      n32     dup2                            sys_dup2                        
+33      n32     pause                           sys_pause                       
+34      n32     nanosleep                       compat_sys_nanosleep            
+35      n32     getitimer                       compat_sys_getitimer            
+36      n32     setitimer                       compat_sys_setitimer            
+37      n32     alarm                           sys_alarm                       
+38      n32     getpid                          sys_getpid                      
+39      n32     sendfile                        compat_sys_sendfile             
+40      n32     socket                          sys_socket                      
+41      n32     connect                         sys_connect                     
+42      n32     accept                          sys_accept                      
+43      n32     sendto                          sys_sendto                      
+44      n32     recvfrom                        compat_sys_recvfrom             
+45      n32     sendmsg                         compat_sys_sendmsg              
+46      n32     recvmsg                         compat_sys_recvmsg              
+47      n32     shutdown                        sys_shutdown                    
+48      n32     bind                            sys_bind                        
+49      n32     listen                          sys_listen                      
+50      n32     getsockname                     sys_getsockname                 
+51      n32     getpeername                     sys_getpeername                 
+52      n32     socketpair                      sys_socketpair                  
+53      n32     setsockopt                      compat_sys_setsockopt           
+54      n32     getsockopt                      compat_sys_getsockopt           
+55      n32     clone                           __sys_clone                     
+56      n32     fork                            __sys_fork                      
+57      n32     execve                          compat_sys_execve               
+58      n32     exit                            sys_exit                        
+59      n32     wait4                           compat_sys_wait4                
+60      n32     kill                            sys_kill                        
+61      n32     uname                           sys_newuname                    
+62      n32     semget                          sys_semget                      
+63      n32     semop                           sys_semop                       
+64      n32     semctl                          compat_sys_semctl               
+65      n32     shmdt                           sys_shmdt                       
+66      n32     msgget                          sys_msgget                      
+67      n32     msgsnd                          compat_sys_msgsnd               
+68      n32     msgrcv                          compat_sys_msgrcv               
+69      n32     msgctl                          compat_sys_msgctl               
+70      n32     fcntl                           compat_sys_fcntl                
+71      n32     flock                           sys_flock                       
+72      n32     fsync                           sys_fsync                       
+73      n32     fdatasync                       sys_fdatasync                   
+74      n32     truncate                        sys_truncate                    
+75      n32     ftruncate                       sys_ftruncate                   
+76      n32     getdents                        compat_sys_getdents             
+77      n32     getcwd                          sys_getcwd                      
+78      n32     chdir                           sys_chdir                       
+79      n32     fchdir                          sys_fchdir                      
+80      n32     rename                          sys_rename                      
+81      n32     mkdir                           sys_mkdir                       
+82      n32     rmdir                           sys_rmdir                       
+83      n32     creat                           sys_creat                       
+84      n32     link                            sys_link                        
+85      n32     unlink                          sys_unlink                      
+86      n32     symlink                         sys_symlink                     
+87      n32     readlink                        sys_readlink                    
+88      n32     chmod                           sys_chmod                       
+89      n32     fchmod                          sys_fchmod                      
+90      n32     chown                           sys_chown                       
+91      n32     fchown                          sys_fchown                      
+92      n32     lchown                          sys_lchown                      
+93      n32     umask                           sys_umask                       
+94      n32     gettimeofday                    compat_sys_gettimeofday         
+95      n32     getrlimit                       compat_sys_getrlimit            
+96      n32     getrusage                       compat_sys_getrusage            
+97      n32     sysinfo                         compat_sys_sysinfo              
+98      n32     times                           compat_sys_times                
+99      n32     ptrace                          compat_sys_ptrace               
+100     n32     getuid                          sys_getuid                      
+101     n32     syslog                          sys_syslog                      
+102     n32     getgid                          sys_getgid                      
+103     n32     setuid                          sys_setuid                      
+104     n32     setgid                          sys_setgid                      
+105     n32     geteuid                         sys_geteuid                     
+106     n32     getegid                         sys_getegid                     
+107     n32     setpgid                         sys_setpgid                     
+108     n32     getppid                         sys_getppid                     
+109     n32     getpgrp                         sys_getpgrp                     
+110     n32     setsid                          sys_setsid                      
+111     n32     setreuid                        sys_setreuid                    
+112     n32     setregid                        sys_setregid                    
+113     n32     getgroups                       sys_getgroups                   
+114     n32     setgroups                       sys_setgroups                   
+115     n32     setresuid                       sys_setresuid                   
+116     n32     getresuid                       sys_getresuid                   
+117     n32     setresgid                       sys_setresgid                   
+118     n32     getresgid                       sys_getresgid                   
+119     n32     getpgid                         sys_getpgid                     
+120     n32     setfsuid                        sys_setfsuid                    
+121     n32     setfsgid                        sys_setfsgid                    
+122     n32     getsid                          sys_getsid                      
+123     n32     capget                          sys_capget                      
+124     n32     capset                          sys_capset                      
+125     n32     rt_sigpending                   compat_sys_rt_sigpending        
+126     n32     rt_sigtimedwait                 compat_sys_rt_sigtimedwait      
+127     n32     rt_sigqueueinfo                 compat_sys_rt_sigqueueinfo      
+128     n32     rt_sigsuspend                   compat_sys_rt_sigsuspend        
+129     n32     sigaltstack                     compat_sys_sigaltstack          
+130     n32     utime                           compat_sys_utime                
+131     n32     mknod                           sys_mknod                       
+132     n32     personality                     sys_32_personality              
+133     n32     ustat                           compat_sys_ustat                
+134     n32     statfs                          compat_sys_statfs               
+135     n32     fstatfs                         compat_sys_fstatfs              
+136     n32     sysfs                           sys_sysfs                       
+137     n32     getpriority                     sys_getpriority                 
+138     n32     setpriority                     sys_setpriority                 
+139     n32     sched_setparam                  sys_sched_setparam              
+140     n32     sched_getparam                  sys_sched_getparam              
+141     n32     sched_setscheduler              sys_sched_setscheduler          
+142     n32     sched_getscheduler              sys_sched_getscheduler          
+143     n32     sched_get_priority_max          sys_sched_get_priority_max      
+144     n32     sched_get_priority_min          sys_sched_get_priority_min      
+145     n32     sched_rr_get_interval           compat_sys_sched_rr_get_interval
+146     n32     mlock                           sys_mlock                       
+147     n32     munlock                         sys_munlock                     
+148     n32     mlockall                        sys_mlockall                    
+149     n32     munlockall                      sys_munlockall                  
+150     n32     vhangup                         sys_vhangup                     
+151     n32     pivot_root                      sys_pivot_root                  
+152     n32     _sysctl                         compat_sys_sysctl               
+153     n32     prctl                           sys_prctl                       
+154     n32     adjtimex                        compat_sys_adjtimex             
+155     n32     setrlimit                       compat_sys_setrlimit            
+156     n32     chroot                          sys_chroot                      
+157     n32     sync                            sys_sync                        
+158     n32     acct                            sys_acct                        
+159     n32     settimeofday                    compat_sys_settimeofday         
+160     n32     mount                           compat_sys_mount                
+161     n32     umount2                         sys_umount                      
+162     n32     swapon                          sys_swapon                      
+163     n32     swapoff                         sys_swapoff                     
+164     n32     reboot                          sys_reboot                      
+165     n32     sethostname                     sys_sethostname                 
+166     n32     setdomainname                   sys_setdomainname               
+167     n32     create_module                   sys_ni_syscall                  
+168     n32     init_module                     sys_init_module                 
+169     n32     delete_module                   sys_delete_module               
+170     n32     get_kernel_syms                 sys_ni_syscall                  
+171     n32     query_module                    sys_ni_syscall                  
+172     n32     quotactl                        sys_quotactl                    
+173     n32     nfsservctl                      sys_ni_syscall                  
+174     n32     getpmsg                         sys_ni_syscall                  
+175     n32     putpmsg                         sys_ni_syscall                  
+176     n32     afs_syscall                     sys_ni_syscall                  
+177     n32     reserved177                     sys_ni_syscall                  
+178     n32     gettid                          sys_gettid                      
+179     n32     readahead                       sys_readahead                   
+180     n32     setxattr                        sys_setxattr                    
+181     n32     lsetxattr                       sys_lsetxattr                   
+182     n32     fsetxattr                       sys_fsetxattr                   
+183     n32     getxattr                        sys_getxattr                    
+184     n32     lgetxattr                       sys_lgetxattr                   
+185     n32     fgetxattr                       sys_fgetxattr                   
+186     n32     listxattr                       sys_listxattr                   
+187     n32     llistxattr                      sys_llistxattr                  
+188     n32     flistxattr                      sys_flistxattr                  
+189     n32     removexattr                     sys_removexattr                 
+190     n32     lremovexattr                    sys_lremovexattr                
+191     n32     fremovexattr                    sys_fremovexattr                
+192     n32     tkill                           sys_tkill                       
+193     n32     reserved193                     sys_ni_syscall                  
+194     n32     futex                           compat_sys_futex                
+195     n32     sched_setaffinity               compat_sys_sched_setaffinity    
+196     n32     sched_getaffinity               compat_sys_sched_getaffinity    
+197     n32     cacheflush                      sys_cacheflush                  
+198     n32     cachectl                        sys_cachectl                    
+199     n32     sysmips                         __sys_sysmips                   
+200     n32     io_setup                        compat_sys_io_setup             
+201     n32     io_destroy                      sys_io_destroy                  
+202     n32     io_getevents                    compat_sys_io_getevents         
+203     n32     io_submit                       compat_sys_io_submit            
+204     n32     io_cancel                       sys_io_cancel                   
+205     n32     exit_group                      sys_exit_group                  
+206     n32     lookup_dcookie                  sys_lookup_dcookie              
+207     n32     epoll_create                    sys_epoll_create                
+208     n32     epoll_ctl                       sys_epoll_ctl                   
+209     n32     epoll_wait                      sys_epoll_wait                  
+210     n32     remap_file_pages                sys_remap_file_pages            
+211     n32     rt_sigreturn                    sysn32_rt_sigreturn             
+212     n32     fcntl64                         compat_sys_fcntl64              
+213     n32     set_tid_address                 sys_set_tid_address             
+214     n32     restart_syscall                 sys_restart_syscall             
+215     n32     semtimedop                      compat_sys_semtimedop           
+216     n32     fadvise64                       sys_fadvise64_64                
+217     n32     statfs64                        compat_sys_statfs64             
+218     n32     fstatfs64                       compat_sys_fstatfs64            
+219     n32     sendfile64                      sys_sendfile64                  
+220     n32     timer_create                    compat_sys_timer_create         
+221     n32     timer_settime                   compat_sys_timer_settime        
+222     n32     timer_gettime                   compat_sys_timer_gettime        
+223     n32     timer_getoverrun                sys_timer_getoverrun            
+224     n32     timer_delete                    sys_timer_delete                
+225     n32     clock_settime                   compat_sys_clock_settime        
+226     n32     clock_gettime                   compat_sys_clock_gettime        
+227     n32     clock_getres                    compat_sys_clock_getres         
+228     n32     clock_nanosleep                 compat_sys_clock_nanosleep      
+229     n32     tgkill                          sys_tgkill                      
+230     n32     utimes                          compat_sys_utimes               
+231     n32     mbind                           compat_sys_mbind                
+232     n32     get_mempolicy                   compat_sys_get_mempolicy        
+233     n32     set_mempolicy                   compat_sys_set_mempolicy        
+234     n32     mq_open                         compat_sys_mq_open              
+235     n32     mq_unlink                       sys_mq_unlink                   
+236     n32     mq_timedsend                    compat_sys_mq_timedsend         
+237     n32     mq_timedreceive                 compat_sys_mq_timedreceive      
+238     n32     mq_notify                       compat_sys_mq_notify            
+239     n32     mq_getsetattr                   compat_sys_mq_getsetattr        
+240     n32     vserver                         sys_ni_syscall                  
+241     n32     waitid                          compat_sys_waitid               
+242     n32     sys_setaltroot                  sys_ni_syscall                  
+243     n32     add_key                         sys_add_key                     
+244     n32     request_key                     sys_request_key                 
+245     n32     keyctl                          compat_sys_keyctl               
+246     n32     set_thread_area                 sys_set_thread_area             
+247     n32     inotify_init                    sys_inotify_init                
+248     n32     inotify_add_watch               sys_inotify_add_watch           
+249     n32     inotify_rm_watch                sys_inotify_rm_watch            
+250     n32     migrate_pages                   compat_sys_migrate_pages        
+251     n32     openat                          sys_openat                      
+252     n32     mkdirat                         sys_mkdirat                     
+253     n32     mknodat                         sys_mknodat                     
+254     n32     fchownat                        sys_fchownat                    
+255     n32     futimesat                       compat_sys_futimesat            
+256     n32     newfstatat                      sys_newfstatat                  
+257     n32     unlinkat                        sys_unlinkat                    
+258     n32     renameat                        sys_renameat                    
+259     n32     linkat                          sys_linkat                      
+260     n32     symlinkat                       sys_symlinkat                   
+261     n32     readlinkat                      sys_readlinkat                  
+262     n32     fchmodat                        sys_fchmodat                    
+263     n32     faccessat                       sys_faccessat                   
+264     n32     pselect6                        compat_sys_pselect6             
+265     n32     ppoll                           compat_sys_ppoll                
+266     n32     unshare                         sys_unshare                     
+267     n32     splice                          sys_splice                      
+268     n32     sync_file_range                 sys_sync_file_range             
+269     n32     tee                             sys_tee                         
+270     n32     vmsplice                        compat_sys_vmsplice             
+271     n32     move_pages                      compat_sys_move_pages           
+272     n32     set_robust_list                 compat_sys_set_robust_list      
+273     n32     get_robust_list                 compat_sys_get_robust_list      
+274     n32     kexec_load                      compat_sys_kexec_load           
+275     n32     getcpu                          sys_getcpu                      
+276     n32     epoll_pwait                     compat_sys_epoll_pwait          
+277     n32     ioprio_set                      sys_ioprio_set                  
+278     n32     ioprio_get                      sys_ioprio_get                  
+279     n32     utimensat                       compat_sys_utimensat            
+280     n32     signalfd                        compat_sys_signalfd             
+281     n32     timerfd                         sys_ni_syscall                  
+282     n32     eventfd                         sys_eventfd                     
+283     n32     fallocate                       sys_fallocate                   
+284     n32     timerfd_create                  sys_timerfd_create              
+285     n32     timerfd_gettime                 compat_sys_timerfd_gettime      
+286     n32     timerfd_settime                 compat_sys_timerfd_settime      
+287     n32     signalfd4                       compat_sys_signalfd4            
+288     n32     eventfd2                        sys_eventfd2                    
+289     n32     epoll_create1                   sys_epoll_create1               
+290     n32     dup3                            sys_dup3                        
+291     n32     pipe2                           sys_pipe2                       
+292     n32     inotify_init1                   sys_inotify_init1               
+293     n32     preadv                          compat_sys_preadv               
+294     n32     pwritev                         compat_sys_pwritev              
+295     n32     rt_tgsigqueueinfo               compat_sys_rt_tgsigqueueinfo    
+296     n32     perf_event_open                 sys_perf_event_open             
+297     n32     accept4                         sys_accept4                     
+298     n32     recvmmsg                        compat_sys_recvmmsg             
+299     n32     getdents64                      sys_getdents64                  
+300     n32     fanotify_init                   sys_fanotify_init               
+301     n32     fanotify_mark                   sys_fanotify_mark               
+302     n32     prlimit64                       sys_prlimit64                   
+303     n32     name_to_handle_at               sys_name_to_handle_at           
+304     n32     open_by_handle_at               sys_open_by_handle_at           
+305     n32     clock_adjtime                   compat_sys_clock_adjtime        
+306     n32     syncfs                          sys_syncfs                      
+307     n32     sendmmsg                        compat_sys_sendmmsg             
+308     n32     setns                           sys_setns                       
+309     n32     process_vm_readv                compat_sys_process_vm_readv     
+310     n32     process_vm_writev               compat_sys_process_vm_writev    
+311     n32     kcmp                            sys_kcmp                        
+312     n32     finit_module                    sys_finit_module                
+313     n32     sched_setattr                   sys_sched_setattr               
+314     n32     sched_getattr                   sys_sched_getattr               
+315     n32     renameat2                       sys_renameat2                   
+316     n32     seccomp                         sys_seccomp                     
+317     n32     getrandom                       sys_getrandom                   
+318     n32     memfd_create                    sys_memfd_create                
+319     n32     bpf                             sys_bpf                         
+320     n32     execveat                        compat_sys_execveat             
+321     n32     userfaultfd                     sys_userfaultfd                 
+322     n32     membarrier                      sys_membarrier                  
+323     n32     mlock2                          sys_mlock2                      
+324     n32     copy_file_range                 sys_copy_file_range             
+325     n32     preadv2                         compat_sys_preadv2              
+326     n32     pwritev2                        compat_sys_pwritev2             
+327     n32     pkey_mprotect                   sys_pkey_mprotect               
+328     n32     pkey_alloc                      sys_pkey_alloc                  
+329     n32     pkey_free                       sys_pkey_free                   
+330     n32     statx                           sys_statx                       
diff --git a/arch/mips/kernel/syscalls/syscallhdr.sh b/arch/mips/kernel/syscalls/syscallhdr.sh
new file mode 100644
index 0000000..54ace2e
--- /dev/null
+++ b/arch/mips/kernel/syscalls/syscallhdr.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=_UAPI_ASM_MIPS_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    echo "#ifndef ${fileguard}"
+    echo "#define ${fileguard}"
+    echo ""
+
+    nxt=0
+    while read nr abi name entry compat ; do
+	if [ -z "$offset" ]; then
+	    echo -e "#define __NR_${prefix}${name}\t$nr"
+	else
+	    echo -e "#define __NR_${prefix}${name}\t($offset + $nr)"
+	fi
+	nxt=$nr
+	let nxt=nxt+1
+    done
+
+    echo ""
+    if [ -z "$offset" ]; then
+        echo -e "#define __NR_syscalls\t$nxt"
+    else
+        echo -e "#define __NR_syscalls\t($offset + $nxt)"
+    fi
+    echo ""
+    echo "#endif /* ${fileguard} */"
+) > "$out"
diff --git a/arch/mips/kernel/syscalls/syscalltbl.sh b/arch/mips/kernel/syscalls/syscalltbl.sh
new file mode 100644
index 0000000..2d92857
--- /dev/null
+++ b/arch/mips/kernel/syscalls/syscalltbl.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abi="$3"
+
+emit() {
+    nxt="$1"
+    nr="$2"
+    entry="$3"
+    
+    while [ $nxt -lt $nr ]; do
+	echo "__SYSCALL($nxt, sys_ni_syscall, )"
+        let nxt=nxt+1
+    done
+    
+    echo "__SYSCALL($nr, $entry, )"
+}
+
+grep '^[0-9]' "$in" | sort -n | (
+    nxt=4000
+    while read nr abi name entry compat ; do
+	if [ "$my_abi" = "32-o32" ]; then 
+	    let t_nxt=$nxt+0
+            emit $t_nxt $nr $entry
+	elif [ "$my_abi" = "64-o32" ]; then
+	    let t_nxt=$nxt+0
+	    if [ -z "$compat" ]; then
+		emit $t_nxt $nr $entry
+	    else
+		emit $t_nxt $nr $compat
+	    fi
+	elif [ "$my_abi" = "64-64" ]; then
+	    let t_nxt=$nxt+1000
+            emit $t_nxt $nr $entry
+	elif [ "$my_abi" = "64-n32" ]; then
+	    let t_nxt=$nxt+2000
+            emit $t_nxt $nr $entry
+	fi
+	nxt=$nr
+        let nxt=nxt+1
+    done
+) > "$out"
-- 
1.9.1

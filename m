Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 10:39:23 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:44648
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeINIjML39ii (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 10:39:12 +0200
Received: by mail-pf1-x444.google.com with SMTP id k21-v6so3968106pff.11
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8sjNGCK0zN8Sat8B+C2dpluIvjVDRmCNhIkEV3iqyxk=;
        b=eUA2nLyGRnjctydMlUwUjC3Zxsc9DA/J82h+uIGSi8+vWSqmJzyxPAKSxM7bMEnzVx
         fo63TbdMJV6SK1XpOEl6tZcYIRV27B+Mr+7vi4jcILUDLv58yf2sox7cYv9pe9tAlqZf
         yWkBCl7erYbgqzh9BsfPxeARsAUhX+mkhWxcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8sjNGCK0zN8Sat8B+C2dpluIvjVDRmCNhIkEV3iqyxk=;
        b=SXPyPdtEJZjvjk3pa+Z9kOO8fL9WA+aCbDyOZ7J108GcXeCTbbRcXjke7floo/FGAY
         cy4dZRBoSr6WpE59cvoo2oWzsvGyWf1bQBFSL6qhJcP0t36idR6iGTDOn/blyP2zoPln
         ngCgdcNah2nqFrRlH2QG3Y+H1NhmSorn8/9BkopMtoNfEukXFGSQ1nGFdR4Ajq+aOgsg
         nUrhve96GrdhSs+1d1gc0POfwnyXVsTP5wPGneV2IHWQfM1o5pARoYo4CpNXq/JUHr9f
         8Edk50eG9sGXb991xPnow+mP7OAYWVzXLRLNFKkcQ0ieo6DDOa+h3AKYQKCgK6vJJz2G
         nAKA==
X-Gm-Message-State: APzg51BREx9ZS6efWJ6pd0PehLW6buK3cgqAoiPs9jf802IVEceYK/w2
        ksu0hFKz8cXM1grsPaYZl2skSQ==
X-Google-Smtp-Source: ANB0VdYSQefJPnfjKiiNTKhOzmrG9jTnmR1DZi4aEJwRTgwHs2CaawPWyDZmWLzxOiDKCa+oIbAfSg==
X-Received: by 2002:a63:6746:: with SMTP id b67-v6mr10773208pgc.330.1536914345455;
        Fri, 14 Sep 2018 01:39:05 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id c1-v6sm11664289pfg.25.2018.09.14.01.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:39:04 -0700 (PDT)
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
Subject: [PATCH 0/3] System call table generation support
Date:   Fri, 14 Sep 2018 14:08:31 +0530
Message-Id: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66237
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

The purpose of this patch series is:
1. We can easily add/modify/delete system call by changing entry 
in syscall.tbl file. No need to manually edit many files.

2. It is easy to unify the system call implementation across all 
the architectures. 

The system call tables are in different format in all architecture 
and it will be difficult to manually add or modify the system calls
in the respective files manually. To make it easy by keeping a script 
and which'll generate the header file and syscall table file so this 
change will unify them across all architectures.

syscall.tbl contains the list of available system calls along with 
system call number and corresponding entry point. Add a new system 
call in this architecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
        - Compat entry name, if required.

ARM, s390 and x86 architecuture does exist the similar support. I 
leverage their implementation to come up with a generic solution.

I have done the same support for work for alpha, m68k, microblaze, 
ia64, powerpc, parisc, sh, sparc, and xtensa. But I started sending 
the patch for one architecuture for review. Below mentioned git
repository contains more details.
Git repo:- https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work for solving the Y2038 issue. We 
need to add/change two dozen of system calls to solve Y2038 issue. 
So this patch series will help to easily modify from existing 
system call to Y2038 compatible system calls.

I started working system call table generation on 4.17-rc1. I used 
marcin's script - https://github.com/hrw/syscalls-table to generate 
the syscall.tbl file. And this will be the input to the system call 
table generation script. But there are couple system call got add 
in the latest rc release. If run Marcin's script on latest release,
It will generate a new syscall.tbl. But I still use the old file - 
syscall.tbl and once all review got over I'll update syscall.tbl 
alone w.r.to the tip of the kernel. The impact of this thing, few 
of the system call won't work. 

Firoz Khan (3):
  mips: Add __NR_syscalls macro in uapi/asm/unistd.h
  mips: Add system call table generation support
  mips: uapi header and system call table file generation

 arch/mips/Makefile                        |    3 +
 arch/mips/include/asm/Kbuild              |    4 +
 arch/mips/include/uapi/asm/Kbuild         |    3 +
 arch/mips/include/uapi/asm/unistd.h       | 1053 +----------------------------
 arch/mips/kernel/scall32-o32.S            |  385 +----------
 arch/mips/kernel/scall64-64.S             |  334 +--------
 arch/mips/kernel/scall64-n32.S            |  337 +--------
 arch/mips/kernel/scall64-o32.S            |  374 +---------
 arch/mips/kernel/syscall_table_32_o32.S   |    8 +
 arch/mips/kernel/syscall_table_64_64.S    |    9 +
 arch/mips/kernel/syscall_table_64_n32.S   |    8 +
 arch/mips/kernel/syscall_table_64_o32.S   |    9 +
 arch/mips/kernel/syscalls/Makefile        |   62 ++
 arch/mips/kernel/syscalls/README.md       |   16 +
 arch/mips/kernel/syscalls/syscall_32.tbl  |  375 ++++++++++
 arch/mips/kernel/syscalls/syscall_64.tbl  |  335 +++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl |  339 ++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |   37 +
 arch/mips/kernel/syscalls/syscalltbl.sh   |   44 ++
 19 files changed, 1268 insertions(+), 2467 deletions(-)
 create mode 100644 arch/mips/kernel/syscall_table_32_o32.S
 create mode 100644 arch/mips/kernel/syscall_table_64_64.S
 create mode 100644 arch/mips/kernel/syscall_table_64_n32.S
 create mode 100644 arch/mips/kernel/syscall_table_64_o32.S
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/README.md
 create mode 100644 arch/mips/kernel/syscalls/syscall_32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

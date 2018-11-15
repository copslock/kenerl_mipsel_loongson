Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 07:16:11 +0100 (CET)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:33756
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeKOGOuecWS4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 07:14:50 +0100
Received: by mail-pg1-x542.google.com with SMTP id z11so5893623pgu.0
        for <linux-mips@linux-mips.org>; Wed, 14 Nov 2018 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0tQIHbtWTEJXDVXezxM6VBnYKAKgJoIsp5A5yYAdlQg=;
        b=VPah5N159BVpjL349YtPuPT+YVt1gIH7iBwUW9b2mUpivzQJO1ybkSc8zqWU/dFQf6
         lXpEccUq92OsdpCrAwoeeMkXNFitNLF3NID0xMKkBro6pfzea0YscmN5LTcZET5oWXIh
         2+HtjHWrcZPayDMhW4GFty0moCf3nJ4l5bvzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0tQIHbtWTEJXDVXezxM6VBnYKAKgJoIsp5A5yYAdlQg=;
        b=K64y90gvSdanF0ctZgFiv0/ouBghwetIg4Fy5ao5lUw3fxAVFHymKiOzAiy3bioraT
         4X9X7yZh5qqSHZVMjpBlGS3nepbW3eN264lKsq4CMjal66VnP1LXO+lJeyqgxikBt8oY
         1j6w5t/jvVJLfuyekB5uhtrpWOqnvlYne/xZIn3B0+igPnmq2LSF3a3IS8h/Hut2etog
         IYw654RbPSwg/mCLgRCQFqsMxvRJDUL0M3WPPSr/S6Z9t767JibJ8J+gxcKQSdEahoT+
         hOPfW0/pcouoQR5pgNEqheezxu5G9++XE/qL1aeKAKO1vxsVRIMr23WNkLdN+KLVdUAf
         MSQQ==
X-Gm-Message-State: AGRZ1gI0DFE7ZDI78hT/lZpwKvgt8lQl3DubbUcDFZCXEj5FX6wWRXvF
        itiiS9MQZzI9nTmHBKSs2PgIog==
X-Google-Smtp-Source: AJdET5e2iv148bBfWIb1prGb1HZjBPhAD47bBzZRq/WMEiJ/ZeRr/L2OSDGTJZMYjZgg8qCpHkioDw==
X-Received: by 2002:a62:6881:: with SMTP id d123-v6mr5245567pfc.195.1542262489435;
        Wed, 14 Nov 2018 22:14:49 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm39861931pgp.90.2018.11.14.22.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 22:14:48 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v2 0/5] mips: system call table generation support
Date:   Thu, 15 Nov 2018 11:44:16 +0530
Message-Id: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67299
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

The purpose of this patch series is, we can easily
add/modify/delete system call table support by cha-
nging entry in syscall.tbl file instead of manually
changing many files. The other goal is to unify the 
system call table generation support implementation 
across all the architectures. 

The system call tables are in different format in 
all architecture. It will be difficult to manually
add, modify or delete the system calls in the resp-
ective files manually. To make it easy by keeping a 
script and which'll generate uapi header file and 
syscall table file.

syscall.tbl contains the list of available system 
calls along with system call number and correspond-
ing entry point. Add a new system call in this arch-
itecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
	- Compat entry name, if required.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to 
come up with a generic solution.

I have done the same support for work for alpha, 
ia64, m68k, microblaze, parisc, powerpc, sh, sparc, 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in
the syscall.tbl.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (5):
  mips: add __NR_syscalls along with __NR_Linux_syscalls
  mips: add +1 to __NR_syscalls in uapi header
  mips: remove syscall table entries
  mips: add system call table generation support
  mips: generate uapi header and system call table files

 arch/mips/Makefile                        |    3 +
 arch/mips/include/asm/Kbuild              |    4 +
 arch/mips/include/asm/unistd.h            |    6 +-
 arch/mips/include/uapi/asm/Kbuild         |    3 +
 arch/mips/include/uapi/asm/unistd.h       | 1057 +----------------------------
 arch/mips/kernel/ftrace.c                 |    6 +-
 arch/mips/kernel/scall32-o32.S            |  390 +----------
 arch/mips/kernel/scall64-64.S             |  335 +--------
 arch/mips/kernel/scall64-n32.S            |  341 +---------
 arch/mips/kernel/scall64-o32.S            |  379 +----------
 arch/mips/kernel/syscalls/Makefile        |   71 ++
 arch/mips/kernel/syscalls/syscall_64.tbl  |  339 +++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl |  343 ++++++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl |  382 +++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |   36 +
 arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
 16 files changed, 1259 insertions(+), 2472 deletions(-)
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/syscall_64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

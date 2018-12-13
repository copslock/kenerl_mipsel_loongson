Return-Path: <SRS0=Dbp0=OW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFDC65BAE
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726E220873
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 09:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ltorjs70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726E220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLMJIU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:08:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34631 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeLMJIR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 13 Dec 2018 04:08:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so778110plz.1
        for <linux-mips@vger.kernel.org>; Thu, 13 Dec 2018 01:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=j2k0a//87b8BQ/RyZIuhn5c4saHG+Uhyajpr2bzW4H8=;
        b=Ltorjs70XmGENTwmEPHcYSbo0zk0wYzeVt4HBZIWN9Yp+GI8ACqYMaGddkFtl/U+Ly
         J98c+BrUd00yn1kDR89fnJQzcRdctwN6mLRQUaAAU49aey0eDWo5dtNZ7mQoHZpOINt/
         6/8nuHobp568d5oMQZ1qZmkb8VA+v+O9sOZ+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j2k0a//87b8BQ/RyZIuhn5c4saHG+Uhyajpr2bzW4H8=;
        b=MiXNxaeGlAZslKFaZpyokMvLXcFE8Dm4d1OUVu4dgzk6ToNaT012UyIvffS0wv7NP2
         ztTtJomDrLlmu//V05at8VCIV83qvg3f8jmMHr9S7VYxPP4bQa5Lozw1CJd7m1A2I7Mv
         JKIzhGFclhWFa1GzspiXfYbLt5ehIu+dB4oDbJzUyIZo1VIESJp3xnBUtZH/61IUE069
         qbwdk8xoWV6kyvKzg4k2t7i2EmdsbDENARGW1cbOSl9maSQ3tbmEFm1C/DVu9c0Uq+FM
         OasngQiYIPkQ5P3NlwDFj+556RPiw/B1BYvUhHnuqGzQrpOfLFt79qWx7XP9ChxGY1S5
         z8YA==
X-Gm-Message-State: AA+aEWZhCB/AzLT67arV1qmAKfpMyZnPD7mOB2xyIuKYUXa3hHetxmFX
        ornwMePeyasnmDON8dg7mYr1ebdj49I=
X-Google-Smtp-Source: AFSGD/XI+lUdFAm5J5scGOj1hibFtH9g5aNHgX/fxG8xqZsRXibALAPtFYdHXCksBh+WI3FGeMAbIQ==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10mr23050507plb.192.1544692096246;
        Thu, 13 Dec 2018 01:08:16 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id m11sm1650533pgh.51.2018.12.13.01.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:08:15 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 0/7] mips: system call table generation support
Date:   Thu, 13 Dec 2018 14:37:32 +0530
Message-Id: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

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

Changes since v4:
 - _MIPS_SIM_ABIN64 (suppose to be _MIPS_SIM_NABI64)
   macro rename back to _MIPS_SIM_ABI64 to avoid
   toolchain issue. 

Changes since v3:
 - rearranged the patches for '64' to 'n64' conver-
   sion.
 - moved the unistd_nr_*.h files to asm/unistd.h
 - modified the *.sh files.

Changes since v2:
 - fixed __NR_syscalls assign issue.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (7):
  mips: add __NR_syscalls along with __NR_Linux_syscalls
  mips: remove unused macros
  mips: rename macros and files from '64' to 'n64'
  mips: add +1 to __NR_syscalls in uapi header
  mips: remove syscall table entries
  mips: add system call table generation support
  mips: generate uapi header and system call table files

 arch/mips/Makefile                        |    3 +
 arch/mips/include/asm/Kbuild              |    4 +
 arch/mips/include/asm/unistd.h            |   11 +-
 arch/mips/include/uapi/asm/Kbuild         |    6 +
 arch/mips/include/uapi/asm/unistd.h       | 1074 +----------------------------
 arch/mips/kernel/Makefile                 |    2 +-
 arch/mips/kernel/ftrace.c                 |    8 +-
 arch/mips/kernel/scall32-o32.S            |  391 +----------
 arch/mips/kernel/scall64-64.S             |  444 ------------
 arch/mips/kernel/scall64-n32.S            |  341 +--------
 arch/mips/kernel/scall64-n64.S            |  117 ++++
 arch/mips/kernel/scall64-o32.S            |  379 +---------
 arch/mips/kernel/syscalls/Makefile        |   96 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl |  343 +++++++++
 arch/mips/kernel/syscalls/syscall_n64.tbl |  339 +++++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl |  382 ++++++++++
 arch/mips/kernel/syscalls/syscallhdr.sh   |   37 +
 arch/mips/kernel/syscalls/syscallnr.sh    |   28 +
 arch/mips/kernel/syscalls/syscalltbl.sh   |   36 +
 19 files changed, 1427 insertions(+), 2614 deletions(-)
 delete mode 100644 arch/mips/kernel/scall64-64.S
 create mode 100644 arch/mips/kernel/scall64-n64.S
 create mode 100644 arch/mips/kernel/syscalls/Makefile
 create mode 100644 arch/mips/kernel/syscalls/syscall_n32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_n64.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscall_o32.tbl
 create mode 100644 arch/mips/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscallnr.sh
 create mode 100644 arch/mips/kernel/syscalls/syscalltbl.sh

-- 
1.9.1


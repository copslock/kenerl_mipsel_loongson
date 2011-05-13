Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 14:39:44 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:49448 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491816Ab1EMMjl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 14:39:41 +0200
Received: by fxm14 with SMTP id 14so2302504fxm.36
        for <linux-mips@linux-mips.org>; Fri, 13 May 2011 05:39:35 -0700 (PDT)
Received: by 10.223.85.155 with SMTP id o27mr1619874fal.109.1305290375340;
        Fri, 13 May 2011 05:39:35 -0700 (PDT)
Received: from localhost.localdomain (540371FD.catv.pool.telekom.hu [84.3.113.253])
        by mx.google.com with ESMTPS id 18sm568268fan.25.2011.05.13.05.39.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 05:39:34 -0700 (PDT)
From:   Gergely Kis <gergely@homejinni.com>
To:     linux-mips@linux-mips.org
Cc:     oprofile-list@lists.sourceforge.net,
        Daniel Kalmar <kalmard@homejinni.com>
Subject: [PATCH 0/2] MIPS: oprofile: callgraph support
Date:   Fri, 13 May 2011 12:38:03 +0000
Message-Id: <1305290285-13818-1-git-send-email-gergely@homejinni.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <gergely@homejinni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gergely@homejinni.com
Precedence: bulk
X-list: linux-mips

From: Daniel Kalmar <kalmard@homejinni.com>

These patches add callgraph/backtrace support to oprofile on MIPS.

Stack unwinding is done by code examination. For kernelspace, the
already existing unwind function is utilized that uses kallsyms to
quickly find the beginning of functions. For userspace a new function
was added that examines code at and before the pc.

Daniel Kalmar (2):
  MIPS: Add unwind_stack_by_address to support unwinding from any
    kernel code address
  MIPS: oprofile: Add callgraph support

 arch/mips/include/asm/stacktrace.h |    4 +
 arch/mips/kernel/process.c         |   18 +++-
 arch/mips/oprofile/Makefile        |    2 +-
 arch/mips/oprofile/backtrace.c     |  173 ++++++++++++++++++++++++++++++++++++
 arch/mips/oprofile/common.c        |    1 +
 arch/mips/oprofile/op_impl.h       |    2 +
 6 files changed, 194 insertions(+), 6 deletions(-)
 create mode 100644 arch/mips/oprofile/backtrace.c

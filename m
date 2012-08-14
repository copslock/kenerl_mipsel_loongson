Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 20:08:18 +0200 (CEST)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:51541 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903851Ab2HNSIO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2012 20:08:14 +0200
Received: by qcsu28 with SMTP id u28so554234qcs.36
        for <multiple recipients>; Tue, 14 Aug 2012 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6SVsbCjPaUva61aiBw20u0Qhxl87SCvC44yNoG+P680=;
        b=u4quZOb951wjoLzLTmTUIJ2y6n0RjfCtqS+Uy8WccIGj1OvBBp1o1xVej/1stdyXZC
         RptGdg9xt/TNY2jYxdcqpW/Mhxm/VZrqmgDIOLM22evuIE3ofLciAM2tZ8tIZUlHx7Be
         ifaCgo780KT1IMD/zrjKtAhkEo6CLXYxO1RqgDSEnEcJCHdnWchdHrVjI3+lsvXknpXN
         FAtRHEhfOpYWDo4/SMobSSMXXWOQx9We0rcFxTTEGDdz3AXPpcchFRJGG9JH08zSk2MK
         x3F4sETdyjZfxCd/7Vvzx+YkIREAWn5/x0AmEke9OqJW8hDNJZ5WoJzJPS9zO0mECfAl
         1wkA==
Received: by 10.50.149.134 with SMTP id ua6mr13180491igb.11.1344967687902;
        Tue, 14 Aug 2012 11:08:07 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i17sm12266713igd.5.2012.08.14.11.08.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Aug 2012 11:08:07 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q7EI85Yn013213;
        Tue, 14 Aug 2012 11:08:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q7EI828J013212;
        Tue, 14 Aug 2012 11:08:02 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] Align MIPS swapper_pg_dir for faster code.
Date:   Tue, 14 Aug 2012 11:07:59 -0700
Message-Id: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 34165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The MIPS swapper_pg_dir needs 64K alignment for faster TLB refills in
kernel mappings.  There are two parts to the patch set:

1) Modify generic vmlinux.lds.h to allow architectures to place
   additional sections at the start of .bss.  This allows alignment
   constraints to be met with minimal holes added for padding.
   Putting this in common code should reduce the risk of future
   changes to the linker scripts not being propagated to MIPS (or any
   other architecture that needs something like this).

2) Align the MIPS swapper_pg_dir.

Since the initial use of the code is for MIPS, perhaps both parts
could be merged by Ralf's tree (after collecting any Acked-bys).

David Daney (2):
  vmlinux.lds.h: Allow architectures to add sections to the front of
    .bss
  MIPS: Align swapper_pg_dir to 64K for better TLB Refill code.

 arch/mips/kernel/vmlinux.lds.S    |   21 +++++++++++++++++++--
 arch/mips/mm/init.c               |   17 +++++++++--------
 include/asm-generic/vmlinux.lds.h |    9 +++++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

-- 
1.7.2.3

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2010 09:36:10 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.8]:63774 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490945Ab0IHHgH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Sep 2010 09:36:07 +0200
Received: from corscience.de (DSL01.212.114.252.242.ip-pool.NEFkom.net [212.114.252.242])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0LaHU2-1OTUId3jbS-00m15V; Wed, 08 Sep 2010 09:35:58 +0200
Received: from localhost.localdomain (unknown [192.168.102.58])
        by corscience.de (Postfix) with ESMTP id 5D0D851FB1;
        Wed,  8 Sep 2010 09:35:57 +0200 (CEST)
From:   Bernhard Walle <walle@corscience.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: N32: Fix getdents64 syscall for n32
Date:   Wed,  8 Sep 2010 09:35:57 +0200
Message-Id: <1283931357-4550-1-git-send-email-walle@corscience.de>
X-Mailer: git-send-email 1.7.0.4
X-Provags-ID: V02:K0:A88FcoG+4ETwZjSdVb6m4bq/PACEGxvt/d7rR0O5oLq
 teWV2Q7vdDH6EDzManA8+RHXqIyOWflBoAW+YzmmbUkhkoLEQH
 B61bYmD/1PnMWo1yvCwx1lNdC4ObulzPrB8ucO0DONN1QEvBzg
 O2nZnRfs5iIq1zcCyuSQ3/jZpaQLwv00vhSemHzeGrIu5ATWz5
 ExlFdct7AQmmGsBh7fj6Q==
X-archive-position: 27730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walle@corscience.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6041

Commit 31c984a5acabea5d8c7224dc226453022be46f33 introduced a new syscall
getdents64. However, in the syscall table, the new syscall still refers
to the old getdents which doesn't work.

The problem appeared with a system that uses the eglibc 2.12-r11187
(that utilizes that new syscall) is very confused. The fix has been
tested with that eglibc version.

Signed-off-by: Bernhard Walle <walle@corscience.de>
---
 arch/mips/kernel/scall64-n32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index a3d6613..dfa8cbc 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -419,5 +419,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_perf_event_open
 	PTR	sys_accept4
 	PTR     compat_sys_recvmmsg
-	PTR     sys_getdents
+	PTR     sys_getdents64
 	.size	sysn32_call_table,.-sysn32_call_table
-- 
1.7.0.4

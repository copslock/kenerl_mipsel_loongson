Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 18:00:07 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:40734 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492259Ab0CIRAB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 18:00:01 +0100
Received: by fxm27 with SMTP id 27so2998744fxm.28
        for <multiple recipients>; Tue, 09 Mar 2010 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=bPQ808PTuOzOs9H1lNEBXTRB+1OBivpqMYhXWPYuFNo=;
        b=JVwge/m92trriRcUHLhO83vZipa7EH5NIbTNWrg642drTZJ+wekxHEBLOP5BFrY6F+
         15J70vpNl7uOP675revfRSk37KwQtpsYkIafHfYDxl5op97mEsVOcJUFt7CzzTQ5iuzU
         MnhamojHxjojbYXsqjqHE2av6pnY04rFAmses=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=A4vVcdfd1nUBugEnoOWNnkPzY8KXZzorA5aBdwTr/5OYQCf14apBuNaUFtJRChhug/
         CK6XJuPD3oN+4+1MXiXK6K8BMHWxFk6CbjGR1iCKtlAKRWPge4r8mqSZYMHZmEediSe9
         Kzee6TloiTfWVbUqV/taPdRYHCc04WTNBesY0=
Received: by 10.223.81.90 with SMTP id w26mr101400fak.9.1268153994336;
        Tue, 09 Mar 2010 08:59:54 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id z15sm11394784fkz.21.2010.03.09.08.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 08:59:53 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson: Add module info to the loongson2_clock driver
Date:   Wed, 10 Mar 2010 00:53:21 +0800
Message-Id: <1268153601-4396-1-git-send-email-wuzhangin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch fixes the warning of the tool which checks the module info of
the loongson2_clock driver when inserting it into the kernel:

"Feb 25 23:42:27 localhost kernel: [    4.965000] loongson2_clock: module
license 'unspecified' taints kernel."

Reported-by: Liu Shiwei <liushiwei@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/cpufreq/loongson2_clock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpufreq/loongson2_clock.c b/arch/mips/kernel/cpufreq/loongson2_clock.c
index d7ca256..3eaae1d 100644
--- a/arch/mips/kernel/cpufreq/loongson2_clock.c
+++ b/arch/mips/kernel/cpufreq/loongson2_clock.c
@@ -164,3 +164,7 @@ void loongson2_cpu_wait(void)
 	spin_unlock_irqrestore(&loongson2_wait_lock, flags);
 }
 EXPORT_SYMBOL_GPL(loongson2_cpu_wait);
+
+MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
+MODULE_DESCRIPTION("cpuclock driver of Loongson2F");
+MODULE_LICENSE("GPL");
-- 
1.7.0.1

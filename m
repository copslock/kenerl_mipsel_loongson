Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2015 18:47:50 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:44908 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007701AbbIEQrsSKe4O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Sep 2015 18:47:48 +0200
Received: from [37.162.190.121] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZYGd1-0007PS-LH; Sat, 05 Sep 2015 18:47:47 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZYGcn-0001UG-Kl; Sat, 05 Sep 2015 18:47:33 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: idle: add case for CPU_5KE
Date:   Sat,  5 Sep 2015 18:47:31 +0200
Message-Id: <1441471651-5677-1-git-send-email-aurelien@aurel32.net>
X-Mailer: git-send-email 2.1.4
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

While the 5KE processors have never been taped out, they exists though
a CP0.PRId and experimental RTLs or QEMU implementations. Add a case
entry in the idle code, as they can use the standard idle loop like the
5K processors.

Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/kernel/idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index e4f62b7..3453370 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -155,6 +155,7 @@ void __init check_wait(void)
 	case CPU_4KEC:
 	case CPU_4KSC:
 	case CPU_5KC:
+	case CPU_5KE:
 	case CPU_25KF:
 	case CPU_PR4450:
 	case CPU_BMIPS3300:
-- 
2.1.4

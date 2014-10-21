Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 14:23:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41578 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012026AbaJUMXX2vYtK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 14:23:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9936AAB09631E
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 13:23:14 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 21 Oct
 2014 13:23:16 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Oct 2014 13:23:16 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.141) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Oct 2014 13:23:15 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: lasat: Add missing CONFIG_PROC_FS dependency to PICVUE_PROC
Date:   Tue, 21 Oct 2014 13:23:11 +0100
Message-ID: <1413894191-27148-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.141]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The picvue_proc.c file creates the /proc interface for the PICVUE LCD
display driver. As a result of which, it needs to depend on the PROC_FS
symbol to avoid build problems like the following one when
CONFIG_PROC_FS is not enabled.

arch/mips/lasat/picvue_proc.c:26:14: error: 'pvc_linename'
defined but not used [-Werror=unused-variable]
 static char *pvc_linename[PVC_NLINES] = {"line1", "line2"};
              ^

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lasat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lasat/Kconfig b/arch/mips/lasat/Kconfig
index 1d2ee8a9be13..8776d0a34274 100644
--- a/arch/mips/lasat/Kconfig
+++ b/arch/mips/lasat/Kconfig
@@ -4,7 +4,7 @@ config PICVUE
 
 config PICVUE_PROC
 	tristate "PICVUE LCD display driver /proc interface"
-	depends on PICVUE
+	depends on PICVUE && PROC_FS
 
 config DS1603
 	bool "DS1603 RTC driver"
-- 
2.1.2

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:49:18 +0200 (CEST)
Received: from mail-ie0-f201.google.com ([209.85.223.201]:52589 "EHLO
        mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009237AbaIRVrpUd4yk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:45 +0200
Received: by mail-ie0-f201.google.com with SMTP id rl12so311495iec.0
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eyZOUWlSCi145QujO7hkXT9FmHMEN4uSb2/MM2WNbg=;
        b=D47LHPtTYnwcIIlyWDdPrhhAFaUozOK0ptYdqO+KgOzEOBQmnPhP38EZOSdHt/WB+w
         kmjcYOgejCBdmFEjc54pIPjN2eMR7py+leX8I+K5DYX9FiY9W8A/O33Odpvc30vVjiqZ
         bD/kcHTgiZMKNF0AoLAyPVNr0Gz6kFBfINMGRrGQ7ixzUrdwhLiWCdYX7ipxSord76+7
         t9TVDLV3jYWTDcv6OuihatTI5mbDuC7cckEodzis4s0Ke9pvCu54II7cRbcCHheS69Gg
         cIyt0wcLH+nfyErMRaVwAMN0U6xZuGU++uqeqtwJDGQBs7TTAWnSq1V/tsjB6dNeZemi
         9onw==
X-Gm-Message-State: ALoCoQk1ssA7AnUZeAThq0gKTpjglpwjnen1YTvZ6svd8WYwP5tD+szDFWYXkGOmtSaSWOh6ww7g
X-Received: by 10.182.186.4 with SMTP id fg4mr1272208obc.9.1411076859447;
        Thu, 18 Sep 2014 14:47:39 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id j25si5188yhb.0.2014.09.18.14.47.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:39 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id P0uuVMGs.2; Thu, 18 Sep 2014 14:47:39 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 58798220B91; Thu, 18 Sep 2014 14:47:38 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/24] MIPS: smp-cps: Enable all hardware interrupts on secondary CPUs
Date:   Thu, 18 Sep 2014 14:47:13 -0700
Message-Id: <1411076851-28242-8-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Currently interrupt vectors 2 and 5 are left disabled on secondary CPUs.
Since systems using CPS must also have a GIC, which is responsible for
routing all external interrupts and can map them to any hardware interrupt
vector, enable the remaining vectors.  The two software interrupt vectors
are left disabled since they are not used with CPS.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
No changes from v1.
---
 arch/mips/kernel/smp-cps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index e6e16a1..cd20aca 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -273,8 +273,8 @@ static void cps_init_secondary(void)
 	if (cpu_has_mipsmt)
 		dmt();
 
-	change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
-				 STATUSF_IP6 | STATUSF_IP7);
+	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
+				 STATUSF_IP5 | STATUSF_IP6 | STATUSF_IP7);
 }
 
 static void cps_smp_finish(void)
-- 
2.1.0.rc2.206.gedb03e5

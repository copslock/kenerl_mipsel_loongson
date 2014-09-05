Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:31:41 +0200 (CEST)
Received: from mail-pd0-f202.google.com ([209.85.192.202]:41235 "EHLO
        mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025680AbaIERahWxMX4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:37 +0200
Received: by mail-pd0-f202.google.com with SMTP id w10so2344833pde.3
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eAU5OAzW6U+uBmepCEOjYLyLQp5qe2ASOJd/KQFHwd0=;
        b=hG8/ESjDrF/zxS3+MV+3vc5Vf5lI3UUKLYJo0waUpoDmvJAOm+tuMslxMLCGeN8CgT
         w3Q6WUayFJ6UUu9FJtM1Jb0DMDjtpIQVJlbJ4kYFq5GIYyp8pdBQ/go9M+i5mkQaO4xy
         Kzs6b0OWDPHjo9tb0J1lbUbxotju8YRZhbe3QGK2aK06KWcecU85SFqBAX20cMsfNjCk
         hKEwo+5X2xZ/X3Cl7yWEvPnPzCNuHB+nyXdFclF2nAOeFafcsch5dJctnGAzsYDtQ0xh
         xkH9vvU9FM/eWcDhFkJIRxE8qxJWrXxDzlD+3TAZzy0G3JcOHkhVbzPzRmxcbSMMDvi8
         1+KQ==
X-Gm-Message-State: ALoCoQkHvwST4eIe1ACmGays+P4L7VR3WQzIu7yvSaZDmyOP6JEc38OCId/vtY/aYumh8tHaurdC
X-Received: by 10.66.196.70 with SMTP id ik6mr7790809pac.44.1409938231431;
        Fri, 05 Sep 2014 10:30:31 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j25si509254yhb.0.2014.09.05.10.30.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:31 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3952231C285;
        Fri,  5 Sep 2014 10:30:31 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id EFC672209EA; Fri,  5 Sep 2014 10:30:30 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/16] MIPS: smp-cps: Enable all hardware interrupts on secondary CPUs
Date:   Fri,  5 Sep 2014 10:30:06 -0700
Message-Id: <1409938218-9026-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42433
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
---
New for v2.
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

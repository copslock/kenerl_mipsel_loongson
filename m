Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 12:40:51 +0200 (CEST)
Received: from mail-la0-f50.google.com ([209.85.215.50]:46456 "EHLO
        mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288Ab3EIKktd0sMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 12:40:49 +0200
Received: by mail-la0-f50.google.com with SMTP id fl20so2674485lab.37
        for <multiple recipients>; Thu, 09 May 2013 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=trIumjYMNdGX1CaoE0mYiPoBfMlLaWZiF32A/mFVVwU=;
        b=RbHGRP/dbM8U9/yiJ4edQ5aQ8MNUcMGQwWAQ9+mrAwjNeyaCAVep/aMkHhUf7tAKLJ
         HE1LVzWZsEC/Q99QteCYga1H9vYWIohdzm1VkVdZEQeNPy/kKdpbMgBU7TMNhXdd0RYb
         0lv6qs0MJk8vbspR3qgM/X6ZD/6X74miC9Nzf9icybEi0AZnmvW3skdX535Mn0wKnXmV
         e3W3IioeJeYr1BcSA1jvEDibfqN7UduLo7SCj8jBgBy9NOtl0sVdLRESmYoOtbvfmkqN
         6Gm/N7LLO8DPnVzthPXIJkIQQHbssnUH9TE/q6uh6yoJMRQfaMosyaJs7ZkOL3tPKcOC
         7VRw==
X-Received: by 10.152.26.225 with SMTP id o1mr5154898lag.43.1368096043617;
        Thu, 09 May 2013 03:40:43 -0700 (PDT)
Received: from localhost.localdomain (95-26-197-249.broadband.corbina.ru. [95.26.197.249])
        by mx.google.com with ESMTPSA id d8sm625346lae.2.2013.05.09.03.40.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 03:40:42 -0700 (PDT)
From:   Denis Efremov <yefremov.denis@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Denis Efremov <yefremov.denis@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH 19/21] MIPS: MSP71xx: remove inline marking of EXPORT_SYMBOL functions
Date:   Thu,  9 May 2013 14:36:57 +0400
Message-Id: <1368095819-11011-8-git-send-email-yefremov.denis@gmail.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
Return-Path: <yefremov.denis@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yefremov.denis@gmail.com
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

EXPORT_SYMBOL and inline directives are contradictory to each other.
The patch fixes this inconsistency.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <yefremov.denis@gmail.com>
---
 arch/mips/pmcs-msp71xx/msp_prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pmcs-msp71xx/msp_prom.c b/arch/mips/pmcs-msp71xx/msp_prom.c
index 0edb89a..1c98975 100644
--- a/arch/mips/pmcs-msp71xx/msp_prom.c
+++ b/arch/mips/pmcs-msp71xx/msp_prom.c
@@ -83,7 +83,7 @@ static inline unsigned char str2hexnum(unsigned char c)
 	return 0; /* foo */
 }
 
-static inline int str2eaddr(unsigned char *ea, unsigned char *str)
+int str2eaddr(unsigned char *ea, unsigned char *str)
 {
 	int index = 0;
 	unsigned char num = 0;
-- 
1.8.1.4

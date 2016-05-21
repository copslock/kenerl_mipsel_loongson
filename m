Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:07:09 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34392 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032207AbcEUMC2y8zvI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:02:28 +0200
Received: by mail-lf0-f65.google.com with SMTP id 65so26121lfq.1;
        Sat, 21 May 2016 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DwHXC8rz5n/2M2rb5TT8hzfg93oL+Kz2+KNh7cBrCTU=;
        b=Ekf1N/kDiTQs/7U39Vv4DgTo0xQ7dH5eFEQDnrb4uSnW/Z0IDJyMYR1jtLHRSpzuQQ
         6/Dmtk2ynofiQ/f6XRX2CgunE6Bg62Ef+LrAURuW8kEPGR1rVsxUyEvUTp0Grum0iBZ8
         4ERuD+ZMRjUeVY1hgrh5QAPJPkLXfcg5ztfhBf/RPYPJQjQV9uJir8b/FD+jvtMEdH8z
         8zsHrShUs/QCBGh430VmWU/YYV4wTs+6sj+U0l/e7YB3tRtelQ85jiRcj/BoCF1Iu6Du
         hXSywpN3o/Yj6JOnzfTACjWYjefKzaELsZiCx6NPS0s2KXatDxbcgAdXIWe/rXMDX7ac
         BBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DwHXC8rz5n/2M2rb5TT8hzfg93oL+Kz2+KNh7cBrCTU=;
        b=JjcjdwKWXiR+IHzp3BG8PeRZT3OYlPzQXZth0bhMtTwM2WAdWyjZOh+ElBskQVwcwb
         yVZqqN5i8+6tnOqrZnL7Z1uhrOIZ9KMEZO1rUP76JsqoKJOjGkDplfPU9rkCmUjtxeiN
         rD3MvXLBUNfVIE2ejV+dJgcLUu/f9F/W95NFkUAzdgZBVPhfK9bQapmd8K5FlrlhMEJz
         ZCr2/YkmpQpdaMJMycx61VFD1oobl2Gdv3LTE019lBL0LXgAtOXAK76TnOzDeq/4z8bl
         FTQCrOOEYyXwfE7iFN/jhTr0aniW5VrxRTApSPJNRPUBkqq+zwcLs64FUxYVzXLMl0hS
         lDfg==
X-Gm-Message-State: AOPr4FW6nEV0T2yeq9MXfxioO7m9Lvl33TEd5o3UkUJElo/Hf7qpY8QDk0KHaRFgTShGWg==
X-Received: by 10.25.207.131 with SMTP id f125mr3015190lfg.62.1463832143592;
        Sat, 21 May 2016 05:02:23 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id o75sm2193634lfi.9.2016.05.21.05.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:02:22 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0201/1529] Fix typo
Date:   Sat, 21 May 2016 14:02:19 +0200
Message-Id: <20160521120219.10406-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/sgi-ip27/ip27-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 570098b..75f7da7 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -76,7 +76,7 @@ static void per_hub_init(cnodeid_t cnode)
 #ifdef CONFIG_REPLICATE_EXHANDLERS
 	/*
 	 * If this is not a headless node initialization,
-	 * copy over the caliased exception handlers.
+	 * copy over the aliased exception handlers.
 	 */
 	if (get_compact_nodeid() == cnode) {
 		extern char except_vec2_generic, except_vec3_generic;
-- 
2.8.2.534.g1f66975

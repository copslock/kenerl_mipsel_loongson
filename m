Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:26:59 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:39931 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492203AbZGBP04 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:26:56 +0200
Received: by mail-ew0-f214.google.com with SMTP id 10so2095301ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:21:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aKm/7IpHnEXDxEKScWwpTKl3q0tjxhNjcE1YZwuHFf4=;
        b=u5GCzIEboXUnWnnElBEkx98fcN6w+zGrbtLhN94pmPAR4pvtqzkMpQXy7AcCtL2Xjk
         acKX78ll8bt7YAmldpNQq9X6lmmfy0Rox+1oBnTw8YpADmlVbjbCKkqY0M1AtauVstwf
         GEcSFakMy9t34iB01jA5IkP3+znRiJ5jnfqsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hRGD4ER6s2KtDilNSc+GGC4kotFcCdsF7xFsgitechJ2pgUbK3law+aeq4kO1BlA62
         gu6GxB/5b4eN7OXEjRbGtEqndYYGkG0LdOyEUS8E7TWseLv4YiycjRMRrRWj22KZfnf1
         3FU+9Fv+I4w/Rre6neSX/tTbkKdEcEIGuzsLE=
Received: by 10.210.27.14 with SMTP id a14mr1130644eba.7.1246548070978;
        Thu, 02 Jul 2009 08:21:10 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 7sm5367141eyg.7.2009.07.02.08.21.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:21:10 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Jason Wessel <jason.wessel@windriver.com>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 04/16] [loongson] pm: Remove redundant source code
Date:	Thu,  2 Jul 2009 23:20:56 +0800
Message-Id: <93ba7839f73d96de29fa76647ca1fe90012a021c.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

the implmentation of loongson2e_power_off and loongson2e_halt is
almostly the same, just reserve one of them.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/lemote/lm2e/reset.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/mips/lemote/lm2e/reset.c b/arch/mips/lemote/lm2e/reset.c
index 099387a..47ff506 100644
--- a/arch/mips/lemote/lm2e/reset.c
+++ b/arch/mips/lemote/lm2e/reset.c
@@ -28,14 +28,9 @@ static void loongson2e_halt(void)
 	while (1) ;
 }
 
-static void loongson2e_power_off(void)
-{
-	loongson2e_halt();
-}
-
 void mips_reboot_setup(void)
 {
 	_machine_restart = loongson2e_restart;
 	_machine_halt = loongson2e_halt;
-	pm_power_off = loongson2e_power_off;
+	pm_power_off = loongson2e_halt;
 }
-- 
1.6.2.1

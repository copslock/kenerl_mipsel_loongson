Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 22:46:27 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36395 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041914AbcFPUqXgOX9U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jun 2016 22:46:23 +0200
Received: by mail-wm0-f66.google.com with SMTP id m124so14084536wme.3;
        Thu, 16 Jun 2016 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hvDiJWVXJl8uajFCyhNXUYDASjRJdmB7No7shsCxceA=;
        b=fI1PTh5+ZItKVD6GcNle6AifRNdnl/QEYCxiKF+GZKJOwY3kkZYKl05ynsrbIzpoxM
         bVjsff6/WNke+rj6wncYyws6MTCJrYV7+1R7fvWYFTKsRUJlNLW/NUpmm2dRJlGSf5Bv
         BEwU3HqT0w8Ut5c5W9JuQRRmd9IMafn4a/FvMhSR++W5xA1oVr1HHrZc0+C7zcb9T/IK
         RD4MjU5Ez/PrYQjI88KRZ0OaEMZnMaAr2hJ6ThrRVIgQiOQ70gYC0Go4Z2sALxBvuuJ0
         wFVNQkDZOoZrT2/m9iKA388MMGrYLRxSHhjk12+6ijA9gO9i6sGbNStzZllTvIcjJCrt
         G7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hvDiJWVXJl8uajFCyhNXUYDASjRJdmB7No7shsCxceA=;
        b=BSVh1SCjetryR0YVSEhCThDqtM+CU0O4vy3pEDkKTqCuryKoFIzmJm8sAu6tqPZWx7
         J8v32FURCU0ghkc8VXz8cUMWs86dQXkxdEJ4aAM7M7ejX2W0NnDANHtukznZnTcYylss
         2IywqNysvEn87j4wXGQiQBVEOqliuKufUXAWEurM5wxVN1wPxq0Rb8wypfjBD1gjjiaV
         CDzU85uI52esOjzMHss7mhvr+ZVRJ6lltWrxfjmdf0BY/6Qxcta5WsIGADzlAEl9P2E7
         2qaVc1G0Mwxq5mVGRpRnJvQW4wqxjLwpyWOOOOHmp1I4WEXHTFL68d0D+7lWAtpxuPOb
         1ovw==
X-Gm-Message-State: ALyK8tJGvJ7nt9RR21J84coQ3BFdRs0FHiYpbqXGWHCrJw1SYEkoY1DorM7oBUxTzekrrw==
X-Received: by 10.194.170.197 with SMTP id ao5mr1223055wjc.99.1466109978258;
        Thu, 16 Jun 2016 13:46:18 -0700 (PDT)
Received: from localhost.localdomain (234.98.208.46.dyn.plus.net. [46.208.98.234])
        by smtp.gmail.com with ESMTPSA id 124sm40980wml.12.2016.06.16.13.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jun 2016 13:46:16 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] MIPS: Lantiq: fix build failure
Date:   Thu, 16 Jun 2016 21:46:08 +0100
Message-Id: <1466109968-22033-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

Some configs of mips like xway_defconffig are failing with the error:
arch/mips/lantiq/irq.c:209:2: error: initialization from incompatible
pointer type [-Werror]
  "icu",
  ^
arch/mips/lantiq/irq.c:209:2: error: (near initialization for
'ltq_irq_type.parent_device') [-Werror]
arch/mips/lantiq/irq.c:219:2: error: initialization from incompatible
pointer type [-Werror]
  "eiu",
  ^
arch/mips/lantiq/irq.c:219:2: error: (near initialization for
'ltq_eiu_type.parent_device') [-Werror]

The first member of the "struct irq" is no longer a pointer for the
name.

Fixes: be45beb2df69 ("genirq: Add runtime power management support for IRQ chips")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log can be seen at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/137992701

 arch/mips/lantiq/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index ff17669e..02c0252 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -206,7 +206,7 @@ static void ltq_shutdown_eiu_irq(struct irq_data *d)
 }
 
 static struct irq_chip ltq_irq_type = {
-	"icu",
+	.name = "icu",
 	.irq_enable = ltq_enable_irq,
 	.irq_disable = ltq_disable_irq,
 	.irq_unmask = ltq_enable_irq,
@@ -216,7 +216,7 @@ static struct irq_chip ltq_irq_type = {
 };
 
 static struct irq_chip ltq_eiu_type = {
-	"eiu",
+	.name = "eiu",
 	.irq_startup = ltq_startup_eiu_irq,
 	.irq_shutdown = ltq_shutdown_eiu_irq,
 	.irq_enable = ltq_enable_irq,
-- 
1.9.1

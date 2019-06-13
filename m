Return-Path: <SRS0=RAP1=UM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5586DC31E4A
	for <linux-mips@archiver.kernel.org>; Thu, 13 Jun 2019 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C58E21473
	for <linux-mips@archiver.kernel.org>; Thu, 13 Jun 2019 17:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393462AbfFMRHA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:07:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:52190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393452AbfFMRG7 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 13 Jun 2019 13:06:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99843AEA3;
        Thu, 13 Jun 2019 17:06:57 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 4/7] MIPS: SGI-IP27: remove ioc3 ethernet init
Date:   Thu, 13 Jun 2019 19:06:30 +0200
Message-Id: <20190613170636.6647-5-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190613170636.6647-1-tbogendoerfer@suse.de>
References: <20190613170636.6647-1-tbogendoerfer@suse.de>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Removed not needed disabling of ethernet interrupts in IP27 platform code.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip27/ip27-init.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 066b33f50bcc..59d5375c9021 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -130,17 +130,6 @@ cnodeid_t get_compact_nodeid(void)
 	return NASID_TO_COMPACT_NODEID(get_nasid());
 }
 
-static inline void ioc3_eth_init(void)
-{
-	struct ioc3 *ioc3;
-	nasid_t nid;
-
-	nid = get_nasid();
-	ioc3 = (struct ioc3 *) KL_CONFIG_CH_CONS_INFO(nid)->memory_base;
-
-	ioc3->eier = 0;
-}
-
 extern void ip27_reboot_setup(void);
 
 void __init plat_mem_setup(void)
@@ -182,8 +171,6 @@ void __init plat_mem_setup(void)
 		panic("Kernel compiled for N mode.");
 #endif
 
-	ioc3_eth_init();
-
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0UL;
 	set_io_port_base(IO_BASE);
-- 
2.13.7


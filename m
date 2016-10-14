Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 11:19:15 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:25132 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991859AbcJNJTHON5ar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 11:19:07 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 4505736720D06;
        Fri, 14 Oct 2016 10:18:58 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 14 Oct 2016
 10:19:00 +0100
Received: from localhost (10.100.200.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 14 Oct
 2016 10:19:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 1/2] mfd: syscon: Support native-endian regmaps
Date:   Fri, 14 Oct 2016 10:17:31 +0100
Message-ID: <20161014091732.27536-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net>
References: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.203]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The regmap devicetree binding documentation states that a native-endian
property should be supported as well as big-endian & little-endian,
however syscon in its duplication of the parsing of these properties
omits support for native-endian. Fix this by setting
REGMAP_ENDIAN_NATIVE when a native-endian property is found.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 drivers/mfd/syscon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 2f2225e..b93fe4c 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -73,8 +73,10 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	/* Parse the device's DT node for an endianness specification */
 	if (of_property_read_bool(np, "big-endian"))
 		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
-	 else if (of_property_read_bool(np, "little-endian"))
+	else if (of_property_read_bool(np, "little-endian"))
 		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
+	else if (of_property_read_bool(np, "native-endian"))
+		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
 
 	/*
 	 * search for reg-io-width property in DT. If it is not provided,
-- 
2.10.0

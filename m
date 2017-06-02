Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:32:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16387 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdFBTbygiepn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:31:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9839D46B067DE;
        Fri,  2 Jun 2017 20:31:44 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:31:48
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 5/9] MIPS: generic: Set RTC_ALWAYS_BCD to 0
Date:   Fri, 2 Jun 2017 12:29:55 -0700
Message-ID: <20170602192959.25435-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602192959.25435-1-paul.burton@imgtec.com>
References: <20170602192959.25435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58148
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

Drivers for the mc146818 RTC generally check control registers to
determine whether a value is encoded as binary or as a binary coded
decimal. Setting RTC_ALWAYS_BCD to 1 effectively bypasses these checks
and causes drivers to always expect binary coded decimal values,
regardless of control register values.

This does not seem like a sane default - defaulting to 0 allows the
drivers to check control registers to determine encoding type & allows
the driver to work generically with both binary & BCD encodings. Set
this in mach-generic/mc146818rtc.h such that the generic kernel, or
platforms which don't provide a custom mc146818rtc.h, can have an RTC
driver which works with both encodings.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mach-generic/mc146818rtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-generic/mc146818rtc.h b/arch/mips/include/asm/mach-generic/mc146818rtc.h
index 0b9a942f079d..9c72e540ff56 100644
--- a/arch/mips/include/asm/mach-generic/mc146818rtc.h
+++ b/arch/mips/include/asm/mach-generic/mc146818rtc.h
@@ -27,7 +27,7 @@ static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
 	outb_p(data, RTC_PORT(1));
 }
 
-#define RTC_ALWAYS_BCD	1
+#define RTC_ALWAYS_BCD	0
 
 #ifndef mc146818_decode_year
 #define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1900)
-- 
2.13.0

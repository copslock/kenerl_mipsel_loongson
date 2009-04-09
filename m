Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 06:06:19 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:4573 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20022124AbZDIFGL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 06:06:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 8AC0734133;
	Thu,  9 Apr 2009 13:03:13 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rGoQTO9SCdxX; Thu,  9 Apr 2009 13:03:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id ABD7D34129;
	Thu,  9 Apr 2009 13:03:07 +0800 (CST)
Message-ID: <49DD8238.7060609@lemote.com>
Date:	Thu, 09 Apr 2009 13:06:00 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 10/14] lemote: rtc driver binary mode support
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

The original driver will exit when detect rtc binary mode. In fact both
the binary mode and bcd are supported
---
drivers/rtc/rtc-cmos.c | 2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index b6d35f5..85c327e 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -757,7 +757,7 @@ cmos_do_probe(struct device *dev, struct resource
*ports, int rtc_irq)
* <asm-generic/rtc.h> doesn't know 12-hour mode either.
*/
if (is_valid_irq(rtc_irq) &&
- (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
+ (!(rtc_control & RTC_24H) /*|| (rtc_control & (RTC_DM_BINARY))*/)) {
dev_dbg(dev, "only 24-hr BCD mode supported\n");
retval = -ENXIO;
goto cleanup1;
-- 
1.5.6.5

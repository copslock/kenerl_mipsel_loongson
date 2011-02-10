Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2011 15:17:21 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:42041 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491025Ab1BJORS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Feb 2011 15:17:18 +0100
Received: by fxm19 with SMTP id 19so1501515fxm.36
        for <linux-mips@linux-mips.org>; Thu, 10 Feb 2011 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=oUWwFa9PxxuKFfbAjykpAoUgKh1tHMd5UQLf+pvZHSo=;
        b=L9w1B+DJ+1aQaBxjjiPnBor7AskkNGffv4FtSUDMklYdzUFR+Jh8pGLK0asXgn0r8Z
         H2sCn46usQlfA2rW1e+29hHlq05dpLHkoP9AaYTDHembK0rzQwUQL1QezK80b6O8jyU6
         3WckQ5UDviWuc9xkOwOD+MbzF33hRO5enml1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NZxO18A5iALuu4CAgpwTvoJ2KbTSZ/+BOYY3kQJrhLwfTnIx6Sd+NegPi0Sr6MEkAq
         NrdzPKz1oqxCqW/pbFaxmtpVjJFiNsC5rHMJYmioTUX9t8mx++4Dkt0PK5xoVDPRKewr
         vDAj3pU+qOM7aXbvG4kUrmjt64b3p3E6Gap4w=
Received: by 10.223.81.68 with SMTP id w4mr4966645fak.84.1297347433197;
        Thu, 10 Feb 2011 06:17:13 -0800 (PST)
Received: from localhost.localdomain (178-191-11-137.adsl.highway.telekom.at [178.191.11.137])
        by mx.google.com with ESMTPS id n1sm36732fam.16.2011.02.10.06.17.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 06:17:12 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RESEND] MIPS: Alchemy: update inlinable GPIO API
Date:   Thu, 10 Feb 2011 15:17:07 +0100
Message-Id: <1297347429-18215-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The GPIO API has grown a few new functions, add the missing ones
to the other inlinables.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   35 +++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 62d2f13..f26bfe7 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -556,6 +556,16 @@ static inline void gpio_set_value(int gpio, int v)
 	alchemy_gpio_set_value(gpio, v);
 }
 
+static inline int gpio_get_value_cansleep(unsigned gpio)
+{
+	return gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value_cansleep(unsigned gpio, int value)
+{
+	gpio_set_value(gpio, value);
+}
+
 static inline int gpio_is_valid(int gpio)
 {
 	return alchemy_gpio_is_valid(gpio);
@@ -585,6 +595,31 @@ static inline void gpio_free(unsigned gpio)
 {
 }
 
+static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
+{
+	return -ENOSYS;
+}
+
+static inline void gpio_unexport(unsigned gpio)
+{
+}
+
+static inline int gpio_export(unsigned gpio, bool direction_may_change)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_sysfs_set_active_low(unsigned gpio, int value)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_export_link(struct device *dev, const char *name,
+				   unsigned gpio)
+{
+	return -ENOSYS;
+}
+
 #endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
 
 
-- 
1.7.4

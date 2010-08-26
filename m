Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2010 16:01:00 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:56131 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab0HZOA5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Aug 2010 16:00:57 +0200
Received: by bwz13 with SMTP id 13so1368199bwz.36
        for <linux-mips@linux-mips.org>; Thu, 26 Aug 2010 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=W1cy3JixoOfa3CoG6f3dyj04WVClLI0/gEZFNE3JsJ8=;
        b=LyKlkK3gWP+mQjQCQWrHzSCtW8a13cUkUgmd5L65mcOl8iXA7OjlARDISnTmWFJhir
         vWTBqbH94d7Fo7MDoQJL1ZJ/Fyo0DvKfu5IEmSo3MevCWtZI7q6ahahHqGYmhQ1NTNYi
         miTfAhrY1/V92ljvaFMWylGWDlLozLVXk0kSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xgoVd2iMtg1iSsIEUcsh3eZ755+011P3swtQwxRqniK67jLA3fkx7pPicWLFHHpiln
         PuNjRwE9R+QpxE/wU0/CNqCNkp86lh36ec2gmz3AXnWDXBfXovtW8lOeKnZm9+cPugvE
         Ja50KpcsZpB1Dlc1liDJlo0b5ywkaSfj5UuEc=
Received: by 10.204.52.12 with SMTP id f12mr6169041bkg.212.1282831256097;
        Thu, 26 Aug 2010 07:00:56 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id s34sm1679797bkk.1.2010.08.26.07.00.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 07:00:55 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: Alchemy: update inlinable GPIO API
Date:   Thu, 26 Aug 2010 16:00:50 +0200
Message-Id: <1282831250-1448-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The GPIO API has grown a few new functions, add the missing ones
to the other inlinables (CONFIG_GPIOLIB=n)

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
gpio_keys is one user of gpio_set_debounce() for example.

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
1.7.2

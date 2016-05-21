Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:02:12 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35659 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032207AbcEUMAgwcaCI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:36 +0200
Received: by mail-lf0-f65.google.com with SMTP id p10so3968231lfb.2;
        Sat, 21 May 2016 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lDPIqGkucz5+xSmZXBEOimiGoxkypFyV7N/pOzFcRQ0=;
        b=P8GkmFYOT9vMFYgKifMOZLeDtRJdpm5Gm77Iko3Ww+QLqL86LZwbAGxdqTTUocgKV+
         QalKeaV1kimNev6CAnAKHDGZjIUEfLWp89S+7yYk/4kYMtecRVXYSYqgBMS9n2eYnDja
         ULc6g2PsrpM20yoBEp0pi67+wucbmVA1RvIzR0auradOl6ahBwcS93kVsKsOPW6a4oT0
         BSrpScDIk717EMEUYUgzVK3joonZlbJA+6h+A8CrCFskG2x7U5GIYdSYPeY2rzodypew
         tfEFRk3ih5dsVevqNCBcFmUUwrYSZxN679FdB84I8Y/9sYHbgLuPVvAvbfLJADzz6bgZ
         caig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lDPIqGkucz5+xSmZXBEOimiGoxkypFyV7N/pOzFcRQ0=;
        b=YZO+QC7c7af2WU0RTv9+bPMwTzfu3EWlrSf/ZKLReHdafvAmZJuogmTQfJ/jqs92Ol
         YBQp6nrV8s/65dD8gxSzBsTGA+yK9p1RTSY0mnfvldira7pxtyqdzSMMvgyb9YbSj0F/
         uAzd1jpdQXkNx91nQMVStGPsR3AHgYH3KZjKMAL1TZ+dMEb9DjFFjD8PWd3Ah4aVJqGN
         EolfEyy0yyXnbDxu7ahgS1mcvx8BWwGtoKJsi/VP6CjnF3fM/YRF6nPi2I1GmXXGtcR3
         jIKkUS7yP+AFMhMjJTDuce9h7dHBApGkoxdFaNS4VWDfwGZaPQOXbwcoR5dpGJ4eTCmH
         bWnA==
X-Gm-Message-State: AOPr4FWNosDz7tb5YXqjtEAgrp/TZ9SULw45qrJrkt9be7/4KxU/vS2VvftBMeWcDUnyAQ==
X-Received: by 10.25.89.77 with SMTP id n74mr2365440lfb.29.1463832030527;
        Sat, 21 May 2016 05:00:30 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id yf9sm3988866lbb.34.2016.05.21.05.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:29 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, chenhc@lemote.com,
        linux-mips@linux-mips.org
Subject: [PATCH 0186/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:26 +0200
Message-Id: <20160521120026.9546-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53584
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
 arch/mips/include/asm/mach-loongson64/loongson_hwmon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h b/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
index 4431fc5..74230d0 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
@@ -24,7 +24,7 @@ struct temp_range {
 	u8 level;
 };
 
-#define CONSTANT_SPEED_POLICY	0  /* at constent speed */
+#define CONSTANT_SPEED_POLICY	0  /* at constant speed */
 #define STEP_SPEED_POLICY	1  /* use up/down arrays to describe policy */
 #define KERNEL_HELPER_POLICY	2  /* kernel as a helper to fan control */
 
-- 
2.8.2.534.g1f66975

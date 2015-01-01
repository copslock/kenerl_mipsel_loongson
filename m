Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 20:09:11 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:51292 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009333AbbAATJJr00AN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 20:09:09 +0100
Received: by mail-we0-f177.google.com with SMTP id q59so3658551wes.22
        for <linux-mips@linux-mips.org>; Thu, 01 Jan 2015 11:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xpdeFvvi4fFljDTIoeIOebYiVQjtm+BU6UsEslepRwo=;
        b=VmOqw48x8p3zM7pmefN7++MSYGbTEsipzAoHn9OjlPwPHK9a249tb9yhMCP3zppGpF
         XkDPrGTUTEucYTw4qMVBLX1K7ZiGxl524qdOc88ChulAhXAMeM+AF3XYGtDXXrnFC/QQ
         OxPCbHr8Z2ML20fCxa9MzF6fx5zEn9XA4dfX6H//t9JaXKvkjqoJs9LHjl0TaIKRvrxw
         6aix5ibtgMiIHUDDZsARc4YbY+JhcXrmv6/37boDXucW4ZjtcBLyY1kKV/KCnaESUG89
         dUodiULIRAKwzVa8aY8XQqIpKIyohpG6kg7uvkhLl5dV4ju7Gn3Fln7R/Is5KePyTQUy
         cnLg==
X-Gm-Message-State: ALoCoQmbUI3a3n4Jj51ATfNc12dL3hokN39fZOuOy+ZP5jx9Euf8mtVLUYlBFG1k2Kcvg8NAyIR6
X-Received: by 10.180.84.98 with SMTP id x2mr123791471wiy.14.1420139344456;
        Thu, 01 Jan 2015 11:09:04 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id w3sm11634294wjf.3.2015.01.01.11.09.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jan 2015 11:09:03 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: ath79: gpio:  Remove some unused functions
Date:   Thu,  1 Jan 2015 20:12:05 +0100
Message-Id: <1420139525-2833-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard.strandqvist@spctrm.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
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

Removes some functions that are not used anywhere:
ath79_gpio_function_disable() ath79_gpio_function_enable()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/ath79/common.h |    2 --
 arch/mips/ath79/gpio.c   |   10 ----------
 2 files changed, 12 deletions(-)

diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index a312071..9eb841a 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -24,8 +24,6 @@ unsigned long ath79_get_sys_clk_rate(const char *id);
 
 void ath79_ddr_wb_flush(unsigned int reg);
 
-void ath79_gpio_function_enable(u32 mask);
-void ath79_gpio_function_disable(u32 mask);
 void ath79_gpio_function_setup(u32 set, u32 clear);
 void ath79_gpio_init(void);
 
diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index 8d025b0..d0a5d92 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -168,16 +168,6 @@ void ath79_gpio_function_setup(u32 set, u32 clear)
 	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
 }
 
-void ath79_gpio_function_enable(u32 mask)
-{
-	ath79_gpio_function_setup(mask, 0);
-}
-
-void ath79_gpio_function_disable(u32 mask)
-{
-	ath79_gpio_function_setup(0, mask);
-}
-
 void __init ath79_gpio_init(void)
 {
 	int err;
-- 
1.7.10.4

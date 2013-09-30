Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 16:42:16 +0200 (CEST)
Received: from mail-ea0-f172.google.com ([209.85.215.172]:45268 "EHLO
        mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6841854Ab3I3OmN7E6Xs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 16:42:13 +0200
Received: by mail-ea0-f172.google.com with SMTP id r16so2750951ead.31
        for <linux-mips@linux-mips.org>; Mon, 30 Sep 2013 07:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U3m0rcgLcHmVy6j6b0IipH67RJHFvb67vE2DeRHgd/4=;
        b=hJ0SDNT1bSobQCeX78G557ws41rc/fpu7j/vcWLyHnsKFY/7o0Aj5SnlL9Ld/bX79G
         zD9st1Rxmx+ZTe5q3KIG3xfm40x48ToC52EcjcivqAyKz2k724kp68YO3/hbFzD1AMOC
         3DGgEFwhXOvDjE8yochQemg8wNILeAhVPr1jGmMJNb2gHQmGBlo+1aUbLcSX7yHwrwAY
         1TXkdpbU7NhZqsAtdaafI84kcrGDPlVLrZn6tMXj1KqPyDtqcHQAh3gJiQHxwv8uJuU0
         o2ZSOJZ843fVDFiOc0BDX6bfKuIsBfDxvSufrWfPTwsNyxuPS5nHtz2U1v3L6FIGaMJu
         Xvhw==
X-Gm-Message-State: ALoCoQlGoK0qNaCxKspuqxCL6TVEunfX4xvnNjq5Bc/zbptkAKjgYG3nObJ9SJ5lUkXRmlRgZZok
X-Received: by 10.14.246.11 with SMTP id p11mr38279691eer.9.1380552128389;
        Mon, 30 Sep 2013 07:42:08 -0700 (PDT)
Received: from localhost.localdomain ([85.235.11.236])
        by mx.google.com with ESMTPSA id n48sm1803036eeg.17.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 07:42:07 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: db1235: Don't use MMC_CLKGATE
Date:   Mon, 30 Sep 2013 16:41:59 +0200
Message-Id: <1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

As a first step in removing code for MMC_CLKGATE, MIPS db1235 defconfig
which is the only current user, shall move away from this option.

The mmc host drivers au1xmmc and jz4740_mmc, which are used on MIPS
don't support clock gating through MMC_CLKGATE, thus removing the
config option will have no effect on power save - clock gating wise.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/mips/configs/db1235_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/db1235_defconfig b/arch/mips/configs/db1235_defconfig
index e2b4ad5..28e49f2 100644
--- a/arch/mips/configs/db1235_defconfig
+++ b/arch/mips/configs/db1235_defconfig
@@ -351,7 +351,6 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
-CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_AU1X=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.7.9.5

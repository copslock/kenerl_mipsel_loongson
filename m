Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:04:12 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34704 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009913AbaLYR5nOyAWh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:43 +0100
Received: by mail-pd0-f172.google.com with SMTP id y13so11865418pdi.31;
        Thu, 25 Dec 2014 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7MdbUu7kiYzid0tlvtyxEQ1uCguQOYNT5YnmpmgYvVA=;
        b=ouxJfxNMFw3xAo1F88EaWg/maDKjXRXSKeIDF/52KN7E8J6rtyLeqmyE/cNHkgQyBE
         l1XKNlRkE9ARD+lNyq+RsA7uFtnxUZ7ojeq4ASlStZgLCfXhA0N/Gw3O3nz6YGbMlrEG
         YbNJU1MqjwRbbc78V+UbRdlE7TI/FFsBs7S5ro0u/5TsRlt2JxD5OdJTCL21w9VrLxxj
         JFPmf7//+fS5jGYxSizZB6l4k2/GRXNQpHFOVQaRI11q0HS034G51sYgGJt7vHMmIL1N
         ON7lGjLmMVsx0Kcibhn9cOAdH/B/u5d+mnwC5dohv8cT5RMoJqc7y4nOb3QEgaTGxmNF
         zFXw==
X-Received: by 10.70.15.131 with SMTP id x3mr32554389pdc.128.1419530257618;
        Thu, 25 Dec 2014 09:57:37 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.36
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:36 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 24/25] MIPS: BMIPS: Update DT bindings to reflect new SoC support
Date:   Thu, 25 Dec 2014 09:49:19 -0800
Message-Id: <1419529760-9520-25-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Add an entry for each supported Broadcom SoC.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt | 11 -----------
 Documentation/devicetree/bindings/mips/brcm/soc.txt    | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/soc.txt

diff --git a/Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt b/Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
deleted file mode 100644
index 8a139cb..0000000
diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
new file mode 100644
index 0000000..7bab90c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
@@ -0,0 +1,12 @@
+* Broadcom cable/DSL/settop platforms
+
+Required properties:
+
+- compatible: "brcm,bcm3384", "brcm,bcm33843"
+              "brcm,bcm3384-viper", "brcm,bcm33843-viper"
+              "brcm,bcm6328", "brcm,bcm6368",
+              "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
+              "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
+
+The experimental -viper variants are for running Linux on the 3384's
+BMIPS4355 cable modem CPU instead of the BMIPS5000 application processor.
-- 
2.1.1

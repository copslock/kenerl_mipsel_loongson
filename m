Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:14:33 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35803 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008034AbaLLWIylQNI0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:54 +0100
Received: by mail-pa0-f48.google.com with SMTP id rd3so8006091pab.35
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9gRDvmQrVYsOHCLF5cEZfjOXPavFEfKgqh6QXV7C9Z4=;
        b=F6E2m7orbMtpoc2dgPAfzbbCViYQnLpMJVZdQvYOXSCuTaZCW7gJ9sLalx1HQbMfJ6
         7NGL206OGYryYOvfhT4WxM+CyfqE2ti0qZQFUrEKnUYmw1XKoO/SC87WOdeEWvuqJz2v
         /jc1HwvkJAjBMCqaOVHm2SrXqorgTx8FkAoK5O+lFWQj1cl3BlL6pG0g9nMjdydhAS0v
         AkFASEZyUj31EhtUiUdgHFYEdcF7HjVKkR1/EQxVhwELpLOHd7mpiAYWny3LROKzl9aX
         F2hKhwbORhX67slQEL5M168+G61cwtYhGiBonNTQBUdVzlD7R5BBis/aijftzBvXu8rh
         D6ZQ==
X-Received: by 10.66.66.135 with SMTP id f7mr29764743pat.81.1418422129077;
        Fri, 12 Dec 2014 14:08:49 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:48 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 22/23] MIPS: BMIPS: Update DT bindings to reflect new SoC support
Date:   Fri, 12 Dec 2014 14:07:13 -0800
Message-Id: <1418422034-17099-23-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44660
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
index 0000000..f011443
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
+              "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7360",
+              "brcm,bcm7420", "brcm,bcm7425"
+
+The experimental -viper variants are for running Linux on the 3384's
+BMIPS4355 cable modem CPU instead of the BMIPS5000 application processor.
-- 
2.1.1

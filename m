Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 23:38:19 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:33792
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994890AbdFPVhc0548C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 23:37:32 +0200
Received: by mail-wr0-x242.google.com with SMTP id y25so5502311wrd.1;
        Fri, 16 Jun 2017 14:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bOOV9oExnzwHMA1NkeEvUu69N0POwqdE4jHG4zv9EF4=;
        b=SzpnknbOQ3HNdvQLjm3utkdkqtSfVJsYwqpamt4LquxnySUulK9IgS9vdeS/+7YC/5
         A9m/m8St6hMnc8ZWL7axxwLufsCohGMOms2q6+BR1ldI57QKm4ESSzhjKAVachUHdpdW
         wYm/Wg0o2+KzgAxlbokjWT+gz0PtIz/hQk8P5r2XvIFF+x1w5bPjefDbxjHdNUAP4de0
         bivQvKH+p518+pSEJecRckNnJwn5j2n8/9+URDxNHccHVx6e8EwNTv+I++zLndNxwSyn
         F6Z/shZ1BrM9N5C0sGbMtb6XXjDShAyjcmCkaHz3RmrWPgUt+LWCSKA4PU/ufL0/Rbsb
         orKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bOOV9oExnzwHMA1NkeEvUu69N0POwqdE4jHG4zv9EF4=;
        b=mruk1B3rhppheot3RQsJcVzHmwwG9GdWbeVDovRW5TeguHH4aez7+A3NXUa2Vqp1fP
         zQ9VJ9lXIoTn3BYTXtM6FV5C9hyLALFY8+RlMCx42tO4fimfo3zm3RA4aQwDTbOD9zvU
         WHXbETj8dZcuTOIR1ZX2h5BWKqSqC1L6QrWQ8JtdZVXt9OsINAjhQLXi+OrJoPVnJbcI
         //CcmyHD5nM4WRCRmwcRSQJeQehIglKoisTlPPumkoKEGxZuvUgnezaRZ5kb0dmLlkts
         YvCCfmf8+nD+/66klVabSmNUmSXCMe1+jooxbWhny8TpEIgYZu19piXbCkgQJokxWYMa
         mgig==
X-Gm-Message-State: AKS2vOxdadsqKT36kll5h8gA/kKw7wqa59BbAOFtsPlaEp6I/8+lVW12
        //Ya1i6Wh7hKMg==
X-Received: by 10.223.166.2 with SMTP id k2mr366616wrc.34.1497649047082;
        Fri, 16 Jun 2017 14:37:27 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w17sm2576546wra.34.2017.06.16.14.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 14:37:26 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-mips@linux-mips.org (open list:BROADCOM BCM47XX MIPS ARCHITECTURE),
        linux-pm@vger.kernerl.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/5] soc: bcm: brcmstb: Add Kconfig entry point for power management
Date:   Fri, 16 Jun 2017 14:37:00 -0700
Message-Id: <20170616213703.21487-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170616213703.21487-1-f.fainelli@gmail.com>
References: <20170616213703.21487-1-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Add the necessary pluming to select and build CONFIG_BRCMSTB_PM.
Functional code is not added yet.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/Kconfig          | 2 ++
 drivers/soc/bcm/brcmstb/Kconfig  | 8 ++++++++
 drivers/soc/bcm/brcmstb/Makefile | 1 +
 3 files changed, 11 insertions(+)
 create mode 100644 drivers/soc/bcm/brcmstb/Kconfig

diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index 49f1e2a75d61..055a845ed979 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -20,4 +20,6 @@ config SOC_BRCMSTB
 
 	  If unsure, say N.
 
+source "drivers/soc/bcm/brcmstb/Kconfig"
+
 endmenu
diff --git a/drivers/soc/bcm/brcmstb/Kconfig b/drivers/soc/bcm/brcmstb/Kconfig
new file mode 100644
index 000000000000..996a75db015e
--- /dev/null
+++ b/drivers/soc/bcm/brcmstb/Kconfig
@@ -0,0 +1,8 @@
+if SOC_BRCMSTB
+
+config BRCMSTB_PM
+        bool "Support suspend/resume for STB platforms"
+        default y
+        depends on PM
+
+endif # SOC_BRCMSTB
diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
index 9120b2715d3e..ee5b4de741b8 100644
--- a/drivers/soc/bcm/brcmstb/Makefile
+++ b/drivers/soc/bcm/brcmstb/Makefile
@@ -1 +1,2 @@
 obj-y				+= common.o biuctrl.o
+obj-y				+= pm/
-- 
2.9.3

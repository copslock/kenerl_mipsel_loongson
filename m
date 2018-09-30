Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2018 16:16:11 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:46027
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbeI3OPjSHm2u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2018 16:15:39 +0200
Received: by mail-wr1-x444.google.com with SMTP id q5-v6so4505869wrw.12;
        Sun, 30 Sep 2018 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=Qo20lw9M3JkN07IZ94G0L4Z8aC8BsDlLJ1Lei5zF7k97rqEbjoE+kkFsiWTa+TLp/C
         Tz6WqfxK0vxgfG22+TVaLDeLYHvLk9ZoZRMY0ZyzrH+HURcVA/u7tAO5Eee6rD4gZ62Z
         uS3BRX49Oh2bMMCKgv0V1R0fLR9X5BvHCdPpcmWFH7B/ZgZ1ftfxNM2YSRG+0p8SBdHW
         6rae7v7ThK10uN4lvpODBZFXYZ6y0kRqanoAd3hqZgfxNtK5LuyZ8iItPpjuxcYF8xI0
         2CTN3+OI3SpnpHMOoZRx50kKpguYiNlkLlbkmviOZmzbbm2uMZLjEDF9QHBq/Nn2X5qa
         zVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=BrinlzI7wtyP424Mj61NTCE/FdxMouvn9gUDIDsPZ2j+qFI4Cmttqz5BKPATEvCY5o
         SQWueDyg4cw1T576DQMoEHHpQR84QLnXt8iEFgy/YPSCvtZbx9FaGa9FkHgn81F7o1zr
         O8lGFGgzR+wuZ7/FGH3TckO2IMCAZExVizT9VReMCFjKIWcu20iVu7acmgiOvS7H64mI
         yWbWH7oGl4VA9o9BubswZV0+za6l1ECKjXykN7eVz1Ih/8JpBj5hW3BUVmhV4vN/JXaT
         n/nXrwYtcFNOe3Zf3xh6czXDz2BgC0bIAzhxwEB5Gwz5kmUuOS0I3AhCUAKNNy5dV3sF
         qYZQ==
X-Gm-Message-State: ABuFfogahDtI9YggQLtKr76SEkGXU2+FOmzsGGcUsecLbjlE8BE5oPuD
        pBGuPbthFaKPp0iCjsdDGbCoU6xcPZg=
X-Google-Smtp-Source: ACcGV62CvjUD5JGQCjpLZhkMmwTzce069M0NylEBZwyOKREW+3dzcLSn/Ig8FUZS4zs0zVukwkgDLg==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr4252596wrq.225.1538316933722;
        Sun, 30 Sep 2018 07:15:33 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:33 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/5] dt-binding: timer: Document RTL8186 SoC DT bindings
Date:   Sun, 30 Sep 2018 17:15:07 +0300
Message-Id: <20180930141510.2690-3-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930141510.2690-1-yasha.che3@gmail.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

This patch adds device tree binding doc for the
Realtek RTL8186 SoC timer controller.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 .../bindings/timer/realtek,rtl8186-timer.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
new file mode 100644
index 000000000000..eaa6292c16e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
@@ -0,0 +1,17 @@
+Realtek RTL8186 SoC timer
+
+Required properties:
+
+- compatible : Should be "realtek,rtl8186-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt number of the timer.
+- clocks: phandle to the source clock (usually a 22 MHz fixed clock)
+
+Example:
+
+timer {
+	compatible = "realtek,rtl8186-timer";
+	reg = <0x1d010050 0x30>;
+	interrupts = <0>;
+	clocks = <&sysclk>;
+};
-- 
2.19.0

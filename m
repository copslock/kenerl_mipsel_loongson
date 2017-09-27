Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 17:16:28 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:38631
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992211AbdI0PQD3TEXl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 17:16:03 +0200
Received: by mail-pf0-x243.google.com with SMTP id a7so7044115pfj.5;
        Wed, 27 Sep 2017 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJmJZ1dc4hdZmIg5NGZKJ5pcmI3HjdeR6VGBn9AS7zU=;
        b=YwGrjCt+SsnbTs/WR68tzpoFVOncPaJQ0YVZjTGyYXqyOXmqEz7Dk9Xuy9b3FOVXNz
         QzsdePJtUkPUBrkVGEIxWw/07CYoJTvQ9J5BUXueenmW3hEXWnb6f0im2H/QkpKalKET
         ZYElN9u01fEXZMuVZefk1eWJ5IJD/d8kN9+5GGDSCHYonBg7ArsmCVTTc0hCQ08pwpq3
         GHvW5epC29gIL+Gg+XzoS0yu22uXy3ca27Y+5VUU8/cEUpQvSlSe0erwye4VMVinrhFF
         MSIFyXFOT2GrsHuYpxUBqXTfxjZlNnnDV2MUJ3RZWaEeKeR+C8Mf/Muibr2I59fMHDTK
         U/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJmJZ1dc4hdZmIg5NGZKJ5pcmI3HjdeR6VGBn9AS7zU=;
        b=dk8NNMhMRf/QTHzRiD7ejs64Mt+Fq8ZlzvhOw1XVQzMAo3gKeWdD668znlPYXYhbtR
         DCiu1grPxLxndLOpSuZkdGg+Lyx5xnRrDR0+eOFanMJaKd9e80EKRg6NDCrHpcnf3Y1a
         I/AFtdpU6cG8pjN+BuUCsAKzKygeuJRADBH7K3s2pLM0H5iKApwwcWjlShzMzqS6RXfu
         K5fwzKAJgt3Pdgh3gfAk5dJdmJ7PRPBRjJKqF/ehBnZStl1ulXAiF4Ze4vLxGCl2Vvar
         uBVrreXs+BmKhMK/x+y55u4AhpHCi8n4kVx6RW5VtGkPbujRNshE8L6N7gVpQ4WYMXGt
         qmpA==
X-Gm-Message-State: AHPjjUgRyfFSX2Q02F/LdQEHB8/aTFnmzWTBOB7il77XrZiMBIzSP792
        4EsWQKmBzIeDwrIPl4zS0Ls=
X-Google-Smtp-Source: AOwi7QBJO6FzeOntrerTu9DNpBJS1B83qlDFguCjbiQcyJKps+W67wMawBoe/gvcqNECBAnw9CEeUA==
X-Received: by 10.84.143.131 with SMTP id 3mr1589695plz.224.1506525357078;
        Wed, 27 Sep 2017 08:15:57 -0700 (PDT)
Received: from linux.local ([42.109.141.25])
        by smtp.gmail.com with ESMTPSA id b65sm21289624pfj.97.2017.09.27.08.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 08:15:56 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, malat@debian.org, dom.peklo@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [RFC 1/4] dt-bindings: Add Ingenic X1000 SoC clock define
Date:   Wed, 27 Sep 2017 20:45:24 +0530
Message-Id: <20170927151527.25570-2-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Ingenic X1000 SoC has different set of peripherals than JZ4780 and
JZ4740. Add a new device tree binding for the clock.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 include/dt-bindings/clock/x1000-cgu.h | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 include/dt-bindings/clock/x1000-cgu.h

diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/x1000-cgu.h
new file mode 100644
index 0000000..17f05bc
--- /dev/null
+++ b/include/dt-bindings/clock/x1000-cgu.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2016 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_X1000_CGU_H__
+#define __DT_BINDINGS_CLOCK_X1000_CGU_H__
+
+/* Add details for other peripherals when their support is added */
+#define X1000_CLK_EXCLK		0
+#define X1000_CLK_RTCLK		(X1000_CLK_EXCLK + 1)
+#define X1000_CLK_APLL		(X1000_CLK_RTCLK + 1)
+#define X1000_CLK_MPLL		(X1000_CLK_APLL + 1)
+
+#define X1000_CLK_SCLKA		(X1000_CLK_MPLL + 1)
+#define X1000_CLK_CPUMUX	(X1000_CLK_SCLKA + 1)
+#define X1000_CLK_CPU		(X1000_CLK_CPUMUX + 1)
+#define X1000_CLK_L2CACHE	(X1000_CLK_CPU + 1)
+#define X1000_CLK_AHB0		(X1000_CLK_L2CACHE + 1)
+#define X1000_CLK_AHB2PMUX	(X1000_CLK_AHB0 + 1)
+#define X1000_CLK_AHB2		(X1000_CLK_AHB2PMUX + 1)
+#define X1000_CLK_PCLK		(X1000_CLK_AHB2 + 1)
+#define X1000_CLK_DDR		(X1000_CLK_PCLK + 1)
+#define X1000_CLK_MSCMUX	(X1000_CLK_DDR + 1)
+#define X1000_CLK_MSC0		(X1000_CLK_MSCMUX + 1)
+#define X1000_CLK_MSC1		(X1000_CLK_MSC0 + 1)
+#define X1000_CLK_CIMMCLK	(X1000_CLK_MSC1 + 1)
+#define X1000_CLK_PCMPLL	(X1000_CLK_CIMMCLK + 1)
+#define X1000_CLK_PCM		(X1000_CLK_PCMPLL + 1)
+#define X1000_CLK_NEMC		(X1000_CLK_PCM + 1)
+#define X1000_CLK_UART0		(X1000_CLK_NEMC + 1)
+#define X1000_CLK_UART1		(X1000_CLK_UART0 + 1)
+#define X1000_CLK_UART2		(X1000_CLK_UART1 + 1)
+#define X1000_CLK_PDMA		(X1000_CLK_UART2 + 1)
+#define X1000_CLK_CIM		(X1000_CLK_PDMA + 1)
+#define X1000_CLK_DDR0		(X1000_CLK_CIM + 1)
+#define X1000_CLK_DDR1		(X1000_CLK_DDR0 + 1)
+#define X1000_CLK_CORE1		(X1000_CLK_DDR1	+ 1)
+
+#define X1000_CLK_I2SPLL	(X1000_CLK_CORE1 + 1)
+#define X1000_CLK_I2S		(X1000_CLK_I2SPLL + 1)
+
+#endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
-- 
2.10.0

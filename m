Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2018 16:16:44 +0200 (CEST)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:36997
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992363AbeI3OPncL7ku (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2018 16:15:43 +0200
Received: by mail-wr1-x443.google.com with SMTP id u12-v6so10970107wrr.4;
        Sun, 30 Sep 2018 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=UqxFYsu2VAYcfRo5y5FcS0y59ApqqLdQ1vZ9PGJ6gfJc7MH6SMbO1TxctOw0omEl8a
         Nn2dJmUiX3183pzvOV83pyjXjuE6ENCQQr5BrK9mTLX/5GVte+Pa2dw1MOx2GkLnKeg4
         64bIEtU5BQCOj1xlEVu53k1IYuDODWE4b/1/47BJbjKh39YaOXfg++UhzG0rFgxBXckN
         7T5+/qw3BDbrIFw4jrEepp6tSqPR2twOefgsjS1u3OKp/LjcrVQ0DQZ7H95HXY4ecivh
         APnGccXAW6MzAiasOXauRrBa5Hvr6vBEpMYRmEu9Wfj+aGu4sbQNfHB0jmDbYpnHnFFa
         Y/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=cgwQmBFnVQR2ZgRQOu4078V7unR6JqnKiB/dBJ5Hr1lxvKBX7Wal33yn20KsV9FYc6
         WhioOGDmbeTW+xemk7nfQ9oHNC7EuNk9JRYRxB7wWbnSSUoJeHUFu5t094u/j56FpIzH
         RT9ocSj1MLMdXvgldrBYSq7sUcbEVhdPKuqq/i1tWxJ2ku1658sKJVo3Ush9d/0z1Mve
         8oVY3120teN+NJgW3Sc2JIKFgS/CHeDf2aHTjH6tIlFT1SPLVaLd4BADCATbcA2JsPYN
         kipKC9YInR7QvAorkIu9WIi98dqRpNcaG974/Tg5Poja2Oqac53vwTeNeja6vQGWeQUe
         Np9g==
X-Gm-Message-State: ABuFfohCje3JoncGw3EMWwRzEpfUvZkwM+PVfgIAgwhY97A/zZsJqOUW
        /MLr6XyOe96RCZDSYFqvf4mCI3BzqT8=
X-Google-Smtp-Source: ACcGV61EsWNGccevOPvtLXACP9hRtTAspuBVF+AN/e1su9FKiH5Z66vrlJqqAu5WGsZVwYSFRGBKXQ==
X-Received: by 2002:adf:9206:: with SMTP id 6-v6mr1132992wrj.275.1538316938000;
        Sun, 30 Sep 2018 07:15:38 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:37 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 4/5] dt-binding: mips: Document Realtek SoC DT bindings
Date:   Sun, 30 Sep 2018 17:15:09 +0300
Message-Id: <20180930141510.2690-5-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930141510.2690-1-yasha.che3@gmail.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66621
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

This patch adds device tree binding doc for Realtek MIPS SoCs.

It includes a compatible string for the Realtek RTL8186 SoC.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/mips/realtek.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/realtek.txt

diff --git a/Documentation/devicetree/bindings/mips/realtek.txt b/Documentation/devicetree/bindings/mips/realtek.txt
new file mode 100644
index 000000000000..09d19758168a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/realtek.txt
@@ -0,0 +1,9 @@
+Realtek MIPS SoC device tree bindings
+
+1. SoCs
+
+Each device tree must specify a compatible value for the Realtek SoC
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  realtek,rtl8186-soc
-- 
2.19.0

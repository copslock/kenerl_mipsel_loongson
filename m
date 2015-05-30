Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2015 01:53:57 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:10495 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006760AbbE3Xx4ZEGx4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 May 2015 01:53:56 +0200
Received: from localhost.localdomain (unknown [78.54.178.112])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id F1D864B008C;
        Sun, 31 May 2015 01:51:51 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/12] devicetree: Add bindings for the SoC of the ATH79 family
Date:   Sun, 31 May 2015 01:52:24 +0200
Message-Id: <1433029955-7346-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1433029955-7346-1-git-send-email-albeu@free.fr>
References: <1433029955-7346-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 .../devicetree/bindings/mips/ath79-soc.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/ath79-soc.txt

diff --git a/Documentation/devicetree/bindings/mips/ath79-soc.txt b/Documentation/devicetree/bindings/mips/ath79-soc.txt
new file mode 100644
index 0000000..88a12a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/ath79-soc.txt
@@ -0,0 +1,21 @@
+Binding for Qualcomm Atheros AR7xxx/AR9XXX SoC
+
+Each device tree must specify a compatible value for the AR SoC
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+- qca,ar7130
+- qca,ar7141
+- qca,ar7161
+- qca,ar7240
+- qca,ar7241
+- qca,ar7242
+- qca,ar9130
+- qca,ar9132
+- qca,ar9330
+- qca,ar9331
+- qca,ar9341
+- qca,ar9342
+- qca,ar9344
+- qca,qca9556
+- qca,qca9558
-- 
2.0.0

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:15:03 +0100 (CET)
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35562 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011642AbcBIIOaoF1b5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:30 +0100
Received: by mail-lf0-f54.google.com with SMTP id l143so110795363lfe.2;
        Tue, 09 Feb 2016 00:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mcDhd7DkcVCm7XjqTQLSehT1NG0EypiHJWYxvJ9eGqw=;
        b=u/57ojB46+UBZ75u1bfi0/bWIGyYxhmC2Frw7BvleGtLR14BOot3vGRumtPqy2WW+X
         /tDu6hF1cIiMhlfet6Npcr5GtcXCOYZOrfsCxRgOL2MUEHOT7tPvGcTOe6ihigd1YqmV
         /nnf0Nkz/JMzlhliBY5n1NzxCUUNj1Vs+3vxk2JmBiXwnf1bNHETiBps+w+ZZQNsb8Zt
         6lcA3kCfpC1TCswM0TPQ4YUjLt0hvcYlzMyzFWXt0Fvw2/Nd1SfGFyGc0XfLqdaxQug/
         NdrbGl2Bn2k+/V3zy+5t5ScfxwXrgqyWgyNVB2RnLhdZSe4OeWexH/Q9OqmMDT9dGJlX
         ZaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mcDhd7DkcVCm7XjqTQLSehT1NG0EypiHJWYxvJ9eGqw=;
        b=WEwha14qIvr49bIgB+OzU7VcbOa4tmAg90R3Ia7tN43Mb+Dc3oA+0XvG+wTOEUBe9v
         qPGvaDeFYovYc3IYbY/ejogKhaO6mWLz2sZn6xc+gumkRoJB4ioPrQK/5jRQAFzXsHtH
         JHwHzuEqCIqsTOVanbwk+ge9/xWhVPW83eJFvlFUuUutkReCKS1u3MTuTwjubfItUVED
         HxkkXKfAEtujrQ+A5gfG6HqBr9UKOUxQjCJGOr+A1Pvd8WHq3byaO29ZZBa7+LqMUvny
         IOAyLnLw19Gk+4PVfAQZNJ29JaffWRMBdAAp1uqWPvdJNlBN7VaU71MwJBo6zoXDULXn
         ydVg==
X-Gm-Message-State: AG10YOShIv61vMWf+1rrdMb08hz6FbIXCo04y5ILcl4SGa0ztRqhaTQXCvhulHBHWcG4FQ==
X-Received: by 10.25.151.135 with SMTP id z129mr5298705lfd.122.1455005665480;
        Tue, 09 Feb 2016 00:14:25 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:25 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org
Subject: [RFC v5 02/15] dt-bindings: clock: qca,ath79-pll: fix copy-paste typos
Date:   Tue,  9 Feb 2016 11:13:48 +0300
Message-Id: <1455005641-7079-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/clock/qca,ath79-pll.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
index e0fc2c1..ae99f22 100644
--- a/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
+++ b/Documentation/devicetree/bindings/clock/qca,ath79-pll.txt
@@ -3,7 +3,7 @@ Binding for Qualcomm Atheros AR7xxx/AR9XXX PLL controller
 The PPL controller provides the 3 main clocks of the SoC: CPU, DDR and AHB.
 
 Required Properties:
-- compatible: has to be "qca,<soctype>-cpu-intc" and one of the following
+- compatible: has to be "qca,<soctype>-pll" and one of the following
   fallbacks:
   - "qca,ar7100-pll"
   - "qca,ar7240-pll"
@@ -21,7 +21,7 @@ Optional properties:
 
 Example:
 
-	memory-controller@18050000 {
+	pll-controller@18050000 {
 		compatible = "qca,ar9132-ppl", "qca,ar9130-pll";
 		reg = <0x18050000 0x20>;
 
-- 
2.7.0

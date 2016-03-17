Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:35:50 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35612 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006966AbcCQDeoz7cgp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:44 +0100
Received: by mail-lf0-f65.google.com with SMTP id e138so2230918lfe.2;
        Wed, 16 Mar 2016 20:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MgYZ4e80lNfbfynDIY88dxkazaW7Dh8/ckcLSZ7DOJ8=;
        b=pNXRv7sZKChpYdYsDLLaDYMA0og6i2D+XwFVuEmal4dPhhu/BfgRtwLkJEtkNY6GNP
         VEFOaAmpqQxuequ39SHy/wLhXDT0FttUvZ8HhTnGG2LjTKg/lxpMlmu9kYUkE04gSMWN
         HYSqrjsxzTgc0QPVLJQANB4fS26VVthR6h4OPAJXxW9YHNwYlHdoAHDUoDqdA/Qx5Lj/
         sjq2AouZoiGdGxtsK9eSjEDuLae+2qTjS66FVncT3DHEVAgNAprtpdQiLtHdt+tqyjNn
         v9Cm2B6op1yY345ioggmr1H6ORJ3qf5wdrrdPkBUbaBSA6KOAZYygfHavqYJO9xy7oJy
         73VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MgYZ4e80lNfbfynDIY88dxkazaW7Dh8/ckcLSZ7DOJ8=;
        b=bXOGZSpfymGt/KteGGWVtqGF5MPbqaUTW4IElB933a2AuSwvRuoC1S9m05enLAhsC+
         Er+IYDi5hMueORwIj3NuhSiEB45rLKVMtU07ZbKKohBwsXO4lAyxMaMSpBA5K85UMBLO
         zC7WkDHfeStwJbTipgpF1D4G/thhEj6VF417Z2HRBhkVBCvWafzXJqY/z+baLnpmX04d
         Bs/QS1k6FWjHOlQLmbEyOcq2YrieVsnWNBnKUgwhBBIVA1zo231+45nGIj7akGQ2iN1Z
         E2oKbrvEhFlUgHVKyOw5Gg/kQTDncXe8m4IH40EKYqHsBMzk/8HjnYk2sJuu5oMT0oh3
         KswA==
X-Gm-Message-State: AD7BkJIeD9qoYKfEJlMqY58HQCb66Yr0YUjUNTfIkVAedNOka/0P/NlkHpY4YQAWvpmo3w==
X-Received: by 10.25.163.76 with SMTP id m73mr2171090lfe.39.1458185678717;
        Wed, 16 Mar 2016 20:34:38 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:37 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 04/18] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
Date:   Thu, 17 Mar 2016 06:34:11 +0300
Message-Id: <1458185665-4521-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52618
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

The TP-LINK TL-WR1043ND board has only one serial port,
so replacing the default of 0 with 0 does nothing useful.

Moreover, the correct name for aliases node is "aliases" not "alias".

An overview of the "aliases" node usage can be found
on the device tree usage page at devicetree.org [1].

Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].

[1] http://devicetree.org/Device_Tree_Usage#aliases_Node
[2] https://www.power.org/documentation/epapr-version-1-1/

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Acked-by: Alban Bedel <albeu@free.fr>
Cc: Alban Bedel <albeu@free.fr>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index e535ee3..c3069c3 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -9,10 +9,6 @@
 	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
 	model = "TP-Link TL-WR1043ND Version 1";
 
-	alias {
-		serial0 = "/ahb/apb/uart@18020000";
-	};
-
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x2000000>;
-- 
2.7.0

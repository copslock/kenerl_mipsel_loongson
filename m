Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 09:21:58 +0100 (CET)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34868 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007755AbcANIV4to4Ur (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 09:21:56 +0100
Received: by mail-wm0-f44.google.com with SMTP id f206so330306153wmf.0
        for <linux-mips@linux-mips.org>; Thu, 14 Jan 2016 00:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/H9UnZggMzFyqHPt5lMEj1lkNFQp+6bw15umnWhXMBs=;
        b=pUSpl+W0QlhbY6zcWTBjMTVHzHN8wNSOpqOFwEWm0qoPEKXy4WodIIGZKLkLWVlfve
         zwdgrWGHzcCqdhDBvQAxp6cSnCSBU7op2s8MF4jmdYYCanhnTyximoJqHJjPAiKuLrTm
         Wj6+zb1EqMC4m7L7zDZ4P9CGnhh69FA30J3PJqAVCCLfC/a4kwAVi0UYE+YjPtgzENC8
         R27Av+NEM+G3VewUdGiKP6TADlwmGErVGHgG6ETKu+fgNLC0o91syWpJVs3vcIpu1Ebv
         kaqQYdcxsLuBBm+hkUcyJmvW4E8osi4tDq86AKoxN++f2/ndhJyUM1fzUlUbXiQUXINS
         cTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/H9UnZggMzFyqHPt5lMEj1lkNFQp+6bw15umnWhXMBs=;
        b=LNAfxU9mqoqjW939vApYa318I9u3jdU3znHwR+qnnUwzwsVJnGlCPEZwTMQSAdHROp
         3zRfYhKr+4o47kUYur6p8pc1eUIP/OpCBNiCNtQnqoUo9XMonueygqu2iiwucU6q1tKt
         MrR/wT7GHGBrr3J6WCHe45bsfZiyo7WyU77gejqzTFB6pqbadayAPc0NneaHcA3jMVSS
         ghoqcTxKNbedPISj8VazxYr/vzaPu6zIw7GrriBsIiA6AzCSlr1PywrbFCHlQMTKaTMd
         2+pxa29n8Su9cG8RZpb3ow29U17V75JlGNgTjtNV5hK9Xl0je70idq/JSYV4Ruz8AUKq
         zWkw==
X-Gm-Message-State: ALoCoQnNHyif7xPk8o9LYhiGtBb01Xh0+8vS+PZlyWDNXLjgRmhHhSZDPiU0uGzU7llux7RB4WMLOk8VU73TUke+zmD1np72og==
X-Received: by 10.112.209.99 with SMTP id ml3mr742893lbc.26.1452759711525;
        Thu, 14 Jan 2016 00:21:51 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id tv1sm267673lbb.4.2016.01.14.00.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 00:21:50 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, devicetree@vger.kernel.org
Subject: [PATCH] MIPS: dts: tl_wr1043nd_v1: fix "aliases" node name
Date:   Thu, 14 Jan 2016 11:20:57 +0300
Message-Id: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51113
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

The correct name for aliases node is "aliases" not "alias".

An overview of the "aliases" node usage can be found
on the device tree usage page at devicetree.org [1].

Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].

[1] http://devicetree.org/Device_Tree_Usage#aliases_Node
[2] https://www.power.org/documentation/epapr-version-1-1/

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 003015a..4b6d38c 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -9,7 +9,7 @@
 	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
 	model = "TP-Link TL-WR1043ND Version 1";
 
-	alias {
+	aliases {
 		serial0 = "/ahb/apb/uart@18020000";
 	};
 
-- 
2.6.2

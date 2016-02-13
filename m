Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 23:00:02 +0100 (CET)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36168 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012306AbcBMV6g4f6Ni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 22:58:36 +0100
Received: by mail-lf0-f67.google.com with SMTP id h198so5750360lfh.3;
        Sat, 13 Feb 2016 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MgYZ4e80lNfbfynDIY88dxkazaW7Dh8/ckcLSZ7DOJ8=;
        b=as4NbK2NJ0wuyzNN7r3S4oCNoGJ89dKjVLjJ3PCxvUEab8VRSs1T2NxDBSeuqnVpJh
         ITame3M1a+XtIuC+ZfnAbbUPV+qdl0AcVW79/kRopSfiWhjjiMoDOi4ED1Y4Y1ldRYWN
         sRPkGtShKDD5xSqcquLfbSeSrPBhNnGsRdjXJU6r/0HbJg81qBknNKnEWvQ0IdzJ0TIG
         ock1ufRHg+kZxML3eYTWJW5GSuTO6G1/qnNFETe41GY17RXjFDvGR5yrFXKFrQjM8ADl
         yUsFEyNHmUbVuZynVt+h78zb6NLUOFYgv3RJH2uSR6VU440o/KvoIQTBxEEg9YZwBzPQ
         PsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MgYZ4e80lNfbfynDIY88dxkazaW7Dh8/ckcLSZ7DOJ8=;
        b=IZhy+bOl0QhyOLs1KJbDkx71WNblwNvxGoV9D+F55MgTlaN/COVjJP4ipmZak9xqOZ
         j1XRXKzVth6aCLn3nYXkJvlnFrHF4yhXVt8S7r4jFWoFytxANnM4mJ8kEwptN1jYA/6Y
         YOmu3SSBaTt4CT2GmHu/7xNqczx9WcdfRWOSHRY8p7t4mCnV1qMZjs/wUxElnb9/1XnL
         Z1eKcaB6LqY4/uCD4CrK0/JunfVRb7oKeGpVs/4AfLRzVWJwo89m7Oh8iVzPaDEeSqSx
         LovbmEF6kJDSf+wdK5wD1xIg9vZ4P/q98zXCk2VQiivblzBm8eXlLNai2DKHg/mxy24U
         ChCg==
X-Gm-Message-State: AG10YOT+GPM4xCvtZXsnndRwEvuxVlwMCGO/VDPrtIXhwGf7j/5pzc5QsUkWnvJgIu3meQ==
X-Received: by 10.25.77.203 with SMTP id a194mr3920015lfb.62.1455400710941;
        Sat, 13 Feb 2016 13:58:30 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id jr10sm2624949lbc.42.2016.02.13.13.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Feb 2016 13:58:29 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 05/10] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
Date:   Sun, 14 Feb 2016 00:58:12 +0300
Message-Id: <1455400697-29898-6-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
References: <1455400697-29898-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52037
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

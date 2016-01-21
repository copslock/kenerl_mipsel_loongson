Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 10:59:37 +0100 (CET)
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33856 "EHLO
        mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008977AbcAUJ7gP7pns (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 10:59:36 +0100
Received: by mail-lb0-f195.google.com with SMTP id oe3so1730151lbb.1
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 01:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lhXqjTjfyt19K8TashbuwLRiskWBvjXwtkBNQJc1Wvg=;
        b=mZnDCal+HYyPLDZEIw/OkJHCx+FaVpoHWcsU11LnemkFRLaI1JwDqoKinQssH2Dzzq
         33U3qIyhJufjWuuVMnQfOwRKuCDeZfy5neTG5gp0wRPwkjpo/M25PuWuJ4aqXeXkXV/+
         hP6R8qdTzu7rPJJarO39Tg03sVSul362yHplsJS6SgdPHeJqBw4xoQjHpOHyxauvCpxS
         VaUVYGlUHHZSbQg2/1YSDvxzSd4Vm93W4QDQi/8/2rUMPLwsvJxxJdxbx5uRJpLyaeSa
         py7aJMcc4wIeyQMykef8bY2HBMzCVnrgYwGVeJCsJUyHcxkelLgBQpM9ANXWtIp2kacA
         wfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lhXqjTjfyt19K8TashbuwLRiskWBvjXwtkBNQJc1Wvg=;
        b=dx76d1L13Z2nGcqJPda1o+6fdAaWlFFww9lYHesd0JtS3sk8fzVv35yCrFHWEhp5bp
         x425Z+Yzavok/1J+MTyUGeEpPziv7w8wMUQVC35ZKoRov3EM6i85eRzVBJred3Ibqfg8
         56908A3bkmA25Ia0tNLtdMDlm1gS0OcJevlpJD+PIsf+e2ce2YRvJlFUZ9+PRmr8mJ6b
         +7a2lRj6pkv4KB/jkod8Jb9Xa5YOmtA/q3edBzbt1vQU2zN8c2JXvT5mXnKKXdQqr2fJ
         apBXvQGHSHDhfKQM2Knn1k1XyNNfmjDOmTpyCblaYlGfaecuCkkWqCpjSlcXr6m3c/pE
         eFZw==
X-Gm-Message-State: ALoCoQl/eSQydILagX0fdysOHqa+j+PPQx0VqpAlfJlLHZBapx0M/8wR9Y98T9IuSI2sQP/bB/9bgGklRwfjF9YwB1qeLV9q7w==
X-Received: by 10.112.166.2 with SMTP id zc2mr14841281lbb.34.1453370370786;
        Thu, 21 Jan 2016 01:59:30 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id i127sm86367lfd.3.2016.01.21.01.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 01:59:30 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
Subject: [PATCH 1/3] MIPS: dts: qca: ar9132_tl_wr1043nd_v1.dts: drop unused alias node
Date:   Thu, 21 Jan 2016 12:59:03 +0300
Message-Id: <1453370345-16688-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
References: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51268
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
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 003015a..a6108f8 100644
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
2.6.2

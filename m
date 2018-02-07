Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 03:36:54 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:34131
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeBGCgsDJ-Ml (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Feb 2018 03:36:48 +0100
Received: by mail-pg0-x244.google.com with SMTP id s73so1943194pgc.1;
        Tue, 06 Feb 2018 18:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UjbifgPHINX3otfBd9DkfuobXRLbZuqxSCfJ2+lLt+4=;
        b=IsbDIT2pNiWiopeaI1KDFRn4u+eL5gXkfbUNDhy8cz69Ng34iBLJ2zqafHJAEjibFO
         kkNgyjkV8nGH7bSWEQoCdyjGma7syj8zZnwPIII53IMqnY1qvLxDLlfpbqq8qhBO/nYq
         NN5uqJKtdon2LCAfVmHapZrLgATrI5jfrSXwXk2R8EJ/CwO2aUN6b9BHsxu4fHnLkDtj
         GGFknhYb7482VxtJCNwEpuyurhYM/V5NsNb+VPDwHRxAcMKUvCFB1ocC1er1JhuIdCEI
         TkKPHKRXzbwqJ+eA5/k2iZxwNjIDSsZV8wqtilI686AQuaB7wry8YJzT+R4oCxOS0U/A
         uk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UjbifgPHINX3otfBd9DkfuobXRLbZuqxSCfJ2+lLt+4=;
        b=Q8T2vpRCuMrThpturm743wU8MSVymCmm6NvM7sgeFZ4swKQFEskWAi+gWWfh7Vszuh
         AE0udM8MSUG5mXClaQkFerYKKYPlE3XVbwxFVmZ4wz0bb5uehrHwOMN4scVQvEakUh0Q
         SOl7D7iW7AFqhQvLFghYIsoIwv5qnn+uRLBPHor/2tASQVOvVbaybeKygOYN7VAm06rq
         r5Sufy+gCxodeEJmD9Js6yeE9LnS/bA1YojRTw4t6b3b5w0plp4E2owqr4GcBbVUK7ln
         w+cO+SrjLEmFzwe+xkvfrjKDjvr+PEFcSw/5X156QHSE2+BKZ6yDyojwvjOn5QNjfwLh
         VgaQ==
X-Gm-Message-State: APf1xPCAs46xZocXNoZ4oHbBwpgKY/NLBD1SOeLHeIilkj4APB7AIX9R
        y+7m0MWlFHROHaviGY0Djzcnolze
X-Google-Smtp-Source: AH8x225BFscsHp+Z83VLj8cYXKaaRYWcBS0mwM7pJE5GLK4UFOfF5trbhIcOLLIlNb5N1aTD9qQbFg==
X-Received: by 10.99.176.15 with SMTP id h15mr3628358pgf.374.1517971001187;
        Tue, 06 Feb 2018 18:36:41 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id m9sm654627pff.59.2018.02.06.18.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2018 18:36:40 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Enable CONFIG_SOC_BRCMSTB
Date:   Wed,  7 Feb 2018 11:36:27 +0900
Message-Id: <20180207023627.7898-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.16.1
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Enable CONFIG_SOC_BRCMSTB in bmips_stb_defconfig. CONFIG_BRCMSTB_PM is
also enabled by default option in Kconfig.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/configs/bmips_stb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 3cefa6bc01dd..47aecb8750e6 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -72,6 +72,7 @@ CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
+CONFIG_SOC_BRCMSTB=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.16.1

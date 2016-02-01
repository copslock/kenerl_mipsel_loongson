Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 02:40:12 +0100 (CET)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36756 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009637AbcBABkKtE25S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 02:40:10 +0100
Received: by mail-ob0-f171.google.com with SMTP id ba1so106950558obb.3;
        Sun, 31 Jan 2016 17:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Gvc47rZL8rMl/KeUsvtbjMO2q6YN85K4gBqfXW2WOgA=;
        b=0K2++pA8wSkDai5H/pxFTGWfcac8huZpmOZTGhbugPDXopEjxg21j8JF+AxV3O8TJv
         fqiNjDXkJNENVeLGTwjmFUZD3cJbtmOXzNarBr45Js6JSTKDcmJZ3BnlB21ynoYmQcEH
         FWYHOgIrWQYCZ1XEcfKzUOTm9Qp+EkWBz9IslrYBPZvumt6N7/O+Nup4UArJ22tZIpmK
         Va21SfJYKG8dqOlc+StW8mVyL2EuN8YJClEw01L5VMUvb7UvOMlHh4p2Y5aKPykrSjwc
         nzU/g6Xw3tMcbEXFkHQJQ0RwKhunjG2Xt5rwUxStMdzYoSvUGs7r8g6fmNQVUSK/iYxi
         MB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Gvc47rZL8rMl/KeUsvtbjMO2q6YN85K4gBqfXW2WOgA=;
        b=hw8yhBCZ99dnB1a+lIzIalduwd2BPCkYLsxIK4iNrZxX8kfjPmBoibtsMMlYl6QjHZ
         Fbw8XPEl8cXMAkhN9EuMb8+m/LRswS0rOTmeb5R3M6yU53nhYATvnaHC+vOm92iebyA4
         KikTSV7fze2AGZOefNjWV3o5klOxkl0BMnE4Q8YMaI6NOXBVxENSvPmA7PIO5Ez80NtP
         TA8PhEZrl4ecMo+pqdkYzktD6Sqn0aznHC9415IeugODPYOBbQMwvcpJZEgtRLS2XmB/
         5TM87FV7jZynOtIm0GHIRUTMALbJk5FInazX3gRbMw8JHVovDMWrOGFGsDxji5IsxJ7g
         wA0w==
X-Gm-Message-State: AG10YOSsiendggRZJK+RsJfDR706TMM/qSoYXjOUFQBmIQ3+WoVjEyO/N2ytpZbVRzrglg==
X-Received: by 10.60.94.82 with SMTP id da18mr15635687oeb.40.1454290804797;
        Sun, 31 Jan 2016 17:40:04 -0800 (PST)
Received: from bender.lan (ip68-5-39-32.oc.oc.cox.net. [68.5.39.32])
        by smtp.gmail.com with ESMTPSA id y9sm12855983obg.4.2016.01.31.17.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 17:40:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: Remove stale entry for BCM33xx chips
Date:   Sun, 31 Jan 2016 17:40:01 -0800
Message-Id: <1454290801-29735-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Commit 70371cef114ca ("MAINTAINERS: Add entry for BMIPS multiplatform
kernel") supersedes this entry for BCM33xx.

Fixes: 70371cef114ca ("MAINTAINERS: Add entry for BMIPS multiplatform kernel")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4aa5467..3361093cd799 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2357,14 +2357,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
 S:	Maintained
 N:	bcm2835
 
-BROADCOM BCM33XX MIPS ARCHITECTURE
-M:	Kevin Cernekee <cernekee@gmail.com>
-L:	linux-mips@linux-mips.org
-S:	Maintained
-F:	arch/mips/bcm3384/*
-F:	arch/mips/include/asm/mach-bcm3384/*
-F:	arch/mips/kernel/*bmips*
-
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
-- 
2.5.0

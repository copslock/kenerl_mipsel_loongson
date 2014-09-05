Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 09:49:45 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34073 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006813AbaIEHtnt3Plr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 09:49:43 +0200
Received: by mail-pd0-f175.google.com with SMTP id z10so1992575pdj.6
        for <multiple recipients>; Fri, 05 Sep 2014 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZtCErFFZ0TYnLOWgQ5ofqT9PxHOMGt8H1WdN5B38oXI=;
        b=uK1fkcdqLwwDQwlPtKFA79dZtNq6lnYE6M4gebYzU3TtLPNDfpiMg3PX5/uSSn2FhZ
         bXUBcouj0jUV01uS8hB+bGu/pM8g6707/zHcng2d/H/0W4fuLGe022FuYXg8tS516oCe
         Ng4TWrgWC1fI3LwSfE/2lb0l/lcKb5H9c6Qw7Y0R5LgT70+2L3qGScIIG4XrKMKEjtrC
         rendt8cES76tWgHa43TaLziM8FT6PRhrRMKjHj+5h6un5sY6VS3UOrVu86pWsWELet7d
         kjW/ZMrJXD1Ds3rRNGqNQBk5lQtVPqYHT1edl0Wz4CYCvAs5i3S9mxJH+JC3BuoaArva
         OY+w==
X-Received: by 10.70.35.67 with SMTP id f3mr17584422pdj.34.1409902934493;
        Fri, 05 Sep 2014 00:42:14 -0700 (PDT)
Received: from localhost.localdomain ([125.71.161.173])
        by mx.google.com with ESMTPSA id j9sm1054228pdr.77.2014.09.05.00.42.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 00:42:13 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: prom.c: Only show machine name when it is available
Date:   Fri,  5 Sep 2014 15:41:45 +0800
Message-Id: <1409902905-17344-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

'Unknown' machine name in /proc/cpuinfo will make users confused.
Therefore, it is better to show it only when it is available.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/kernel/prom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 5d39bb8..595fa5c 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -33,6 +33,9 @@ __init void mips_set_machine_name(const char *name)
 
 char *mips_get_machine_name(void)
 {
+	if (!strncmp(mips_machine_name, "Unknown", 64))
+		return NULL;
+
 	return mips_machine_name;
 }
 
-- 
1.9.1

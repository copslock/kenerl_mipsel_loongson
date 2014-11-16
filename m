Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:23:24 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55991 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013772AbaKPATrgyzhV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:47 +0100
Received: by mail-pa0-f47.google.com with SMTP id kq14so946077pab.6
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNlFqoVrRwxvk4tjlFVHPP9GNPt5q36EQVaHWpUxRmY=;
        b=MnLvlykXqQmsy5smCAzWYEAGbRovpWSeS0bhzkPQPym/qJUwUoZpWB6nrCAw/2H855
         nM52g9Eng1BkfhisAA/Rv9XKLhbcUNPz/FRQG5J8FEnMHFcAzop130l32mui09zPEozo
         jx8iiC5Yqd0I20zaVs7Hu/NVoUpUtqw/DObCODeh57m1PGsICmih0dZSsOGBPnxCk0pO
         FA3iBJ/nC+t3qvY6WsmqyPXgkSejg2lSeQ2bmoOUhS+/nDNOq4tR4S6eVcJN1D+Oy7RS
         7TsaiWK2Qo/j7cOe2c+KjioY7kN0fGvQYDdBDd+cM4FWF13zHenTm0W0Em74mBTWdLFN
         BhSQ==
X-Received: by 10.70.45.16 with SMTP id i16mr17521924pdm.91.1416097181945;
        Sat, 15 Nov 2014 16:19:41 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:41 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 14/22] MIPS: BMIPS: Fix L1_CACHE_SHIFT when BMIPS5000 is selected
Date:   Sat, 15 Nov 2014 16:17:38 -0800
Message-Id: <1416097066-20452-15-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

BMIPS platforms can select multiple CPUs, in which case we'll need to
use the greatest common denominator (= 1 << 7 = 128 bytes, for the
BMIPS5000 L2).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3d56928..c0130ec 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1473,6 +1473,7 @@ config CPU_BMIPS
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_HAS_PREFETCH
+	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
-- 
2.1.1

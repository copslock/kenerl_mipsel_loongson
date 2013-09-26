Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 20:51:39 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:40131 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816384Ab3IZSveBW0St (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 20:51:34 +0200
Received: by mail-ie0-f180.google.com with SMTP id u16so1966124iet.39
        for <multiple recipients>; Thu, 26 Sep 2013 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=noVV1u5RfkID4yFGfTTP4+o/sciPsXkHw1x6dqIwbQU=;
        b=TieIliaTJKWKeGvkA2LzvZUZ6lnJHLg1wnWY9I4d9Qbo9+Pk9A/1jCUdC5vxcuBB4v
         Ry/tnV/NRES3ZDqyjCT+DJIJa58EuJvwWUJhflNAYLnr7U644ldn+A4d2pkJgy4hMgne
         96wHX+qXpd5yX+M4Ipu+TsmgRfd1eJvZoEj13UBgDEyTOHVli3PLnZeQqUSMOAEjLIfX
         30C2V92I1+YaKDc6UaIf/GWdywjNSK2w7lRfF7C2RXcsEvA+UbgqPDa5KcARIVyz2pa9
         DKMRdLmOmII2s+t5YJHrpC6FVHgA27un/X6GO8F74msMjNSEmNmBlFb2TcB2c/mnd7Ra
         zTYA==
X-Received: by 10.43.49.8 with SMTP id uy8mr2717243icb.73.1380221487781;
        Thu, 26 Sep 2013 11:51:27 -0700 (PDT)
Received: from rob-laptop.calxeda.com ([173.226.190.126])
        by mx.google.com with ESMTPSA id x5sm56492iga.6.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 11:51:27 -0700 (PDT)
From:   Rob Herring <robherring2@gmail.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 11/21] mips: add explicit includes of prom.h
Date:   Thu, 26 Sep 2013 13:50:46 -0500
Message-Id: <1380221456-11192-12-git-send-email-robherring2@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1380221456-11192-1-git-send-email-robherring2@gmail.com>
References: <1380221456-11192-1-git-send-email-robherring2@gmail.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

From: Rob Herring <rob.herring@calxeda.com>

In preparation of removing prom.h include by of.h, add explicit includes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/prom.c           | 1 +
 arch/mips/mti-sead3/sead3-setup.c | 2 ++
 arch/mips/ralink/of.c             | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 49c4603..19686c5 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -14,6 +14,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/time.h>
+#include <asm/prom.h>
 
 #include <lantiq.h>
 
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index b5059dc..928ba84 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -10,6 +10,8 @@
 #include <linux/of_fdt.h>
 #include <linux/bootmem.h>
 
+#include <asm/prom.h>
+
 #include <asm/mips-boards/generic.h>
 
 const char *get_system_type(void)
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index ce38d11..58c4fd52 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -21,6 +21,7 @@
 #include <asm/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
+#include <asm/prom.h>
 
 #include "common.h"
 
-- 
1.8.1.2

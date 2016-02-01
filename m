Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:13:17 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34353 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011939AbcBAALBc7OEA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:11:01 +0100
Received: by mail-lf0-f52.google.com with SMTP id j78so16236042lfb.1
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmcPDXdjCVAqjzcrJHFksHqN28vA2Ms7RTWbWfsstro=;
        b=GfLP+wD9tmrSB5yKusYwSVTY5EFrqtsK04n/Rca6PGC8s2UejrowbKhYc3ccOTis5o
         P9sAWdr2bHEHvlg0+dO1fHBu5cCZCXdIrgxD08YlHACiirBxnRjtv5PC1DjOZoSpnxhn
         PQTCvdACLjZ0feT9MCV1bTjsA8nflJqAb6OUBWAppwgyqtDlDd+GGb2eslCwgHCgVnRM
         gaW4g2Iwh4zz8ktvbrueitmLNFhkTPNoB43aETncR5pdY25lZmAUdtNiJbb/YqHb36hO
         ItmNz0sSB3zqAe0+qOlrlcXqZxEcZigtXpv9Y9yurTQ1u0Y10l6AII/ntuU/qj0ysJCf
         qCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmcPDXdjCVAqjzcrJHFksHqN28vA2Ms7RTWbWfsstro=;
        b=PVHllKjw3y8gcc1nqC8PCAOIhaEj+0IHPoXgB8u4wcWwxx4W2oHALjeNJ5ZXIiB3Mz
         nNlABUA2KoizLzq5xGqeK0Bzn4tg084SjjvcDJY+//kv1siG1oSIN5a/CeHE9J8ttsIo
         HYbdSbcldH7EctCC7XDOLkakxK0cjfbfpS8U5VapBAnYePrXGMqHGSOTM6CJqqEL1lHc
         0yQzHcpJsS0zqGYEBVH3ryE1lFA+rxj4OxrCj/btL3f8A2jQ2L37x6wiGArEEBgYZU1I
         IUx08NTvSgwAIe5Sv/3z1ly0Bx+h14QXE849H+BBgxRpsQpocTR74q/82E2q1WSQMT72
         Cj9w==
X-Gm-Message-State: AG10YOSf1sOf04c+xRRfPFgeAeoW82jb0/Jyvu9P7yZ+/zF/WO4uwWeFTCc2WdmsYLf/Dw==
X-Received: by 10.25.137.136 with SMTP id l130mr6212150lfd.158.1454285456286;
        Sun, 31 Jan 2016 16:10:56 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:55 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>
Subject: [RFC v4 08/15] MIPS: dts: qca: simplify Makefile
Date:   Mon,  1 Feb 2016 03:10:33 +0300
Message-Id: <1454285440-18916-9-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51569
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

Do as arch/mips/boot/dts/ralink/Makefile does.
Without this patch adding a dtb-file leads
to adding __two__ lines to the Makefile.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
---
 arch/mips/boot/dts/qca/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 2d61455d..244329e 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,8 +1,7 @@
 # All DTBs
-dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
+dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
 
-# Select a DTB to build in the kernel
-obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
+obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
-- 
2.7.0

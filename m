Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:55:29 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50803 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013570AbaKLUynI0xVX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:43 +0100
Received: by mail-pa0-f44.google.com with SMTP id bj1so13834946pad.3
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ERPDJEOIcUC0tTsnGjAzIUgQ+Seq4ZI+XiAbQJI0BY4=;
        b=M+d2snlOHQw0+03G0J+fUcvBEsgXh96ZfQ9WRZw3u3LAdDwSd4m+1V9xKvVkn2XY/6
         6uoCP1hZIejcg/EfDxizjGIYv+IBx/QqCW9tRwmuaMci6/8jmd7VUVAt6NzqoLisKWeV
         d37e0VUk6ruFXmEuJFfTh2xmPBmRi68a5PzL+JR/VzjU58yq5zsI8svztyNm6AVeypYw
         h9qhMHx/HU9BOMclGMs1Jv9Iy5V1oJ2ArNHxbZlX+SoR3qESbjGojwhholUvSewIBbzO
         wrmKv6/YRdAdIENgCk2nUz0CrMW1KUBGfBpIG+hRRm61TjpiW3zR6vpmQOY8sI/BaCBh
         6A+Q==
X-Received: by 10.70.47.195 with SMTP id f3mr19920645pdn.156.1415825677502;
        Wed, 12 Nov 2014 12:54:37 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:36 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 03/10] of: Fix of_device_is_compatible() comment
Date:   Wed, 12 Nov 2014 12:54:00 -0800
Message-Id: <1415825647-6024-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44078
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

This function passes back a value from __of_device_is_compatible(), which
returns a score in the range 0..11, not a bool.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3823edf..707395c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -485,7 +485,7 @@ EXPORT_SYMBOL(of_device_is_compatible);
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
  *
- * Returns true if the root node has the given value in its
+ * Returns a positive integer if the root node has the given value in its
  * compatible property.
  */
 int of_machine_is_compatible(const char *compat)
-- 
2.1.1

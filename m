Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2018 13:32:31 +0200 (CEST)
Received: from mail-lj1-x243.google.com ([IPv6:2a00:1450:4864:20::243]:41793
        "EHLO mail-lj1-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992871AbeILLcVljM52 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2018 13:32:21 +0200
Received: by mail-lj1-x243.google.com with SMTP id y17-v6so1304418ljy.8
        for <linux-mips@linux-mips.org>; Wed, 12 Sep 2018 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pR42x8AIhEMBTbExVmiy65uEYfsTpfnjsPzSIQbJS0M=;
        b=aUBvBHoaolIh1TD5koccfrqnsFV8wVEAjGPi8FDwIyBMMzXR78S2s26Ct2FFiBIbX7
         ahfECwIhJD7QjS6XNjbm+ycssVYpq0XG6Zn0gzG3tuotjvwRAtlFKJT2bgxijWE6O7rH
         +Mfo61HFCzYRSKpExaes4OBpabZukJBeUnRCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pR42x8AIhEMBTbExVmiy65uEYfsTpfnjsPzSIQbJS0M=;
        b=C9vKgL3XomSaEnXX5HQiGGTdvs5O860o5Pl3flDN/KUb2ztATzN5PnSROcrFPVZLSe
         dcPPoWqdy3YBdzHF5hMHfi9Gs11nEXwi+xYgcAoQ1XN00H7wRnJ4JbKtZ6T3YfISQFHI
         XnID65qQ9GXr8Q+NedNPEGZOo4gIFAR7cREzf+BCymvtl4/8iCwVTZPZ6FMOaciuEIaQ
         XBVOWWw0V3F5iOW0nylUKOBPE7eFmLiDToaHPgJQ5fBL3atphtg7gwc8LTL1WkKhwWOw
         lDh6EVfCV1Q3v7qlo2kqO8Ys0QIws53isZySid/2XzdJt/Q9hWt97iMgoz5uggJG8VgQ
         NIqQ==
X-Gm-Message-State: APzg51DbuHKMhWHsrKpbE3M2mLnYxNT9BVfd2XOCOOE4ZeT45FH1e/Ir
        PA0NOUCM9kAfBTD+pP/lMVw7Bg==
X-Google-Smtp-Source: ANB0Vda+FhZ+aXc4sLKiRHD+1nKAKP6C0u7ftfHq7GsxecLbXARfUrgq8vOWe6I01pIkJtOYyARpkA==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr1074072ljc.71.1536751936172;
        Wed, 12 Sep 2018 04:32:16 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id q19-v6sm144182lje.29.2018.09.12.04.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:32:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 2/3] gpio: vr41xx: Cut down on boilerplate
Date:   Wed, 12 Sep 2018 13:32:03 +0200
Message-Id: <20180912113204.1064-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180912113204.1064-1-linus.walleij@linaro.org>
References: <20180912113204.1064-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

This switches this file to use the SPDX license tag.

Cc: Yoichi Yuasa <yuasa@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-vr41xx.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index 7ffb58b0d239..7d40104b8586 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Driver for NEC VR4100 series General-purpose I/O Unit.
  *
  *  Copyright (C) 2002 MontaVista Software Inc.
  *	Author: Yoichi Yuasa <source@mvista.com>
  *  Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/errno.h>
 #include <linux/fs.h>
-- 
2.17.1

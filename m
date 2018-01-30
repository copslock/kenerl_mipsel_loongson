Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2018 20:25:30 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:43143
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994752AbeA3TZGcU1BO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2018 20:25:06 +0100
Received: by mail-lf0-x244.google.com with SMTP id o89so17020641lfg.10;
        Tue, 30 Jan 2018 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DrxXdiWWbNjvXacFDQ80uUw3x4XjUJ6shA9HeDmAfRg=;
        b=JLAUvznQB33BI+M27QLzHVzOzTkuGHquN2zg9U1bsa1XVuIPHVbN5lDGRo/dmacSve
         movy1gFWOe/qLr083/Xwv6X7g+bdvUIQJTqUh1EPd476hpo7NNiA4N8RjGIqDsPiFb/d
         wXOTlqNn3161DLEDYfPlval99qWjud/AyF9g7TCvA04XK0kFZxu4Dz2oRGKX1+f/KJta
         Sre09UJTNBarnqQEOPIROLCf1LkWpoyjhpEmsJjbKYpWeEm7dxy8v3KGCKQ0YrG/Xno2
         aEZYLE9yBitSRBpxj3PHz945Y6IFjb5AnEiDz4y86y7HeBHPDcsQP0k/YxQrSfvgwPWc
         cm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DrxXdiWWbNjvXacFDQ80uUw3x4XjUJ6shA9HeDmAfRg=;
        b=LEIYk91CUR5ke3sEjFg8EOm6JLkp9opMGAJHq2AsPfqMR3oCDmRDNc1CQNnVKfOkOt
         GlkLcLlZMsrG9HxkE2rpkuHTJdPCNGi0+nLcpEaGfmW7+YRzDCBcpxCE22zisxDDrUvm
         QoNVEYjtwOE+upArd5EYLsh5sdRm6etmcq/4h9pVaH6Uupffj/SfY16OF+Wm6J41evxc
         RW8DiMECSW/MoO35IWWD9oaBQ5k2Lyat/dp3XWyRkwOhcTgWhDySseoDe0tzvnl9fOio
         HjxZ8OEGcpT1FVQxoq2MlGYY+NdOXHp0UYMgdzGMWFaqRnemIFGst75gFFNLzP9EM31W
         y4Kw==
X-Gm-Message-State: AKwxytdBF7bFmR+ef8UmbB3qY3g/YB5og8kplfas64eR2fwOpzhqBGcC
        SDHppd66JZUn7pS8X4ByTCI=
X-Google-Smtp-Source: AH8x227Ic25610EmmxLCrh23sR/ZzQWbIcwBxEJssgBeavqx3cgr3xpswzidLXUIfLHMI6DZw1E4wQ==
X-Received: by 10.25.23.27 with SMTP id n27mr10604680lfi.89.1517340301208;
        Tue, 30 Jan 2018 11:25:01 -0800 (PST)
Received: from huvuddator.lan (ua-213-113-106-221.cust.bredbandsbolaget.se. [213.113.106.221])
        by smtp.gmail.com with ESMTPSA id l16sm3534818lfk.65.2018.01.30.11.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 11:25:00 -0800 (PST)
From:   Ulf Magnusson <ulfalizer@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 08/10] MIPS: kconfig: Remove empty help text
Date:   Tue, 30 Jan 2018 20:23:03 +0100
Message-Id: <20180130192349.8420-9-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130192349.8420-1-ulfalizer@gmail.com>
References: <20180130192349.8420-1-ulfalizer@gmail.com>
Return-Path: <ulfalizer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulfalizer@gmail.com
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

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ab98569994f0..57cd591e7b28 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2326,7 +2326,6 @@ config MIPS_VPE_LOADER_TOM
 config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
 	depends on MIPS_VPE_LOADER
-	help
 
 config MIPS_VPE_APSP_API_CMP
 	bool
-- 
2.14.1

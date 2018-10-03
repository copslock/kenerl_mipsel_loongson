Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2018 19:23:58 +0200 (CEST)
Received: from mail-lf1-x141.google.com ([IPv6:2a00:1450:4864:20::141]:44081
        "EHLO mail-lf1-x141.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994583AbeJCRXzWqWnv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Oct 2018 19:23:55 +0200
Received: by mail-lf1-x141.google.com with SMTP id m18-v6so4726143lfl.11
        for <linux-mips@linux-mips.org>; Wed, 03 Oct 2018 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=utv6fEpwR6QLfcyWWwvXTi4UbTJ6FH6NK3F/Ekoe3DA=;
        b=a1vIf0fUhFtjdwwIYhCB69iB7lpdS3+PBAxjs/aot/VZHk+FTbxEmxJSXS6LIsdf4A
         K71mHBU0uEwUJjUHq8nBJiVZVFHFJMtw4cjTWoCTeAVx3zzhxfcdZ8wXUUr3AT0xltsy
         kaT8Or1TtUeWpit2kdY8m3qv+0+TlmnKonS6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=utv6fEpwR6QLfcyWWwvXTi4UbTJ6FH6NK3F/Ekoe3DA=;
        b=mRA7l8oXQLsni0nzoEMrjkMIET/LY3om/ME0qHIsvnBgrtqSjP+PZumxCDZq0K8CgT
         TI/9Q1qg7ZE2amkJfqNhZxPyUB3uLsV6Qfjn4QumVZo+DjNtKAsiagSdH45KaU7MskAI
         /PC73wL/DbvvhCckW+nZ1rob80DYNh6SG9JvUYMeNVHPUeDsZgJ4bffb5UkmA9EP0RkF
         VMl/3eoTgVenMaPDr12Z5K2Sv3W6GfbHBpnLvW6MJxssB1q6FXDH1LbAPocE+M4nuSm2
         oP3zLUpaKQ3cAz5FjukhREXqwv/nnbDDy2bUrPzG0tfY+1zFCx4v/WnGk6DWrvyqRGiB
         KrLQ==
X-Gm-Message-State: ABuFfogezW6TubGVjEp1tCPS8oVydEYISCVOs2UOHZrKYCOaSTckQvsm
        w4fWFzHFdmtQSMxLoRKF0nQR1A==
X-Google-Smtp-Source: ACcGV60k6rD8Md05wKIDwUDR9PdQcJw0KRMU5diuz8UDS9mAIQzWapjgYqVUg+AkYKwe3a/A2fS8ew==
X-Received: by 2002:a19:a3d1:: with SMTP id m200-v6mr1537650lfe.38.1538587429578;
        Wed, 03 Oct 2018 10:23:49 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id d126-v6sm471174lfe.75.2018.10.03.10.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 10:23:48 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: delete duplication of BUILTIN_DTB selection
Date:   Wed,  3 Oct 2018 20:23:35 +0300
Message-Id: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

CONFIG_BUILTIN_DTB selection is duplicated in menu
"Machine selection" under MIPS_MALTA.

Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3551199..71d6549 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -539,7 +539,6 @@ config MIPS_MALTA
 	select USE_OF
 	select LIBFDT
 	select ZONE_DMA32 if 64BIT
-	select BUILTIN_DTB
 	select LIBFDT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
-- 
2.7.4

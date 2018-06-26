Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2018 17:30:52 +0200 (CEST)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:38499
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993032AbeFZPappPAzf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2018 17:30:45 +0200
Received: by mail-lf0-x243.google.com with SMTP id a4-v6so7062703lff.5
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2018 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aN6HZZHl2Cz1VEDT1VHZFwOAVPnA7t5zp2KaLIWq7Kw=;
        b=esJPzil5vZpMKd4EIumFXRihPOwpKN+dh3Q4SIUk8O21irdJwNGnuo/eBaVRAB8nxB
         YADGXTZllCv2TJIZ4o3HKs2o3LrhqrhUKzrzR8TlA2L6V3mMTghDpbrKFHyHG6+ILCve
         FPQ2lhjVwuzD/ZQ12BUV8IXaX8UUH/mxsUodk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aN6HZZHl2Cz1VEDT1VHZFwOAVPnA7t5zp2KaLIWq7Kw=;
        b=a/rLkd6Hugf6JAYYfAwYfmFkXWXEIzPSgz//Y2vpYHfnEC2w39zyeCK84/K9cugDaQ
         0HF+f60pBziBLa1GsoDYVpf3QuRCxgkkoa/PfkhQOoPSaPzjNgIAFuablNpt/Xh2uLgA
         yANaRZzYgTYW35PiCngc3Thl2c11yMbuJIsFMHqfuMYgr9oVijumc5PsnQrhka+etkn0
         1iliiHuG2g3BOCkLX8fulphYAyzonSMrsEKlabjygGBz6FbeKtdXKDGfb4lQHMOmHlyF
         eyvVIVSHzKevyjVDUnpd405TQd/5TGJVD0kSQ8nzONUPgxqeI19gSEELtTYiljLn8mmb
         apxw==
X-Gm-Message-State: APt69E1We+Se171gfanh3O3DKLaIp997C+Uk9gWWiZGtHXQQTN10N/Qp
        leqBd9RL1qPW0EC4wA2f51CLqQ==
X-Google-Smtp-Source: AAOMgpeoTt49GCJ/sUtKplVr+STJ3cEyi8Y74eGvyuvQTtjbXV6DB84NxgJJcpAZEaR3MIbC7DsOvA==
X-Received: by 2002:a19:6d11:: with SMTP id i17-v6mr1574017lfc.103.1530027040140;
        Tue, 26 Jun 2018 08:30:40 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id g17-v6sm306096ljg.27.2018.06.26.08.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 08:30:39 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] mips: configs: remove no longer needed config option
Date:   Tue, 26 Jun 2018 17:30:35 +0200
Message-Id: <20180626153035.361-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Return-Path: <anders.roxell@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anders.roxell@linaro.org
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

Since commit eedf265aa003 ("devpts: Make each mount of devpts an
independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
in the defconfig anymore.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/mips/configs/ip27_defconfig    | 1 -
 arch/mips/configs/nlm_xlp_defconfig | 1 -
 arch/mips/configs/nlm_xlr_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 91a9c13e2c82..fbcbfc365c64 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -262,7 +262,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_ALI1535=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index e8e1dd8e0e99..aec323ed6968 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -403,7 +403,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index c4477a4d40c1..88c185da23ce 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -336,7 +336,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
-- 
2.18.0

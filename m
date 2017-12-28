Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 22:31:18 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:43109
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdL1Va0NLjvH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 22:30:26 +0100
Received: by mail-wm0-x243.google.com with SMTP id n138so45753238wmg.2;
        Thu, 28 Dec 2017 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PBPmc4DROt+sHKDLnAgUM+xs9Pmc3QG4TlcOrffjcIg=;
        b=E1MQg+zXYxIFYak1JtAQx3d7a3dXhwLZX1QjnEsezWv2ZVmpNsU6gFkoyssn/5G7Eb
         i2h5/xJG/1PSMEulQOoe4mvxuftMmcR3KUjDoZA7pAK0nGNsfVvFbRgUbMXxzFmeMFB4
         LqhewU8bGndJLO6O/q9BaE3liImgs1PqVoE5US7qSxvZVGGi6mtgdZuV9tiIvP+rYm8G
         LtybT5QNLc0R5e2OW3Z02XBUCD2PEK1xYpG1b6dc/tjQVOuWrRt/UNtd0zYt9LvsmKC9
         aF8S6EWgsxL4Sr6GieDvs/aP/EUEAtDJr1cenVvyAb9CATDavj6Lwq7gFhCKn4LPmnJ4
         ybNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=PBPmc4DROt+sHKDLnAgUM+xs9Pmc3QG4TlcOrffjcIg=;
        b=r3tqwgIciGQl232EcqL7qVddU129aSCa8uYEiippAoSjuW+Bh5z2iRkkuGMdkVDXEX
         rqRv3TQyTfsYyT3AAmyhQorgcVcnabdLDFfGaroL5aJPgHVf+Kv288ozURQmD4LJIE3C
         YgCUkGBJgr3ZRhm8VAaCinu8oCw59lCFjxZuQDS/snLssQhIs/xUTH1UegfeO277wUqm
         zC8707AYz/vbF3bWXck/8effeXNZ/fjPjCyEdXev1h2RSG4vkuOUoQImfjJ3PB9Sg/t5
         5wCCEqv5s8XGe7vJceJqPweqTlps7doDg9bYUXxOYAkUMmC+ox1V/PuDUQxE7sGFZxrm
         +AVg==
X-Gm-Message-State: AKGB3mKFhfw64OVuFfkxdYNxw3S1GNPgKJ0ItFkvBWkx9OIXSjkEb/2w
        9mQCY9FTOtJpxRntsRLzqvo=
X-Google-Smtp-Source: ACJfBot23jEBXEAVbKRgPt0V0NU7jXE0LKPLJUKDnJlZ0knlAeXsTHUS004uUMhFMkpfvp1f/44kwg==
X-Received: by 10.28.71.136 with SMTP id m8mr28289263wmi.89.1514496620707;
        Thu, 28 Dec 2017 13:30:20 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id 62sm21606161wmo.33.2017.12.28.13.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:30:20 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 2009A10C32F6; Thu, 28 Dec 2017 22:30:19 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com, Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 2/2] dts: Probe efuse for CI20
Date:   Thu, 28 Dec 2017 22:29:53 +0100
Message-Id: <20171228212954.2922-3-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171228212954.2922-1-malat@debian.org>
References: <20171228212954.2922-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

MIPS Creator CI20 comes with JZ4780 SoC. Provides access to the efuse block
using jz4780 efuse driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index b5f4ad8f2c45..62c63617e97a 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -171,3 +171,5 @@ CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
+CONFIG_NVMEM=y
+CONFIG_JZ4780_EFUSE=y
-- 
2.11.0

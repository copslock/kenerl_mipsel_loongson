Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 21:21:21 +0100 (CET)
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33195 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014872AbcAWUSDST7zd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 21:18:03 +0100
Received: by mail-lf0-f54.google.com with SMTP id m198so65138894lfm.0
        for <linux-mips@linux-mips.org>; Sat, 23 Jan 2016 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RNr3jfPP3IP+ICxr9afqVHIp8eV2Njk0sxHGJyzeawM=;
        b=hxIIw7wRibYjr6WSVWGmiypNCqxPgKpHRB0S4r4jECsC5lJl4O/EJ1UHDqKprQi9cx
         8syherusUmlVBIoCShhCbnqSyWeD+u622eAVZrtb6sE2oxJ/sic41KkJWIO+W8KiTcpA
         nhOOR2DzI2wIAzma3LUEN4Mf7knNrdH3HU96V7UH9eZJqsa67jzA1SSHsCj7A4QSx2ie
         9J4TKsb6BMsi/Hz0vTfp4ZVU6XwNkGDnFA3qgPzWIuJiEzC2Jigzeky9ltBnZRqCNhCW
         yixdpnpcCzzKNscEzrWLfhWWfxty2RuFysfj08RH/+X6RDRlTSCgGVUt8gBkOT1Xv9EI
         E2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RNr3jfPP3IP+ICxr9afqVHIp8eV2Njk0sxHGJyzeawM=;
        b=abOymGEJ7cw9uqw7vSY0xKCBkEw4eACleJDbYMUq+6KCQ/F5HUK3sq63aDWaLZMnIP
         +YMbXaaq0U/00vzH0ITNAqBoUtT+NN7xugXXlAHTalF2XJZUmms7jwZ8asXtAlbCcMXZ
         O9iCos1Vp64hBV1FUAbNQKFfsLTvVlxw8KMXD4MUMU0ieC+kdA5h4L2t+X0Bnmdb8D63
         /KaXNmslWoqcZ+wFG1FvlZr/A7teNwvWZwDvZxX1Sd1M9AqgS6aFn5ggAjLAyGXYqXy1
         aw8xMcEBmB0keYX7IgE+AgaRv0z5HNKwryobFpKcHsWvZDeeagpgiFD5z03wTRicOtI9
         pPrg==
X-Gm-Message-State: AG10YOSGMVUzypjFIBw3cV+HTILm1emVeZt7UcetFNvgyD0DKZMDLPeZZ3scQrBpsVSpDg==
X-Received: by 10.25.166.143 with SMTP id p137mr3831159lfe.116.1453580274712;
        Sat, 23 Jan 2016 12:17:54 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o82sm1664186lfo.47.2016.01.23.12.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:17:54 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>, devicetree@vger.kernel.org
Subject: [RFC v3 12/14] devicetree: add Onion Corporation vendor id
Date:   Sat, 23 Jan 2016 23:17:29 +0300
Message-Id: <1453580251-2341-13-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51338
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

Please see https://onion.io/contact for details.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 64f35c9..a81e423 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -162,6 +162,7 @@ nuvoton	Nuvoton Technology Corporation
 nvidia	NVIDIA
 nxp	NXP Semiconductors
 okaya	Okaya Electric America, Inc.
+onion	Onion Corporation
 onnn	ON Semiconductor Corp.
 opencores	OpenCores.org
 option	Option NV
-- 
2.6.2

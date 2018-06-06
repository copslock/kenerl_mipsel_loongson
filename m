Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2018 21:38:41 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:36670
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994725AbeFFTiYg6045 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2018 21:38:24 +0200
Received: by mail-wr0-x242.google.com with SMTP id f16-v6so7519316wrm.3;
        Wed, 06 Jun 2018 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W8zl4Wx3N0wx2PwRCFxcbADdVeCY6GFY62lJyH1HFmQ=;
        b=o/SQzCsGc2LsZsWTxf14hTh+1BRvQ5zE7yDbxXnYHLbev6rdbH+pulLLQXjqudx6gJ
         Ht68HEs8oPLvdg7clQclk0FdQEWXYamrpz9+157rgrq6dREt9FVvCw40yolj3y+69/CU
         sJUdPMLThzX7Xp8Bav5S/IA8snTO51GOLOXd5vqHHqKDhD73MHAyG9+RoDNoXNRB1Cyn
         oC4w0mx4HhP+x3sCGBMXn3zwPcoOaZpIO/R2ma94xBe6Q6lGumT4oFolwLrk08G6c2s4
         lccS1AhU86KSwyt1/HgkZDe+8VKqfpJKJRI3EsvXYACHG0K5FuI4va147zmorbxC6iY4
         fwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=W8zl4Wx3N0wx2PwRCFxcbADdVeCY6GFY62lJyH1HFmQ=;
        b=t5FdPDQ6FnNT4CG6A4DgidepAux7T7AlNSJUdg+hVs/tGjeV2C+1Mbg4W9RjXM9fs8
         UJwLA3jXl55gHVHSxG/S1rfBqFooDO/+y3IQJdHSrr7eh9kzDszKBwMMNd8TcUQNR+V5
         Z701rOG6v1kSneR9CdM5ajgyTCktFPbw/UlLsqLQGhoxkX8Sipw8AgtSBGKWP+mWVybl
         Yc6wqM58523T9hxvYutOC1IxYS/yUvwEzsXr8LRwEYoRsXG7geUp7++3kFDoapmQihrD
         jBulEXS1HIWjwH27VLidYgug0nB0aMNPslL2dxAAonuofaWTwbXSOKDGJfkFm++qq/2p
         Trag==
X-Gm-Message-State: APt69E2hZnCRH9280Z6o3w/yG5DBV1aT0nGqZvNh39QW+g8mSISqlcf0
        e5QWpcQNEZcqiHkqqzoboOM=
X-Google-Smtp-Source: ADUXVKKAEVz4/yN2Qa/o7Hs76/9Ter7c4hegB0if2tXjfQENkBThCE7XB/+3Qg5f2f903a7rSOOe+A==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr3567029wrd.61.1528313899213;
        Wed, 06 Jun 2018 12:38:19 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id f24-v6sm3609046wmc.0.2018.06.06.12.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:38:18 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id A039910C2B80; Wed,  6 Jun 2018 21:38:17 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 2/3] MIPS: Ci20: Enable SND_JZ4740_SOC driver
Date:   Wed,  6 Jun 2018 21:38:09 +0200
Message-Id: <20180606193811.16007-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
References: <20180606193811.16007-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64201
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

Update the Ci20's defconfig to enable the JZ4780's SND driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index e1c14f6af824..0c08c7675b42 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -104,6 +104,10 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_JZ4740_SOC=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-- 
2.11.0

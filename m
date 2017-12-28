Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 22:30:26 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:37794
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990486AbdL1VaTWAMjH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 22:30:19 +0100
Received: by mail-wr0-x243.google.com with SMTP id f8so29458617wre.4;
        Thu, 28 Dec 2017 13:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PCeqksEvtJzi8IRN3Tr9ndQQSSlncjM5YKxT7M90uuE=;
        b=BWcW9smKYkEthMMzYmlmiHhcQPfk9eNwZhRjHoz392kBvmPYucreY2x2V7QGn9OBSn
         0wHmLD8+brQaiOJCPB9bCpegXb4R4p3Rrr9d7Lz+IsDE4qG7VUd3RaS2rKAKc0PubJqz
         pDhD825X1pS78T+uRNsv5nUplQSExs7uF17qvdBCl1XUu8QFJnekMY576DxmLwttqpyR
         V3DEV4j+0VTGi0Xwj90jYjF/xcMvdkRbDEYvfFzoPahsWtCpb6Pvas52ldn0hUIAd9ei
         Fm2oBbuATAm0rjHKsHu7jCxpRWt5mGPz2loeKeETkmorUAed4kxB4UmbmalIRkKTIjqa
         9e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PCeqksEvtJzi8IRN3Tr9ndQQSSlncjM5YKxT7M90uuE=;
        b=VaiN0vviq2XAciN5PqVLo9xWD/WVQonFmdKXWkzfBstd3KOv4mPaorqSKiuWKROs7N
         a4BSOcauLAn82fXZ7xYfGyT/ULujwuiN4o1v3UgrUS8pHslRHQefpUYdEWL5bhq3nnNi
         38e4pIMCDy2oMchkc7+SXvpnjbfgSIyEdtlXYNHBl4sPx5jUMsoOXVlQ1OAmhcQ+AaTJ
         mGdvYfIF0spkpZzqF4V+UwfBJIXLtld5RB4JCesfl+zn9K5qtO53kpwdepYLmBOsdmgx
         THuP98xvxkj3VWlHtHFOcffatgy83CQ5Fu7kwhdJcKPoACfkjjJpUtQYEpPqTcXIQ8wT
         FjSg==
X-Gm-Message-State: AKGB3mLOGVgHBuoZ2AduK6fWoTepdGo8nuCWHCocnalJEwCCOfA8Y8ie
        QrqzWEFlj+BQCA0pdCO0RnQ=
X-Google-Smtp-Source: ACJfBot1fMAm5/1eMom8S0hIgdB0nTS9st1QY3DdcbogpROVtXSDXWULMkT5sGechyXJW58tiCA6Hg==
X-Received: by 10.223.133.162 with SMTP id 31mr28507612wrt.251.1514496613689;
        Thu, 28 Dec 2017 13:30:13 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id m68sm41002635wmi.28.2017.12.28.13.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:30:13 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CC3A510C32F6; Thu, 28 Dec 2017 22:30:11 +0100 (CET)
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
Subject: [PATCH v2 0/2] Add efuse driver for Ingenic JZ4780 SoC
Date:   Thu, 28 Dec 2017 22:29:51 +0100
Message-Id: <20171228212954.2922-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61692
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

This patchset bring support for read-only access to the JZ4780 efuse as found
on MIPS Creator CI20.

To keep the driver as simple as possible, it was not possible to re-use most of
the nvmem core functionalities. This driver is not compatible with the original
efuse driver as found in the custom linux kernel from upstream (1), in
particular it does not expose to the users neither:
`/sys/devices/platform/*/chip_id` nor `/sys/devices/platform/*/user_id`.

The goal of this driver is to provide access to the MAC address to the dm9000
driver.

(1) https://github.com/ZubairLK/CI20_linux/commit/6efd4ffca7dcfaff0794ab60cd6922ce96c60419

Changes in v2:
Properly handle offset and byte value from the main entry point.
Also add a commit message in patch #2.

Mathieu Malaterre (1):
  dts: Probe efuse for CI20

PrasannaKumar Muralidharan (1):
  nvmem: add driver for JZ4780 efuse

 .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++
 .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++
 MAINTAINERS                                        |   5 +
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-
 arch/mips/configs/ci20_defconfig                   |   2 +
 drivers/nvmem/Kconfig                              |  10 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/jz4780-efuse.c                       | 305 +++++++++++++++++++++
 8 files changed, 385 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
 create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
 create mode 100644 drivers/nvmem/jz4780-efuse.c

-- 
2.11.0

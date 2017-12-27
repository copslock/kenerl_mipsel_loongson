Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 13:28:17 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:34473
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbdL0M2KGKd96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 13:28:10 +0100
Received: by mail-wr0-x243.google.com with SMTP id 36so3343050wrh.1;
        Wed, 27 Dec 2017 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=OYJRbcwi9Ms/RWJ2IHQPFz6hu6j7B7HOYghCmEfXOyE=;
        b=I5wlrrRm8ODG99rWeBaaujnQC4Qkw7tUVGJLIyuOmRGTEbvyirx9yoki5xgc5XH2dF
         p8GdnwLwUHVtZIYoye66HmoZYfg1yYWVbymczWAgXc5z/mCSI1t7WW2R+Et+X0Nh/soa
         5Gd7bVOlv3OOxPNSeugFXerrh1jiuTnFqhFYA4vzmkzRfosjVDRwPPZXKsZCMmKNgCp1
         dJw5k8EIz7UuZdNvkiZfPq3FSwfLkxGK8t1g44/VaSSax/1l+kc30tmzDZtTMwMKkHq4
         AGFPiLDnDUF7/YGk+k9jPovEcy92QTaLJ0zy09bPBnTS4NuG6jejDeRsL8S8ulb9V+gx
         M5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=OYJRbcwi9Ms/RWJ2IHQPFz6hu6j7B7HOYghCmEfXOyE=;
        b=QooXkmSThnP4YgEztrlomX+vFJWDul/CpE8bZ7/O9GRB/7Vr2BgrReYBq9aevunK1a
         e/Ns3WrTOvX9bdPrq6Tdhx6TTiAk71jjHyiH3ZysNoEU1FEJBSc1VmPtdt02ZKHe2oaN
         r8w+X0wT6ImMLhVMXA9Y1fJzxZXrbpkRnzXn5zs/eAxOQdjUvxRxUYvqMtlaPzHBtFNZ
         5TaDJ+4eLXsgtoHB2EbRdt5j+4vBxdqt1To4rCWI9LlVnCW9whMl+KOqeWL9z3G6iBuT
         B/ZX4uEUTE2M08cJN9ERfnz/oi3xoq9YAT0L1VgQqHd8/WnCYI86oRu/XfD43kk9VKtt
         H9TQ==
X-Gm-Message-State: AKGB3mK3/2Q8V/DiK8D/VcXJG04cZ1d1GVN5Dgqd4qAnU/u8aLbEMDt4
        lydF6+SpZMtyUwkqnp9Z6f8=
X-Google-Smtp-Source: ACJfBotmpX91N3vGYUs3dF/xguKEcW/KMXIBB0QfA3FY93l/ADKD1gOLHiIUy9ygQ+p3QnsWcHPCCQ==
X-Received: by 10.223.192.69 with SMTP id c5mr14398106wrf.214.1514377684069;
        Wed, 27 Dec 2017 04:28:04 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id n65sm53608711wrb.17.2017.12.27.04.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 04:28:03 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 28EB810C322F; Wed, 27 Dec 2017 13:28:02 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Zubair.Kakakhel@imgtec.com
Cc:     Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 0/2] Add efuse driver for Ingenic JZ4780 SoC
Date:   Wed, 27 Dec 2017 13:27:00 +0100
Message-Id: <20171227122722.5219-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61628
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
 drivers/nvmem/jz4780-efuse.c                       | 274 +++++++++++++++++++++
 8 files changed, 354 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
 create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
 create mode 100644 drivers/nvmem/jz4780-efuse.c

-- 
2.11.0

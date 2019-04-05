Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A8C4360F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A19217D7
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRCGDeky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfDEACI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:02:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34395 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDEACH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 4 Apr 2019 20:02:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so2050570pgq.1;
        Thu, 04 Apr 2019 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UY883wQ+oAVcrWSICQEzSEPgdh2KiWe639rhn+wuPc=;
        b=tRCGDekyn57vHnTFWZVF/FgY7c9d78lZCZtFVt80ytSdpJLJGZbIWyQOHYmy3dkbwe
         FVICB/CIDtAkN465+vBntORq70F7a3YsbILJB1t/cBN8C4w4Pkmd9vVYWejDPD/2cau5
         lMoVtw53wem0dfaEXzSBHZERGtRuRjLPCzoHY+X01q+8XR3w6mOEejl/lchq/ey7DA6a
         NU7wUmUMFLJkzWK85KjOGsJEhcxdHtMbCdsDrtQJMdImdizIFYaX7AHdSs+QYC38f4bL
         x7saIme5YQLsMSn3AN0VWTasoJYqOBEd0Q1fO7biu1c7fMx7zNLt5Jmz47fsjpRyOqQd
         esww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0UY883wQ+oAVcrWSICQEzSEPgdh2KiWe639rhn+wuPc=;
        b=QNYEC4fhJTSMNku+4H7KbspOqOxAEfpCUPXfDCXZvX7x+CjpU78DqENG3QPO19zRF3
         fWvox9fGKVxcmysW/KK5BZyXi2FK5Pubc9F0I3qEBugzJN5vscy9Ecoxg+AvFRuoapNY
         1BvZAwGlnqKf+t2fIitIQPaQxnYraUYBVkAEVymg+tbBPdwb7e3AJbvlyt1lR3bImBy/
         4owLhMKxUG/0mjrUGxvKKWnbxrV5o1+sV7U93EUufg52tqKZieGdgCKPdSk4H4D7nr4W
         QtzjZ8DbsR8d5mDzBLXVRNw9syiYGiHcYjDdfusyTdOfd55BMiBwzO6u+hSUbf70obLW
         mK7g==
X-Gm-Message-State: APjAAAV5ZJxlVIXhVy38PMPsBNYkHeh3ajY+GQpGCBO7VNpjI5KQWTk7
        qECpbgrlYrEKCqO9PRIXDwE=
X-Google-Smtp-Source: APXvYqx1VKjPsdbtJO5c7m5Ik1eQ4K8hKCfKLoIFxVY5E+8S80Ka4hXeuHEr2cId44p4Zob/PZvjGQ==
X-Received: by 2002:a63:1203:: with SMTP id h3mr8912349pgl.164.1554422526798;
        Thu, 04 Apr 2019 17:02:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id p26sm43755664pfa.49.2019.04.04.17.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:02:06 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC v2 0/5] MIPS: ralink: peripheral clock gating driver
Date:   Fri,  5 Apr 2019 09:01:24 +0900
Message-Id: <20190405000129.19331-1-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Changelog:

v2:
  - moves ralink gating clock driver to drivers/clk/
  - describes the resources of gating clocks in devicetree
      and removes resource tables in source code
  - changes gating clock provider to platform_driver
  - changes PLL clock provider to platform_driver
  - replaces clk_* API calls to clk_hw_* APIs
  - uses BIT() macro
  - uses IS_ENABLED(CONFIG_COMMON_CLK) macro

------
This series introduce Mediatek/Ralink SoC's clock gating driver and
rework PLL clks as clock provider.

The gating clocks are different at individual SoCs.
Their resources are described with devicetree.

NOGUCHI Hiroshi (5):
  clk: ralink: add rt2880-clock driver
  dt-bindings: clk: add document for ralink clock driver
  mips: ralink: mt7620/76x8 use common clk framework
  mips: ralink: mt76x8: add nodes for PLL clocks and gating clocks
  mips: ralink: mt7620: add nodes for PLL	clocks and gating clocks

 .../bindings/clock/ralink,rt2880-clock.txt    |  58 +++++
 arch/mips/boot/dts/ralink/mt7620a.dtsi        |  46 +++-
 arch/mips/boot/dts/ralink/mt7628a.dtsi        |  52 +++++
 arch/mips/ralink/Kconfig                      |   2 +
 arch/mips/ralink/clk.c                        |  33 +++
 arch/mips/ralink/common.h                     |   4 +
 arch/mips/ralink/mt7620.c                     |  82 +++++---
 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-rt2880.c                      | 199 ++++++++++++++++++
 include/dt-bindings/clock/mt7620-clk.h        |  17 ++
 11 files changed, 472 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
 create mode 100644 drivers/clk/clk-rt2880.c
 create mode 100644 include/dt-bindings/clock/mt7620-clk.h

-- 
2.20.1


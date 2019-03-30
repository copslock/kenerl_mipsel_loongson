Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C703DC43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0592184D
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf4Wiq1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfC3Md5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:33:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35292 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbfC3Md4 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 30 Mar 2019 08:33:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id p19so2285018plo.2;
        Sat, 30 Mar 2019 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0mt+2TR/aQBYxFhl01YPRilqwpZdmJ6PLwvKjb1RvJI=;
        b=Rf4Wiq1MCmAW2ppC60/2MruXzVHa9AUy+KWPJsWxFM/QO0yMnyAPts217uAk5RkwW8
         O8KNLS6YQPimAjb4fuBPYh/6HbCfLKy+Ax0T2dsBETxPSrkdWQ+zFGTYhKNWK+/0U2Jj
         Q71zh4V5ljHO4xQgem4dx7+Er9zl41QTksvG8jLzht+3Cl85W3BvwXww4Z3DwI/elWtx
         ZHc0Zk+F4BrmCWPjwrs69gOTsYW6rZLwejIkzIJBdImuMMosPtfF5pqwJ6q1nIt1KXGm
         i2TxQ0ZzAWKwP63QwAF8rZWwaBfjsjUmKwnCaoEcdomp0NvVshpxxbn1ceLXGxruJBiA
         wWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0mt+2TR/aQBYxFhl01YPRilqwpZdmJ6PLwvKjb1RvJI=;
        b=gCxIjFCC4+48C66XaxnsYHhuofZjalXX0yVEuk0C5EYQIR+dSuoXkiKkIHTmomQyCI
         pe1kVEk2DfKSBxHw0rudwqjT7iMNslXztwaTurD+i/6ANoJswXX11kPwoi7XBaWAYWAh
         aciILtG3MXsEsuNvUuqpo9rxznXVLz7HjNVzlBswxmK0rjVKb1t+rpideBqK5VtjrEND
         ZQZQh+X4mPhth5t2ynlRiE1Ocw6/Qq4HzLy6as87gs4dokMDDwuBjgJJ+jG+nMMHnxWR
         FrFwC6FoNoHNYY+v6Kvwad/l8QbZ1BN2XQEOEHdcg8pSqlbpoPv7kPiaF/wpcoz0RAEX
         uj8g==
X-Gm-Message-State: APjAAAVZjiiP/2K0VjWrBPNcELetz7DCydtnnE8gGm1UD6DG/Moi4RE6
        EBO5ugkvF8vznuq8yJLHivc=
X-Google-Smtp-Source: APXvYqwsIadSLRHrSSeMgjyJE7PCbRVQOfy/m+H73UGPamh3/dCrtXNkiPxHOD3dtAnHAWppsq0OZg==
X-Received: by 2002:a17:902:7081:: with SMTP id z1mr13220341plk.252.1553949236069;
        Sat, 30 Mar 2019 05:33:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id m23sm7864309pfa.117.2019.03.30.05.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 05:33:55 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC 0/5] MIPS: ralink: peripheral clock gating driver
Date:   Sat, 30 Mar 2019 21:33:12 +0900
Message-Id: <20190330123317.16821-1-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This series introduce Mediatek/Ralink SoC's clock gating driver.
The gating clock items are different at individual SoCs.
Driver loads gating clock item table defined in individual SoC source files,
via OF device id data.

NOGUCHI Hiroshi (5):
  mips: ralink: add rt2880-clock driver
  mips: ralink: add dt-binding document for rt2880-clock driver
  mips: ralink: mt7620/76x8 use clk framework and rt2880-clock driver
  mips: ralink: mt7628: add nodes for clock provider
  mips: ralink: mt7620: add nodes for clock provider

 .../bindings/clock/ralink,rt2880-clock.txt    |  20 +++
 arch/mips/boot/dts/ralink/mt7620a.dtsi        |  34 ++++-
 arch/mips/boot/dts/ralink/mt7628a.dtsi        |  37 +++++
 arch/mips/ralink/Kconfig                      |   6 +
 arch/mips/ralink/Makefile                     |   2 +
 arch/mips/ralink/clk.c                        |  30 ++++
 arch/mips/ralink/common.h                     |   3 +
 arch/mips/ralink/mt7620.c                     | 132 ++++++++++++++---
 arch/mips/ralink/rt2880-clk_internal.h        |  21 +++
 arch/mips/ralink/rt2880-clock.c               | 134 ++++++++++++++++++
 include/dt-bindings/clock/mt7620-clk.h        |  17 +++
 11 files changed, 411 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ralink,rt2880-clock.txt
 create mode 100644 arch/mips/ralink/rt2880-clk_internal.h
 create mode 100644 arch/mips/ralink/rt2880-clock.c
 create mode 100644 include/dt-bindings/clock/mt7620-clk.h

-- 
2.20.1


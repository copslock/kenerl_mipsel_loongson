Return-Path: <SRS0=SfqM=YX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422A9CA9EC5
	for <linux-mips@archiver.kernel.org>; Wed, 30 Oct 2019 13:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C572087E
	for <linux-mips@archiver.kernel.org>; Wed, 30 Oct 2019 13:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="wdKZRr15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfJ3NyI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:54:08 -0400
Received: from forward106o.mail.yandex.net ([37.140.190.187]:60094 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbfJ3NyI (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Wed, 30 Oct 2019 09:54:08 -0400
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 732BA5061E4B;
        Wed, 30 Oct 2019 16:54:05 +0300 (MSK)
Received: from iva8-e1a842234f87.qloud-c.yandex.net (iva8-e1a842234f87.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:e1a8:4223])
        by mxback18j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id CFdertCcbH-s48WxDui;
        Wed, 30 Oct 2019 16:54:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1572443645;
        bh=t8CWijRjkAweyoXbreWHhbH0+9CHrOHDm7ZbXb78yac=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=wdKZRr15NMKbrsvCr6ZdlBvZey66zQhfJoMBfQM0F55hm/O9IWOVOQV/+2dt+o0kO
         787YlV8naTJ5DD3CkxpMPS19rJ6tPARDbRGttxxgqbZJyBQhZ6l2vYXJMy5XY5KmEM
         iUz/EzYtbSekXmNbv50iYbIRFxFmtuny/J66pZOo=
Authentication-Results: mxback18j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by iva8-e1a842234f87.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id iQ85YfuBaZ-ruUupR4a;
        Wed, 30 Oct 2019 16:54:02 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        axboe@kernel.dk, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, bhelgaas@google.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pci@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/5] PCI Devices for Loongson PCH
Date:   Wed, 30 Oct 2019 21:53:42 +0800
Message-Id: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

This series is adding quirks & configs for Loongson PCH Devices.


Jiaxun Yang (5):
  PCI: pci_ids: Add Loongson IDs
  net: stmmac: Split devicetree parse
  net: stmmac: pci: Add Loongson GMAC
  dt-bindings: net: document loongson.pci-gmac
  libata/ahci: Apply non-standard BAR fix for Loongson

 .../net/wireless/loongson,pci-gmac.yaml       | 71 +++++++++++++++++++
 drivers/ata/ahci.c                            |  7 ++
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 52 +++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 63 +++++++++++-----
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 +
 include/linux/pci_ids.h                       |  4 ++
 6 files changed, 181 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/loongson,pci-gmac.yaml

-- 
2.23.0


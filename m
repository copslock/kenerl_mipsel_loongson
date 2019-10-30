Return-Path: <SRS0=SfqM=YX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5319CA9EC7
	for <linux-mips@archiver.kernel.org>; Wed, 30 Oct 2019 13:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEDB20874
	for <linux-mips@archiver.kernel.org>; Wed, 30 Oct 2019 13:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="wJKmPGOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfJ3NyS (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:54:18 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:34995 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbfJ3NyS (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Wed, 30 Oct 2019 09:54:18 -0400
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 610D59411F7;
        Wed, 30 Oct 2019 16:54:14 +0300 (MSK)
Received: from iva8-e1a842234f87.qloud-c.yandex.net (iva8-e1a842234f87.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:e1a8:4223])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bs174B8v8y-sDv0nwPT;
        Wed, 30 Oct 2019 16:54:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1572443654;
        bh=LZfCzRmnU5GvSwNDTZRMxa1XSUXSuYUhaw6ApIP4riQ=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=wJKmPGOanSsEV3K2e5hMdIEowzXiw1PWxSyTsNtDsr4nD8frEBBMnSq10gVgRZ6gy
         b7rxmrO+px7aZFw0iuONaHAvy/SJJviVqjFrlPz5gGnBQotilCPv/kVng8S4LpbZZR
         za2bNj+TMDDRlyYOYtr6GAqcjI0t6rlebs+abm+Y=
Authentication-Results: mxback17j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by iva8-e1a842234f87.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id iQ85YfuBaZ-s6UuMBEg;
        Wed, 30 Oct 2019 16:54:12 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        axboe@kernel.dk, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, bhelgaas@google.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-pci@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/5] PCI: pci_ids: Add Loongson IDs
Date:   Wed, 30 Oct 2019 21:53:43 +0800
Message-Id: <20191030135347.3636-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
References: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add Loongson device IDs that will be used by drivers later.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/linux/pci_ids.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 21a572469a4e..75f3336116eb 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -148,6 +148,10 @@
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
 
+#define PCI_VENDOR_ID_LOONGSON		0x0014
+#define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_AHCI	0x7a08
+
 #define PCI_VENDOR_ID_TTTECH		0x0357
 #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
 
-- 
2.23.0


Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B4C4151A
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940B21783
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690296;
	bh=XHvGrq9LUVK3VhEp6c72qxwXepi97IZhYICnHguuWkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGRYGP3Ddz4SWhdtbyxBguU994NGWr8c2nN92LnAtviKbeld+sGQ4sPwhFHs58KKy
	 uaRbKnyepSvVapfMmhmNaeMdr8l+GYUBrUlbT10RbrcRltbcZm4XrMSBrrs0eJVooU
	 7tkqqorqNLFKhFuuMB+FibOnqwz9ZaJJF9Kyv2RM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfA1Po4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfA1Poz (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB1521741;
        Mon, 28 Jan 2019 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690294;
        bh=XHvGrq9LUVK3VhEp6c72qxwXepi97IZhYICnHguuWkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5kBFrBS7oHHq+A8SbczQoZzywrZE1psXqqkFzY0Nx54GLI5DE3yhqGS6XPV1ySB7
         zCF+FNi6LjpSkhWJBigcj/X9BZfMF1M/O7WlxqCpdIgP7AZiUGpyFtLe8desAhdRGA
         aDHrZRhgrp3NeP1iUNjmcSjfYLHO+P2uKU2aVtqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 037/304] MIPS: Boston: Disable EG20T prefetch
Date:   Mon, 28 Jan 2019 10:39:14 -0500
Message-Id: <20190128154341.47195-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 5ec17af7ead09701e23d2065e16db6ce4e137289 ]

The Intel EG20T Platform Controller Hub used on the MIPS Boston
development board supports prefetching memory to optimize DMA transfers.
Unfortunately for unknown reasons this doesn't work well with some MIPS
CPUs such as the P6600, particularly when using an I/O Coherence Unit
(IOCU) to provide cache-coherent DMA. In these systems it is common for
DMA data to be lost, resulting in broken access to EG20T devices such as
the MMC or SATA controllers.

Support for a DT property to configure the prefetching was added a while
back by commit 549ce8f134bd ("misc: pch_phub: Read prefetch value from
device tree if passed") but we never added the DT snippet to make use of
it. Add that now in order to disable the prefetching & fix DMA on the
affected systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21068/
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/img/boston.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
index 65af3f6ba81c..84328afa3a55 100644
--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -141,6 +141,12 @@
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
 
+				eg20t_phub@2,0,0 {
+					compatible = "pci8086,8801";
+					reg = <0x00020000 0 0 0 0>;
+					intel,eg20t-prefetch = <0>;
+				};
+
 				eg20t_mac@2,0,1 {
 					compatible = "pci8086,8802";
 					reg = <0x00020100 0 0 0 0>;
-- 
2.19.1


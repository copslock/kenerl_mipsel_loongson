Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DB4C282C8
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB921741
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695236;
	bh=2PEJvm6vMC6GcGABpMFMjpxKDGWay7fgf8Y8iLBBlQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e1yMEHoIATvYWZzBfOK/2fp9RjZ1EETCSFsgNBNdFBu15uvv1SmsOKpdeUhBJV8tb
	 tBCYCB0guy6gZHdCuGQGfZVnfj9J7YL7JfIBmOPVoZ56YVzsRxdQPmwBTeRKerLfUm
	 /jVg3uuSEKINqQGA7/C+JzpCwfCAJ8HJjmB6Zgik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfA1RHL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732593AbfA1QMz (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684DE2147A;
        Mon, 28 Jan 2019 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691974;
        bh=2PEJvm6vMC6GcGABpMFMjpxKDGWay7fgf8Y8iLBBlQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQlzZKJeAaT4o48QLiiCu0QTOGEF2ZsI+Kq7O9oYrHmqfjxFRPIn/94g2pCL2Ss23
         iJev2GlZCUURim6+3oFdteFEnLA0TyEgWQlwnGFEHSVlaRfCFiViUT4bmi6bKm15bK
         UIvuR+lxbnIgMs2hhbAvaTDLp+7AGIvRq22L/rp8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 023/170] MIPS: Boston: Disable EG20T prefetch
Date:   Mon, 28 Jan 2019 11:09:33 -0500
Message-Id: <20190128161200.55107-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index f7aad80c69ab..bebb0fa21369 100644
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


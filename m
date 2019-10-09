Return-Path: <SRS0=7KIV=YC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C2DECE58C
	for <linux-mips@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC41021929
	for <linux-mips@archiver.kernel.org>; Wed,  9 Oct 2019 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641887;
	bh=E1p83cVGBh/VObNOpqqftqKRBwPpNj8M5LZKNYhZfR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pzqT9b7whO9PMjXECtgLXoIigx6ldZZjvSXiP50FVTF2T+KHR2QakZ8ebZlRG50zi
	 hlJWm+bjQqGwn2s1CwTp97mFKxUjftIgOwc0jMfReBa0FLB0HhI6VAsKC1M+5W/BJP
	 oCscDBEz2gQ+pnw6CtIqSkM8lxbXmrrkcUnWtvOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbfJIRYq (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbfJIRYo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:44 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A150218AC;
        Wed,  9 Oct 2019 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641884;
        bh=E1p83cVGBh/VObNOpqqftqKRBwPpNj8M5LZKNYhZfR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G866P2qEJnSZsuER1Ha1BWAeYm2ZfeggwmAlF9rdaVDe7XTnpK1Aab4WKaSduPhqy
         5wJ8hgavjzUzFAITvLaN+HwSoXSRjb5muwt9tGugbIUY1pImO3MuVxWdobKBeWuAhP
         R+SozMK951zOt8AdUIW0nAcbuY30gfcq/kZAEXX0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/13] MIPS: dts: ar9331: fix interrupt-controller size
Date:   Wed,  9 Oct 2019 13:06:25 -0400
Message-Id: <20191009170635.536-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170635.536-1-sashal@kernel.org>
References: <20191009170635.536-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 0889d07f3e4b171c453b2aaf2b257f9074cdf624 ]

It is two registers each of 4 byte.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/qca/ar9331.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/qca/ar9331.dtsi b/arch/mips/boot/dts/qca/ar9331.dtsi
index cf47ed4d85694..1fda24fc18606 100644
--- a/arch/mips/boot/dts/qca/ar9331.dtsi
+++ b/arch/mips/boot/dts/qca/ar9331.dtsi
@@ -98,7 +98,7 @@
 
 			miscintc: interrupt-controller@18060010 {
 				compatible = "qca,ar7240-misc-intc";
-				reg = <0x18060010 0x4>;
+				reg = <0x18060010 0x8>;
 
 				interrupt-parent = <&cpuintc>;
 				interrupts = <6>;
-- 
2.20.1


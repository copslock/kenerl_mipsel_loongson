Return-Path: <SRS0=J4Li=YU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE26CA9EBC
	for <linux-mips@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CE3205F4
	for <linux-mips@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212229;
	bh=E1p83cVGBh/VObNOpqqftqKRBwPpNj8M5LZKNYhZfR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h9wGkhsis+dqNm1I3JIpSDFWjIlUeR80jd6nq3dQ9z/epw92X1TsuJaUEYZUPNyRb
	 FC0DzPaDDH54Zw9iw16GL60dvJkVG1H1AIg6fFANyLgWwdFnedUMcOKEg1kAh1Guae
	 A5pObKccEjAyWSUEceS1MVoJCuo4RfrEX7t4tQ04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfJ0VFx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbfJ0VFw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 27 Oct 2019 17:05:52 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410A22064A;
        Sun, 27 Oct 2019 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210351;
        bh=E1p83cVGBh/VObNOpqqftqKRBwPpNj8M5LZKNYhZfR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvJKi1elFRAEMngVuB8ImAKXjcyUcKpq2mbxyM3fwrTDMyOKLl3yrv2nrkXsiKWjB
         5Q4ijinWjtBNvlhgUKfXaE0EKiVn1yGDhXPfPdIRq1ezesfJ2wnzlURbI6IeWDyM4U
         e1UKyxPwSu41B1LtapgovOl7jv61AWjeQsr8z/3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/49] MIPS: dts: ar9331: fix interrupt-controller size
Date:   Sun, 27 Oct 2019 22:00:44 +0100
Message-Id: <20191027203123.338204502@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
References: <20191027203119.468466356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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




Return-Path: <SRS0=gy6h=X2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40073ECE587
	for <linux-mips@archiver.kernel.org>; Tue,  1 Oct 2019 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B412168B
	for <linux-mips@archiver.kernel.org>; Tue,  1 Oct 2019 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="ujWAewN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfJATJx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:09:53 -0400
Received: from srv1.deutnet.info ([116.203.153.70]:55206 "EHLO
        srv1.deutnet.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJATJx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 1 Oct 2019 15:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
         bh=/BP8hOWE8SJ76SRf1RmiWyLqtKvXhcXYW4oao3LZWlU=; b=ujWAewN8qvEhfRACKz/cHB94/
        E9/AEznd+AcWQtBdLzH1qfQtwblimz2V8UIchzsBt/jfGjTWMfNlnf77/nXzSvhF2j5+1PmQptQKd
        2RS3Xt10R4ubq714D4mkofKoYd5nfTD9RSuQYS7ACBgg1JRpg4OTkjepOfVurTxG8evOC7oGXHrwM
        EMB/CPv3O+r+myMLLcZvUL0+7VuWKAolYu6GPK8YCE1r0SkpM4Z5W7n6gU9Jy9FpDZqe4N6se0sCg
        pfB+ySTNIYOb/ohv8Y+y0AqtV6tdL77iMiy6zGlN/Vflh2cvP8qxSWbjjf+yS/7J9F5rYJUKIoXaS
        IXIH8RRgQ==;
Received: from [2001:bc8:3dc9::1] (helo=localhost)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1iFNWv-0000qa-0E; Tue, 01 Oct 2019 21:09:49 +0200
Received: from agriveaux by localhost with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1iFNWu-00BgOM-Kk; Tue, 01 Oct 2019 21:09:48 +0200
Date:   Tue, 1 Oct 2019 21:09:48 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, agriveaux@deutnet.info
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 5/5] MIPS: JZ4780: DTS: Add CPU nodes
Message-ID: <0dbd1986be4ee50bdd9f45c140aded7c49fddb8a.1569955865.git.agriveaux@deutnet.info>
References: <cover.1569955865.git.agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569955865.git.agriveaux@deutnet.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The JZ4780 have 2 core, adding to DT.

Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index f928329b034b..9c7346724f1f 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -7,6 +7,23 @@
 	#size-cells = <1>;
 	compatible = "ingenic,jz4780";
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "ingenic,jz4780";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "ingenic,jz4780";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
 	cpuintc: interrupt-controller {
 		#address-cells = <0>;
 		#interrupt-cells = <1>;
-- 
2.20.1


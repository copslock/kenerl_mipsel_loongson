Return-Path: <SRS0=S7cO=VG=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC8C73C53
	for <linux-mips@archiver.kernel.org>; Tue,  9 Jul 2019 18:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901CB2087F
	for <linux-mips@archiver.kernel.org>; Tue,  9 Jul 2019 18:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW0wqqvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfGISWv (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:22:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33879 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfGISWv (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 9 Jul 2019 14:22:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so10526510plt.1;
        Tue, 09 Jul 2019 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14941MCmJea/f9nxksHUctUhT5FKLU9Frn5jof0WtuE=;
        b=gW0wqqvyJ4Z2qq0g7t5KKKxsz5V/WKxx7dpvKM6qK/ERdWssQW4tFHYDQ+stV3w7P8
         9SYfO4PVdHXhPcWe8w+0ApFXRcmBuPs4s4qOv4HwtRYjC4sDt/3xbkW2xeROdxSDqVpp
         vZ4f9clunnn6X3lPL31hO3X8sBb9LJqInHb+xLBrM76SvI0jK5zmtU9s/T3D0JFqQN4a
         M5kRmuAai0rSsvSsFWqp2GveygZr6k9aydXQNKa+dwlyYBccPjmq2bPftzwbR7isMmKO
         7+eJtBiuOkhu7iPk3AShADa2bkFAFALllHAUF1Mug77rOFBCjQF0BaK2SGRYBCM2N+Uo
         3byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14941MCmJea/f9nxksHUctUhT5FKLU9Frn5jof0WtuE=;
        b=jRIBKxl85Ea7Lj1ZK0lUr4jirKMMAdCpbSgcRT9vb6h1bJpVtV2GNmKJ8Qql2beu/J
         h4klbhb/CkghRvr2DvR3EStPIyRxSfE61E3ZIBQTIAjX8pWN27kFML1u5/7uSnRPEzgw
         4c6CTMBg+IB8eGY8+lXXyly6wUed/9X8gK/5KfjDXYsEWCRo+SI0eWlLFrKjoNfxTPyi
         ppJkz2uxvCehj/mMU6RtPqypJ9zbH2FxEtruqF/fg5R2DrpwWOyLmMI6KpyQCm4yHQuk
         fapLjKLdFb9SntQlZ+0fC6Kw6f67wnM4Pz/ea/ojg73ZTTNoIiqIyssZ/hj0YQJ6xBcc
         RqdQ==
X-Gm-Message-State: APjAAAWb6Ukq/Dd24hMxGRx4I2xQ6q+i22/BJN4wAaZsJrYbrsYnlGNd
        7g5w08tsR6PlHp1SZBFVQzkUKmSC3V1zGA==
X-Google-Smtp-Source: APXvYqzKj+Fqdp7qcv2pHkOixbAbKJ1ai7LV4ypDO5bRjcwYN89jpWEd4xaWf7wm4WdR3kzF7gzuWQ==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12mr33838928plq.146.1562696570189;
        Tue, 09 Jul 2019 11:22:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id m69sm21008639pga.11.2019.07.09.11.22.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:22:49 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weijie Gao <hackpascal@gmail.com>, NeilBrown <neil@brown.name>,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 5/5] staging: mt7621-dts: fix register range of memc node in mt7621.dtsi
Date:   Wed, 10 Jul 2019 02:20:18 +0800
Message-Id: <20190709182018.23193-6-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709182018.23193-1-gch981213@gmail.com>
References: <20190709182018.23193-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The memc node from mt7621.dtsi has incorrect register resource.
Fix it according to the programming guide.

Signed-off-by: Weijie Gao <hackpascal@gmail.com>
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 12717f570ceb..ac9189276590 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -138,7 +138,7 @@
 
 		memc: memc@5000 {
 			compatible = "mtk,mt7621-memc";
-			reg = <0x300 0x100>;
+			reg = <0x5000 0x1000>;
 		};
 
 		cpc: cpc@1fbf0000 {
-- 
2.21.0


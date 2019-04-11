Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DF5C10F13
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A1D2083E
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="VFodtS5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfDKMU0 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:20:26 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:46554 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKMU0 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 08:20:26 -0400
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id B0EE63C017DC;
        Thu, 11 Apr 2019 15:20:23 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback7j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id dNcVzy2puC-KNcKt8i4;
        Thu, 11 Apr 2019 15:20:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554985223;
        bh=IzbwqLW/q4VeMivUvZ5KCD8lQ3TSqiuKZvKLu+u83+M=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=VFodtS5nTor5DcyantpJ0ITcVr1fOPD/f9gTxh0+h4Zb+L8Q+gdV+8TJVKel4ibcg
         RNQ7kzT1+s6UHjc/AFqhpZYtqEOOKC35VrI72jkc4Nl6DMIqgLaMCtjpfu8pDQc1ID
         tsAyJl7ZQAIPOGw4XYw4blmc6mOHWte1Y++IemdI=
Authentication-Results: mxback7j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QbB7ClwXzg-KHCmX6L3;
        Thu, 11 Apr 2019 15:20:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     devicetree@vger.kernel.org, paul.burton@mips.com,
        robh+dt@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 4/6] dt-bindings: Add vendor prefix for loongson
Date:   Thu, 11 Apr 2019 20:19:13 +0800
Message-Id: <20190411121915.8040-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411121915.8040-1-jiaxun.yang@flygoat.com>
References: <20190312091520.8863-2-jiaxun.yang@flygoat.com>
 <20190411121915.8040-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add vendor prefix for loongson, known as
Loongson Technology Corporation Limited, a CPUs & IP Cores vendor.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..6464192f47ae 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -221,6 +221,7 @@ linux	Linux-specific binding
 linx	Linx Technologies
 lltc	Linear Technology Corporation
 logicpd	Logic PD, Inc.
+loongson Loongson Technology Corporation Limited
 lsi	LSI Corp. (LSI Logic)
 lwn	Liebherr-Werk Nenzing GmbH
 macnica	Macnica Americas
-- 
2.21.0


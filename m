Return-Path: <SRS0=KGvN=RH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEECC4360F
	for <linux-mips@archiver.kernel.org>; Mon,  4 Mar 2019 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E68020835
	for <linux-mips@archiver.kernel.org>; Mon,  4 Mar 2019 22:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="DntyqbfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCDW3e (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:29:34 -0500
Received: from tomli.me ([153.92.126.73]:44168 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbfCDW3d (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Mar 2019 17:29:33 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id f5d363d7;
        Mon, 4 Mar 2019 22:29:32 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 22:29:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=foHmT6tpUB7T3HL59GtGQQQmGWB4MM4AVOND1ASTjGg=; b=DntyqbfMIxkHR5vA6mrPwLX8iKbi9cFtbFaEmo5k1S/oOdtJaATYuYKLn4zZG6pnciM8GLd13YmNfBp0r8cfLBGNb1iqXmhMvDfHHuOk7HZf/ffjlvoMGeCEXEh6M3hSe4COUPaGKX5yQVL9kxiLVrzJc8eCI0CIHwh93PAH+z4CLejb8urgn1a68RiJrHLNn3Eb8VeCzOQLB7Dayd8E1AB4+K0lYKcE020JW62kEge2jsKeQt+FkZPghLYKB6oEaOwRx/pIBv5iOs1JWBv/k02HnsHvUf/DYdQWbgOfntu1ilRJ79ujOtditmxcAhq9YO2zdTunvPOZ3+q0tbqRaA==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] MAINTAINERS: add myself as a maintainer of MIPS/Loongson2 platform code.
Date:   Tue,  5 Mar 2019 06:28:48 +0800
Message-Id: <20190304222848.25037-8-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304222848.25037-1-tomli@tomli.me>
References: <20190304222848.25037-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

I've introduced platform code for Lemote Yeeloong computers and modified
power management-related files. Add myself as a maintainer of these code.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 208f19801a23..a82cd47927c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10134,6 +10134,15 @@ F:	arch/mips/include/asm/mach-loongson64/
 F:	drivers/*/*loongson2*
 F:	drivers/*/*/*loongson2*
 
+MIPS/LOONGSON2 LEMOTE PLATFORM AND POWER MANAGEMENT DRIVER
+M:	Tom Li <tomli@tomli.me>
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	arch/mips/loongson64/common/platform.c
+F:	arch/mips/loongson64/lemote-2f/pm.c
+F:	arch/mips/loongson64/lemote-2f/sci.c
+F:	arch/mips/loongson64/lemote-2f/platform.c
+
 MIPS/LOONGSON3 ARCHITECTURE
 M:	Huacai Chen <chenhc@lemote.com>
 L:	linux-mips@vger.kernel.org
-- 
2.20.1


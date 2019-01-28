Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D73C282CB
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 09:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBC52087F
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 09:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="TsgE7ZmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfA1JW3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:22:29 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25487 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfA1JW3 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 28 Jan 2019 04:22:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548667248; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Pf5nWkKt0kjBMNGjWJ7OLJ7eNV4tQk1GV+OnL3Ubk0FBuj1nsUf1p402G2rkGDIPoqJg8S0SF+EeQdn+AbO/FTk5bNLp4D7i8m9dzjnk6jGc2xS57KwZumAIxgCS6Q1F3Hq7DpCXm3G1UHDpNGh/2/MvniUexs1at3HpBILWODU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548667248; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=cRoiBGwVqZHOkDh+r4rAUWAOQFeNdZ6XyR+ld8jEDs8=; 
        b=LqanWrf8Mqls6F25+IVt/54yL2JhYxJZlqNjzE4h9cJQKL8/RLP4f5W4WOAUkVXJJpf0k8F1LnnaFQ+0b5jYEqRZPzRJDr8sYMTXGDiV8I2bxqzz+dFXSMSV9kuX7Q6KJ6LCoUv2PUTPQ5jbVmCmCVrKRVOgo9i3+dSEUQIzX5Y=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=tZDvlK/GUrqcNAK4vOI9oL1phKsJd10lCQQJ1Cm3hDe3LxgknQKnzWIhR0kzlap+qFAT2lwfveLG
    U8xVxJctnefELPXxKjMxtB/Rp2DoicuOvXXuPVqWYm0tl6gWlNKp  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548667248;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1650; bh=cRoiBGwVqZHOkDh+r4rAUWAOQFeNdZ6XyR+ld8jEDs8=;
        b=TsgE7ZmO1J7zr46SEgf62f9vttzjmx61l1gZX0B7X8+oecSrsJpnh++vj7XWI2xm
        xRiMF0RxbyXzRWN7IsiOU541yeMy48Kb64kVbg1ACqMDSZk87w3bCR0O2BJg5uV6OCo
        hm7sEX+Il3K/hYuuDUXnNL1pL32XuJP5O+yRoBqA=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548667245692615.8883492599009; Mon, 28 Jan 2019 01:20:45 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
Date:   Mon, 28 Jan 2019 17:19:35 +0800
Message-Id: <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add support for probing the 8250_ingenic driver on the
X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/tty/serial/8250/8250_ingenic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 15a8c8d..1999e3b 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -145,6 +145,10 @@ EARLYCON_DECLARE(jz4780_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart",
 		    ingenic_early_console_setup);
 
+EARLYCON_DECLARE(x1000_uart, ingenic_early_console_setup);
+OF_EARLYCON_DECLARE(x1000_uart, "ingenic,x1000-uart",
+		    ingenic_early_console_setup);
+
 static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 {
 	int ier;
@@ -328,12 +332,18 @@ static const struct ingenic_uart_config jz4780_uart_config = {
 	.fifosize = 64,
 };
 
+static const struct ingenic_uart_config x1000_uart_config = {
+	.tx_loadsz = 32,
+	.fifosize = 64,
+};
+
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
+	{ .compatible = "ingenic,x1000-uart", .data = &x1000_uart_config },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match);
-- 
2.7.4



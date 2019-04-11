Return-Path: <SRS0=fNfu=SN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB7FC10F14
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC162083E
	for <linux-mips@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="amGneY6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfDKMUd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:20:33 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:37165 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfDKMUd (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Thu, 11 Apr 2019 08:20:33 -0400
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id C74CD4200C6A;
        Thu, 11 Apr 2019 15:20:30 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id vhskqf5ZQ6-KU4uOQW6;
        Thu, 11 Apr 2019 15:20:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1554985230;
        bh=CjsRND6fVCwNjty2QFm2hXF7hynBJdtzagz/50SMmRA=;
        h=In-Reply-To:Subject:To:From:Message-Id:Cc:References:Date;
        b=amGneY6xFlec2x9dGeothaBFijgYNFDHFpbuwXjRKA9gLXER1KmS0CftIgZ2xx2EG
         SUmiVWP8xugxEhCn5itKMK7AnJ+h74LWFe8i6Z2P3mAhmJdEhDutfh37qJQGOdUbU8
         VHySRfm4MEbvm6TOrYXhmbim68I/WJeA8YSv38sg=
Authentication-Results: mxback7g.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QbB7ClwXzg-KOCmQ3vo;
        Thu, 11 Apr 2019 15:20:28 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     devicetree@vger.kernel.org, paul.burton@mips.com,
        robh+dt@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 5/6] dt/bindings: Add bindings for ls1x CPU
Date:   Thu, 11 Apr 2019 20:19:14 +0800
Message-Id: <20190411121915.8040-6-jiaxun.yang@flygoat.com>
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

This documented ls1x CPU node.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Documentation/devicetree/bindings/mips/loongson/ls1x-cpu.txt | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/loongson/ls1x-cpu.txt

diff --git a/Documentation/devicetree/bindings/mips/loongson/ls1x-cpu.txt b/Documentation/devicetree/bindings/mips/loongson/ls1x-cpu.txt
new file mode 100644
index 000000000000..33664bd15487
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/loongson/ls1x-cpu.txt
@@ -0,0 +1,4 @@
+* Loongson-1 MCU CPUs
+
+Required properties:
+- compatible: "loongson,ls1b", "loongson,ls1c"
-- 
2.21.0


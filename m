Return-Path: <SRS0=J4Li=YU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF12CA9EAF
	for <linux-mips@archiver.kernel.org>; Sun, 27 Oct 2019 21:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6C2205F4
	for <linux-mips@archiver.kernel.org>; Sun, 27 Oct 2019 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212306;
	bh=OxtsmDZcRyjTy/TwgnZe5iInYm/ARc+kAq5vsnT/P2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zdCLe5NTEfQzH7DgV71yYalKiKHU9KDAYlGxtg6v0FRtUl6GzlorDyqaLgtamEwun
	 TDTSFmxvIYvLPPSLVvjDhoCEjyOmrkorOxbnor5HT7Iobrq3Q4+0suLTxzXr6yMkjS
	 P/FO4CJBs++sgon1NSMzuQhSooHWr9WZraqTTcIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfJ0VDj (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbfJ0VDh (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:37 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456C8208C0;
        Sun, 27 Oct 2019 21:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210216;
        bh=OxtsmDZcRyjTy/TwgnZe5iInYm/ARc+kAq5vsnT/P2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oavV55ySsN0Nu79XTI+bFwzz0xS53lt/MN8+XMBDz3Aeu77MDrXMf8YZw9Yx/+IbB
         6704LI5awFy/nycHGjslxGgbFk5tNC2bvmdfW0NNTgAYGUq3G0k+qY1F+M2byEQH3L
         UpmrQwM0cFIyDJCJmWs/twdQMGhKWJ/UWV/Zn6iw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Paul Burton <paul.burton@mips.com>, chenhc@lemote.com,
        ralf@linux-mips.org, jhogan@kernel.org, linux-mips@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 07/41] mips: Loongson: Fix the link time qualifier of serial_exit()
Date:   Sun, 27 Oct 2019 22:00:45 +0100
Message-Id: <20191027203104.062911000@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 25b69a889b638b0b7e51e2c4fe717a66bec0e566 ]

'exit' functions should be marked as __exit, not __init.

Fixes: 85cc028817ef ("mips: make loongsoon serial driver explicitly modular")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: chenhc@lemote.com
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/loongson64/common/serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/serial.c b/arch/mips/loongson64/common/serial.c
index ffefc1cb26121..98c3a7feb10f8 100644
--- a/arch/mips/loongson64/common/serial.c
+++ b/arch/mips/loongson64/common/serial.c
@@ -110,7 +110,7 @@ static int __init serial_init(void)
 }
 module_init(serial_init);
 
-static void __init serial_exit(void)
+static void __exit serial_exit(void)
 {
 	platform_device_unregister(&uart8250_device);
 }
-- 
2.20.1




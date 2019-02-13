Return-Path: <SRS0=gFuS=QU=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A90C282C4
	for <linux-mips@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C6A20835
	for <linux-mips@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026502;
	bh=9fff7Y53ByZc4GPGUy1uC7VXdvhIdzzONFMNSuxFStU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lbCnM5J4YroCk8V0qTiqVDXwLkQphKoZ9tTpa5hRtCX+D11QtuSxhNgpcheX9F+Y
	 kNbppDNctHsfR12HoQZrU8IK2FGLiPM7FKCyAUbsSPmStqfv0ofIt+hK8UoquWRT8/
	 9rVcToF9gj+KEK6QPOZMFmQqwLwuwqIYdp4GNWDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfBMCy4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388332AbfBMChh (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E20F222C2;
        Wed, 13 Feb 2019 02:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025457;
        bh=9fff7Y53ByZc4GPGUy1uC7VXdvhIdzzONFMNSuxFStU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etH2TgwQfiqxErxF0xCaqsMhFaGq+vXjAS8NauI7TW3HdGw9Vm7J9tZJGDQJp908Q
         RSvXcsodrPnTUzUq9q4sI1JeJy4z6AGIUZxp+bfrrMtU6Ea/Wvw7Wf0bPpVKEcuxgp
         gO4BklaV2y/m/V0MMpgwte9rcP9J8GcJfaDE0zUo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 28/83] MIPS: ath79: Enable OF serial ports in the default config
Date:   Tue, 12 Feb 2019 21:36:06 -0500
Message-Id: <20190213023701.20286-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Alban Bedel <albeu@free.fr>

[ Upstream commit 565dc8a4f55e491935bfb04866068d21784ea9a4 ]

CONFIG_SERIAL_OF_PLATFORM is needed to get a working console on the OF
boards, enable it in the default config to get a working setup out of
the box.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/configs/ath79_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 951c4231bdb8..4c47b3fd958b 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -71,6 +71,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=1
 CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_AR933X=y
 CONFIG_SERIAL_AR933X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-- 
2.19.1


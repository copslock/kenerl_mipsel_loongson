Return-Path: <SRS0=6l1E=OM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A69C04EB9
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A2A206B7
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="vk/pcjfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A2A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLCW2I (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:28:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37143 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeLCW2H (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 3 Dec 2018 17:28:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so13857913wru.4
        for <linux-mips@vger.kernel.org>; Mon, 03 Dec 2018 14:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gqq+2vYV/a2b0pVHbZH8lrLAWzcENAcJL894oiyu2vs=;
        b=vk/pcjfNjCIBWgj6TIZi8OY1ZoNJxMRQmkBy3zh55blBsWACLh7zI2Aue8i78Erenk
         ZpBv4TcSLgwG+UemiL36VVrUQt2c+FqY33OaZ7iS+p3rEGGt9Eh2hC4X2y7/yJAeQRPK
         0SOSwAl9IfIdBIEA9uZIIqt2tHhksXlT5FfAJ7cPJ6UdQSpiPcvNyZVsElEI4Ik3/E/o
         wuF8/xjdDS767pPDE+wGEWd7ryCAo+Nclk2srwQecTvK+rvlRKZ0X3CzJZ+FEVpV2xg9
         2PBHlq9YqXdohoUt2AbDETvuZWfkoTondyqp/TGlfJVFKH9ndnX6yTUj8pKEMVlQI7TY
         5vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gqq+2vYV/a2b0pVHbZH8lrLAWzcENAcJL894oiyu2vs=;
        b=HVD12PCp4WjUaHNmFokVIQyOrx9s6AHBip39UUxT1QXXCLtQmzRr1KegBq4naOQ/KM
         qm9hMGtxkXSWGnxF5pavd7/J0waEz1/I0tBA1Z9vquuJpwE2iyerrrxGGpjf9BJuC65y
         mxGQjkq+/0ALnJRarmhk0DUtzJehLxNRWEuJS0FWedrP2Mq12H2a6NboW8g25bcS3WOt
         dImiEMznRry2LC9yB8MbliKNPXQg/LP4sle/afWb7ylo0fUdD5HaWJs3DrWySN/5pttW
         jH1ciF3JHYfjpsvD5OS5Jb5lSWa2guWxnVTPPvu6ef53+nkNnsWctr6GXuJQnZMG8dE5
         iiRQ==
X-Gm-Message-State: AA+aEWZ+SRGXj11rLEFMVmf7xCm4zcAuH6n5YM+VwK3EBAXSb0d+SIG6
        NnrqhcQoOw+lK0/vN5xUs/0b5g==
X-Google-Smtp-Source: AFSGD/Ww5fQTFU7BFYfcgsnB5yenHfMbiEYY+HGrootEy/DsQimwFqXaqEvOSmLXfgOQulf/npXBtw==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr16192459wrn.276.1543876086354;
        Mon, 03 Dec 2018 14:28:06 -0800 (PST)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id s16sm17416818wrt.77.2018.12.03.14.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 14:28:05 -0800 (PST)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     daniel@iogearbox.net, ast@kernel.org
Cc:     netdev@vger.kernel.org, oss-drivers@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH v2 bpf] mips: bpf: fix encoding bug for mm_srlv32_op
Date:   Mon,  3 Dec 2018 17:27:54 -0500
Message-Id: <1543876074-4372-1-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

For micro-mips, srlv inside POOL32A encoding space should use 0x50
sub-opcode, NOT 0x90.

Some early version ISA doc describes the encoding as 0x90 for both srlv and
srav, this looks to me was a typo. I checked Binutils libopcode
implementation which is using 0x50 for srlv and 0x90 for srav.

v1->v2:
  - Keep mm_srlv32_op sorted by value.

Fixes: f31318fdf324 ("MIPS: uasm: Add srlv uasm instruction")
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/mips/include/uapi/asm/inst.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index c05dcf5..273ef58 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -369,8 +369,8 @@ enum mm_32a_minor_op {
 	mm_ext_op = 0x02c,
 	mm_pool32axf_op = 0x03c,
 	mm_srl32_op = 0x040,
+	mm_srlv32_op = 0x050,
 	mm_sra_op = 0x080,
-	mm_srlv32_op = 0x090,
 	mm_rotr_op = 0x0c0,
 	mm_lwxs_op = 0x118,
 	mm_addu32_op = 0x150,
-- 
2.7.4


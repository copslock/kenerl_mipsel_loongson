Return-Path: <SRS0=IVZI=ZA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67317FA372C
	for <linux-mips@archiver.kernel.org>; Fri,  8 Nov 2019 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEA221924
	for <linux-mips@archiver.kernel.org>; Fri,  8 Nov 2019 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214927;
	bh=Ek+tRWptDmvc/XOB2PFxRi0EZJosnbs0W+8St8JxikU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xKcKpGXfMJlLBXgT+Tc9XQ+IG+HoK5q9AMtJnhuftXADwqFDWAv/buTxeKpFMF9Cy
	 Ol7AaQSimSbUzoyLROX+0D3PzAw4WijYBbVp1DxfiI14+mHYk7Thm2mgHUU0xk9cgl
	 3vfUTB3LlALs0/KCaRpX1yQoQnk4+qltYqxzw63Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbfKHMIk (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388643AbfKHLk3 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 8 Nov 2019 06:40:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F1E20869;
        Fri,  8 Nov 2019 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213228;
        bh=Ek+tRWptDmvc/XOB2PFxRi0EZJosnbs0W+8St8JxikU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJl5zphX+oNNSEhLOGGwjo6SoYjoEBBIJrfTHVml4KFrclHIHLPtaa4SFc6A1uKEK
         pxStQ88i4IENrMJKJw27QURtp2Bo/wPg3Rfnbi+/9y3hRgfHo5Q7G9UrOzWgZeGVEk
         9qCZ0/zfW37tQ3ntC0MDmziWENzHJed6ArFrL3gs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        jhogan@kernel.org, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 100/205] mips: txx9: fix iounmap related issue
Date:   Fri,  8 Nov 2019 06:36:07 -0500
Message-Id: <20191108113752.12502-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

[ Upstream commit c6e1241a82e6e74d1ae5cc34581dab2ffd6022d0 ]

if device_register return error, iounmap should be called, also iounmap
need to call before put_device.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20476/
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/txx9/generic/setup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index f6d9182ef82a9..70a1ab66d252c 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -960,12 +960,11 @@ void __init txx9_sramc_init(struct resource *r)
 		goto exit_put;
 	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
 	if (err) {
-		device_unregister(&dev->dev);
 		iounmap(dev->base);
-		kfree(dev);
+		device_unregister(&dev->dev);
 	}
 	return;
 exit_put:
+	iounmap(dev->base);
 	put_device(&dev->dev);
-	return;
 }
-- 
2.20.1


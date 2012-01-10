Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2012 13:12:49 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:52168 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903839Ab2AJMMo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2012 13:12:44 +0100
Received: by iakk12 with SMTP id k12so988318iak.36
        for <multiple recipients>; Tue, 10 Jan 2012 04:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ok7Vv6d+zRqIDWyiguyX5JQ0C7RgNfC/O+dbkFS1IOU=;
        b=jsH+k3Oc+H3FArushv//VnTt67FGOH5fslLlUk6a2hpwyjmZ6oD81TrtWeEof+a91K
         Sl+zHVe+QyASN6ejXprArYV/JH9JWuhSEkIBGTS9HPTYyKyuomc+mXJHNIAgNMpaiUHx
         rx+zq3pycVI1tY52zcWHIbLzqd7AY5TNMXj7k=
Received: by 10.50.47.136 with SMTP id d8mr2218361ign.21.1326197557858;
        Tue, 10 Jan 2012 04:12:37 -0800 (PST)
Received: from sdk (UQ1-221-170-12-50.tky.mesh.ad.jp. [221.170.12.50])
        by mx.google.com with ESMTPS id 36sm262564794ibc.6.2012.01.10.04.12.34
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 04:12:36 -0800 (PST)
Date:   Tue, 10 Jan 2012 21:11:56 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Kay Sievers <kay.sievers@vrfy.org>,
        Ralf Baechle <ralf@linux-mips.org>, yuasa@linux-mips.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: txx9 7segled fix struct device has no member
Message-Id: <20120110211156.31e27cae.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 32211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

arch/mips/txx9/generic/7segled.c: In function 'tx_7segled_init_sysfs':
arch/mips/txx9/generic/7segled.c:105:6: error: 'struct device' has no member named 'dev'
make[3]: *** [arch/mips/txx9/generic/7segled.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/txx9/generic/7segled.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/txx9/generic/7segled.c b/arch/mips/txx9/generic/7segled.c
index 8e93b21..4642f56 100644
--- a/arch/mips/txx9/generic/7segled.c
+++ b/arch/mips/txx9/generic/7segled.c
@@ -102,7 +102,7 @@ static int __init tx_7segled_init_sysfs(void)
 			break;
 		}
 		dev->id = i;
-		dev->dev = &tx_7segled_subsys;
+		dev->bus = &tx_7segled_subsys;
 		error = device_register(dev);
 		if (!error) {
 			device_create_file(dev, &dev_attr_ascii);
-- 
1.7.3.4

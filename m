Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 04:27:58 +0100 (CET)
Received: from forward104o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::607]:45281
        "EHLO forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbdLZD0uUOVME (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 04:26:50 +0100
Received: from mxback6g.mail.yandex.net (mxback6g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:167])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id F348D703411;
        Tue, 26 Dec 2017 06:26:37 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback6g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ajL9MJKaLY-Qb48NEhD;
        Tue, 26 Dec 2017 06:26:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258797;
        bh=slO9uOihf1qbhcwWc8boFOnyrccI8X7nXRwE+y7lMFk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=NZGEA00b56XcBbFpXaSNW0lv7nRFm4QCw3+HqfTjomOE3VsZUskr/Tc5BEr9lZKI8
         Cm3uZG8MuxbVIsBSIAtbZzoGKSdIbj9+yx6CPAsdc+l4ZW3MTExZ+HI6DZvrFQCvhz
         mxAaVXsQ3q0xtEmflmiQOWmXCcz2FsYS90g5iprI=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id NFRULz4HAX-QXxSBYvW;
        Tue, 26 Dec 2017 06:26:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258796;
        bh=slO9uOihf1qbhcwWc8boFOnyrccI8X7nXRwE+y7lMFk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=OtofTzDWEDxgcwFIB7+qfWlRl28FyGmLVcf12nEWiMWOP1qU0BE922lAmQALQsAip
         +toRME5Lm8bvXN/UzXnSd139nLlJiFGjLBvUjQX6wWy5kFJXjLlhYBZIC5CFWzpZ2y
         99rhaTQOGRr+iDx4GxiY196WGnFmNXOADB0qcI6o=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v6 4/4] MAINTAINERS: Add entry for Lemote YeeLoong Extra Driver
Date:   Tue, 26 Dec 2017 11:26:02 +0800
Message-Id: <20171226032602.11417-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
References: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add myself as a maintainer of Lemote YeeLoong Extra driver

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)
 mode change 100644 => 100755 MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
old mode 100644
new mode 100755
index a6e86e20761e..5a7c0d4b233a
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7873,6 +7873,12 @@ W:	http://legousb.sourceforge.net/
 S:	Maintained
 F:	drivers/usb/misc/legousbtower.c
 
+Lemote YeeLoong EXTRAS DRIVER
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	drivers/platform/mips/yeeloong_laptop.c
+
 LG2160 MEDIA DRIVER
 M:	Michael Krufky <mkrufky@linuxtv.org>
 L:	linux-media@vger.kernel.org
-- 
2.15.1

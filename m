Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 07:52:45 +0100 (CET)
Received: from forward102p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:102]:40027
        "EHLO forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990589AbdLIGuvI15iO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 07:50:51 +0100
Received: from mxback6o.mail.yandex.net (mxback6o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::20])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id BA02C43045D1;
        Sat,  9 Dec 2017 09:50:43 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback6o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gQY6siNjKM-ohU8BQ1j;
        Sat, 09 Dec 2017 09:50:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802243;
        bh=DjmLBsOlrQefkbw0JIjtYZGetDSxpvRThdmKrYdKZKk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=GY5HCJrFePoKOORLmhPf+TxhQZNp0+9CgrhMsZNgI9s3BgHTac0XiPigC49ffD3cw
         BPXkcj+HV/E5uIQOsj12lC/pv9YIdNeOL9ETyWgu6mTXhcwsTju4grVfZSeWY1tQC8
         BTWtvOaLT7dWNJ3BLd/vn96qC8i8MvcwJ7cBVPvE=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jBC3v0GG1J-oepapQNa;
        Sat, 09 Dec 2017 09:50:41 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512802242;
        bh=DjmLBsOlrQefkbw0JIjtYZGetDSxpvRThdmKrYdKZKk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=wXP3rTQpZ6/sA+1w5wJKHzeWqq0U2aMUTmySnhJMk6RIMBmJaAPRDrP3NaW2vnbvo
         R/Dc2/LtwcdaNgtM7BAgq4l4OqE5+9GyrhgMB57ZZrn5nknX37dsqRW5+c/p2wI2Km
         9X4MWKQ22eOEvIa3X6tXW1FQnvINSySsTN3h+q8g=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 5/5] MAINTAINERS: Add entry for Lemote YeeLoong Extra Driver
Date:   Sat,  9 Dec 2017 14:49:53 +0800
Message-Id: <20171209064953.8984-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171209064953.8984-1-jiaxun.yang@flygoat.com>
References: <20171209064953.8984-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61389
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
index 1c3feffb1c1c..f576db163986
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7619,6 +7619,12 @@ W:	http://legousb.sourceforge.net/
 S:	Maintained
 F:	drivers/usb/misc/legousbtower.c
 
+Lemote YeeLoong EXTRAS DRIVER
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+S:	Maintained
+F:	drivers/platform/mips/yeeloong_laptop.c
+
+
 LG2160 MEDIA DRIVER
 M:	Michael Krufky <mkrufky@linuxtv.org>
 L:	linux-media@vger.kernel.org
-- 
2.15.0

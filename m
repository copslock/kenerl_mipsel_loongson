Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Dec 2017 16:00:31 +0100 (CET)
Received: from forward100o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::600]:57613
        "EHLO forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbdLPO6ekdn9S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Dec 2017 15:58:34 +0100
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id D717D2A20A15;
        Sat, 16 Dec 2017 17:58:28 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback9j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id MwPA7S0FWb-wSOW3Opg;
        Sat, 16 Dec 2017 17:58:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1513436308;
        bh=4GBPq2NP8qkkgO8AnPlAH5TaCFSxKicxu9ESDkpceCc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=GQ7Sk90T1hDKf/ITtw6UvNIdZU+8Aa/jWXzkea0KiCjeZyCKPlLqTqUBx8t16hp0Z
         9cW/HEX8kaTPUoGo+mmP6Zh3xJbvmCscd1lkRb4pGwIOAQMJtqk3A8t/mFeFFgWUAt
         EKuP7/+ScOcxwul9pa7OSooXQ/1LEZnEbz6zM/7U=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6waszUSHIG-wPsGMs7d;
        Sat, 16 Dec 2017 17:58:27 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1513436307;
        bh=4GBPq2NP8qkkgO8AnPlAH5TaCFSxKicxu9ESDkpceCc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=alRBflgO62ncmnYhARqFn7uB5s1oUc/MdTKz/+Myba5EXCnAgbWY4RFeDGr5f2ibt
         yMWCsPwZFgosxPBisX723f9txUULC69TTLPqMdboDkvNMcQgi0yMN6IYyfSgTOXkPs
         c8IMMHVChpwSq0QjGEeSD9XU8shlJkpolZJgvwu8=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Huacai Chan <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 5/5] MAINTAINERS: Add entry for Lemote YeeLoong Extra Driver
Date:   Sat, 16 Dec 2017 22:57:51 +0800
Message-Id: <20171216145751.3486-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171216145751.3486-1-jiaxun.yang@flygoat.com>
References: <20171216145751.3486-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61499
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
index cdd6365a59d9..d2de627828a0
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7890,6 +7890,12 @@ W:	http://legousb.sourceforge.net/
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
2.15.1

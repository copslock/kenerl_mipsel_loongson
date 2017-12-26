Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 14:26:42 +0100 (CET)
Received: from forward103j.mail.yandex.net ([5.45.198.246]:37257 "EHLO
        forward103j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdLZNYnt0sTZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 14:24:43 +0100
Received: from mxback11g.mail.yandex.net (mxback11g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:90])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id ECE6834C1310;
        Tue, 26 Dec 2017 16:24:37 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback11g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GlksGTSWrP-ObZW3hTH;
        Tue, 26 Dec 2017 16:24:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294677;
        bh=GDiuzDabsGP63XK/sks5F+APn6ntvfiaJvxGo6UjmXA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=VX8QRK7gW8CaAMgV2e7ms6XUiDDUpSWodHe6bG8WZvbFpE3gShVqIHLBwKFYjYorX
         QltJumCl5+cjA2L7QSO669aGV857tnMFgtUTBzbkfjVXOcD1tEylKvuIIbCz+U4bei
         w+TB0pob2K4ZzZAILoBpvYlCOsneO0qBw0R1AxJs=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Ful6zNDKwE-OXk8d1uh;
        Tue, 26 Dec 2017 16:24:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514294676;
        bh=GDiuzDabsGP63XK/sks5F+APn6ntvfiaJvxGo6UjmXA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=LP1rb1dNnR1ORU4VnnV8nabYqyASletW3BXJA6JWRgY/G+l8RS9AellwWeZu1QMWf
         aYaE59DGh5Ebwx/FOI7cCSI20d0KM/7M41qjmpj6O16vbKj92aIZSi/7sTyf8OR0Kl
         umI6tsvS1vU+x/HqAH7/lzMVGC+cjM5DhCblCc5Q=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 6/7] MIPS: Loongson64: cleanup all mach files to use SPDX Identifier
Date:   Tue, 26 Dec 2017 21:23:38 +0800
Message-Id: <20171226132339.7356-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61604
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

To reduce unnecessary license text.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson64/Makefile | 1 +
 arch/mips/loongson64/Platform | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/loongson64/Makefile b/arch/mips/loongson64/Makefile
index 4fe3d88fc361..64b270c70607 100644
--- a/arch/mips/loongson64/Makefile
+++ b/arch/mips/loongson64/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 
 #
 # Common code for all Loongson based systems
 #
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 0fce4608aa88..ceffdace758e 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 
 #
 # Loongson Processors' Support
 #
-- 
2.15.1

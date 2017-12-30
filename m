Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 19:31:23 +0100 (CET)
Received: from forward106o.mail.yandex.net ([37.140.190.187]:40655 "EHLO
        forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdL3S3yzbUgc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 19:29:54 +0100
Received: from mxback12g.mail.yandex.net (mxback12g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:91])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 291F5783E59;
        Sat, 30 Dec 2017 21:29:49 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback12g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id D2EJzp7E7R-TPX02Ntu;
        Sat, 30 Dec 2017 21:29:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658566;
        bh=GDiuzDabsGP63XK/sks5F+APn6ntvfiaJvxGo6UjmXA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=SkKbZ2SWAqaZddSI6q0YDhuHdn3+ING+2gHZMGaW3wCMbUt89wQojx3EnR3By6xyY
         AmobcOboA8+wN4DAmUA321HQOJ3m9UNyM32y8/ILA12x+geG2kP1mH749YcrEcoGHk
         8jA7g6+AZF720AdgUdKG86IJE2wr2HVRZGEDfwAw=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 6PdmBEypOo-TNT4T8uv;
        Sat, 30 Dec 2017 21:29:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514658565;
        bh=GDiuzDabsGP63XK/sks5F+APn6ntvfiaJvxGo6UjmXA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=FPdFovE7ezTjPKlQFla97G7d0C9/vCZSkaP9/+r+RIitauUqE8M0v3pLANRxg5OM/
         QicVB6Id1PgrUcmQHg+dxWcmQkpqtATrXCoIMp9yFpkWGEOMbfdrusteQDA2xwWQfz
         hf5Iz1KYFGSREF7g3oQuiWPrYcgzg88gZSCx16Rw=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCHv2 6/8] MIPS: Loongson64: cleanup all mach files to use SPDX Identifier
Date:   Sun, 31 Dec 2017 02:28:29 +0800
Message-Id: <20171230182830.6496-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171230182830.6496-1-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61796
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

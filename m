Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 09:48:10 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:52849 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492159Ab0AaIsE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 09:48:04 +0100
Received: by pzk41 with SMTP id 41so5062980pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 00:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=tokio+Tp3nTeYcK4d5heoNPc0sgT84IsFwSRpNo3/Mg=;
        b=jo5DAWHrbK3qBbDhNJnTTVwkwQMrPmS+I//cq64PkMIWIuLUzXDsiq48g2NLRX5yWC
         v/TL/sDmvQEXYzyk7cXKVffZ9SA20RdQu9EQPu/Fr3OcdINNBavRsGZF375e1YeeiQ2h
         qXPck4/iAgCv6xNuB0fC+Oh6zIjSlte9IOfpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NVeMzlsDxGqsNQ7bNVZBnAfvhoReI/WEYL0R2gtra89tgigTaWmyOheix9O0Lge3sN
         kBP0BcRkFpSfOV+foxl0BK+38euOUhd1p6dGRTHl4PvJi+2ypXSnWBGIJAnjlWvE39Ry
         x+nbp83Hwkz60SJukx+JQwlbqW4E6VLGIjrAA=
Received: by 10.115.5.18 with SMTP id h18mr2093382wai.177.1264927676531;
        Sun, 31 Jan 2010 00:47:56 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm3352110pzk.14.2010.01.31.00.47.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 00:47:56 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson: Lemote 2F: Fixup of the Makefile
Date:   Sun, 31 Jan 2010 16:41:52 +0800
Message-Id: <1264927312-21390-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19685

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch removes the duplicated obj-y line.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 01f71b1..8699a53 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -2,7 +2,6 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += irq.o reset.o ec_kb3310b.o
 obj-y += machtype.o irq.o reset.o ec_kb3310b.o
 
 #
-- 
1.6.6

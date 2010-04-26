Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 14:02:39 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:54963 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492498Ab0DZMCg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Apr 2010 14:02:36 +0200
Received: by gwb1 with SMTP id 1so262039gwb.36
        for <multiple recipients>; Mon, 26 Apr 2010 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Nl39hrGq5vgdjyZdFaMehAWaos7T0sRl3ua+mi67nTo=;
        b=j7ZxkMyvmJgsnmjTQWqzRbJVC4YS24tIbDSVSbvpZOnWx5+PpxMovHXFClXsSiRq9k
         2vbsMR1h6Z7oEUiJe1hEVR3UN4zIDLmOfwU+xgT8dRu6wsmR2NeDEgl4YhGfqaXIAtvK
         jD1cB1S2w8gfXbAgv3NozDbifEcSvtu74GzDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=heos3bZDEmt1eHSJVslWPKFDz0S/3owRr6xPNs3vdplqoVHBrZLi1PyoTf6ARdDeFy
         F2zCkmwTjEOgXXa4FjnyBiQ5gIpFz1KPMtKTHrMlGsqBUb8A5n4EfO5gAsb7JRpVZKTF
         hhn+IdVN/uC7eYT4PE9dGFcViwYw/6j7VrCDU=
Received: by 10.150.128.3 with SMTP id a3mr3909433ybd.280.1272283341540;
        Mon, 26 Apr 2010 05:02:21 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 15sm1856832gxk.10.2010.04.26.05.02.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 05:02:21 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson: Oprofile: Enable it when CONFIG_OPROFILE=m
Date:   Mon, 26 Apr 2010 20:01:54 +0800
Message-Id: <eef62a9626aaf083c6dbc472d36abf16bd85e3b6.1272283237.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

When the oprofile is compiled as a module, the do_IRQ() is not called in
arch/mips/loongson/lemote-2f/irq.c for the wrong #ifdef there.

This patch fixes it via calling do_IRQ() whenever oprofile is compiled
as a module(CONFIG_OPROFILE_MODULE is defined) or compiled into the
kernel(CONFIG_OPROFILE is defined).

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index 882dfcd..1d8b4d2 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -79,7 +79,7 @@ void mach_irq_dispatch(unsigned int pending)
 	if (pending & CAUSEF_IP7)
 		do_IRQ(LOONGSON_TIMER_IRQ);
 	else if (pending & CAUSEF_IP6) {	/* North Bridge, Perf counter */
-#ifdef CONFIG_OPROFILE
+#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
 		do_IRQ(LOONGSON2_PERFCNT_IRQ);
 #endif
 		bonito_irqdispatch();
-- 
1.7.0

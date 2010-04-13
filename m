Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2010 07:17:00 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:34883 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491118Ab0DMFQz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Apr 2010 07:16:55 +0200
Received: by pwj4 with SMTP id 4so1409453pwj.36
        for <multiple recipients>; Mon, 12 Apr 2010 22:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rqsLiZC6AB6BNuGZ5mJsCMmlcAVD36zT8K7cQAcK6FY=;
        b=SuV3aHXGLaKELd33pdy3gt2zpIZRkT62Gv104KsQRmKOeaRCu+mVCoKD/8hHx25mIR
         o2MtTb+JkS0EeYYuJKzyMM6MVrvk/rlNFpxwVSE2rxS8XWZ6UEzCFRpKACVmTW83kYiZ
         GxolCWbR0/aY3Z5GyxvgDWA7zUKF/fLQ5Mczk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=yC7VtMg10/5z82MH2ve4Kc8lz5wJVBzB3RMIdc8IinzNcy2CixDwl8TR968ZJlvvWw
         J32nmwmpn2rufpbxHB0nb5le/HVOWgEhGB8di10+hbUfHPGXvbHRVDvJ7eCAXPgAL4mO
         lbY2I7EzbhqmqPP0x+HqMkR5xTddtjpPV2e+g=
Received: by 10.142.1.41 with SMTP id 41mr2277724wfa.289.1271135806948;
        Mon, 12 Apr 2010 22:16:46 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm4619421iwn.7.2010.04.12.22.16.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 22:16:46 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson: update cpu-feature-overrides.h
Date:   Tue, 13 Apr 2010 13:16:34 +0800
Message-Id: <1271135794-19762-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Loongson doesn't support MIPSR2, therefore, MIPSR2 vectored interrupts
(cpu_has_vint) and MIPSR2 external interrupt controller mode
(cpu_has_veic) are 0.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../asm/mach-loongson/cpu-feature-overrides.h      |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index 16210ce..675bd86 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -52,6 +52,8 @@
 #define cpu_has_tx39_cache	0
 #define cpu_has_userlocal	0
 #define cpu_has_vce		0
+#define cpu_has_veic		0
+#define cpu_has_vint		0
 #define cpu_has_vtag_icache	0
 #define cpu_has_watch		1
 
-- 
1.7.0

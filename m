Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 03:15:12 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:42959 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492239Ab0ESBPI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 03:15:08 +0200
Received: by pxi1 with SMTP id 1so3474342pxi.36
        for <multiple recipients>; Tue, 18 May 2010 18:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NKtwZwxPak96l1X6cJbPSnNJpKO+j0/6OUb13pxLxUc=;
        b=BGS6ah7exc/tn3i7sFsGqQfjJeMU5ZMS6L+ek6f7VFAd2WLSaxyOKAHPcq96qld38R
         j0FAhxwWgt8PR3FcdLibJxuIae+DYl2qoo0qpZzWZYweCXuWZkMh/HwqwenRwie5V/4w
         lC7VChBmqaNmon6xz60ecNPiujpCjVwR0y3j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=C0KwO3AhFs5dXZDcCkjTY0oGoP8WMwkSYKRosPT7KCOfAkbQyjPXs1JOgZIMU0X5lL
         7QmDcstRi0+V7qxaTCn+tsnt4gSahULYmzzvytw20UQbHAn9ihB7f4rtdoLtKsSUTufM
         oUEAnCk4Wt08/MAAYdk0ZiQ709EJpOKqsTbkg=
Received: by 10.140.57.15 with SMTP id f15mr5761447rva.56.1274231698286;
        Tue, 18 May 2010 18:14:58 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id d14sm5671524rva.18.2010.05.18.18.14.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 18:14:57 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Zhang Le <r0bertz@gentoo.org>,
        loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson: cs5536: Fixup of the isa support
Date:   Wed, 19 May 2010 09:14:18 +0800
Message-Id: <af4d16cdc608a1bbf128e84914eeb69543ba6dbc.1274231644.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The function _wrmsr() called by divil_lbar_disable()/enable() should be
passed the argument with the offset.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/cs5536/cs5536_isa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/common/cs5536/cs5536_isa.c b/arch/mips/loongson/common/cs5536/cs5536_isa.c
index f5c0818..4d9f65a 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_isa.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_isa.c
@@ -61,7 +61,7 @@ static void divil_lbar_enable(void)
 	for (offset = DIVIL_LBAR_SMB; offset <= DIVIL_LBAR_PMS; offset++) {
 		_rdmsr(DIVIL_MSR_REG(offset), &hi, &lo);
 		hi |= 0x01;
-		_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);
+		_wrmsr(DIVIL_MSR_REG(offset), hi, lo);
 	}
 }
 
@@ -76,7 +76,7 @@ static void divil_lbar_disable(void)
 	for (offset = DIVIL_LBAR_SMB; offset <= DIVIL_LBAR_PMS; offset++) {
 		_rdmsr(DIVIL_MSR_REG(offset), &hi, &lo);
 		hi &= ~0x01;
-		_wrmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), hi, lo);
+		_wrmsr(DIVIL_MSR_REG(offset), hi, lo);
 	}
 }
 
-- 
1.7.0.4

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 03:14:02 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:64274 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492254Ab0ESBN6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 03:13:58 +0200
Received: by pzk35 with SMTP id 35so588499pzk.0
        for <multiple recipients>; Tue, 18 May 2010 18:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=c4Xp6biLqpDV0xes18Xa45oRbfeyS7W3wCSHI8tKeT4=;
        b=RC7d8cYi+FurlpN+3ScZTvoUFe/5r407aBzxRSpGRF3ntyp1Wo+uCgBWBzz7hMMVey
         nRpcgBrJfLTRb3nyF+Z7aDPwP60/qf6R+vQSouVO1LVED1Y6aZvxMjiAuZ6KjoL9ou5R
         aBQ6VH3lbKcbPBy79N+xencx9fCOA2Z2VV12Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TuhnCOqbnCbdR3c69L5mkqgh1XGIl8BRL7UHlZWRF/+/JjvvbtayBsRVXyfBB6Mo6E
         VBdvJ8DAxvO2IyKsFAe/y8Ibjb3T/jFPDQ2a3nlfUXHWNji5wg+3Qn/+ZWw8wMr1nEoZ
         X93fOLXiTGLWRg9VU6tKJRrFKwxi9rJgl6NVE=
Received: by 10.141.124.21 with SMTP id b21mr5540046rvn.267.1274231630502;
        Tue, 18 May 2010 18:13:50 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id h11sm5669619rvm.21.2010.05.18.18.13.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 May 2010 18:13:50 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Zhang Le <r0bertz@gentoo.org>,
        loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] Loongson: cs5536: add a missing break; for ide
Date:   Wed, 19 May 2010 09:13:38 +0800
Message-Id: <bf65a506db0a8fd71822db28279504156e366208.1274231591.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/cs5536/cs5536_ide.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson/common/cs5536/cs5536_ide.c b/arch/mips/loongson/common/cs5536/cs5536_ide.c
index 7ebf17a..681d129 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ide.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ide.c
@@ -179,6 +179,7 @@ u32 pci_ide_read_reg(int reg)
 	case PCI_IDE_ETC_REG:
 		_rdmsr(IDE_MSR_REG(IDE_ETC), &hi, &lo);
 		conf_data = lo;
+		break;
 	case PCI_IDE_PM_REG:
 		_rdmsr(IDE_MSR_REG(IDE_INTERNAL_PM), &hi, &lo);
 		conf_data = lo;
-- 
1.7.0.4

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 15:24:13 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:56482 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491924Ab0ELNX4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 15:23:56 +0200
Received: by mail-pw0-f49.google.com with SMTP id 6so511839pwj.36
        for <multiple recipients>; Wed, 12 May 2010 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=XdwDEiJB1OR8QQQP7z/6LGY0uLnjSJF+kxyFjiC3dfY=;
        b=u04p7KWYmv80ow5nC2Fg1iGG2UOdvDH6UiZNg+0QCcucDzMw/MC/R31ZWilAhnbuz+
         bh16WsG6XGjkna8JVFsFKhvKqg1tHFnjVDlyYw8mZNr41/OZw/LqSq7D8aXVHoV1aFBP
         HPreQhFdPjnyTmUeyMcwnIuyvzU28UtdPI22s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mV3iFNk5RQAj/T8mXQm7KNB3em0x5Bkr1I1pMyDsBph9G8LqY6W+i199HqFNxIBGJ8
         uKtEKaPVAcRM/S11kC97l4udnf0m0RjbvRaf5de6ffrHqkHi4X+VFB+i2X82g33mu7Cr
         s/YJhG7iXG6kopLDsg3xbiaFCAjVei3aioVvY=
Received: by 10.115.100.21 with SMTP id c21mr3453994wam.105.1273670635781;
        Wed, 12 May 2010 06:23:55 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id b6sm1273475wam.21.2010.05.12.06.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 06:23:55 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/9] tracing: MIPS: mcount.S: merge the same continuous #ifdefs
Date:   Wed, 12 May 2010 21:23:09 +0800
Message-Id: <6727e6718df351f8f74f55520d3f7b093f72b92a.1273669419.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273669419.git.wuzhangjin@gmail.com>
References: <cover.1273669419.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

There are two same continuous #ifdefs, this patch merges them to reduce
two lines.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/mcount.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 6851fc9..e256bf9 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -45,8 +45,6 @@
 	PTR_L	a5, PT_R9(sp)
 	PTR_L	a6, PT_R10(sp)
 	PTR_L	a7, PT_R11(sp)
-#endif
-#ifdef CONFIG_64BIT
 	PTR_ADDIU	sp, PT_SIZE
 #else
 	PTR_ADDIU	sp, (PT_SIZE + 8)
-- 
1.7.0.4

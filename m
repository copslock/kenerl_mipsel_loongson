Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 10:34:16 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:55540 "EHLO
	mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1492106AbZKXJeM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 10:34:12 +0100
Received: by pzk41 with SMTP id 41so4315832pzk.0
        for <multiple recipients>; Tue, 24 Nov 2009 01:34:01 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XOI4V7OIW4iqexdNWb56UA4axgsbaAP/yu0d/s1rZNA=;
        b=TkseM5dsQirgiZu7bFLzsqGumeOXaU7IhceqW8DV8JcavweobxcZzZtrxD3gYIluO5
         ZUiQA1zvIzCipPd04xW78tZRSmukdwvKYWVPrsdZTDq9x9gPcZxVyEyspLwFcK7bPba8
         47jXUPdihKAdY3lhkm22jsu6lpMvPfOXBIGyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XPeloR48ZV6jORXda5lemqFJq1f7Uz+6LSa9kYOD/fkmZEnCF1lTIT29GFRKZWFJ5v
         +z8Qr5y/u+ZkTG1CSYX7g6Tr4avETs1D68ZIhSP5ZmpGcAJ9iq80Vgxt/e8hwJeVh81x
         R5lJqDMmq8b++iJiBf/khy9pEXhuFfcrVAroQ=
Received: by 10.115.133.39 with SMTP id k39mr11742608wan.94.1259055241676;
        Tue, 24 Nov 2009 01:34:01 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm3573135pzk.14.2009.11.24.01.33.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 01:34:01 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: EARLY_PRINTK: Fixup of dependency
Date:	Tue, 24 Nov 2009 17:33:50 +0800
Message-Id: <1259055230-15818-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

In the old version, if the platform select SYS_HAS_EARLY_PRINTK and
users not select DEBUG_KERNEL, there is no interface for user to enable
or disable the EARLY_PRINTK option, it will be enabled all the time.
this will waste a little bit of memory and slow down the booting of
kernel but the users never know it.

This patch will only enable that option when the DEBUG_KERNEL is
enabled.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b342197..d2446d5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -824,8 +824,8 @@ config DMA_NEED_PCI_MAP_STATE
 	bool
 
 config EARLY_PRINTK
-	bool "Early printk" if EMBEDDED && DEBUG_KERNEL
-	depends on SYS_HAS_EARLY_PRINTK
+	bool "Early printk" if EMBEDDED
+	depends on SYS_HAS_EARLY_PRINTK && DEBUG_KERNEL
 	default y
 	help
 	  This option enables special console drivers which allow the kernel
-- 
1.6.2.1

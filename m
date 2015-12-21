Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2015 04:48:00 +0100 (CET)
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36503 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbbLUDr6e344q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Dec 2015 04:47:58 +0100
Received: by mail-pf0-f175.google.com with SMTP id o64so81060961pfb.3;
        Sun, 20 Dec 2015 19:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qFOtFoDTbshgNaooF1nt7KnaSK8UyyOeD6mJc+Z7GqQ=;
        b=Tlhm+qws+nmPoRliQvThvFurqfUtg5b0jcV5E3vCPqH69sUbO1L/BuKAF0U5qGtFke
         SPYLbUmcQ8tPZy19uprrRoe3wmx29vuUqE3Wgp3KHJ8skGll0q5ng02B6OQX5kt2cnem
         OjWLk49eji5sq4h1dATWaqpYrTFWA7OX88ISDLzbLWci1HLK5sL09J+SQuzQ2VZnjcM8
         TRQmVTy6KI5nKvn4TKU5jb8kRtSZcfXjo2Z3FCqzYD1tkActWN4riK6hcu5ZVZmByHDX
         j8euJZaWV/tupxhrioClwRR0/rkYKgD/y5aGBhA8x5NDaYfmSR8ZV1HdkjKAtfQpsD23
         Mrxw==
X-Received: by 10.98.68.146 with SMTP id m18mr2012049pfi.77.1450669672521;
        Sun, 20 Dec 2015 19:47:52 -0800 (PST)
Received: from praha.local.private ([211.255.134.166])
        by smtp.gmail.com with ESMTPSA id c27sm5102572pfd.50.2015.12.20.19.47.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 19:47:52 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Jonas Gorski <jogo@openwrt.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH] MIPS: fix macro typo
Date:   Mon, 21 Dec 2015 12:47:35 +0900
Message-Id: <1450669655-62959-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Change the CONFIG_MIPS_CMDLINE_EXTEND to CONFIG_MIPS_CMDLINE_DTB_EXTEND
to resolve the EXTEND_WITH_PROM macro.

Fixes: 2024972ef533 ("MIPS: Make the kernel arguments from dtb available")
Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 66aac55df349..569a7d5242dd 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -623,7 +623,7 @@ static void __init request_crashkernel(struct resource *res)
 
 #define USE_PROM_CMDLINE	IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
 #define USE_DTB_CMDLINE		IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
-#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_EXTEND)
+#define EXTEND_WITH_PROM	IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
 
 static void __init arch_mem_init(char **cmdline_p)
 {
-- 
2.6.3

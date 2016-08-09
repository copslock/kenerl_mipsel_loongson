Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 12:53:28 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35456 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992461AbcHIKxVvN2mc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 12:53:21 +0200
Received: by mail-pf0-f195.google.com with SMTP id h186so706852pfg.2;
        Tue, 09 Aug 2016 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hwFDK9kklA2DWoCnm2J0S8tixJlvCjWgFPXwKaaiahQ=;
        b=dUNF4yQRkjoNlcFAHFSVPdD+Af9vjed2jOFtndJDES6cW8Po+fWLQBYuHc9USNGMSz
         HAt8UbOu/ZoP1XTRSso+t0Y3ilgjfGEKhnta4GjDd1g0zoNeegj6ZCJTXv7ccFTo5eJT
         EK9WwbUpMydvkNIG0U8NYNfwKwiuyp+eNpW3LH6dPMD1H2nPYilQH9ywzdT+3pNihm/4
         fChKqrE+FQx9Xclu680FdmXE5csZ3QQyjiYxh3B1vj4wG2nPkiuGiNTnYlbfoAJbHOd4
         a0vQoE7a0VC6Wiuwo/QRf8msyn2angVNToPlvQjbqIewYuNKhWqknr19PN3zg2uNHeWu
         aToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hwFDK9kklA2DWoCnm2J0S8tixJlvCjWgFPXwKaaiahQ=;
        b=BhrYprSgBzKggJ7uXtZIsWGYLxeiiSKj4yqE0j8LKNndyNdZK8kgCTsTaWKsnYs2pJ
         403xsOUT+D4//H8+BbbTcHcIop1DDEHMortaYBO3vnXoQZ3TW8YDVgPmfdCzTLLSZs8O
         eyEKMHfPai0mf4Wxz1q8tAQWEWHKkQdng+WXDLGY4ApjK4fXbOcebrg9Wu9aewZPnNTv
         bDIEawXQlLiZrepZFldqwwqkfJAePHyTzWhIyZGfYt803sSa50hUKanxk/X/E76+Fd7S
         zuZVq/wAm5jn1jjW/Xl7EJJ18Rj87yFelKvqK4G5XzrpTNCbxy2pUNWgxUXboDqpZllq
         tCEQ==
X-Gm-Message-State: AEkooutr/0u5Qes//DT4YcXU5woLJhX4TpeVgu7+8qw0FXYJF6JqcfQMHKsFCLDRk/irCg==
X-Received: by 10.98.48.65 with SMTP id w62mr170851972pfw.18.1470739995769;
        Tue, 09 Aug 2016 03:53:15 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id d5sm54999408pfc.4.2016.08.09.03.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Aug 2016 03:53:14 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: Loongson1B: Modify DEFAULT_MEMSIZE
Date:   Tue,  9 Aug 2016 18:52:59 +0800
Message-Id: <1470739979-11382-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch changes DEFAULT_MEMSIZE to 64MB
which is the memory size of latest EVB.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/loongson1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 3584c40..ec7efd0 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -13,7 +13,7 @@
 #define __ASM_MACH_LOONGSON32_LOONGSON1_H
 
 #if defined(CONFIG_LOONGSON1_LS1B)
-#define DEFAULT_MEMSIZE			256	/* If no memsize provided */
+#define DEFAULT_MEMSIZE			64	/* If no memsize provided */
 #elif defined(CONFIG_LOONGSON1_LS1C)
 #define DEFAULT_MEMSIZE			32
 #endif
-- 
1.9.1

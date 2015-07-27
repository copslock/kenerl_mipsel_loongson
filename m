Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 10:03:11 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37059 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009523AbbG0IDJgMjro (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 10:03:09 +0200
Received: by wibud3 with SMTP id ud3so103689153wib.0;
        Mon, 27 Jul 2015 01:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5rxkl9HUh4FP8Ad2TASfEvmqMPXHvMvrdrJ5S62890=;
        b=aTkMOTlsltVGclCcMGGYn0vfrnWW79AdTyzi/mEYpbcbeYBWWi/4RNqcQvsDXcuD4g
         8FmnbsQz5YQVtT718bfwvxdjB8wFtLE9Xd4iMpM26JfUUlcAodV04/yX3o7wp9cAByVQ
         b3oQhteCinBPcwIYS6mCJJEOD0It6bZHPoSXOIUFl7bEnMZ6kY6+gesr2bZ4JmEJhSBj
         AJbFX1YzZa7Z5i9najWNTtAs4R1FbDuJ46dhiANiGAogeXvKjq9GzJHNxVkOlj7rccEK
         vIwVWsI9dAEsgyM3FEZ6QXfiCr+CkXw+//Z5zkKMLm+IYok8RLkAaj8GQ8WoVet31Aoz
         XA8w==
X-Received: by 10.194.109.36 with SMTP id hp4mr56232922wjb.4.1437984184343;
        Mon, 27 Jul 2015 01:03:04 -0700 (PDT)
Received: from anemoi.home (ip4-83-240-67-251.cust.nbox.cz. [83.240.67.251])
        by smtp.gmail.com with ESMTPSA id s16sm12167801wib.16.2015.07.27.01.03.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 01:03:03 -0700 (PDT)
From:   Jiri Slaby <jslaby@suse.com>
To:     jslaby@suse.com
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] MIPS: Fix KVM guest fixmap address
Date:   Mon, 27 Jul 2015 10:02:07 +0200
Message-Id: <1437984150-15702-26-git-send-email-jslaby@suse.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437984150-15702-1-git-send-email-jslaby@suse.com>
References: <1437984150-15702-1-git-send-email-jslaby@suse.com>
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.com
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 8e748c8d09a9314eedb5c6367d9acfaacddcdc88 upstream.

KVM guest kernels for trap & emulate run in user mode, with a modified
set of kernel memory segments. However the fixmap address is still in
the normal KSeg3 region at 0xfffe0000 regardless, causing problems when
cache alias handling makes use of them when handling copy on write.

Therefore define FIXADDR_TOP as 0x7ffe0000 in the guest kernel mapped
region when CONFIG_KVM_GUEST is defined.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9887/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/include/asm/mach-generic/spaces.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index 9488fa5f8866..afc96ecb9004 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -94,7 +94,11 @@
 #endif
 
 #ifndef FIXADDR_TOP
+#ifdef CONFIG_KVM_GUEST
+#define FIXADDR_TOP		((unsigned long)(long)(int)0x7ffe0000)
+#else
 #define FIXADDR_TOP		((unsigned long)(long)(int)0xfffe0000)
 #endif
+#endif
 
 #endif /* __ASM_MACH_GENERIC_SPACES_H */
-- 
2.4.6

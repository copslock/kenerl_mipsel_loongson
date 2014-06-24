Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 01:00:28 +0200 (CEST)
Received: from mail-ie0-f201.google.com ([209.85.223.201]:61794 "EHLO
        mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860023AbaFXXAYxPAHJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 01:00:24 +0200
Received: by mail-ie0-f201.google.com with SMTP id lx4so261911iec.2
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 16:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7fOGyxvyAsjUTvjIqaUEk3TFzfl7m3jeEoXgHMHMeIw=;
        b=e0o2SholLSi2qlLrcuG5yUQu6+6g7KRcT7FLb5vUEAcUxk1DPW7VjmrfiR7QKXzCU1
         GQKhoHQAy7MzUGdzLxq6DJrHwCbVe9fYnME3aF9Wq0NynkW76Rodp1T9iZiMQm8FrF2M
         uuxsUELiVekgEiKCIOxDiWgG6ow13fZUm0I4poefvsALP3V4m+fKBXrJwWvfGCbhpD2J
         1kke0qZrZWG1FtTs8Gvq7FHJFJrj+31WMChNRnfceVeCQjOuVoB+QjBjViCtckQ8VjqL
         BFbqFA8KPocdB6sjoYGuR+NmoR2O++l5WZEQkr9WM8TyuzsbWhpj3rla7CDgjVfVE/c6
         Yk9A==
X-Gm-Message-State: ALoCoQmTpcduQoQdQJRHu2sHfgwTug7irdnW9PBW3+5qtq8AbhINUy4LimqjvWkoEptg9UfwDWXZ
X-Received: by 10.182.166.36 with SMTP id zd4mr2134686obb.43.1403650818547;
        Tue, 24 Jun 2014 16:00:18 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si152873yhk.4.2014.06.24.16.00.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jun 2014 16:00:18 -0700 (PDT)
Received: from bellis2.mtv.corp.google.com (bellis2.mtv.corp.google.com [172.22.72.99])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5669031C82A;
        Tue, 24 Jun 2014 16:00:18 -0700 (PDT)
Received: by bellis2.mtv.corp.google.com (Postfix, from userid 134248)
        id EC8AB2209BA; Tue, 24 Jun 2014 16:00:17 -0700 (PDT)
From:   Ben Chan <benchan@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Olof Johansson <olofj@chromium.org>
Subject: [PATCH] MIPS: ZBOOT: implement stack protector in compressed boot phase
Date:   Tue, 24 Jun 2014 16:00:17 -0700
Message-Id: <1403650817-21641-1-git-send-email-benchan@chromium.org>
X-Mailer: git-send-email 2.0.0.526.g5318336
Return-Path: <benchan@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benchan@chromium.org
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

This patch implements the stack protector code in MIPS compressed boot
phase based on the same code added to arm in commit
8779657d29c0ebcc0c94ede4df2f497baf1b563f "stackprotector: Introduce
CONFIG_CC_STACKPROTECTOR_STRONG" by Kees Cook <keescook@chromium.org>

Signed-off-by: Ben Chan <benchan@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Olof Johansson <olofj@chromium.org>
---
 arch/mips/boot/compressed/decompress.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index c00c4dd..b49c7ad 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -67,10 +67,24 @@ void error(char *x)
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
+unsigned long __stack_chk_guard;
+
+void __stack_chk_guard_setup(void)
+{
+	__stack_chk_guard = 0x000a0dff;
+}
+
+void __stack_chk_fail(void)
+{
+	error("stack-protector: Kernel stack is corrupted\n");
+}
+
 void decompress_kernel(unsigned long boot_heap_start)
 {
 	unsigned long zimage_start, zimage_size;
 
+	__stack_chk_guard_setup();
+
 	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
 	    (unsigned long)(&__image_begin);
-- 
2.0.0.526.g5318336

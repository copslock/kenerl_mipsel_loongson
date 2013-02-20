Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2013 07:17:57 +0100 (CET)
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61443 "EHLO
        mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827454Ab3BTGRzIZPkH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Feb 2013 07:17:55 +0100
Received: by mail-bk0-f46.google.com with SMTP id j5so3481077bkw.19
        for <multiple recipients>; Tue, 19 Feb 2013 22:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=nbm0gZCeSkLhw8gAiYRbblFBhUEtHW9Z98h8f04L03o=;
        b=IaFwuz8CQc4jVyn/8HctSDBc4Wjr+uo36m6dQ8n1bnRv+haLIq2hf/7eaiOCk5QRWm
         e3y9CcP7VrHF7PnQDzdGkCWUE82wWeTKlVozEvmu8RqUks146+xsv99Tyxn1KwpnU8SQ
         TTFy9RcYe/1GU0CgWfpXZkgwc+e8vzqdTIpPqmBoVUMYZZ98IqGvJC1UdTFGMZd2zglQ
         jC6vqcM5lVjBG3hE1dIWHdTMy4QIf+reSF7dwu3f+VGHL0t6qBEp3zoqhtIAtUUg80dm
         iHOnWsEQMuxBpKmCgS/g081+Hjp+G3IkCa4xJQIZoK/IrnqshrAx07Dl8AJfzxx8pWPn
         iiuQ==
X-Received: by 10.205.127.135 with SMTP id ha7mr7633253bkc.140.1361341069628;
        Tue, 19 Feb 2013 22:17:49 -0800 (PST)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id go8sm22899083bkc.20.2013.02.19.22.17.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 22:17:49 -0800 (PST)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: fix access_ok()
Date:   Wed, 20 Feb 2013 14:17:36 +0800
Message-Id: <1361341056-15287-1-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Yong Zhang <yong.zhang@windriver.com>

Current access_ok() will fail even if the address range is
valid when it reaches to the end of TASK_SIZE.
For exampe: addr = 0xfffffffff0; size = 16;
the real address range it want to access is 0xfffffffff0~0xfffffffff;
but addr + size = 0x10000000000 which we will not and can't access.
In current realization of access_ok(), the high bit will be 1
thus access_ok() indicates the operation is not allowed.

The bug is found in old kerenl(before vdso is realized) in
following typical call trace:
sys_mount()
  copy_mount_options()
    exact_copy_from_user()
When the parameter 'from' for exact_copy_from_user() residents in
the last page of the task's virtual address, such as stack.
But it's still in current kernel.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/uaccess.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 3b92efe..55d4214 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -114,8 +114,12 @@ extern u64 __ua_limit;
 	unsigned long __ok;						\
 									\
 	__chk_user_ptr(addr);						\
-	__ok = (signed long)(__mask & (__addr | (__addr + __size) |	\
-		__ua_size(__size)));					\
+	if (likely(size))						\
+		__ok = (signed long)(__mask & (__addr |			\
+				(__addr + __size - 1) |			\
+				__ua_size(__size)));			\
+	else								\
+		__ok = 0;						\
 	__ok == 0;							\
 })
 
-- 
1.7.9.5

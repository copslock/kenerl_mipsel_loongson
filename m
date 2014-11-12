Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 06:47:37 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64740 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012552AbaKLFrdYlhRY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 06:47:33 +0100
Received: by mail-pa0-f54.google.com with SMTP id hz1so1028246pad.27
        for <multiple recipients>; Tue, 11 Nov 2014 21:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=zIC86PrYeziYsIA9DCEQ0hu8mN5BMtuKD1VUTA0QI2s=;
        b=NkmV56NzDIL3Fyy22tluW/UKzU08W/f3K5hEL58JwWVNb50DWF3fp73IT4TwIaUL15
         SzVEaGZb2Cpjd7LPKuMoNSZf1H5MloExBc2VDi303Cb/RHJ9pCxabmXjuOCCqRbnFm2f
         1QBZbQqZ6NomOxOvhN3eWGv4qQZIV+svWyoljmPmI7y0dzuTUsQfxakNk4xWVVuD+4b1
         x1tqkSbs1gO/F88O4oWqUUwwjbRi76DWTFbd42yzRmkrsSM4xXv6mHPeasXdeY/SEEJa
         rDR/ljxIJUQ/MqY5kbKzh1WciF3syCXCOb1LtZxedvbpEVQHXuieQrCvUD9MF4q5Whoo
         /SxA==
X-Received: by 10.67.14.7 with SMTP id fc7mr2298940pad.55.1415771247352;
        Tue, 11 Nov 2014 21:47:27 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id xy3sm20956806pbb.38.2014.11.11.21.47.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Nov 2014 21:47:26 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Fix a copy & paste error in unistd.h
Date:   Wed, 12 Nov 2014 13:47:14 +0800
Message-Id: <1415771234-6364-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Commit 5df4c8dbbc (MIPS: Wire up bpf syscall.) break the N32 build
because of a copy & paste error.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/uapi/asm/unistd.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 9dc5856..d001bb1 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -1045,7 +1045,7 @@
 #define __NR_seccomp			(__NR_Linux + 316)
 #define __NR_getrandom			(__NR_Linux + 317)
 #define __NR_memfd_create		(__NR_Linux + 318)
-#define __NR_memfd_create		(__NR_Linux + 319)
+#define __NR_bpf			(__NR_Linux + 319)
 
 /*
  * Offset of the last N32 flavoured syscall
-- 
1.7.7.3

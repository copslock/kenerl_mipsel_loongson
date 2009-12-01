Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 07:55:50 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:57941 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492130AbZLAGzq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 07:55:46 +0100
Received: by pzk35 with SMTP id 35so3446600pzk.22
        for <multiple recipients>; Mon, 30 Nov 2009 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=FaHKPCCGS+EkoEUOTtJEUisoHXUNm02T3M6l+h9WLWo=;
        b=QrfxaWLm6LxXaq6ZYLKOlIO5GQZZ9+ClH1J/5qGX4gadf3WmMeuhGEHBj9ORBPaRyU
         zz3RsfQYzFCsEC7y37L43sAjwJOMluUp5lqBa3mb0aA/CQt33QJDKYuODPkTQnoxo/bJ
         ITrNd7gBCy1oXZgJIWSIQ5cjgJv0VR2IiP2MY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FjJWjTf24Wu4kPAylt4bgnRTw1u0xYrrYE7MRKhtrIq4RCHqMV4pqd9Aqf1UNEy/uU
         doa8S2QWqbiweZW1ScSJhQKyowX9dJGR1FwunhG2Nawhy66KbpKGk0ouWTcwkeCD/e9o
         F/hnOgEz2STxO+xFM/4z1bmXAVruhjcKCHxm4=
Received: by 10.115.26.2 with SMTP id d2mr10065670waj.14.1259650535418;
        Mon, 30 Nov 2009 22:55:35 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3474092pzk.15.2009.11.30.22.55.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 22:55:35 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/2] Loongson: disable PAGE_SIZE_4KB
Date:   Tue,  1 Dec 2009 14:55:25 +0800
Message-Id: <1259650525-31884-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Currently, with PAGE_SIZE_4KB, the kernel for loongson will hang on:

Kernel panic - not syncing: Attempted to kill init!

The possible reason is the cache aliases problem:

Loongson 2F has 64kb, 4 way L1 Cache, the way size is 16kb, which is
bigger then 4kb. so, If using 4kb page size, there is cache aliases
problem(Documentation/cachetlb.txt), to avoid such problem, we may need
extra cache flushing. but with 16kb page size, there is no cache aliases
problem and no corresponding operations needed to cope with that
problem, so, it's better to disable 4kb page size directly before the
above problem is solved.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b03af82..8bf36d2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1510,6 +1510,7 @@ choice
 
 config PAGE_SIZE_4KB
 	bool "4kB"
+	depends on !CPU_LOONGSON2
 	help
 	 This option select the standard 4kB Linux page size.  On some
 	 R3000-family processors this is the only available page size.  Using
-- 
1.6.2.1

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 13:09:30 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:57136 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491825Ab0ENLJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 13:09:07 +0200
Received: by pxi1 with SMTP id 1so1300635pxi.36
        for <multiple recipients>; Fri, 14 May 2010 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=XdwDEiJB1OR8QQQP7z/6LGY0uLnjSJF+kxyFjiC3dfY=;
        b=fOB1YesY8gED21GtfJ6dqQ2wtN5wZn+dHE2PMD9qRsjx0kD8+fIO800HAUwNguBrS2
         u9QkxZPpaXI4SAuZ1itywS6/2TeAzb2yQyLFxKwkrPGQEO0R5OfahzBZqgz6AyGSkAK3
         wcsvANDPoueMgYHWguFJfkqgEjTGjQVJS4GfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uNsrczXRQrUf3r5am2BGqhYrFirLKfQy5/bWabFwF0pBetTCtRBBrIjCnPJCRzp9AA
         sPRjCNhu0Tqxw+6SOzZ1XNMIHqd8xMMuQ7R7Tny1z67UnKGmUzOadFVtKGMPabrql9ON
         SebnEkeA8ZWhcQAhWEs1RCddOCVK6auZNNjzw=
Received: by 10.114.87.17 with SMTP id k17mr987328wab.215.1273835338466;
        Fri, 14 May 2010 04:08:58 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id c14sm19145160waa.13.2010.05.14.04.08.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 04:08:58 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        David Daney <david.s.daney@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/9] tracing: MIPS: mcount.S: merge the same continuous #ifdefs
Date:   Fri, 14 May 2010 19:08:26 +0800
Message-Id: <6727e6718df351f8f74f55520d3f7b093f72b92a.1273834562.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1273834561.git.wuzhangjin@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26710
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

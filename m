Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:00:01 +0200 (CEST)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35537 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032394AbcEUL7ujsH8I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 13:59:50 +0200
Received: by mail-lf0-f66.google.com with SMTP id p10so3967448lfb.2;
        Sat, 21 May 2016 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ZSJeC09p6tlqWfgJ7UazU6pmyFsbglcnbv8wVM8+bO4=;
        b=LGVDX2E9ImY64IKYHdCPwN1F+2caXinUkCSwUEqc0FQYP3WuS2lKF7ivJft3AuNOze
         eJqh4Beiouyw9+o0rT5SVuVFurvEhYq1wM4A2xM+t02l+JEqv5BnUAo9RNofYafYKxT5
         LPsladxVYzgE5v0tVi5x4KjjirLICIaNTjwX3gIe2T8sSoNKNUs1FBW6mYyhYYcnuDUc
         3W2wlkXpsvFZhwxnZ4Qx+bCs6UwNqzhkIm/h3aqgF5RZZVghJvbCGWF8y31D+6sqS7/E
         N4QxP6KK/3hmBtJy3HI+lVJhM8Fkb6pU/2qFHVEJ8+/fo/w3bWQZ2kTL3FoaYfutyJcx
         bO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ZSJeC09p6tlqWfgJ7UazU6pmyFsbglcnbv8wVM8+bO4=;
        b=fa1BGUaipeqHp1yTRq7cZbcBiU/2rDrMi+TaWsMk2UnJyBOCVM72q9gh6llA9hGwh2
         b4696rJvrdrZa6TmZV8Q5QGv5BQAUBt8mizWfZKxfVWCVJhzZwJXGI0PqQPO/9nMtw5I
         xLxu4BIXmadRw5cjiN6mU7pGYtyWj17LPBtlq0TkJ2V2cxzNoBWIdNqj4MpgQtLT9Zgr
         dvW3p/9BdGMcY+3He5f48OekLFalsaG6SLsOieKYOnv9CCj9oEZLVzhqQq5I1w4NAtdJ
         +p35ruUr3b4LCN0r8a4/P4UBnr3r7XiTGAKQYBSWkmm/Pq+nZWHvmo1IJdqsZbOMWjJt
         9WWg==
X-Gm-Message-State: AOPr4FUzCF3HLR02xEzKPI4kG+ddrU25D6tY5/kDvFCAR7yQrg7ZyHOuycYtD1+vpBmSiQ==
X-Received: by 10.25.150.8 with SMTP id y8mr2673677lfd.163.1463831985365;
        Sat, 21 May 2016 04:59:45 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id h9sm4158319lfg.3.2016.05.21.04.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 04:59:43 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0180/1529] Fix typo
Date:   Sat, 21 May 2016 13:59:39 +0200
Message-Id: <20160521115939.9225-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/cobalt/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index 9a8c2fe..c136a18 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -42,8 +42,8 @@ const char *get_system_type(void)
 
 /*
  * Cobalt doesn't have PS/2 keyboard/mouse interfaces,
- * keyboard conntroller is never used.
- * Also PCI-ISA bridge DMA contoroller is never used.
+ * keyboard controller is never used.
+ * Also PCI-ISA bridge DMA controller is never used.
  */
 static struct resource cobalt_reserved_resources[] = {
 	{	/* dma1 */
-- 
2.8.2.534.g1f66975

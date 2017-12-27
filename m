Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 12:08:14 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:36081
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbdL0LIHmtIoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 12:08:07 +0100
Received: by mail-wm0-x242.google.com with SMTP id b76so38924227wmg.1;
        Wed, 27 Dec 2017 03:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AcKbrP3egxdDnfs24RPUz89WbnEB2bIB02HnlZnMxw8=;
        b=gIoMB0EAK04F/np//yYVubUAL6TergARfyIPlZSAW7lAaLzSXLJvKEMlFZYLo3R3Nt
         EvZ+uFj2ySR+raRHay/aodm3x3GWKPjy/XFioHc/dWnEiWop7Szr+sGp+LNjj4dJHKJ9
         Y3LTCX/oen2HMUcYSvzre6n2lVbP9/HOF+/lUlWe2dO/p58JD+xfE8j5X0JMSU1/zu2c
         k7VpkE/P5uwVZsFlIV4aTVVc5KxC0Zd6yOUvDmV30SYP5m8IfyTkAaT87ozr1wuxdzxn
         GZo/+USp2kR6Q1RAQMcvTAvMPGYEIcZoMhC4499w3zLcxsi5YW/YPr5RSFYrU9EoC5j1
         CueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AcKbrP3egxdDnfs24RPUz89WbnEB2bIB02HnlZnMxw8=;
        b=YYo6g1OKUqVqq/6VZSkfIhVy7RQndwaimiFW00ODTVBp+i1A99qK2iG7sXfG4eoiJc
         cBu0UwMHs+aFkgE47R9E/DIXVCDkbUxORYzFyY8eLaVDQhloV90OuJcG8GN3xdPvEO7D
         y6k1l80pdUNJrj78KHLKkekYYQX6Z2x33XPMnLj1zGw9kDig5PPngl2yIoWocuiFTSNX
         dDwYYTH/zNsfyCKJXIzBEgsWN3k2tOpCWJsE+YlSXTpGKAfUx/1bT/VIgdxHHDIAWgZQ
         sltzH15uXZwh6/x5qGilYm5y8WrklXHtbU9Tq7bPLlbnTzbbHCSllmU40t/dJBGj7LNU
         NUhg==
X-Gm-Message-State: AKGB3mIKUN6U6syQxJdQm58Wex0NZ3zJRAztpk8f8umxg+DMQU5Vb3ep
        dV7zl+nsolfuAjpqib1wdwA=
X-Google-Smtp-Source: ACJfBosgNrkkD85+ivrDNuTuc+LosypCcc00+kYQZzH0uNILHoD6djAuR4nRZrZPoSrPd5twh2G3BQ==
X-Received: by 10.28.184.144 with SMTP id i138mr25204487wmf.39.1514372882146;
        Wed, 27 Dec 2017 03:08:02 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id d7sm41523986wrd.54.2017.12.27.03.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 03:08:01 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id EA11F10C1B74; Wed, 27 Dec 2017 12:07:58 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: Use proper Return keyword
Date:   Wed, 27 Dec 2017 12:07:53 +0100
Message-Id: <20171227110755.25788-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171226105532.23452-1-malat@debian.org>
References: <20171226105532.23452-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

For reference:
* https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

Fix non-fatal warning:

arch/mips/kernel/branch.c:418: warning: Excess function parameter 'returns' description in '__compute_return_epc_for_insn'

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Actually use the correct keyword

 arch/mips/kernel/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index b79ed9af9886..e48f6c0a9e4a 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -399,7 +399,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
  *
  * @regs:	Pointer to pt_regs
  * @insn:	branch instruction to decode
- * @returns:	-EFAULT on error and forces SIGILL, and on success
+ * Return:	-EFAULT on error and forces SIGILL, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
  *
-- 
2.11.0

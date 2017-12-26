Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 12:38:31 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:41126
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdLZLiNK5TbK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 12:38:13 +0100
Received: by mail-wr0-x241.google.com with SMTP id p69so25565592wrb.8;
        Tue, 26 Dec 2017 03:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMUjSCsBMZt6tufLhTREbXkugsgOoaWz8c5niYjdD5Q=;
        b=W56vd8yWPu17X6EK5bfHVYSbUsJ7XnkBwTOTXhT8BdU+1PMZv8je7OEAQQ46lUJg6Z
         BIPgI9oRDpwmypj9zw9jLsF9ISPIzUKOwnOCl1QH2B3LMkVb+TDRF2WSeR6GJpxeNzIH
         n2C1ofh8U6Bk5IG3tg2+nY//gdvRNjJSu7duurv6L4kIM4AmL0vXN2MeXOKS2jO6bVZ0
         a4UiWd1Zyw7CslUeS3Q95z2eyUCz6WOD81+YBeOGgFdPw6j/ERIF0wwEbYKq9qxiXJLX
         3MqhIVph0QdbzdpLs3atfAdvKbLSdHUjbs7QIeI2uz2Bo4ju3pkOSq4HhyWJSoZ/N9IJ
         xXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lMUjSCsBMZt6tufLhTREbXkugsgOoaWz8c5niYjdD5Q=;
        b=Z3CMXQ0oGbakplQTSXT+aHh0NGGs+G74PdQxLg05G6tv13zM+k0uQJrc5kz9fZjiYV
         afW0rXGd9hbYf9D5fkpmQYOm/VEiewmCObnzKyR3ipC7o3PYwIYS5vBxAPDvY7n+iiKp
         upXfuogJ9qPlg56g9xCpZYEvWDA0zfvoIRi71wiyB3I0B14Ph6PpoLIg1/YEnVkqALTM
         LZEWq51It2ADYcx7tBm+DvG0eQnmIThVfXhWpfxY+DQ2+GNU6hdxIQDidg+xc38jf69/
         SKe4sG7bGsGYRqc0OX089PFgWrr+C+aaJqjU7Z4bs5tLJya4ibm2KffxY50BngMMm81G
         zFiA==
X-Gm-Message-State: AKGB3mIrQJBZHCVn3vuce5KNXYvKBA/W/g8fo5/Q+zlLbEPOU/dNzAtb
        rD+yOuiLPT3BPzt+XsA0VZk=
X-Google-Smtp-Source: ACJfBov6b8PT6K+O3L6QnD0f22pVrp1kjSXUgiFP8ya+nFNr7eW7A7QlxTCbn7JxCV747zPdw5lwkA==
X-Received: by 10.223.139.73 with SMTP id v9mr25648322wra.77.1514288287783;
        Tue, 26 Dec 2017 03:38:07 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id 127sm13786399wmk.14.2017.12.26.03.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Dec 2017 03:38:07 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D1D5010C1B2E; Tue, 26 Dec 2017 12:38:01 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: Remove a warning when PHYS_OFFSET is 0x0
Date:   Tue, 26 Dec 2017 12:37:14 +0100
Message-Id: <20171226113717.15074-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171226113717.15074-1-malat@debian.org>
References: <20171226113717.15074-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61597
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

Rewrite the comparison in `else if` statement, case where `min_low_pfn >
ARCH_PFN_OFFSET` has already been checked in the first `if` statement:

  if (min_low_pfn > ARCH_PFN_OFFSET) {

Fix non-fatal warning:

arch/mips/kernel/setup.c: In function ‘bootmem_init’:
arch/mips/kernel/setup.c:461:25: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  } else if (min_low_pfn < ARCH_PFN_OFFSET) {
                         ^

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f19d61224c71..073695ccc1aa 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -458,7 +458,7 @@ static void __init bootmem_init(void)
 		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
 			(min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
 			min_low_pfn - ARCH_PFN_OFFSET);
-	} else if (min_low_pfn < ARCH_PFN_OFFSET) {
+	} else if (ARCH_PFN_OFFSET - min_low_pfn > 0UL) {
 		pr_info("%lu free pages won't be used\n",
 			ARCH_PFN_OFFSET - min_low_pfn);
 	}
-- 
2.11.0

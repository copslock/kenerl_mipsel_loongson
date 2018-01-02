Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 19:52:49 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:41073
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeABSwnQ3gB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 19:52:43 +0100
Received: by mail-wm0-x241.google.com with SMTP id g75so63035512wme.0;
        Tue, 02 Jan 2018 10:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnCiy6CW7EhIJHKJLn7gKNTJV3qY33Eqr9Y+hRIiKcg=;
        b=Joap2VViucZx6hRn9wmNpgc4TbfwymcGBzO3vkesMKC2JSuZViZ0N9hts9mUoFzL8I
         VrOgKaaQ0c2Z2vTpsmuwTGrkIIrBtR7AWLb7u6OmGqq5fMPKqz1CwNSk7oftZ1yErDTu
         vyTuuC6HxkSaRzg0GOPsBnh4m0bwhJgG+x7vM3jO/cBR8P1WK0L7pTSiH5x8Ru42NLPB
         YuhrnL+nS5uB0T3xTsRRW7Trf3UNOs1UpGvfBWRqHWsp8CMrI08leKmhJuI6gpyOIgQl
         qj+3+1rJiHAw//DSm3F5IHj3evm2zX3kxJXZ0TmV9UjEcE7OJalJDDP57/XmDVvZDy07
         JnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LnCiy6CW7EhIJHKJLn7gKNTJV3qY33Eqr9Y+hRIiKcg=;
        b=nQzmvKkNaDg0TeXOjx1gcTp5/DIBdWNMvnlx+RtoOIEGnVmluxxroCktVytGVY4ABM
         yviuMpKu6ERVqIL/SrhvLYeOkaj2PucOMpXzCWR+xobeCc2IcyckKpDq1snq2Le57VgQ
         xccFDjj6VxC7DZZ9AuR+9EilZcHz6RyK9NC2j9hEdwnCLF/K4XJIM+XspQHE/gTWLqBt
         OxLsItfo/67EBZ1A15LVf6TNWhswijMS9sbc+lAqe7bgk/sTcmx66NcvzoyFzCCSgEM7
         CxH80k6CKNbYFYk8fQ4geLwgh2yFJwcFVlC7Yw+RiEa9w+Ra2Gl9GYD40r//OtAVrxwJ
         dH5A==
X-Gm-Message-State: AKGB3mLIAsnKCQBjNiVvTH98imIkkHx8HBRdgNTzgB5UW5yMmXR/L3PJ
        vL9BjdOmlq6a+1dZ84yrRuc=
X-Google-Smtp-Source: ACJfBoudRZ59Acc5pr50dO6JXCAZd6WOBibwKYdyDOTpXADy9etc+eBZYjxZ3tnhZUgspK+itD1Glg==
X-Received: by 10.28.227.132 with SMTP id a126mr4041946wmh.41.1514919157651;
        Tue, 02 Jan 2018 10:52:37 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id n33sm10357805wrn.76.2018.01.02.10.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 10:52:36 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9349510C2747; Tue,  2 Jan 2018 19:52:35 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MIPS: Make declaration for function `memory_region_available` static
Date:   Tue,  2 Jan 2018 19:52:21 +0100
Message-Id: <20180102185222.9111-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171226113717.15074-1-malat@debian.org>
References: <20171226113717.15074-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61863
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

Fix non-fatal warning during compilation using W=1:

arch/mips/kernel/setup.c:158:13: warning: no previous prototype for ‘memory_region_available’ [-Wmissing-prototypes]
 bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
             ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Prefer static declaration, clarify W=1 in commit message
 arch/mips/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f19d61224c71..68db4bdd3255 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -155,7 +155,8 @@ void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_add
 	add_memory_region(start, size, BOOT_MEM_RAM);
 }
 
-bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
+static bool __init __maybe_unused memory_region_available(phys_addr_t start,
+	phys_addr_t size)
 {
 	int i;
 	bool in_ram = false, free = true;
-- 
2.11.0

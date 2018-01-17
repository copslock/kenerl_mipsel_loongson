Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 12:32:34 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:35821
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991172AbeAQLc0z95qU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 12:32:26 +0100
Received: by mail-wr0-x244.google.com with SMTP id g38so15278631wrd.2;
        Wed, 17 Jan 2018 03:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=IBvWGulZaa87PCsta/V6fTbzQIYFdhyVbXMkQ/qWQjs=;
        b=VLg5hEqLWduh27WHhnmdXDVQ8uoNe/0L3HjiZDW+wZTzTAAyufEZ/O04i2faHLAFFK
         hInCymCW9MDw3gj/pvp7N+gllQxPz/s1BwRwGxDVbFubtcGMR0bBFKDxSSS8wEDFFOgo
         y6Gc7RrW0JRp5C0C5MurtGj9d+U24moe37cZt5K3Hn9vr74FJCVxybW2Iwhc0mPokJWG
         4PSMmRK/Sq10JrcT5/g7RvN2oYfGcr2hiMIhNQUi8tt7CaeCKZl3M4k4vMFPYwUd1gba
         DZcGDciSiEvAKFjpXCO668F24qtsSqfdjwGmXVT40uD9pAhqjC9+oVnfR6pEWQ2epHXt
         3nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=IBvWGulZaa87PCsta/V6fTbzQIYFdhyVbXMkQ/qWQjs=;
        b=a8jiIBydOTfSuptrrwPbOmmVfY8IPS7qTYhtIPtNO12RVbb3PToDhzLViaJJ4SWIQP
         bwnfo596JmLDPbRlYyGdrmyTc04+m6zL/vtocdGocEWIp50+3G8w9KZFoZ4yrTxihJYu
         TWAyuZWJmQgdZo5PaXwNHQd41Fu4AvHUbWdpO/9BFrJe8FbbeSZqNtCB+4Su/l1qfl41
         e9bKduCJtNU89gig2IJJQKYkXAsnafAP4UVyx7GiznBnO96lGZwn2Lzko+sJ39y2vIZ3
         RsDA3XxD/IXYf5siAYLsDTOGHmMi4f0/GggRK09IWy077KGHT6LxoeRneYDjJlEmigFE
         4uoA==
X-Gm-Message-State: AKwxytdRDIi9ayYn7OeJpsJ8BTwSgHKZAnOjP7/2mWbE1tDfqd3x1HxK
        h1qV0pDbtk3SGooRd+vUK1A=
X-Google-Smtp-Source: ACJfBouJpxL/HHyv/Z4kyiD4Lc6vNd2rHoBWnhg8lbe5aHOE581qVwlGWX4RjEvEIswd6raK7PXLeA==
X-Received: by 10.223.178.26 with SMTP id u26mr2224950wra.149.1516188741388;
        Wed, 17 Jan 2018 03:32:21 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id a34sm7126307wra.18.2018.01.17.03.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jan 2018 03:32:20 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 766FB10C2EA9; Wed, 17 Jan 2018 12:32:19 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ftrace: Remove pointer comparison to 0 in prepare_ftrace_return
Date:   Wed, 17 Jan 2018 12:31:57 +0100
Message-Id: <20180117113157.25768-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62199
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

Replace pointer comparison to 0 with NULL in prepare_ftrace_return
to improve code readability. Identified with coccinelle script
'badzero.cocci'.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 99285be0e088..7f3dfdbc3657 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -361,7 +361,7 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	 * If fails when getting the stack address of the non-leaf function's
 	 * ra, stop function graph tracer and return
 	 */
-	if (parent_ra_addr == 0)
+	if (parent_ra_addr == NULL)
 		goto out;
 #endif
 	/* *parent_ra_addr = return_hooker; */
-- 
2.11.0

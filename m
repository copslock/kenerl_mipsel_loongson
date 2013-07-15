Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jul 2013 00:17:34 +0200 (CEST)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34990 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827451Ab3GOWRdYD5uK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jul 2013 00:17:33 +0200
Received: by mail-pb0-f54.google.com with SMTP id ro2so11740610pbb.41
        for <multiple recipients>; Mon, 15 Jul 2013 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GXVTnnwx1yOF7MV9q5uX3SuNj8MEe1hO7mc87Hj39Do=;
        b=aj++0CEFDeiHcTzocnD6xlPVVr5x6Ib5/9b8L1p7VkN3jkUlK+5UjoWVZ7jj58FKl2
         zADjzv578Om87dT4/kexHvmCpU2NW2UV6iZ8s66FXCQZW8UFhxptO+oYdkVyYkdQy6Gd
         0g1ZPMlr1SH9b5B3BfVfGYYpt9S6xBGQAOtfXkRNZjORorb3w4wcxgQoIwMwXR5MNzuP
         6PpL+ujgvnt9LIF90NszJkkVOfu/ZHR9nu1S+pgGb2stB5s9VIeWwmE6zst2ZwVV9Jxi
         bqQzm1bTzKar8xtWs1oX+HGZWGDpGDXFFKeWIpCMrsHoXymkbmD//rImAYuw5rlLJBK7
         ylnw==
X-Received: by 10.66.193.166 with SMTP id hp6mr57635497pac.118.1373926646887;
        Mon, 15 Jul 2013 15:17:26 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id mr3sm62883049pbb.27.2013.07.15.15.17.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 15:17:25 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6FMHOa8024660;
        Mon, 15 Jul 2013 15:17:24 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6FMHNHR024659;
        Mon, 15 Jul 2013 15:17:23 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Corey Minyard <cminyard@mvista.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] mips/ftrace: Fix function tracing return address to match
Date:   Mon, 15 Jul 2013 15:17:17 -0700
Message-Id: <1373926637-24627-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: Corey Minyard <cminyard@mvista.com>

Dynamic function tracing was not working on MIPS.  When doing dynamic
tracing, the tracer attempts to match up the passed in address with
the one the compiler creates in the mcount tables.  The MIPS code was
passing in the return address from the tracing function call, but the
compiler tables were the address of the function call.  So they
wouldn't match.

Just subtracting 8 from the return address will give the address of
the function call.  Easy enough.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
[david.daney@cavium.com: Adjusted code comment and patch Subject.]
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/mcount.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index a03e93c..539b629 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -83,7 +83,7 @@ _mcount:
 	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
 #endif
 
-	move	a0, ra		/* arg1: self return address */
+	PTR_SUBU a0, ra, 8	/* arg1: self address */
 	.globl ftrace_call
 ftrace_call:
 	nop	/* a placeholder for the call to a real tracing function */
-- 
1.7.11.7

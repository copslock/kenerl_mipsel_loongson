Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 01:19:58 +0200 (CEST)
Received: from mail-ea0-f176.google.com ([209.85.215.176]:41618 "EHLO
        mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834988Ab3FMXT4p3KFU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 01:19:56 +0200
Received: by mail-ea0-f176.google.com with SMTP id z15so5078694ead.7
        for <linux-mips@linux-mips.org>; Thu, 13 Jun 2013 16:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=2VW5kVPVm9rU6Wi08nuMmVRkQUhwL4iD4zQsHF+gjbI=;
        b=Td7MHwKQbgxffWHUJRKxi8IEJbkqehYBLBZ3QG9DUNoDbOjQSTA2Wnrd6Fg2Czwkqz
         YbUffb2fyYq9R4wOoRJvVkaN9kV9SQSPrpOzRS24LtD4972gXSoUBJRnhO9WjAfz1hOw
         TAxLo+WwzgIsbSenbSKGD4YxLEthP87MxNX3xSh+x0Nm/fTT/AinAKNgK/CMyzt8Tsx6
         HA3F9IxePv6eHXmnJUvOmtbotYmTXGGsSmWkys3T5GDBruptqK/ycY9/k88hX+WSaqyR
         xiQD/ZxItuCv8eSEfHbjD7wAsPJv5b3Dkz/3T5zD2F0MYcupqPZCPNSeXe4gVAVXbg3s
         rIWQ==
X-Received: by 10.15.86.74 with SMTP id h50mr3528789eez.97.1371165590547;
        Thu, 13 Jun 2013 16:19:50 -0700 (PDT)
Received: from localhost (host86-139-128-71.range86-139.btcentralplus.com. [86.139.128.71])
        by mx.google.com with ESMTPSA id s8sm46841227eeo.4.2013.06.13.16.19.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 16:19:49 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 9F3243E078E; Fri, 14 Jun 2013 00:19:47 +0100 (BST)
From:   Grant Likely <grant.likely@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] irqdomain: Remove temporary MIPS workaround code
Date:   Fri, 14 Jun 2013 00:19:43 +0100
Message-Id: <1371165583-21907-1-git-send-email-grant.likely@linaro.org>
X-Mailer: git-send-email 1.8.1.2
X-Gm-Message-State: ALoCoQmqcn/KvSpnKThBiI15uIBYp58Qthn6WfoAXqKXWoN4s0VQIA0KaUGq8ryy11XPWReLaw39
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

The MIPS interrupt controllers are all registering their own irq_domains
now. Drop the MIPS specific code because it is no longer needed.

Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

Ralf, this should be okay to pull out now. I'll be submitting it for
v3.11 unless someone yells. Even if so, all the irqdomain infrastructure
is in place to make it trivial to add an irqdomain where missing.

g.

 kernel/irq/irqdomain.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 13f2654..e0c3366 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -475,18 +475,6 @@ unsigned int irq_create_of_mapping(struct device_node *controller,
 
 	domain = controller ? irq_find_host(controller) : irq_default_domain;
 	if (!domain) {
-#ifdef CONFIG_MIPS
-		/*
-		 * Workaround to avoid breaking interrupt controller drivers
-		 * that don't yet register an irq_domain.  This is temporary
-		 * code. ~~~gcl, Feb 24, 2012
-		 *
-		 * Scheduled for removal in Linux v3.6.  That should be enough
-		 * time.
-		 */
-		if (intsize > 0)
-			return intspec[0];
-#endif
 		pr_warn("no irq domain found for %s !\n",
 			of_node_full_name(controller));
 		return 0;
-- 
1.8.1.2

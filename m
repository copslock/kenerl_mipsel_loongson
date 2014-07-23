Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:46:15 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63929 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842523AbaGWNnYlVeut (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:43:24 +0200
Received: by mail-wi0-f171.google.com with SMTP id hi2so7860256wib.4
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gBsFtnP9FWNCWTEHhIAXld8bsO+eHPeGlmnehdpXpVU=;
        b=dqqQxFQJPlfw3wWYfhU+aRuWce9PFmp5E2F/vuNcyr45XX3vEJau/eNcRm8DULvAJs
         mDxO84E7iOY81gcXH8ub+U2xS3nuhNwmTQhItfbbU9QqQCfNnotnUzElOL2Fl6Q1xRVh
         DIu0T7l19YpxBMG2MGk6mUfPLGFiwKouMeypOtYZOGjxaXBtaPaGqv00RnVr08r0Cx3L
         BQ/jVn4PepK68qHOyRSLzF966U2VJLGXyF8JWpdzTWaL8djZiKC6QYUUA8uO4y3nH5lo
         tl/BLm0ubzMsFozWi1G/wNN+xoiTxq+jbaGgkUVwvwCzXdRtzkSfpwvB/R6rKKLoiPKm
         X15Q==
X-Gm-Message-State: ALoCoQnZXqfyYSZFMLh9ipnTQRURxXXMAM44IutHQX/06ud8D+9+doqAwSAE5e1Twbsc3ZkP7e6V
X-Received: by 10.194.185.238 with SMTP id ff14mr2018056wjc.9.1406122998926;
        Wed, 23 Jul 2014 06:43:18 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.43.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:43:18 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>
Subject: [PATCH 07/11] MIPS: O32/32-bit: Remove outdated comment
Date:   Wed, 23 Jul 2014 14:40:12 +0100
Message-Id: <1406122816-2424-8-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

A comment in the O32/32-bit system call code is incorrect since commit
46e12c07b3b9 ("MIPS: O32 / 32-bit: Always copy 4 stack arguments.").
Remove it.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
---
 arch/mips/kernel/scall32-o32.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 3245474..63e8925 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -67,8 +67,6 @@ NESTED(handle_sys, PT_SIZE, sp)
 
 	/*
 	 * Ok, copy the args from the luser stack to the kernel stack.
-	 * t3 is the precomputed number of instruction bytes needed to
-	 * load or store arguments 6-8.
 	 */
 
 	.set    push
-- 
1.9.1

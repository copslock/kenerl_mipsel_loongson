Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:06:09 +0200 (CEST)
Received: from mail-lb0-f193.google.com ([209.85.217.193]:34277 "EHLO
        mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032477AbcEUMCGvE6mI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:02:06 +0200
Received: by mail-lb0-f193.google.com with SMTP id t6so61196lbv.1;
        Sat, 21 May 2016 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=w8MOzMnSs/ZhY3F36NHfkprSiudtENQw4zYQDf4jHxs=;
        b=ZQQQwosW2dzBIx8wOTChEOSHO1ZlQ4Aln5VknDly0Y0DpoaVGdcnFzjGNAmzJQShPR
         M5iBH6pVBnrjJIuOSqIpmVtqhwv26zn5EqXu/j3kCPRI7qd0AERnO/WpX/tWcecIiWWB
         krThIj/tjYOipVbgBjhjEIbv6cdScnoLAIt9bVxWwICOY3QOkz17A4iRUUl/+bWigRkf
         DS+R/z+e4ZIj8l7fpzl/FGJzHa8Y5AuZKZ4coJ5snYy4buvzGOCdnuml7byT0HfY2nAs
         q7jIJxGbhFlSAp9N1F5EVznWpMGn9ErbHQpv+DBjDrN6Xj8hCswaSf0AxbgBwMAjIdqo
         s7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=w8MOzMnSs/ZhY3F36NHfkprSiudtENQw4zYQDf4jHxs=;
        b=XghtNLe7atYIyK2vrJuHi1tdgfRJDgJUtFmR8DLp3nwE0BSgvO5uqvTfFiGqOQrss8
         xY4bv/zCrWrT3u0ro0nYWMegdNEUMZl0V8+HAV6HebrJCrizq1XeZsqzovZKOdkUFfSR
         Zs2N9ohkN6TFI6rvdncnbxkRuMkyfX767LqqL2cy48sAB0kkBhvImGiAsZcQT3L9UvI3
         ZJtCosNsXWdY74S8YqB78z2gl8cG7VfAMpFCsVcDlGHoArMbzoFC27K2gpWAiVvqp04W
         67cxoMHlY5lAzbCR2QqqJN6lWjjREoQcS/xyQHttO6kQfF6lOpl3edWSBkPSXJxeO2UD
         dWWw==
X-Gm-Message-State: AOPr4FXSTZhxKStojOpf9KRhk0rhrBHQ4vmStaIVt1l00da7ZxJrwpwu+/mFGiRYE6oacQ==
X-Received: by 10.112.133.1 with SMTP id oy1mr2378494lbb.79.1463832121550;
        Sat, 21 May 2016 05:02:01 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id t11sm4136285lfd.20.2016.05.21.05.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:02:00 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, rric@kernel.org, ralf@linux-mips.org,
        oprofile-list@lists.sf.net, linux-mips@linux-mips.org
Subject: [PATCH 0198/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:57 +0200
Message-Id: <20160521120157.10249-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53596
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
 arch/mips/oprofile/op_impl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/oprofile/op_impl.h b/arch/mips/oprofile/op_impl.h
index 7c2da27..a4e758a 100644
--- a/arch/mips/oprofile/op_impl.h
+++ b/arch/mips/oprofile/op_impl.h
@@ -24,7 +24,7 @@ struct op_counter_config {
 	unsigned long unit_mask;
 };
 
-/* Per-architecture configury and hooks.  */
+/* Per-architecture configure and hooks.  */
 struct op_mips_model {
 	void (*reg_setup) (struct op_counter_config *);
 	void (*cpu_setup) (void *dummy);
-- 
2.8.2.534.g1f66975

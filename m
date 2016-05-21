Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:02:29 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35678 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032437AbcEUMAm4M0sI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:42 +0200
Received: by mail-lf0-f67.google.com with SMTP id p10so3968347lfb.2;
        Sat, 21 May 2016 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fRhtpSaq1fbTHWOT3NgJRG3nXVmFwXByUXTepK2uDMA=;
        b=Lw/edJRU+J2W8B1kptALwbLs0t/nPsKCzrEVgpiDT6WjhXneWQkzsS2nVYo+JfK9h4
         PYWmsXeJFzjrtN++rdEnzwMyFy6wgXfUi9xtHUbwUjMcSaN1mHxhaBJ1Nq4P5T40Fi/z
         nT/wPKb635rwdXFIm0RkuK5GiVFqv6fYYHa2WYC8cjQNqQW+3HAJqL3rDx8ERlrL4btE
         8BMoy5s4KOdh3iKV0KIc1KswW+I8xgegFgKfiFQBuzdJHQ8WZa3s/uXPjhuwunUDDvr/
         E259EEYyfDct3H4c+FWvNHBHPlW4KYfqIBzKbz+xXe7wSPVQ8+AbNU2k7g2NKftvmE0J
         IeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fRhtpSaq1fbTHWOT3NgJRG3nXVmFwXByUXTepK2uDMA=;
        b=jh9tk5zipEuH490mOBeHOg/2UNbTYWscDKdXZ5ULYpjm1qKrg7/txe330VbDlXcrP6
         MjK0KUlUfCbCjrJZnYw/M//oYWPTq6NCeuXnAE3gP5YKwFzbUrttprXobNLF6/0NKuMa
         zLd3fg6SWodfOtzW2/0U+y+A21yUlrP0VxCWuS15EkcUyd5QN9zdMOwsh7EhALhJv0aW
         j5xGQFnlWEeQGXhmtCB0dx2D3b5hRI7B1uRKmI2d/g9yIcmlxq9JXBAfwAdgunnsiAfJ
         yqGSTdun+Ean8OPxw9zN2JWTgQQUe55XDQyvSo45FOUG27mO0Td8yWXCqecKEWKjGcf6
         M7YA==
X-Gm-Message-State: AOPr4FWGDc0CG5VHCeJsdUTIELwKzTspAO9T8BXNjmcdzt2jYyyI/Hg+ZKvLlcwADf6YaA==
X-Received: by 10.25.148.16 with SMTP id w16mr2693471lfd.40.1463832037636;
        Sat, 21 May 2016 05:00:37 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id h18sm1984099lbb.8.2016.05.21.05.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:36 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0187/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:33 +0200
Message-Id: <20160521120033.9598-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53585
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
 arch/mips/include/asm/mips_mt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips_mt.h b/arch/mips/include/asm/mips_mt.h
index f6ba004..aa4cca0 100644
--- a/arch/mips/include/asm/mips_mt.h
+++ b/arch/mips/include/asm/mips_mt.h
@@ -1,5 +1,5 @@
 /*
- * Definitions and decalrations for MIPS MT support that are common between
+ * Definitions and declarations for MIPS MT support that are common between
  * the VSMP, and AP/SP kernel models.
  */
 #ifndef __ASM_MIPS_MT_H
-- 
2.8.2.534.g1f66975

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:03:30 +0200 (CEST)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35726 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032448AbcEUMBFPfWyI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:01:05 +0200
Received: by mail-lf0-f66.google.com with SMTP id p10so3968827lfb.2;
        Sat, 21 May 2016 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FBrw4C64JD8eeo4v8BzkTeNxGJKLpX8s7oOB9gLfK+0=;
        b=S+rUcKDZlJgHGsHz33DedKv45BziUdxBDgzkwcxFudWhTzUTjptlZZRkB020Spq/k3
         sFjtZsM5DxgJsD3oHwe5ufM4ZnHFPdGBNB4t7tiJnwZNzJY8iaFI6XDV243lfy/wHyC4
         cIebNZNGVCHr7nv8Jkprowfya+vm68MqKFE1cINCMaM6vk7ncpX86gtztI3Y7f4SL8l/
         kD1uFHxd6pn4wd4bXDDmVlS6MRdT9TTcR17sU5SXwof7iuDJc8VaOfB7fmT4BQWImFdX
         8cLtDXDAZmkalw5c3ZecMwogEawEPTeBIPNyz2nrLR1gtf+nb0idwQjHmH2Jy5JV1HP5
         yqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=FBrw4C64JD8eeo4v8BzkTeNxGJKLpX8s7oOB9gLfK+0=;
        b=A8btaLd6nDiQRBwED23Lr9JVvKehSHKnWGvlaH+qSIw7JRAqRxJAIe5fkld3shA8AC
         6oEy+forz2MK5kqvIl9XXYNwEXmXnIC0d/Og4vR1xk0cf6LNKZFk1Va3ZctuUnayda/B
         vn3sykaeyG4KuUHTFWAYZgtQxRQ8YI5kFzkZno+jV1pPE+wCFeTDVrci5ymf6fx+wIUL
         PpEFjvbjAR4a0/M0OgMVKzdS30/7i+XkUhMsbFCeXz+mRnlwzR1OSdhOIFIstAuX+4eV
         B0wnKCjNQz72tqlAGmWgLNCvYx/3hvNFocCLY6n9JD6zwal9Xmz9K/FnjnUwCE5Bh6O1
         m3bA==
X-Gm-Message-State: AOPr4FVSZB9ditJGXYrznlGioCx+3pECBqJ0MUxo4KX0YUzUTB8F+t32wz8ITbde/RIaJg==
X-Received: by 10.25.134.138 with SMTP id i132mr2736243lfd.70.1463832059931;
        Sat, 21 May 2016 05:00:59 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id d63sm2625048lfb.48.2016.05.21.05.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:58 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0190/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:56 +0200
Message-Id: <20160521120056.9766-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53588
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
 arch/mips/include/asm/octeon/cvmx-ipd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ipd.h b/arch/mips/include/asm/octeon/cvmx-ipd.h
index e13490e..cbdc14b 100644
--- a/arch/mips/include/asm/octeon/cvmx-ipd.h
+++ b/arch/mips/include/asm/octeon/cvmx-ipd.h
@@ -39,7 +39,7 @@
 
 enum cvmx_ipd_mode {
    CVMX_IPD_OPC_MODE_STT = 0LL,	  /* All blocks DRAM, not cached in L2 */
-   CVMX_IPD_OPC_MODE_STF = 1LL,	  /* All bloccks into  L2 */
+   CVMX_IPD_OPC_MODE_STF = 1LL,	  /* All blocks into  L2 */
    CVMX_IPD_OPC_MODE_STF1_STT = 2LL,   /* 1st block L2, rest DRAM */
    CVMX_IPD_OPC_MODE_STF2_STT = 3LL    /* 1st, 2nd blocks L2, rest DRAM */
 };
-- 
2.8.2.534.g1f66975

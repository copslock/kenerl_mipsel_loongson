Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 14:09:06 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35073 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012303AbaJ3NIS63xxw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 14:08:18 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so5141691pdj.12
        for <multiple recipients>; Thu, 30 Oct 2014 06:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSHsmmWomp6CJuXiwrP00vbrLgV/GPnpswz8bQ5D+es=;
        b=m4+q2MhTxFs14joFnujiCeDnBuf1w8ITuEEFEh5vvNfBInFV4wWoIardYIttmMVh70
         nyj2WZrcB963I8P1KpXR7K1B3IiEu/yL6AWSyq3QwnWgT69eD86XLbDTZwJMGWuRwP7m
         Yj16w4aqxWQ7YL6w4py5BIUUAg2z0I9bndfrWB+jTui2+6qXeNv82rBsWxHPJh804TTq
         lpPHQOtCkQBtqMGZkKmDJWShwambl+hHEoNNoyNR+XL7IcI8cEZGdKNj0bGwyQ3M4RXL
         tT+wVw5Igv6+QoLce+LVUUClUwXWVNWGRVJAowNOAnZYg0K2VR9ywZjRSD+GoJ5DTs6s
         vCqg==
X-Received: by 10.67.22.1 with SMTP id ho1mr17977810pad.4.1414674492371;
        Thu, 30 Oct 2014 06:08:12 -0700 (PDT)
Received: from localhost.localdomain (p76ecb424.tokynt01.ap.so-net.ne.jp. [118.236.180.36])
        by mx.google.com with ESMTPSA id gy10sm4284525pbd.67.2014.10.30.06.08.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Oct 2014 06:08:11 -0700 (PDT)
From:   Isamu Mogi <isamu@leafytree.jp>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        isamu@leafytree.jp
Subject: [PATCH v2 3/3] MIPS: R3000: Remove redundant parentheses
Date:   Thu, 30 Oct 2014 22:07:38 +0900
Message-Id: <1414674458-7583-4-git-send-email-isamu@leafytree.jp>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
References: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
 <1414674458-7583-1-git-send-email-isamu@leafytree.jp>
Return-Path: <wiz.saturday@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: isamu@leafytree.jp
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

Signed-off-by: Isamu Mogi <isamu@leafytree.jp>
---
 arch/mips/lib/r3k_dump_tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lib/r3k_dump_tlb.c b/arch/mips/lib/r3k_dump_tlb.c
index c97bb70..975a138 100644
--- a/arch/mips/lib/r3k_dump_tlb.c
+++ b/arch/mips/lib/r3k_dump_tlb.c
@@ -44,7 +44,7 @@ static void dump_tlb(int first, int last)
 
 			printk("va=%08lx asid=%08lx"
 			       "  [pa=%06lx n=%d d=%d v=%d g=%d]",
-			       (entryhi & PAGE_MASK),
+			       entryhi & PAGE_MASK,
 			       entryhi & ASID_MASK,
 			       entrylo0 & PAGE_MASK,
 			       (entrylo0 & (1 << 11)) ? 1 : 0,
-- 
1.9.1

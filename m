Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2011 13:29:35 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:37325 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491119Ab1G1L2y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jul 2011 13:28:54 +0200
Received: by yxj20 with SMTP id 20so1609898yxj.36
        for <linux-mips@linux-mips.org>; Thu, 28 Jul 2011 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=iNWr+VeF3/fCi4ihx2BkN0oSjGrbBHQm99vEIfYTLJE=;
        b=fWgNZpS3mib5O8fkqP5fJ3uC1CKYhVuvGbKRkYHyVB580LcIhpz7RSRHoKsMa3SsLG
         YVQtcRZDonVOKDtb1q3pfEM5alM4v1BXheBKFFgiGHN+QPMXrdM5V8sN0xrDV5pifEZs
         mq7GN0hGgOD7ZG4KUexCutl4AIhFplwJN4EAQ=
Received: by 10.91.163.20 with SMTP id q20mr596046ago.169.1311852528065;
        Thu, 28 Jul 2011 04:28:48 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id p6sm678491ank.28.2011.07.28.04.28.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 04:28:47 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Subject: [PATCH 2/2] kernel/resource: enrich the comment for insert_resource_conflict()
Date:   Thu, 28 Jul 2011 19:28:32 +0800
Message-Id: <1311852512-7340-3-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 30754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20661

It helps people better understand how this function works.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 kernel/resource.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 3ff4017..5406ecf 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -617,7 +617,9 @@ static struct resource * __insert_resource(struct resource *parent, struct resou
  * happens. If a conflict happens, and the conflicting resources
  * entirely fit within the range of the new resource, then the new
  * resource is inserted and the conflicting resources become children of
- * the new resource.
+ * the new resource. Also, if the new resource entirely fits within the range
+ * of a conflicting resource without overlapping the latter's children, then
+ * the new resource is inserted too and becomes a child of the conflicting one.
  */
 struct resource *insert_resource_conflict(struct resource *parent, struct resource *new)
 {
-- 
1.7.1

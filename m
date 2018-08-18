Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2018 04:14:09 +0200 (CEST)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:41236
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990396AbeHRCOGmyTn- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2018 04:14:06 +0200
Received: by mail-pl0-x243.google.com with SMTP id p4-v6so921428pll.8
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2018 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=PkbkoAS4UFzOE+Bd4rNwyF/wgp6ovrylOkIZMdgBFmU=;
        b=bBq4VXIaEqEUzP0Qbbs03EjMuXbTZeH8seS+Ht9rsPkOIMB3GzJvhHP6SJDi+CDDqS
         MFXb5bTaX4+cGy9IAifGoO6RAfjcTFqonxMAERwjbm3adRirofv5wxuBAhIbFV8tByKW
         h2/ExjO22C7E6IXlVlnnF1y+qQvQnxBII+ddY+UybS/Rmt8iVEauAPgfuFA2N9j+e3j7
         lV/1NflwGlkNwuQ6iyb9E7dBTGgArujchtYeOTSOJ8ueBOMbCyNaODujM0JSkNZpG0yP
         /kcmz/XivwYDgRnUEHb5KWHOeuG5JL4P1kAitA49HUcHQn4s7qKSWqjDeY5wRKl26RZF
         0zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=PkbkoAS4UFzOE+Bd4rNwyF/wgp6ovrylOkIZMdgBFmU=;
        b=mWOxuFsYZ+4mOBS2G1OYw/xNlSdqCSKQHokVNOD8bQfqvBItYP9/e8iqKjte+s8E3L
         kJxNTxb7XzmUr6BLzIpzcsinVV2448NXJoTdz0inshl+Wofbozcq0kxZKWyq+n5mWCBa
         hWP+lelD1+6AygTUjH7IjWzYlS++mICPnVOisjZUzQRZeBBY2fpnbujxp0KwuphXZXhy
         V4DjU7ugonjTemg5FG5rPqixAYLzEDGa0RHmwxK/xC6xP/e+1ITz/aF0oaDdVmcABxnx
         QIHZP3+O/LADkilG+cEu5kzjohqHaTAzKjbqT1zZdM6C62o62J0APAUIcrDxhXaDkbvP
         2MEQ==
X-Gm-Message-State: AOUpUlHZMW2mjdJosgHZiak9x7Sjec15bvSYMxmlPh6/x/V+tOURAuMy
        v+6HzY86uS6cdoi9trjNowxvHh312IatLw==
X-Google-Smtp-Source: AA+uWPzeidrZ1aFgeXmWhoSZZ8tXEJYHYvjjdH5LM25Mop+6MaCTjJNjMR0TA/nubtMhyHd9lERoMw==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12-v6mr6935662plb.339.1534558439439;
        Fri, 17 Aug 2018 19:13:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:1501:200:5efe:a66f:53fa])
        by smtp.gmail.com with ESMTPSA id g7-v6sm3589661pfi.175.2018.08.17.19.13.57
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 19:13:58 -0700 (PDT)
From:   Jiecheng Wu <jasonwood2031@gmail.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] msi-xlp.c: fix missing return value check of kzalloc()
Date:   Sat, 18 Aug 2018 10:13:48 +0800
Message-Id: <20180818021348.4344-1-jasonwood2031@gmail.com>
X-Mailer: git-send-email 2.14.3.windows.1
Return-Path: <jasonwood2031@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jasonwood2031@gmail.com
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

Function xlp_init_node_msi_irqs() defined in arch/mips/pci/msi-xlp.c calls kzalloc() to allocate memory for struct xlp_msi_data which is dereferenced immediately. As kzalloc() may return NULL on failure, this code piece may cause NULL pointer dereference bug.
---
 arch/mips/pci/msi-xlp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
index bb14335..c03bce1 100644
--- a/arch/mips/pci/msi-xlp.c
+++ b/arch/mips/pci/msi-xlp.c
@@ -474,6 +474,8 @@ void __init xlp_init_node_msi_irqs(int node, int link)
 
 	/* Alloc an MSI block for the link */
 	md = kzalloc(sizeof(*md), GFP_KERNEL);
+	if (!md)
+		return;
 	spin_lock_init(&md->msi_lock);
 	md->msi_enabled_mask = 0;
 	md->msi_alloc_mask = 0;
-- 
2.6.4

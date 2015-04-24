Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2015 19:29:11 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33841 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012144AbbDXR3KIb4ss (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2015 19:29:10 +0200
Received: by pdbqa5 with SMTP id qa5so54496267pdb.1;
        Fri, 24 Apr 2015 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sEleGoKw8SenpXfpprixqnwS9DfAXF4/VtbPXoOxQqY=;
        b=RPJGF5uC6u8HOWjcQxsVWV0XGhoYh6SlaGmNCrjXGUNJHBEKGg+JXwm4P080v3m7vB
         mO+coyU3JkPpBMYl7kQCPoW9ZisgSTszK51hokVR7J3gVZErlFPh89FRSTNnKHaT94B8
         2tQcQSlP4OF17u3BL7kj8RmDgnDL/oDj8ihHQDVcsyAPuhFmY25tzoN05yXLj22GqHZq
         Bk3IxGvD9p8ym37zGSfgoYAi1knegGQgTqBQ9YXT/pd7EKxWSdBdloX0Q1E4BcciKtV8
         r7C8cFywIQaMAKRFhbiZR5TF0NKsvUpGrVCjbx7Cz6Sg+eqURLKKsytGhklvmDo5+aho
         waiw==
X-Received: by 10.70.24.130 with SMTP id u2mr8183714pdf.147.1429896545612;
        Fri, 24 Apr 2015 10:29:05 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id sw4sm11625530pbc.64.2015.04.24.10.29.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Apr 2015 10:29:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org, mmarek@suse.cz,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] gitignore: Add MIPS vmlinux.32 to the list
Date:   Fri, 24 Apr 2015 10:27:40 -0700
Message-Id: <1429896460-15026-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

MIPS64 kernels builds will produce a vmlinux.32 kernel image for
compatibility, ignore them.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index acb6afe6b7a3..6c7ca7a2d52e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -43,6 +43,7 @@ Module.symvers
 /TAGS
 /linux
 /vmlinux
+/vmlinux.32
 /vmlinux-gdb.py
 /vmlinuz
 /System.map
-- 
2.1.0

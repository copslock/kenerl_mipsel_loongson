Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2011 13:28:50 +0200 (CEST)
Received: from mail-yi0-f49.google.com ([209.85.218.49]:48379 "EHLO
        mail-yi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491105Ab1G1L2r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jul 2011 13:28:47 +0200
Received: by yib17 with SMTP id 17so1980740yib.36
        for <linux-mips@linux-mips.org>; Thu, 28 Jul 2011 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aDMbfvxPSBeygsX7W8UE3aPvHQhyddCirXCs1l7/ej4=;
        b=JcJ50MPZgRbW8Ihu5hjvXBvbq5FDc2j8o+xs7AuEhkdIl4RPklsReC9eFZf3FQtvgc
         4ckYm8faSW5VdLgp4pc4Ui4H/SbmIh/xJFDUWzRT/j25u1MBxe13D1yty4lIBcY+QDlG
         NMduQw0h0YoNDlWflrGgLk5jJWhzwXuX2Grmc=
Received: by 10.91.4.32 with SMTP id g32mr689791agi.71.1311852520863;
        Thu, 28 Jul 2011 04:28:40 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id p6sm678491ank.28.2011.07.28.04.28.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 04:28:40 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     jbarnes@virtuousgeek.org, torvalds@linux-foundation.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Subject: [PATCH 0/2] PCI driver to use insert_resource_conflict() to claim resources
Date:   Thu, 28 Jul 2011 19:28:30 +0800
Message-Id: <1311852512-7340-1-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 30752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20655

Use insert_resource_conflict() instead of request_resource_conflict() in
pci_claim_resource() to work with the conflict resource which can be the parent
of the resource to be claimed.

Deng-Cheng Zhu (2):
  PCI: make pci_claim_resource() work with conflict resources as
    appropriate
  kernel/resource: enrich the comment for insert_resource_conflict()

 drivers/pci/setup-res.c |    2 +-
 kernel/resource.c       |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

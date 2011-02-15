Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 14:51:24 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:55694 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491009Ab1BONvV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 14:51:21 +0100
Received: by fxm19 with SMTP id 19so197672fxm.36
        for <multiple recipients>; Tue, 15 Feb 2011 05:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=OYhG1nW4wRookKr3uunVQTqGO3hIjX+ROnZBUJgjUMw=;
        b=dgmmhrZpiYCNSPmgw9ueRkHpDt7xu7emlfdvjRAG1RBpO/5vB4xatCNx0oRfvLpask
         oswgzkVYkmdtNM6rLMJSc721afy7bDgF/twlTUhjabSfYJ03zRPAS3pRZ0ucdSBdT1Sx
         6ZSerE+NxVTFRlZcSN8OkFiIlti8yo1VqSjHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OMBYNB2dcdGx7qFL4LWHmooCexcAg5N/b87AihmDQpzHs1ktRs6Y2yXjc+75kHryTb
         +YbBxE593GAMwEtj2Ly3J0yjevddMxkNK16LYdmrxnsF8/qn3Dehalubyd1Ss/S+9XIa
         rJj7T8hsCQ+YhoZflF4nOLqWd8yr8kkMSgSSk=
Received: by 10.223.101.140 with SMTP id c12mr2776360fao.16.1297777876594;
        Tue, 15 Feb 2011 05:51:16 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id z1sm1650341fau.45.2011.02.15.05.51.13
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 05:51:15 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH 0/2] Minor improvements to MSP pci support.
Date:   Tue, 15 Feb 2011 19:42:31 +0530
Message-Id: <1297779151-26595-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Following set of patch created againt linux-queue head .
Ignoring checkpatch warning (usage of volatile).

Anoop P A (2):
  Introduce MSP_HAS_PCI config option.
  Fix pci id check.

 arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h |    6 +++++-
 arch/mips/pci/Makefile                             |    4 +---
 arch/mips/pci/ops-pmcmsp.c                         |   16 +++++++++-------
 arch/mips/pmc-sierra/Kconfig                       |   12 +++++++++---
 4 files changed, 24 insertions(+), 14 deletions(-)

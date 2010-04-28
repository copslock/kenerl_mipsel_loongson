Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 21:17:52 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9082 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492610Ab0D1TRR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 21:17:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd889c90003>; Wed, 28 Apr 2010 12:17:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3SJGMMj004755;
        Wed, 28 Apr 2010 12:16:23 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3SJGLfc004749;
        Wed, 28 Apr 2010 12:16:21 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/3] Check for accesses beyond end of PGD
Date:   Wed, 28 Apr 2010 12:16:15 -0700
Message-Id: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 28 Apr 2010 19:16:27.0635 (UTC) FILETIME=[4D039C30:01CAE707]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In 64-bit kernels a user space access might cause us to try to access
PGD elements beyound the end of the PGD, we must check for this and
trap it.

David Daney (3):
  MIPS:  Add uasm_i_dsrl_safe() and uasm_i_dsll_safe() to uasm.
  MIPS: Use uasm_i_ds{r,l}l_safe() instead of uasm_i_ds{r,l}l() in
    tlbex.c
  MIPS: Check for accesses beyond the end of the PGD.

 arch/mips/include/asm/uasm.h |   18 ++++++
 arch/mips/mm/tlbex.c         |  129 ++++++++++++++++++++++++++++++++----------
 2 files changed, 117 insertions(+), 30 deletions(-)

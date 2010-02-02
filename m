Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 18:08:51 +0100 (CET)
Received: from mgate.redback.com ([155.53.3.41]:5650 "EHLO mgate.redback.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492411Ab0BBRIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 18:08:42 +0100
X-IronPort-AV: E=Sophos;i="4.49,391,1262592000"; 
   d="scan'208";a="7765305"
Received: from prattle.redback.com ([155.53.12.9])
  by mgate.redback.com with ESMTP; 02 Feb 2010 09:08:38 -0800
Received: from localhost (localhost [127.0.0.1])
        by prattle.redback.com (Postfix) with ESMTP id B25DF15E9B52
        for <linux-mips@linux-mips.org>; Tue,  2 Feb 2010 09:08:38 -0800 (PST)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29799-09 for <linux-mips@linux-mips.org>;
 Tue,  2 Feb 2010 09:08:38 -0800 (PST)
Received: from localhost (rbos-pc-13.lab.redback.com [10.12.11.133])
        by prattle.redback.com (Postfix) with ESMTP id A256D15E9B50
        for <linux-mips@linux-mips.org>; Tue,  2 Feb 2010 09:08:34 -0800 (PST)
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v6 00/01] Virtual memory size detection for 64 bit MIPS CPUs
Date:   Tue,  2 Feb 2010 08:52:19 -0800
Message-Id: <1265129540-10884-1-git-send-email-guenter.roeck@ericsson.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <prvs=6426729b5=groeck@redback.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips


This patchset addresses some of the most recent comments.

It does not address changes to TASK_SIZE, and it does not address replacing
the VMALLOC_END macro with a variable. Those changes are non-trivial
and will require more discussion and/or clarification.

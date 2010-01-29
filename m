Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 00:03:01 +0100 (CET)
Received: from mgate.redback.com ([155.53.3.41]:48095 "EHLO mgate.redback.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492912Ab0A2XC5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 30 Jan 2010 00:02:57 +0100
X-IronPort-AV: E=Sophos;i="4.49,371,1262592000"; 
   d="scan'208";a="7716457"
Received: from prattle.redback.com ([155.53.12.9])
  by mgate.redback.com with ESMTP; 29 Jan 2010 15:02:55 -0800
Received: from localhost (localhost [127.0.0.1])
        by prattle.redback.com (Postfix) with ESMTP id 5A95013D783A
        for <linux-mips@linux-mips.org>; Fri, 29 Jan 2010 15:02:55 -0800 (PST)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32252-06 for <linux-mips@linux-mips.org>;
 Fri, 29 Jan 2010 15:02:55 -0800 (PST)
Received: from localhost (rbos-pc-13.lab.redback.com [10.12.11.133])
        by prattle.redback.com (Postfix) with ESMTP id 4AF5113D7838
        for <linux-mips@linux-mips.org>; Fri, 29 Jan 2010 15:02:52 -0800 (PST)
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH 00/01] Fix crash seen on sb1 CPUs caused by wrong virtual memory size
Date:   Fri, 29 Jan 2010 14:47:21 -0800
Message-Id: <1264805242-31929-1-git-send-email-guenter.roeck@ericsson.com>
X-Mailer: git-send-email 1.6.0.4
X-archive-position: 25752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19219


The following patch fixes a crash seen in 2.6.32 or later on Sibyte CPUs 
with 64 bit kernel, page size configured to 16k or 64k, and IPV6 enabled.

The problem is that VMALLOC_END is calculated to utilize more virtual memory 
bits than available on Sibyte CPUs. This causes a crash during boot.
Fix is to introduce an absolute and page size independent virtual memory
size limit which can be overridden per CPU type.

The problem was probably never seen before because no one tested the limits.
It is seen in 2.6.32 and later due to redesigned percpu memory allocation,
which attempts to allocate memory at the upper limit of virtual memory space.

The fix was verified on a bcm1480 based system with all configurable page sizes
(4k, 16k, 64k).

Open questions are
- Does the default virtual memory limit of 60 bits make sense ?
- Are there any other CPUs with known limitations which we could/should add 
  to this patch ?

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2012 20:24:19 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:35088 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903767Ab2DXSXc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Apr 2012 20:23:32 +0200
Received: by pbbrq13 with SMTP id rq13so415044pbb.36
        for <multiple recipients>; Tue, 24 Apr 2012 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=37zCbDTkTa5VZiCKIjbxe1x3Ix8wE2USZkoCg3l6zqE=;
        b=WUocSy4jq1zguejeY6+Uxaaezz0RJ8vCEtXSLKvInFMzCU6KvUr61OlpFGnS6eth8b
         oz04Jhds0mXWZ5XURzIzwD/mdJt2bFNfe+65kcdx55JR+9UKyLyJ6umEs1Xt35q9ecXI
         WkxEhEnIhqQZhrRZ2Q21cLFzPoEsGhNfVovRJtOSMrqJuEzS/5mgarMh/MJQbBcx1md4
         GVRPnAzhv/AHzQhoawk43C3Tr0qvk8G8QeCRo4KPcCvdC/6/52g8xJNQ94cZBmP5uTTm
         iWPaxnLHI801F6tiaS3mZyCTny9pZGKawpOL2gGfs+aLWJ8qf8e4S6+GidrYptFFGfUG
         bhQg==
Received: by 10.68.224.228 with SMTP id rf4mr47327pbc.22.1335291805464;
        Tue, 24 Apr 2012 11:23:25 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id s7sm18045679pbl.31.2012.04.24.11.23.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 11:23:23 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3OINLxX026729;
        Tue, 24 Apr 2012 11:23:21 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3OINJ7R026725;
        Tue, 24 Apr 2012 11:23:19 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] Buildtime exception table sorting for relative entries.
Date:   Tue, 24 Apr 2012 11:23:13 -0700
Message-Id: <1335291795-26693-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney@caviumnetworks.com>

These are against HPA's x86/extable branch in the tip repo.

Light testing indicates that it works for x86_64, and MIPS64.  x86_32
looks good, but I didn't try to boot the resulting kernel.  But really,
what could go wrong with something so simple?

David Daney (2):
  scripts/sortextable: Handle relative entries, and other cleanups.
  Revert "x86, extable: Disable presorted exception table for now"

 arch/x86/Kconfig      |    1 +
 scripts/Makefile      |    2 +
 scripts/sortextable.c |  171 ++++++++++++++++++++++++++++++++-----------------
 scripts/sortextable.h |   79 +++++++++++++++--------
 4 files changed, 165 insertions(+), 88 deletions(-)

-- 
1.7.7.6

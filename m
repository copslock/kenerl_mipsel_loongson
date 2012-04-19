Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 00:02:06 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:43358 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903736Ab2DSWAS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 00:00:18 +0200
Received: by yhjj52 with SMTP id j52so5430617yhj.36
        for <multiple recipients>; Thu, 19 Apr 2012 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=1pgys0B6Dxv5C7dn7k+0yr9R+FxUMsvgPoFpP2dxUjg=;
        b=ZdGeby46PuL3NNBAwGVCIcB2UT85Ps5FaXfRLREjtSFbky1zOHsogX0VivHKsSot04
         z4iDKVRPoenYTMHFQUIYCfnjWtMlpUqh8ZemfSzNzyHlcVd7P7O34pbo3JyfgWIdvuR+
         s9wPgAjdm85AiqE19ctGg5U3Tmit9tG8GBSDUUgeW5BN5m7sb4ZHbP4Ww3+A8ATqpENv
         lsHqNEqZp4UVvZuk0X7AQJdzAM5XrJhTmJjCTYMJIiXVLNQyPrV43cBCoOPXL5UPFmap
         baMdh88d5cGZwBVqpjmsS8Wue7VRDYIP7vpsoYVbO7JLYFGSxysiqfwh8AV27aQZdljs
         nopg==
Received: by 10.60.27.7 with SMTP id p7mr5503533oeg.56.1334872811832;
        Thu, 19 Apr 2012 15:00:11 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id xb7sm4225784obb.10.2012.04.19.15.00.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 15:00:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3JM0638014628;
        Thu, 19 Apr 2012 15:00:06 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3JM02KV014624;
        Thu, 19 Apr 2012 15:00:02 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/5] Speed booting by sorting exception tables at build time.
Date:   Thu, 19 Apr 2012 14:59:54 -0700
Message-Id: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

v2: Cosmetic changes only.  Cleanup makefile indentation.  Rebase MIPS
    and x86 Kconfig changes against 3.4-rc2.

    Michal Marek had suggested using $(call cmd,sortextable), but I
    wasn't able to figure out a good way to do that *and* have it print
    'SORTEX vmlinux', so I left it as I originally had it.

v1:

I noticed when booting MIPS64 kernels that sorting of the main
__ex_table was taking a long time (2,692,220 cycles or 3.3 mS at
800MHz to be exact).  That is not too bad for real silicon
implementations, but when running on a slow simulator, it can be
significant.

I can get this down to about 1,000,000 cycles by supplying a custom
swap function for the sort, but even better is to eliminate it
entirely by doing the sort at build time. That is the idea behind
this patch set.

Here is more or less what I did:

o A flag word is added to the kernel to indicate that the __ex_table
  is already sorted.  sort_main_extable() checks this and if it is
  clear, returns without doing the sort.

o I shamelessly stole code from recordmcount and created a new build
  time helper program 'sortextable'.  This is run on the final vmlinux
  image, it sorts the table, and then clears the flag word.

Potential areas for improvement:

o Sort module exception tables too.

o Get rid of the flag word, and assume that if an architecture supports
  build time sorting, that it must have been done.

o Add support for architectures other than MIPS and x86

David Daney (5):
  scripts: Add sortextable to sort the kernel's exception table.
  extable: Skip sorting if sorted at build time.
  kbuild/extable: Hook up sortextable into the build system.
  MIPS: Select BUILDTIME_EXTABLE_SORT
  x86: Select BUILDTIME_EXTABLE_SORT

 Makefile              |   10 ++
 arch/mips/Kconfig     |    1 +
 arch/x86/Kconfig      |    1 +
 init/Kconfig          |    3 +
 kernel/extable.c      |    8 ++-
 scripts/.gitignore    |    1 +
 scripts/Makefile      |    1 +
 scripts/sortextable.c |  273 +++++++++++++++++++++++++++++++++++++++++++++++++
 scripts/sortextable.h |  168 ++++++++++++++++++++++++++++++
 9 files changed, 465 insertions(+), 1 deletions(-)
 create mode 100644 scripts/sortextable.c
 create mode 100644 scripts/sortextable.h

-- 
1.7.2.3

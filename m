Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 20:39:54 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:65059 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904146Ab1KRTiM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 20:38:12 +0100
Received: by ggnb1 with SMTP id b1so3418359ggn.36
        for <multiple recipients>; Fri, 18 Nov 2011 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GqVKUDn4yRs13MiiGOUCH42C8c01ma13PsdHAMnoCIQ=;
        b=istNv290cWVq5h5c/srXLC+INTIbg1gJ5FDXl+bVeKAIBe8BbspcGS6/3ySQsjzO4h
         NuD/fiWkcGmPhWsGddjX/L6pntVRzKMO9L9rg5oI5LYTjk+KKRBNwI23kYA+Xq+Nktp8
         zVRHxvjHV5zi/CZ8S7HmFS8/zC8UV6zDRDDPE=
Received: by 10.236.136.167 with SMTP id w27mr7425441yhi.65.1321645085951;
        Fri, 18 Nov 2011 11:38:05 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i50sm2133304yhk.11.2011.11.18.11.38.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 11:38:04 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAIJc2cG020513;
        Fri, 18 Nov 2011 11:38:02 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAIJc141020512;
        Fri, 18 Nov 2011 11:38:01 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 0/5] Speed booting by sorting exception tables at build time.
Date:   Fri, 18 Nov 2011 11:37:43 -0800
Message-Id: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15873

From: David Daney <david.daney@cavium.com>

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

o Get rit of the flag word, and assume that if an architecture supports
  build time sorting, that it must have been done.

o Add support for architectures other than MIPS and x86

Any comments most welcome,

David Daney (5):
  scripts: Add sortextable to sort the kernel's exception table.
  extable: Skip sorting if sorted at build time.
  kbuild/extable: Hook up sortextable into the build system.
  MIPS:  Select BUILDTIME_EXTABLE_SORT
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

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2011 07:07:47 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:42037 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490965Ab1HOFHn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2011 07:07:43 +0200
Received: by gwb1 with SMTP id 1so3205169gwb.36
        for <linux-mips@linux-mips.org>; Sun, 14 Aug 2011 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rMNGR7zFWwSv06d8H5iOyjiSaluzD9/TgFnDfxqQNBI=;
        b=dP5NSyK4pFp2on+9IEath3RQD+sCnykoeVlgNloazR0odR0tupCg82C9TaK7UsC/V0
         CxdVauPuZXIwvigihepjuXry3TLP4o7lQCp8XifbB+AkMtqFCbtAb4tWuxvDS2JYST2E
         lj+S5FhU9uvefVOvKXKCf3uRR7VXg++aAb+Q8=
Received: by 10.150.113.1 with SMTP id l1mr4701520ybc.49.1313384857187;
        Sun, 14 Aug 2011 22:07:37 -0700 (PDT)
Received: from localhost.localdomain (69-165-142-232.dsl.teksavvy.com [69.165.142.232])
        by mx.google.com with ESMTPS id e21sm668516yhn.21.2011.08.14.22.07.33
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 22:07:36 -0700 (PDT)
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaud Lacombe <lacombar@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-mips@linux-mips.org
Subject: [PATCH 02/11] arch/mips: do not use EXTRA_CFLAGS
Date:   Mon, 15 Aug 2011 01:07:05 -0400
Message-Id: <1313384834-24433-3-git-send-email-lacombar@gmail.com>
X-Mailer: git-send-email 1.7.6.153.g78432
In-Reply-To: <1313384834-24433-1-git-send-email-lacombar@gmail.com>
References: <1313384834-24433-1-git-send-email-lacombar@gmail.com>
X-archive-position: 30873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10561

Usage of these flags has been deprecated for nearly 4 years by:

    commit f77bf01425b11947eeb3b5b54685212c302741b8
    Author: Sam Ravnborg <sam@neptun.(none)>
    Date:   Mon Oct 15 22:25:06 2007 +0200

        kbuild: introduce ccflags-y, asflags-y and ldflags-y

Moreover, these flags (at least EXTRA_CFLAGS) have been documented for command
line use. By default, gmake(1) do not override command line setting, so this is
likely to result in build failure or unexpected behavior.

Replace their usage by Kbuild's `{as,cc,ld}flags-y'.

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/netlogic/xlr/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/netlogic/xlr/Makefile b/arch/mips/netlogic/xlr/Makefile
index 9bd3f73..2dca585 100644
--- a/arch/mips/netlogic/xlr/Makefile
+++ b/arch/mips/netlogic/xlr/Makefile
@@ -2,4 +2,4 @@ obj-y				+= setup.o platform.o irq.o setup.o time.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= xlr_console.o
 
-EXTRA_CFLAGS			+= -Werror
+ccflags-y			+= -Werror
-- 
1.7.6.153.g78432

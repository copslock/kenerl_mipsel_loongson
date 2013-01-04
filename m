Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 04:40:16 +0100 (CET)
Received: from mail-ia0-f169.google.com ([209.85.210.169]:59424 "EHLO
        mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816383Ab3ADDkOrtgQm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 04:40:14 +0100
Received: by mail-ia0-f169.google.com with SMTP id u20so6877732iag.14
        for <multiple recipients>; Thu, 03 Jan 2013 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:message-id:to:subject:from;
        bh=dWuFON15dyQb57+zeH11EuVJTmhE2D6tcROiMI+DH1E=;
        b=SxcblVaq2PSZg+M/tLChFOmt3NcoKw7QwG6PPNHmYP+JpFzAiNOvhT6lres61Bkq3h
         dhEikKpOtvpN01Z5yEbxl76zIpQ9F3rMGpzr5s9soXS9IQirk952/Y90gmpVtQx6AXvb
         IJyfNpm5mWSLNRyHFPVc36bra77sSofSTRvAgLvKFsD+tpXiAmi5YeGwGABg/Qc8we0P
         RoLPnLTky8+0WUDqOY7PBXsX4MpFElN5ndoNbZIRS3I8k0ZMhhoXoHOkMpqBCYPp2p5w
         Yt7XEeUEehnPmnHO9bvaLHlNOB5tgraqSGIXKNG71KvVdC0QlzUtNkvHniX6ini55c4b
         6LAg==
X-Received: by 10.50.197.169 with SMTP id iv9mr42550192igc.32.1357270807448;
        Thu, 03 Jan 2013 19:40:07 -0800 (PST)
Received: from localhost ([207.47.250.72])
        by mx.google.com with ESMTPS id eu3sm46094529igc.7.2013.01.03.19.40.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 19:40:06 -0800 (PST)
Received: from shane by localhost with local (Exim 4.72)
        (envelope-from <shane@localhost>)
        id 1Tqy8Z-0003Uc-Cm; Thu, 03 Jan 2013 21:40:03 -0600
Date:   Thu, 03 Jan 2013 21:40:03 -0600
Message-Id: <E1Tqy8Z-0003Uc-Cm@localhost>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] MIPS: Fix build failure of msp71xx default configuration
From:   Shane McDonald <mcdonald.shane@gmail.com>
X-archive-position: 35365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The msp71xx default configuration fails to compile in Linux 3.8-rc2:

In file included from /home/shane/linux-mips/linux/arch/mips/include/asm/bitops.h:22,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:10,
                 from include/asm-generic/bug.h:13,
                 from /home/shane/linux-mips/linux/arch/mips/include/asm/bug.h:41,
                 from include/linux/bug.h:4,
                 from include/linux/page-flags.h:9,
                 from kernel/bounds.c:9:
/home/shane/linux-mips/linux/arch/mips/include/asm/war.h:12:17: error: war.h: No such file or directory

This is because the Platform file points at the incorrect include file
location, and therefore the war.h file cannot be found.

This patch changes the Platform file to point to the correct location.

Caused by a combination of the following lmo-only patches:

13a347ef60c68e490809dad8fcf79c25eabc4d58 [MIPS: MSP71xx: Move code.]
a89c0370cb5429891d49abcc66f93c63b43c7dbe
  [MIPS: Fix make distclean after moving the PMC-Sierra code.]

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmcs-msp71xx/Platform |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmcs-msp71xx/Platform b/arch/mips/pmcs-msp71xx/Platform
index e42a4d6..9a86e29 100644
--- a/arch/mips/pmcs-msp71xx/Platform
+++ b/arch/mips/pmcs-msp71xx/Platform
@@ -2,6 +2,6 @@
 # PMC-Sierra MSP SOCs
 #
 platform-$(CONFIG_PMC_MSP)	+= pmcs-msp71xx/
-cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/pmc-sierra \
+cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/pmc-sierra/msp71xx \
 					-mno-branch-likely
 load-$(CONFIG_PMC_MSP)		+= 0xffffffff80100000
-- 
1.7.2.5

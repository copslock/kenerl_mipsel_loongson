Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Dec 2012 05:06:38 +0100 (CET)
Received: from mail-ia0-f180.google.com ([209.85.210.180]:41264 "EHLO
        mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817286Ab2LXEGhhQwNE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Dec 2012 05:06:37 +0100
Received: by mail-ia0-f180.google.com with SMTP id t4so5718482iag.11
        for <multiple recipients>; Sun, 23 Dec 2012 20:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:message-id:to:subject:from;
        bh=0ATmrfeqXoZIuXtfnoLS/iOn19EdagiWg5Of0lr66H4=;
        b=dwulcPWBh1L+dgynVr05gIHE7+1ALsNlKHhI9Oz0uzZcW/3UF805k3qHd0qqHJvGOy
         8VlGwTCkTqVSm2Qh5OyF/2sW2meGz1TNo4Nwg76BGasU7BpEP0Pqzz5KB5t8GCADRMyk
         EMpn86WlkSX+ChUxv3doHkvowysnzYuskCfiQCOGstpy9DsVpvcb2kK43SF4eysFVWZT
         DbuhuZYMPQxU6jDWhMVwFHr9OccdmOZQpFrSydYJ5DFu2r0otUDH/+qT6X8w9nnCH6mr
         d2l6s6/Ii8eGX/j5ObGWwOqxjG5/MAl/u92uMTFsDmaA8lzq7bGG/mGtHN2OMFfCc+6G
         qZyg==
X-Received: by 10.50.41.165 with SMTP id g5mr19347011igl.66.1356321990861;
        Sun, 23 Dec 2012 20:06:30 -0800 (PST)
Received: from localhost ([207.47.250.72])
        by mx.google.com with ESMTPS id pr7sm21624102igc.16.2012.12.23.20.06.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Dec 2012 20:06:29 -0800 (PST)
Received: from shane by localhost with local (Exim 4.72)
        (envelope-from <shane@localhost>)
        id 1TmzJ4-0003mm-3H; Sun, 23 Dec 2012 22:06:26 -0600
Date:   Sun, 23 Dec 2012 22:06:26 -0600
Message-Id: <E1TmzJ4-0003mm-3H@localhost>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: MIPS: MSP71xx: Indicate new location of source files in Platform file
From:   Shane McDonald <mcdonald.shane@gmail.com>
X-archive-position: 35316
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

The source files for the MSP71xx support code have been moved
in commit 13a347ef60c68e490809dad8fcf79c25eabc4d58,
"MIPS: MSP71xx: Move code." Update the Platform file
to indicate the new location.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmcs-msp71xx/Platform |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pmcs-msp71xx/Platform b/arch/mips/pmcs-msp71xx/Platform
index 17299f9..9a86e29 100644
--- a/arch/mips/pmcs-msp71xx/Platform
+++ b/arch/mips/pmcs-msp71xx/Platform
@@ -1,7 +1,7 @@
 #
 # PMC-Sierra MSP SOCs
 #
-platform-$(CONFIG_PMC_MSP)	+= pmc-sierra/
-cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/pmc-sierra \
+platform-$(CONFIG_PMC_MSP)	+= pmcs-msp71xx/
+cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/pmc-sierra/msp71xx \
 					-mno-branch-likely
 load-$(CONFIG_PMC_MSP)		+= 0xffffffff80100000
-- 
1.7.2.5

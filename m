Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Dec 2012 20:19:37 +0100 (CET)
Received: from mail-ia0-f169.google.com ([209.85.210.169]:63934 "EHLO
        mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820301Ab2LXTTgeeMaM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Dec 2012 20:19:36 +0100
Received: by mail-ia0-f169.google.com with SMTP id r4so6105179iaj.14
        for <multiple recipients>; Mon, 24 Dec 2012 11:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:message-id:to:subject:from;
        bh=f8DlF44tbgk2MK2o79FMGrSBGi1cM0yhFZfQESyMcOE=;
        b=sOXQ+pFb8Zfb1MsTOegc8PKWXmY9y7UeOY+PfwJkFRfvjYMhIZXwozVp2Z55Hs0L/C
         MYK4zn1/vx+bT9oxhdVv8Rhh9NQo4WsFjHY3wZmdul4otHwBTLvf91Lty0rMT4Q5P6MJ
         pVFJJDdV9K5fDz941yF1xGNFP2GwgZexCP4GxplpsYyTw+dfA2e9hiI4sDK/IsXkUDyD
         q5tQTpVvPMzP+1NOIr/+TufAViwuNRBIhR5rNZgBUuJtKyRpvVBVtduC+aent5DufwHJ
         tsZpKoT3IQgit15gXCnAiO4wIeFP0qv3WzHM8KxyYK+KdCpIOnvO1/e2Om+Lr7rQPHL2
         400Q==
X-Received: by 10.50.195.162 with SMTP id if2mr15591950igc.91.1356376769889;
        Mon, 24 Dec 2012 11:19:29 -0800 (PST)
Received: from localhost ([207.47.250.72])
        by mx.google.com with ESMTPS id ez8sm17497056igb.17.2012.12.24.11.19.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Dec 2012 11:19:28 -0800 (PST)
Received: from shane by localhost with local (Exim 4.72)
        (envelope-from <shane@localhost>)
        id 1TnDYb-0003FO-4k; Mon, 24 Dec 2012 13:19:25 -0600
Date:   Mon, 24 Dec 2012 13:19:25 -0600
Message-Id: <E1TnDYb-0003FO-4k@localhost>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, sshtylyov@mvista.com
Subject: [PATCH v2] MIPS: MSP71xx: Move include files
From:   Shane McDonald <mcdonald.shane@gmail.com>
X-archive-position: 35319
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

Now that Yosemite's gone we can move the MSP71xx include files
one level up.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
Patch history:
V1: Original patch
V2: Use format-patch's -M option to indicate file renames

 .../cpu-feature-overrides.h                        |    0
 .../msp71xx => mach-pmcs-msp71xx}/gpio.h           |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_cic_int.h    |    0
 .../msp_gpio_macros.h                              |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_int.h        |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_pci.h        |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_prom.h       |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_regops.h     |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_regs.h       |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_slp_int.h    |    0
 .../msp71xx => mach-pmcs-msp71xx}/msp_usb.h        |    0
 .../msp71xx => mach-pmcs-msp71xx}/war.h            |    0
 arch/mips/pmcs-msp71xx/Platform                    |    2 +-
 13 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/cpu-feature-overrides.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/gpio.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_cic_int.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_gpio_macros.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_int.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_pci.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_prom.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_regops.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_regs.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_slp_int.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/msp_usb.h (100%)
 rename arch/mips/include/asm/{pmc-sierra/msp71xx => mach-pmcs-msp71xx}/war.h (100%)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/gpio.h b/arch/mips/include/asm/mach-pmcs-msp71xx/gpio.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/gpio.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/gpio.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_cic_int.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_cic_int.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_cic_int.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_cic_int.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_gpio_macros.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_gpio_macros.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_gpio_macros.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_gpio_macros.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_int.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_int.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_int.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_int.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_pci.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_pci.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_pci.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_prom.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_prom.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_regops.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_regops.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_regops.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_regs.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_regs.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_slp_int.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_slp_int.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_slp_int.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_slp_int.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_usb.h b/arch/mips/include/asm/mach-pmcs-msp71xx/msp_usb.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/msp_usb.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/msp_usb.h
diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/war.h b/arch/mips/include/asm/mach-pmcs-msp71xx/war.h
similarity index 100%
rename from arch/mips/include/asm/pmc-sierra/msp71xx/war.h
rename to arch/mips/include/asm/mach-pmcs-msp71xx/war.h
diff --git a/arch/mips/pmcs-msp71xx/Platform b/arch/mips/pmcs-msp71xx/Platform
index 9a86e29..7af0734 100644
--- a/arch/mips/pmcs-msp71xx/Platform
+++ b/arch/mips/pmcs-msp71xx/Platform
@@ -2,6 +2,6 @@
 # PMC-Sierra MSP SOCs
 #
 platform-$(CONFIG_PMC_MSP)	+= pmcs-msp71xx/
-cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/pmc-sierra/msp71xx \
+cflags-$(CONFIG_PMC_MSP)	+= -I$(srctree)/arch/mips/include/asm/mach-pmcs-msp71xx \
 					-mno-branch-likely
 load-$(CONFIG_PMC_MSP)		+= 0xffffffff80100000
-- 
1.7.2.5

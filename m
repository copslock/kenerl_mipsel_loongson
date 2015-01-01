Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 18:19:44 +0100 (CET)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:43264 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009173AbbAARTmGaMUA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 18:19:42 +0100
Received: by mail-wi0-f176.google.com with SMTP id ex7so26851225wid.9
        for <linux-mips@linux-mips.org>; Thu, 01 Jan 2015 09:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kRvYe3vfvYCsLMDi02zNzf6Oz+R46qytiMflr9AbYy4=;
        b=TuZLvFLV0aSDUIMIoQhAoAnKJggqXo/xb8UaQ6JJEcso+o7BtT4kOjaHCIaG0iq64r
         OmPrIyvCybFf8PkzZGguPd25wOU51Il8kY7IA7LCxEOwG383GQdM+yS39lGyHMUudaPJ
         qbUpM0Z3OIjQ712LwghXWMTIrNXuhxasHGz6mABD2UwHyPN3Jolx0wOo4mSbDmW6YGt4
         9PgsBtGT87XGyFMah5Lgm7WlB0CjuSxCZaXGJLGfBTYYxJTSimPM68R070mnfuJ1F1ao
         xdGNkNOrI6+jzHvpHfp2CwaKaJ2NCqa3MrHldZiz5EcPikODn/HxYZCOuIaJYsVW7RlL
         YnaA==
X-Gm-Message-State: ALoCoQlYDaph9Z4ISr8JNGihPSd3rErT0e7iL++brRBiEC0ElqLseTQR+bF6pzk9LXz8NCoUgk1p
X-Received: by 10.180.97.195 with SMTP id ec3mr128707075wib.79.1420132776811;
        Thu, 01 Jan 2015 09:19:36 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id a1sm12964797wjx.28.2015.01.01.09.19.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jan 2015 09:19:36 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: fw: arc: misc.c:  Remove some unused functions
Date:   Thu,  1 Jan 2015 18:22:37 +0100
Message-Id: <1420132958-32622-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard.strandqvist@spctrm.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
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

Removes some functions that are not used anywhere:
ArcGetSystemId() ArcSaveConfiguration() ArcRestart() ArcPowerDown() ArcHalt()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/fw/arc/misc.c |   40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/mips/fw/arc/misc.c b/arch/mips/fw/arc/misc.c
index f9f5307..214dc88 100644
--- a/arch/mips/fw/arc/misc.c
+++ b/arch/mips/fw/arc/misc.c
@@ -20,34 +20,6 @@
 #include <asm/bootinfo.h>
 
 VOID
-ArcHalt(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(halt);
-never:	goto never;
-}
-
-VOID
-ArcPowerDown(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(pdown);
-never:	goto never;
-}
-
-/* XXX is this a soft reset basically? XXX */
-VOID
-ArcRestart(VOID)
-{
-	bc_disable();
-	local_irq_disable();
-	ARC_CALL0(restart);
-never:	goto never;
-}
-
-VOID
 ArcReboot(VOID)
 {
 	bc_disable();
@@ -65,18 +37,6 @@ ArcEnterInteractiveMode(VOID)
 never:	goto never;
 }
 
-LONG
-ArcSaveConfiguration(VOID)
-{
-	return ARC_CALL0(cfg_save);
-}
-
-struct linux_sysid *
-ArcGetSystemId(VOID)
-{
-	return (struct linux_sysid *) ARC_CALL0(get_sysid);
-}
-
 VOID __init
 ArcFlushAllCaches(VOID)
 {
-- 
1.7.10.4

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2010 16:06:21 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:44162 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491176Ab0KYPGS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Nov 2010 16:06:18 +0100
Received: by vws5 with SMTP id 5so376421vws.36
        for <multiple recipients>; Thu, 25 Nov 2010 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=p8xwvKBxIe6F96/g5WKFn93diUwK6Il0uYZoikwWm2A=;
        b=EP01zaS9z4xB5aAuAHcRwOJ1biiUhiApWdEXXAFEVuRSVFPze9SF9gAdmTkzF2qvHe
         TvfhPiT43mmV5W1Zdt7hYZhAlQfEqQOINxyUPBXglWJVR8s45e5uW3TI8AckCLe6zVmO
         ngWVYKX4ArJ1mRHoWlcfCoBWvLcxbDbhuXHKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I77sWZJQar8nbAvcECAyOgQGp9mcTOrQgaozf0KzEy5YLaGOl7ok4lFST3Ef5OdM7D
         Ky2xO+iY5szUI6xF+PCjlfP8GbQwUIv6Cs8DmosV4HrB6CEZUvN/3xMjAPv0VdfpkIWe
         8YCq9kHz59tHQA8qLlh8IHfy4b5Enq8tux9J4=
Received: by 10.220.121.162 with SMTP id h34mr265617vcr.13.1290697570531;
        Thu, 25 Nov 2010 07:06:10 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id r7sm235392vbx.19.2010.11.25.07.06.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 07:06:09 -0800 (PST)
From:   Anoop P <anoop.pa@gmail.com>
To:     linux-mips@linux-mips.org, dvomlehn@cisco.com
Cc:     Anoop P A <anoop.pa@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Allow setup_irq call for VPE1 timer.
Date:   Thu, 25 Nov 2010 20:37:12 +0530
Message-Id: <1290697632-6139-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

VSMP configuration can have seperate timer interrupts for each VPE.Need to setup IRQ for VPE1 timer.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/kernel/cevt-r4k.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 2f4d7a9..7eaeacd 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -203,9 +203,10 @@ int __cpuinit r4k_clockevent_init(void)
 
 	clockevents_register_device(cd);
 
+#ifndef CONFIG_MIPS_MT_SMP
 	if (cp0_timer_irq_installed)
 		return 0;
-
+#endif
 	cp0_timer_irq_installed = 1;
 
 	setup_irq(irq, &c0_compare_irqaction);
-- 
1.7.0.4

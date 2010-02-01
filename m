Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 10:17:15 +0100 (CET)
Received: from mail-iw0-f183.google.com ([209.85.223.183]:44210 "EHLO
        mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491988Ab0BAJRL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 10:17:11 +0100
Received: by iwn13 with SMTP id 13so345223iwn.20
        for <multiple recipients>; Mon, 01 Feb 2010 01:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=q29LBEgUBABxQbj20SsOUBh/SZYhpdRH20sJxLf9MmQ=;
        b=ECulLcDcCgyGZkpR3x3ao1Z115OdkJCSX+kFprpFHEYU4S5apvaVtUeRFxDrnsjjHy
         axL6MX1KcgQmA+dGzNwpQWCs4Zgzqjq3eS2yq3JtyB4vlJqQIHF7Ug5r5IFQRBtR9ACJ
         3X+s23HG4/stBEsH6cFalhtf3T7aY4Zuqvn+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iq+EpXwmUGFfunV5d0+29ZMhdJoyUgiSp8j51jrhRssumTyyphKYOMln6+5piSA976
         tGzTZx/1gZ7F8712GFC7gk+0FCBYKrPofsGqiawSCr4839JVqcef9krOA1Ffa9Nb1xeH
         QQ4Xxa0Si9qxVQdhY9aPmo0ahJPNSVc9S277Y=
Received: by 10.231.145.70 with SMTP id c6mr1080716ibv.36.1265015824434;
        Mon, 01 Feb 2010 01:17:04 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm5287272iwn.15.2010.02.01.01.17.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 01:17:03 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     ralf@linux-mips.org
Cc:     David VomLehn <dvomlehn@cisco.com>, mbizon@freebox.fr,
        linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH urgent] MIPS: Fixup of the r4k timer
Date:   Mon,  1 Feb 2010 17:10:55 +0800
Message-Id: <1265015455-32553-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As reported by Maxime Bizon, the commit "MIPS: PowerTV: Fix support for
timer interrupts with > 64 external IRQs" have broken the r4k timer
since it didn't initialize the cp0_compare_irq_shift variable used in
c0_compare_int_pending() on the architectures whose cpu_has_mips_r2 is
false.

This patch fixes it via initializing the cp0_compare_irq_shift as the
cp0_compare_irq used in the old c0_compare_int_pending().

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/traps.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 338dfe8..31b204b 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1501,6 +1501,7 @@ void __cpuinit per_cpu_trap_init(void)
 			cp0_perfcount_irq = -1;
 	} else {
 		cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
+		cp0_compare_irq_shift = cp0_compare_irq;
 		cp0_perfcount_irq = -1;
 	}
 
-- 
1.6.6

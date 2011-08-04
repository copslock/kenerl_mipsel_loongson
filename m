Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2011 17:55:29 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47704 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491763Ab1HDPzB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Aug 2011 17:55:01 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p74Ft0p4006541
        for <linux-mips@linux-mips.org>; Thu, 4 Aug 2011 16:55:00 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p74Ft0qQ006540
        for linux-mips@linux-mips.org; Thu, 4 Aug 2011 16:55:00 +0100
Resent-From: Ralf Baechle <ralf@linux-mips.org>
Resent-Date: Thu, 4 Aug 2011 16:55:00 +0100
Resent-Message-ID: <20110804155500.GC5297@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Received: from mail-wy0-f177.google.com ([74.125.82.177]:45689 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491084Ab1HDOqs (ORCPT
        <rfc822;ralf@linux-mips.org>); Thu, 4 Aug 2011 16:46:48 +0200
Received: by wyg19 with SMTP id 19so1219172wyg.36
        for <ralf@linux-mips.org>; Thu, 04 Aug 2011 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cVkOH5iK21GrhOuDdUqnQScOdiALSR5pI8C1RLl0DB0=;
        b=nFVUNL5OvSfHI7CgBggStjl/gvqDVfvoh/90nLUy4awBeDV7DzlzNfo71ILIfTaODM
         ZKmLDwtrnzTSRjMATNRUDJIgBFbArqzU/Y9xEN0oGQubXp58kTodkWw2d2su/SrY6Xsr
         2bfQ+kM9A6EivWEcu7BIVcckgPk4xxzVY1amY=
MIME-Version: 1.0
Received: by 10.216.237.233 with SMTP id y83mr1443780weq.9.1312469201952; Thu,
 04 Aug 2011 07:46:41 -0700 (PDT)
Received: by 10.216.46.136 with HTTP; Thu, 4 Aug 2011 07:46:41 -0700 (PDT)
Date:   Thu, 4 Aug 2011 22:46:41 +0800
Message-ID: <CAJd=RBBxoWxAG5+v=6XPBfx9eQ3e3mEisXS+gWEvRE9x56tPsA@mail.gmail.com>
Subject: [RFC patch] MIPS: deduplicate comment for i8259
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 30837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3441

The comment for the slave PIC is changed from 8259A-1 to 8259A-2.

Signed-off-by: Hillf Danton <dhillf@gmail.com>
---
 arch/mips/kernel/i8259.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
index c018696..55d2624 100644
--- a/arch/mips/kernel/i8259.c
+++ b/arch/mips/kernel/i8259.c
@@ -230,7 +230,7 @@ static int i8259A_shutdown(struct sys_device *dev)
 	 */
 	if (i8259A_auto_eoi >= 0) {
 		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
-		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
+		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
 	}
 	return 0;
 }

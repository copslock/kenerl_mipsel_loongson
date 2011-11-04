Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 15:50:10 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:60180 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904115Ab1KDOuG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2011 15:50:06 +0100
Received: by faaq17 with SMTP id q17so3542356faa.36
        for <linux-mips@linux-mips.org>; Fri, 04 Nov 2011 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tSHxkvcokvPkUa+VFZrzyARcYxZxfixYLpDo6J80P6E=;
        b=NAxDIlbQMt9qJ1dhPAQbaM3MhaMubUaJ3+/i3+/AcNYG9UDwWJdPudwQXrk0p6N/21
         rwrmqw8gL1nVSEf3JPyGtPJNwQaAw+EfSa3kr/IxHTgAw/o++mURz5wi0XKmHTyTqVct
         iMYu59auN/+TgtWY31Xv7hiDuoMhjUnXwE/js=
Received: by 10.152.103.51 with SMTP id ft19mr991313lab.42.1320418200968;
        Fri, 04 Nov 2011 07:50:00 -0700 (PDT)
Received: from localhost.localdomain (178-191-6-64.adsl.highway.telekom.at. [178.191.6.64])
        by mx.google.com with ESMTPS id hh9sm2618400lab.1.2011.11.04.07.49.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 07:50:00 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] MIPS: remove port limit in ioport_map
Date:   Fri,  4 Nov 2011 15:49:51 +0100
Message-Id: <1320418191-22096-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 31382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3681

Alchemy PCMCIA IO lies outside the 32bit address space and needs to
be ioremapped to be accessible.  The resulting address is
then fed as IO-port base to all PCMCIA client drivers attached
to a particular socket.  pata_pcmcia does devm_ioport_map() on
the port address, which returns errors because MIPS' ioport_map()
implementation rejects incoming port addresses which are not
within the 0..64k window.  Other embedded architectures don't
bother with a check like this;  this patch brings MIPS in line
and in turn makes pata_pcmcia work on all my Alchemy systems
(and doesn't break PCI).

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/lib/iomap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lib/iomap.c b/arch/mips/lib/iomap.c
index e3acb2d..5139fa6 100644
--- a/arch/mips/lib/iomap.c
+++ b/arch/mips/lib/iomap.c
@@ -210,9 +210,6 @@ static void __iomem *ioport_map_legacy(unsigned long port, unsigned int nr)
 
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	if (port > PIO_MASK)
-		return NULL;
-
 	return ioport_map_legacy(port, nr);
 }
 
-- 
1.7.7.1

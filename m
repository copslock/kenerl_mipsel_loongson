Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 11:26:14 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:37737 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492426Ab0KRK0K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 11:26:10 +0100
Received: by gxk25 with SMTP id 25so1857880gxk.36
        for <multiple recipients>; Thu, 18 Nov 2010 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=RkF9Pb+EhzaCqM96K97fdZOnFUk+Uf97VaOx2J+PsXc=;
        b=rrppKAFxnPoLIg5dZbEa7OPe7ESTM3p/BCxrkR9RBXAr/QD5kX/cRihm5LWIvnO+8m
         a+d7Fo0Y6wg88yxOnKsMWvzqNGkHEb/55GsrUZ7GXahSzPjNi3mBH8GJD0qgkNs6xtJ1
         dQNDcT8VXvjIJe3n+sPGboKRV5C6ZqbjUrH+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=lQaYczvhXqDwqhmAHI0NwdZgi5rLifXyYrZJ3d+vtM2fmODQKmeZ8OM9nGlYYNrlC6
         GL8qkk+sB6TQxoNGovB/h+Ctz5G4+HSCFjf+fzV50arBdsWOAEcYysoMvYxX+8A+dt1s
         cOLkjmSuVuezbqlLyr3Wweic2Do6VhnNv66+0=
Received: by 10.150.228.12 with SMTP id a12mr891817ybh.313.1290075964258;
        Thu, 18 Nov 2010 02:26:04 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id v12sm196823ybk.11.2010.11.18.02.26.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 02:26:03 -0800 (PST)
Subject: [PATCH] Fix MSP71xx bpci interrupt handler return value
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 18 Nov 2010 16:02:50 +0530
Message-ID: <1290076370.31469.1.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pci/ops-pmcmsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index b7c03d8..68798f8 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -308,7 +308,7 @@ static struct resource pci_mem_resource = {
  *  RETURNS:     PCIBIOS_SUCCESSFUL  - success
  *

****************************************************************************/
-static int bpci_interrupt(int irq, void *dev_id)
+static irqreturn_t bpci_interrupt(int irq, void *dev_id)
 {
 	struct msp_pci_regs *preg = (void *)PCI_BASE_REG;
 	unsigned int stat = preg->if_status;
@@ -326,7 +326,7 @@ static int bpci_interrupt(int irq, void *dev_id)
 	/* write to clear all asserted interrupts */
 	preg->if_status = stat;
 
-	return PCIBIOS_SUCCESSFUL;
+	return IRQ_HANDLED;
 }
 
 /*****************************************************************************
-- 
1.7.0.4

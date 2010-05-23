Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:53:22 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.154]:14987 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491946Ab0EWTwV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:21 +0200
Received: by fg-out-1718.google.com with SMTP id 16so812543fgg.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=5gCRdpSepsfiS4Lfz1T5yQL1KIrgwFmOFWpqgsFAVBc=;
        b=rDfIux4Q9RjQdi82AIvoZ1OTXsxE1LAmxrvebqPvHWec8RI1SxsAWoiv6RWSp9DbfP
         LpRBcdpqcmnyU8QhQxnMMVcJKJZO5/Y+lzuUbOyqRrzdTjAscy8iQhXsaZetsALlEP5O
         WiPG5zlowFAd+CoUfrSvA20LPpFLYaQRZ+RCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=nlPW3/HcAikzH62JvEwRV6gn9GHk0yfekQETfjKXEUGpvWfUciAozjWqJrUHXJBWxd
         4OmU0HOgfeJLIKZr2dETUH1YxNXkWnR1zTtOK28OsENblHc1wjYBQLUUKFrYPvqyaqPm
         AkGQaS2k5IfClXQ6YiTCP2IaldWz8WDjbFOA0=
Received: by 10.87.48.34 with SMTP id a34mr7260722fgk.2.1274644337614;
        Sun, 23 May 2010 12:52:17 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:17 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 020/199] arch/mips/pmc-sierra/yosemite/ht-irq.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:03 +0200
Message-Id: <1274644332-23964-2-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/pmc-sierra/yosemite/ht-irq.c:38: ERROR: code indent should use tabs where possible
arch/mips/pmc-sierra/yosemite/ht-irq.c:39: ERROR: code indent should use tabs where possible
arch/mips/pmc-sierra/yosemite/ht-irq.c:40: ERROR: code indent should use tabs where possible
arch/mips/pmc-sierra/yosemite/ht-irq.c:43: ERROR: code indent should use tabs where possible
arch/mips/pmc-sierra/yosemite/ht-irq.c:44: ERROR: code indent should use tabs where possible
arch/mips/pmc-sierra/yosemite/ht-irq.c:45: ERROR: code indent should use tabs where possible

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/pmc-sierra/yosemite/ht-irq.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/mips/pmc-sierra/yosemite/ht-irq.c b/arch/mips/pmc-sierra/yosemite/ht-irq.c
index 5aec405..86b98e9 100644
--- a/arch/mips/pmc-sierra/yosemite/ht-irq.c
+++ b/arch/mips/pmc-sierra/yosemite/ht-irq.c
@@ -35,18 +35,17 @@
  */
 void __init titan_ht_pcibios_fixup_bus(struct pci_bus *bus)
 {
-        struct pci_bus *current_bus = bus;
-        struct pci_dev *devices;
-        struct list_head *devices_link;
+	struct pci_bus *current_bus = bus;
+	struct pci_dev *devices;
+	struct list_head *devices_link;
 
 	list_for_each(devices_link, &(current_bus->devices)) {
-                devices = pci_dev_b(devices_link);
-                if (devices == NULL)
-                        continue;
+		devices = pci_dev_b(devices_link);
+		if (devices == NULL)
+			continue;
 	}
 
 	/*
 	 * PLX and SPKT related changes go here
 	 */
-
 }
-- 
1.7.1.251.gf80a2

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2011 02:50:38 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:62639 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903807Ab1KLBuc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2011 02:50:32 +0100
Received: by iapp10 with SMTP id p10so5963804iap.36
        for <multiple recipients>; Fri, 11 Nov 2011 17:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=0eYAUsd2AZC6lJBBWK38U5KJ5bNAlGzQ14neaizsg8Y=;
        b=S87mwBXLRt5ksBV+/SQTYjhEQ6SY6qfiSLcVoaz8hqbvdzqF28sXRKMiz9O1dKEDby
         jwaeo2Ms5ywTfmhcYQYl1k0nOUrnLe09flz7X0zvogcDRzj3PVv1VcB2FkLiKhSV6K3B
         IEWEirY69+Ui25CkuKPUZ1Q+kgN9vpmLDr+hA=
Received: by 10.50.140.1 with SMTP id rc1mr15877275igb.25.1321062625994;
        Fri, 11 Nov 2011 17:50:25 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id fu10sm10055224igc.6.2011.11.11.17.50.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 17:50:25 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAC1oNYg028361;
        Fri, 11 Nov 2011 17:50:23 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAC1oIh2028350;
        Fri, 11 Nov 2011 17:50:18 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
        tglx@linutronix.de, linux@arm.linux.org.uk,
        linux-arm-kernel@lists.infradead.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] irq/of: Enchance irq_domain support.
Date:   Fri, 11 Nov 2011 17:50:14 -0800
Message-Id: <1321062616-28317-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 31584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10781

From: David Daney <david.daney@cavium.com>

This is the first cut at hooking up my Octeon port to the irq_domain things.

The Octeon specific patches are part of a larger set, and will need to
be applied with that set, the first patch is stand-alone.

The basic problem being solved taken from one of my other e-mails:

   Unfortunately, although a good idea, kernel/irq/irqdomain.c makes a
   bunch of assumptions that don't hold for Octeon.  We may be able to
   improve it so that it flexible enough to suit us.


   Here are the problems I see:

   1) It is assumed that there is some sort of linear correspondence
   between 'hwirq' and 'irq', and that the range of valid values is
   contiguous.

   2) It is assumed that the concepts of nr_irq, irq_base and
   hwirq_base have easy to determine values and you can do iteration
   over their ranges by adding indexes to the bases.


David Daney (2):
  irq/of/ARM: Enhance irq iteration capability of irq_domain code.
  MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.

 arch/arm/common/gic.c                |   32 +++--
 arch/mips/Kconfig                    |    1 +
 arch/mips/cavium-octeon/octeon-irq.c |  279 +++++++++++++++++++++++++++++++++-
 include/linux/irqdomain.h            |   29 +++-
 kernel/irq/irqdomain.c               |   97 +++++++++---
 5 files changed, 390 insertions(+), 48 deletions(-)

-- 
1.7.2.3

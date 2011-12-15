Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Dec 2011 03:32:55 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:35640 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903746Ab1LOCcX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Dec 2011 03:32:23 +0100
Received: by ghbf20 with SMTP id f20so1309100ghb.36
        for <linux-mips@linux-mips.org>; Wed, 14 Dec 2011 18:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ugOvcCxWTTU1w4US/DLh7RcHdRIwlTGhOo60rtBHUNc=;
        b=iSseUYBksgyJUQgnPSdCYQnk3stQGVLrGLFYs4cYrHtCuMyIfpksqD49I4MfNeK3Xt
         AaMOiX8kUZBx30/jIbFHPHIzSKna3NhxRx4KBPfcbs0sVlyl/pSVL94IOEFItWjGpRXE
         oMxqV7axJBjDxnJnBTGcMwRWd3pvkbol9md5k=
Received: by 10.101.137.7 with SMTP id p7mr371412ann.34.1323916337584;
        Wed, 14 Dec 2011 18:32:17 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 37sm5831631anu.21.2011.12.14.18.32.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 18:32:17 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pBF2WE6Y008900;
        Wed, 14 Dec 2011 18:32:14 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pBF2WCZG008899;
        Wed, 14 Dec 2011 18:32:12 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/4] irq/of: Cleanup and Enchance irq_domain support.
Date:   Wed, 14 Dec 2011 18:32:06 -0800
Message-Id: <1323916330-8865-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 32101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11956

From: David Daney <david.daney@cavium.com>

Back in early Nov. I send the first version of this patch set.  Now
things are heating up again in the world of irq_domain, so I wanted to
try to get some closure on the issues I had.  The Octeon patch is
included here to show how I am using irq_domain, but is part of a much
larger effort to merge Octeon device tree support.

The basic problem I am attempting to solve is using irq domains when
there is a 'non-linear' mapping of hwirq <--> irq within a domain.
Octeon has a single set of irq numbers that is used across two
different implementations of the interrupt controller as well as more
than 10 different SOCs all which use different subsets of the irq
number space.  The result is that the hwirq to irq mapping function
contains many gaps and discontinuities, it is really quite random.

The existing irq domain infrastructure assumes a continuous linear
mapping of hwirq to irq that can be encapsulated by the irq_base,
hwirq_base and nr_irq elements of struct irq_domain.  This is not
suitable for the Octeon implementation.

The gist of my change is to add an optional iterator function to
irq_domain_ops which knows how to iterate over the irq numbers in a
given domain.  For simple linear domains (those currently supported),
we iterate using the current method based on irq_base, hwirq_base and
nr_irq.

Summary of the patches:

1) Get rid of some unused code to make subsequent changes simpler.

2) Cleanup the data type used by various hwirq functions and users.

3) Add the irq iterator, and fix up the ARM GIC code to use it instead
of the current irq_domain_for_each_irq().

4) Add the Octeon users of the interface.

In an earlier exchange, Rob Herring had said:

   ... Handling sparse irqs is a potentially common problem, so we
   should address that in the core irqdomain code.

Which is what this patch set is doing.

There was a suggestion that perhaps having .to_irq() return a magic
value if there was no mapping would also work.  However I prefer this
approach as it separates the concepts of iteration and mapping of irq
numbers.

Please comment.

David Daney (4):
  irq: Get rid of irq_domain_for_each_hwirq().
  irq/of/ARM: Make irq_domain hwirq type consistent throughout the
    kernel.
  irq/of/ARM: Enhance irq iteration capability of irq_domain code.
  MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.

 arch/arm/common/gic.c                |   34 +++--
 arch/mips/Kconfig                    |    1 +
 arch/mips/cavium-octeon/octeon-irq.c |  259 +++++++++++++++++++++++++++++++++-
 include/linux/irqdomain.h            |   23 ++--
 kernel/irq/irqdomain.c               |   88 ++++++++----
 5 files changed, 354 insertions(+), 51 deletions(-)

-- 
1.7.2.3

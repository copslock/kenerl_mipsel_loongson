Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 20:57:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33427 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903663Ab2CFT5F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2012 20:57:05 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q26Jv2G6027978;
        Tue, 6 Mar 2012 20:57:02 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q26Jv0AZ027977;
        Tue, 6 Mar 2012 20:57:00 +0100
Date:   Tue, 6 Mar 2012 20:57:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     linux-kernel@vger.kernel.org,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] irq_domain/mips: Allow irq_domain on MIPS
Message-ID: <20120306195700.GK4519@linux-mips.org>
References: <1330100995-19823-1-git-send-email-grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1330100995-19823-1-git-send-email-grant.likely@secretlab.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Feb 24, 2012 at 09:29:55AM -0700, Grant Likely wrote:

> This patch makes IRQ_DOMAIN usable on MIPS.  It uses an ugly workaround
> to preserve current behaviour so that MIPS has time to add irq_domain
> registration to the irq controller drivers.  The workaround will be
> removed in Linux v3.6

Looking good, Ack.

Is there any good example for the changes that need to be done to
irq controller drivers?

Thanks,

  Ralf

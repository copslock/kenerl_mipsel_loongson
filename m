Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2010 02:48:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48588 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492643Ab0FDAr6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jun 2010 02:47:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o540lkk8005659;
        Fri, 4 Jun 2010 01:47:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o540lfu0005657;
        Fri, 4 Jun 2010 01:47:41 +0100
Date:   Fri, 4 Jun 2010 01:47:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 14/26] MIPS: JZ4740: Add Kbuild files
Message-ID: <20100604004741.GA4021@linux-mips.org>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
 <1275505832-17185-6-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1275505832-17185-6-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2896

On Wed, Jun 02, 2010 at 09:10:30PM +0200, Lars-Peter Clausen wrote:

> This patch adds the Kbuild files for the JZ4740 architecture and adds JZ4740
> support to the MIPS Kbuild files.

Checkout the changes to the way MIPS platform Makefiles are implemented in
the linux-queue tree.  This new structure will be mandatory for all new
platforms.

  Ralf

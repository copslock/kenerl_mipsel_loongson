Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 07:11:56 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47529 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492166Ab0GWFLw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Jul 2010 07:11:52 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6N5Bnse005479;
        Fri, 23 Jul 2010 06:11:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6N5BmXd005477;
        Fri, 23 Jul 2010 06:11:48 +0100
Date:   Fri, 23 Jul 2010 06:11:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Randomize mmap if randomize_va_space is set
Message-ID: <20100723051148.GB28551@linux-mips.org>
References: <1279570497-11060-1-git-send-email-ddaney@caviumnetworks.com>
 <1279570497-11060-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279570497-11060-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 19, 2010 at 01:14:56PM -0700, David Daney wrote:

> Fairly straight forward: For 32-bit address spaces randomize within a
> 16MB space, for 64-bit within a 256MB space.

Thanks, queued for 2.6.26.

  Ralf

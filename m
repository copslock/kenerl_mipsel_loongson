Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2010 21:36:55 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56835 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492453Ab0BRUgh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Feb 2010 21:36:37 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1IKaaj2017681;
        Thu, 18 Feb 2010 21:36:36 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1IKaaCK017680;
        Thu, 18 Feb 2010 21:36:36 +0100
Date:   Thu, 18 Feb 2010 21:36:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Octeon: Replace spinlock with raw_spinlocks in
 dma-octeon.c.
Message-ID: <20100218203636.GB17411@linux-mips.org>
References: <1266522500-955-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266522500-955-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 18, 2010 at 11:48:20AM -0800, David Daney wrote:

Thanks, queued for 2.6.34 as part of the great locking cleanup.

  Ralf

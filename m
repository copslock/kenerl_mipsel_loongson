Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 14:54:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47256 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491027Ab0JKMyR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Oct 2010 14:54:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9BCsFoB030419;
        Mon, 11 Oct 2010 13:54:15 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9BCsFkm030418;
        Mon, 11 Oct 2010 13:54:15 +0100
Date:   Mon, 11 Oct 2010 13:54:14 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 03/14] MIPS: Octeon: Update L2 Cache code for CN63XX
Message-ID: <20101011125414.GA30400@linux-mips.org>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
 <1286492633-26885-4-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286492633-26885-4-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 07, 2010 at 04:03:42PM -0700, David Daney wrote:

> The CN63XX has a different L2 cache architecture.  Update the helper
> functions to reflect this.
> 
> Some joining of split lines was also done to improve readability, as
> well as reformatting of comments.

I fixed the trailing blank line the patch added to
arch/mips/cavium-octeon/executive/cvmx-l2c.c and queued it for 2.6.37.

Thanks!

  Ralf

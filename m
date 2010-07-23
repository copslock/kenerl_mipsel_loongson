Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 05:53:11 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36848 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491908Ab0GWDxD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Jul 2010 05:53:03 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6N3r0Po031908;
        Fri, 23 Jul 2010 04:53:00 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6N3qxxA031906;
        Fri, 23 Jul 2010 04:52:59 +0100
Date:   Fri, 23 Jul 2010 04:52:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Quit using undefined behavior of ADDU in 64-bit
 atomic operations.
Message-ID: <20100723035259.GA31886@linux-mips.org>
References: <1279825167-23048-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279825167-23048-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 22, 2010 at 11:59:27AM -0700, David Daney wrote:

> For 64-bit, we must use DADDU and DSUBU.

Ouch.  I'm surprised this one was able to lurk around for so long.

Applied.  Thanks!

  Ralf

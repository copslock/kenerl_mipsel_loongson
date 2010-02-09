Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2010 14:17:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36057 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491841Ab0BINQ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Feb 2010 14:16:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o19DHMuu016941;
        Tue, 9 Feb 2010 14:17:22 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o19DHKK6016939;
        Tue, 9 Feb 2010 14:17:20 +0100
Date:   Tue, 9 Feb 2010 14:17:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Don't probe reserved EntryHi bits.
Message-ID: <20100209131720.GA16712@linux-mips.org>
References: <1265660820-5418-1-git-send-email-ddaney@caviumnetworks.com>
 <1265661388.5825.151.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265661388.5825.151.camel@groeck-laptop>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 08, 2010 at 12:36:28PM -0800, Guenter Roeck wrote:

> On Mon, 2010-02-08 at 15:27 -0500, David Daney wrote:
> > The patch that adds cpu_probe_vmbits is erroneously writing to
> > reserved bit 12.  Since we are really only probing high bits, don't
> > write this bit with a one.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > CC: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: you meant.  Patch applied.

Thanks folks,

  Ralf

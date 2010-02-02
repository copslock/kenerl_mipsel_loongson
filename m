Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 18:50:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50130 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492498Ab0BBRug (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 18:50:36 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o12Hopg4029965;
        Tue, 2 Feb 2010 18:50:52 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o12HoogE029953;
        Tue, 2 Feb 2010 18:50:50 +0100
Date:   Tue, 2 Feb 2010 18:50:50 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <guenter.roeck@ericsson.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v6 00/01] Virtual memory size detection for 64 bit MIPS
 CPUs
Message-ID: <20100202175049.GA29596@linux-mips.org>
References: <1265129540-10884-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265129540-10884-1-git-send-email-guenter.roeck@ericsson.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 08:52:19AM -0800, Guenter Roeck wrote:

> This patchset addresses some of the most recent comments.
> 
> It does not address changes to TASK_SIZE, and it does not address replacing
> the VMALLOC_END macro with a variable. Those changes are non-trivial
> and will require more discussion and/or clarification.

I think I'm happy with doing these in followup patches.  What's most
important is sorting the whole issue soon so we can release a working
2.6.33.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 23:47:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57900 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492417Ab0BWWrq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Feb 2010 23:47:46 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1NMlh0E025185;
        Tue, 23 Feb 2010 23:47:44 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1NMlgAG025183;
        Tue, 23 Feb 2010 23:47:42 +0100
Date:   Tue, 23 Feb 2010 23:47:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [V2] Eliminate duplicate opcode definition macros
Message-ID: <20100223224741.GA21949@linux-mips.org>
References: <20100223003113.GA8599@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100223003113.GA8599@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 22, 2010 at 04:31:13PM -0800, David VomLehn wrote:

> Change to different macros for assembler macros since the old names in
> powertv_setup.c were co-opted for use in asm/asm.h. This broken the
> build for the powertv platform. This patch introduces new macros based on
> the new macros in asm.h to take the place of the old macro values.
> 
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>

Thanks, queued for 2.6.34.

  Ralf

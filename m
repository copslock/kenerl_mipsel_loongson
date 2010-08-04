Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 02:00:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47510 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493285Ab0HEAAG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Aug 2010 02:00:06 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o74Nxngr009510;
        Thu, 5 Aug 2010 00:59:49 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o74Nxnp5009509;
        Thu, 5 Aug 2010 00:59:49 +0100
Date:   Thu, 5 Aug 2010 00:59:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com, linux-kernel@vger.kernel.org,
        hschauhan@nulltrace.org
Subject: Re: [PATCH] MIPS: KProbes: Use flush_insn_slot() where possible.
Message-ID: <20100804235949.GE28115@linux-mips.org>
References: <1280859742-26364-4-git-send-email-ddaney@caviumnetworks.com>
 <1280869245-2786-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1280869245-2786-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips


> This is a small cleanup that could either be folded into the original
> 3/5 or applied in addition to it.

I've folded it into 3/5.  Thanks!

  Ralf

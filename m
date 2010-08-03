Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 22:26:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52592 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492865Ab0HCU0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Aug 2010 22:26:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o73KQAVU025648;
        Tue, 3 Aug 2010 21:26:10 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o73KQ8hH025646;
        Tue, 3 Aug 2010 21:26:08 +0100
Date:   Tue, 3 Aug 2010 21:26:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com, linux-kernel@vger.kernel.org,
        hschauhan@nulltrace.org
Subject: Re: [PATCH 1/5] MIPS: Define regs_return_value()
Message-ID: <20100803202607.GA25233@linux-mips.org>
References: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
 <1280859742-26364-2-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1280859742-26364-2-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 03, 2010 at 11:22:18AM -0700, David Daney wrote:

> +#define regs_return_value(regs) ((regs)->regs[2])

This will probably only work if the argument happens to be "regs" otherwise
the things will likely go splat.

  Ralf

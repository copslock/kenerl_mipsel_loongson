Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2010 14:26:33 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49931 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492018Ab0KIN01 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Nov 2010 14:26:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oA9DQOH8027440;
        Tue, 9 Nov 2010 13:26:24 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oA9DQOIP027438;
        Tue, 9 Nov 2010 13:26:24 GMT
Date:   Tue, 9 Nov 2010 13:26:23 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Separate two consecutive loads in memset.S
Message-ID: <20101109132623.GA27392@linux-mips.org>
References: <AANLkTimuGUjcCsnmO3ZgQL-2vD7iD3bgg5V2tDbA_TpU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimuGUjcCsnmO3ZgQL-2vD7iD3bgg5V2tDbA_TpU@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 09, 2010 at 03:48:03PM +0800, Tony Wu wrote:

> partial_fixup is used in noreorder block.
> 
> Separating two consecutive loads can save one cycle on processors with
> GPR intrelock and can fix load-use on processors that need a load delay slot.
> 
> Also do so for fwd_fixup.

Patch is whitespace mangled; please resend.

  Ralf

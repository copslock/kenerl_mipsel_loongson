Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 01:41:20 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38159 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491942Ab0KVAlR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Nov 2010 01:41:17 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oAM0fF3Z011216;
        Mon, 22 Nov 2010 00:41:15 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oAM0fEOw011214;
        Mon, 22 Nov 2010 00:41:14 GMT
Date:   Mon, 22 Nov 2010 00:41:14 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Patard <arnaud.patard@rtp-net.org>
Cc:     shmprtd@googlemail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for Realtek Media Player SoCs
Message-ID: <20101122004114.GA10923@linux-mips.org>
References: <tkrat.a6310f0563cae06d@googlemail.com>
 <87r5efyozy.fsf@lechat.rtp-net.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r5efyozy.fsf@lechat.rtp-net.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 21, 2010 at 11:01:21AM +0100, Arnaud Patard wrote:

> Please read Documentation/SubmittingPatches. One big patch is just
> impossible to review (at least for me), please split it in fewer
> chunks.

This is not outrageously huge and actually well smaller than the "atoms"
some other patches were split into.  Ideally patches should be split such
that each patch fixes one bug or adds one feature and such that applying
only a part of a patch series does not result in a regression.  The
absolute size or number of patches at least to me is a secondary
consideration.

  Ralf

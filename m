Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2011 15:08:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55651 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491084Ab1DHNIj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2011 15:08:39 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p38D8CPb017836;
        Fri, 8 Apr 2011 15:08:12 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p38D8Bxi017833;
        Fri, 8 Apr 2011 15:08:11 +0200
Date:   Fri, 8 Apr 2011 15:08:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Justin P. Mattock" <justinmattock@gmail.com>
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [RFC 3/5]arch:mips:pmc-sierra:msp71xx:Makefile Remove unused
 config in the Makefile.
Message-ID: <20110408130811.GA17431@linux-mips.org>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
 <1302022702-24541-3-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1302022702-24541-3-git-send-email-justinmattock@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 05, 2011 at 09:58:20AM -0700, Justin P. Mattock wrote:

> The patch below removes an unused config variable found by using a kernel
> cleanup script.
> Note: I did try to cross compile these but hit erros while doing so..
> (gcc is not setup to cross compile) and am unsure if anymore needs to be done.
> Please have a look if/when anybody has free time.

NACK.

This need a rewrite, not just chainsawing.  Your code was only touching
the makefile anyway, not the two referenced C files.

 Ralf

  Ralf

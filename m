Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 16:49:41 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49353 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491800Ab1CDPth (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 16:49:37 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p24FnFSr026722;
        Fri, 4 Mar 2011 16:49:15 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p24FnCX3026719;
        Fri, 4 Mar 2011 16:49:12 +0100
Date:   Fri, 4 Mar 2011 16:49:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Maurus Cuelenaere <mcuelenaere@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Jz4740: Add HAVE_CLK
Message-ID: <20110304154912.GA24966@linux-mips.org>
References: <4d6c2da3.cc7e0e0a.2116.ffffde18@mx.google.com>
 <4D6CB9C4.8000609@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6CB9C4.8000609@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 01, 2011 at 10:17:56AM +0100, Lars-Peter Clausen wrote:

> On 03/01/2011 12:20 AM, Maurus Cuelenaere wrote:
> > Jz4740 supports the clock framework but doesn't have HAVE_CLK defined, so define
> > it!
> > 
> > Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks folks.  Applied,

  Ralf

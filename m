Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2016 03:52:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56940 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992170AbcLPCwH2pHiY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Dec 2016 03:52:07 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBG2q6C2031194;
        Fri, 16 Dec 2016 03:52:06 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBG2q6cx031193;
        Fri, 16 Dec 2016 03:52:06 +0100
Date:   Fri, 16 Dec 2016 03:52:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: MIPS: IP22: Fix binutils due to binutils 2.25 uselessnes.
Message-ID: <20161216025206.GE15191@linux-mips.org>
References: <S23993072AbcLOP7sNw5Hx/20161215155948Z+1597@eddie.linux-mips.org>
 <alpine.DEB.2.00.1612160206450.6743@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1612160206450.6743@tp.orcam.me.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, Dec 16, 2016 at 02:22:16AM +0000, Maciej W. Rozycki wrote:

> On Thu, 15 Dec 2016, linux-mips@linux-mips.org wrote:
> 
> > Fix build with binutils 2.25 by open coding the offending
> > 
> > 	dli $1, 0x9000000080000000
> > 
> > as
> > 
> > 	li	$1, 0x9000
> > 	dsll	$1, $1, 48
> > 
> > which is ugly be the only thing that will build on all binutils vintages.
> 
>  What about bit #31?  Shouldn't this be say:
> 
> 	lui	$1, 0x9000
> 	dsll	$1, $1, 16
> 	ori	$1, $1, 0x8000
> 	dsll	$1, $1, 16
> 
> ?

Argh, didn't spot the `8' in there.  64 bit constants are way too long :)

Thanks for reporting, will fix.

  Ralf

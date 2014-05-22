Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:05:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55953 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822090AbaEVNFD2oRSs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:05:03 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MD51xs010767;
        Thu, 22 May 2014 15:05:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MD4xbk010765;
        Thu, 22 May 2014 15:04:59 +0200
Date:   Thu, 22 May 2014 15:04:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove check for
 CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC
Message-ID: <20140522130459.GY10287@linux-mips.org>
References: <1400583055.4912.28.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400583055.4912.28.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40236
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

On Tue, May 20, 2014 at 12:50:55PM +0200, Paul Bolle wrote:

> A check for CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC was added in v2.6.29,
> but without the related Kconfig symbol. Remove this check.
> 
> Also remove the test for an "ecc_verbose" kernel parameter. It is
> undocumented and has no effect anyway.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> Note that __cvmx_interrupt_ecc_report_single_bit_errors doesn't exist.

I tried to chase the history of this but as far as I was able to find,
this is unused since I initially merged Octeon support; beyond that
I wasn't able to find any history.

So queued for 3.16.

Thanks!

  Ralf

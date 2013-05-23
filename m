Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 17:50:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38836 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835061Ab3EWPuNIknH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 May 2013 17:50:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4NFoAK7023843;
        Thu, 23 May 2013 17:50:10 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4NFo9iO023842;
        Thu, 23 May 2013 17:50:09 +0200
Date:   Thu, 23 May 2013 17:50:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@codesourcery.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Trap exception handling fixes
Message-ID: <20130523155009.GA5598@linux-mips.org>
References: <alpine.DEB.1.10.1305230253140.26443@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1305230253140.26443@tp.orcam.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36554
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

On Thu, May 23, 2013 at 04:31:23PM +0100, Maciej W. Rozycki wrote:

> 2a0b24f56c2492b932f1aed617ae80fb23500d21 broke Trap exception handling in 
> the standard MIPS mode.  Additionally the microMIPS-mode trap code mask is 
> wrong, as it's a 4-bit field.  Here's a fix.
> 
> Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
> ---
> Ralf, please apply.  Also the mention of: "A few NOP instructions are used 
> to maintain the correct alignment[...]" in the commit referred makes me 
> feel scared -- there is that .align pseudo-op, you know...  Maciej

Thanks, applied.

Seems that whole bloody patchset was painfully unripe :-(

  Ralf

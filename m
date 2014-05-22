Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:18:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56035 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834704AbaEVNSjMxqf7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:18:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MDIaU3011468;
        Thu, 22 May 2014 15:18:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MDIakk011467;
        Thu, 22 May 2014 15:18:36 +0200
Date:   Thu, 22 May 2014 15:18:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: PNX833x: remove checks for CONFIG_I2C_PNX0105
Message-ID: <20140522131836.GB10287@linux-mips.org>
References: <1400586123.4912.40.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400586123.4912.40.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40239
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

On Tue, May 20, 2014 at 01:42:03PM +0200, Paul Bolle wrote:

> 
> Checks for CONFIG_I2C_PNX0105 were added in v2.6.28. But the related
> Kconfig symbol has not been added to the tree. Remove these checks.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> Note that there's no i2c-pnx0105.h in the tree.

And if I was holding my breath waiting for it to be comitted I'd already
be dead and rotten.  Queued for 3.16.

  Thanks,

  Ralf

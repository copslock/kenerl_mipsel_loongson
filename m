Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 16:19:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59508 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028422AbcEIOTbX3Lco (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2016 16:19:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u49EJU5R030336;
        Mon, 9 May 2016 16:19:30 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u49EJUDf030335;
        Mon, 9 May 2016 16:19:30 +0200
Date:   Mon, 9 May 2016 16:19:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Implement __arch_bitrev* using bitswap for MIPSr6
Message-ID: <20160509141930.GB28818@linux-mips.org>
References: <1462538103-6633-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462538103-6633-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53311
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

On Fri, May 06, 2016 at 01:35:03PM +0100, Paul Burton wrote:

> Release 6 of the MIPS architecture introduced the bitswap instruction,
> which reverses the bits within each byte of a word. Make use of this
> instruction to implement the __arch_bitrev* functions, which should be
> faster for most MIPSr6 CPUs, reduces code size slightly and allows us to
> avoid the lookup table used by the generic implementation, saving 256
> bytes in the kernel binary by dropping that.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Applied after fixing up a trivial conflict.  It would be a bit cleaner
if <asm/bitrev.h> was including <linux/types.h> itself.  <linux/swab.h>
does so but there's no guarantee for that.

  Ralf

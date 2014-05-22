Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:12:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55999 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822090AbaEVNMoplrEp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:12:44 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MDCh3v011248;
        Thu, 22 May 2014 15:12:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MDChgv011247;
        Thu, 22 May 2014 15:12:43 +0200
Date:   Thu, 22 May 2014 15:12:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove checks for CONFIG_SGI_IP35
Message-ID: <20140522131243.GZ10287@linux-mips.org>
References: <1400584909.4912.35.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400584909.4912.35.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40237
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

On Tue, May 20, 2014 at 01:21:49PM +0200, Paul Bolle wrote:

> Ever since (shortly before) v2.4.0 there have been checks for
> CONFIG_SGI_IP35. But a Kconfig symbol SGI_IP35 was never added to the
> tree. Remove these checks.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> For some reason CONFIG_SGI_IP35 was heavily used in arch/ia64 too.
> Anyhow, IA64 has dropped that macro years ago.

The #ifdefs exist because these headers are originally from IRIX and the
equivalent IRIX definitions were converted to Linux-style.  For the
IA64 version keeping those ifdefs around obviously made no sense since -
since IP35 (Origin 300/3000 series) is MIPS-based, so it was dropped
again.

There is some out-of-tree support for IP35 so I'd like to drop this
patch.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Mar 2016 01:09:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58810 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013530AbcCJAJSRed0K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Mar 2016 01:09:18 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2A09B9n024509;
        Thu, 10 Mar 2016 01:09:11 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2A098Pv024499;
        Thu, 10 Mar 2016 01:09:08 +0100
Date:   Thu, 10 Mar 2016 01:09:07 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MIPS/PA-RISC: panic immediately when panic_on_oops
Message-ID: <20160310000907.GD15652@linux-mips.org>
References: <1457554123-18491-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457554123-18491-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52568
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

On Wed, Mar 09, 2016 at 10:08:41PM +0200, Aaro Koskinen wrote:

> MIPS and PA-RISC want to sleep 5 seconds before panicking when
> panic_on_oops is set, with no apparent reason. We should remove
> this feature, since some users may want their systems to fail as
> quickly as possible.
> 
> Users who want to delay reboot after panic can use PANIC_TIMEOUT.
> 
> Also, this change will unify the behaviour with other architectures.

I did a bit of dumpster diving, commit cea6a4ba8acfba6f59cc9ed71e0d05cb770b9d9c
("[PATCH] panic_on_oops: remove ssleep()") removed the 5 second delay
from ARM, i386, ia64, powerpc, x86_64 and xtensa on 2006-03-07.

The idea once upon a time probably was to keep the panic message on the
console long enough so somebody has _maybe_ a chance to read it.  Which
is a pretty weak solution.

  Ralf

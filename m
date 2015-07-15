Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2015 12:05:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53648 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010585AbbGOKFJzdpbx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jul 2015 12:05:09 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6FA57gF022765;
        Wed, 15 Jul 2015 12:05:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6FA53Rh022762;
        Wed, 15 Jul 2015 12:05:03 +0200
Date:   Wed, 15 Jul 2015 12:05:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [RFC PATCH v1] mips: Use unsigned int when reading CP0 registers
Message-ID: <20150715100503.GA22385@linux-mips.org>
References: <1436913870-17738-1-git-send-email-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436913870-17738-1-git-send-email-judge.packham@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48304
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

On Wed, Jul 15, 2015 at 10:44:30AM +1200, Chris Packham wrote:

> Update __read_32bit_c0_register() and __read_32bit_c0_ctrl_register() to
> use "unsigned int res;" instead of "int res;". There is little reason to
> treat these register values as signed. They are either counters (which
> by definition are unsigned) or are made up of various bit fields to be
> interpreted as per the CPU datasheet.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> 
> ---
> This has come up via u-boot[1] which sync's asm/mipsregs.h with the
> kernel. In u-boots case the value read from read_c0_count() is assigned
> to an unsigned long [2] which triggers a sign extension and causes a
> bug.
> 
> U-boot should probably be more explicit about the types used for the
> timer_read_counter() API but that aside is there any reason to treat
> these values as signed integers? A quick grep around the arch/mips makes
> me thing that there may be some bugs lurking when read_c0_count() starts
> to yield a negative value but I haven't really explored any of them.

Known issue but I've always been concerned about math with cycle values
like:

  unsigned int now, timeout = read_c0_counter() + a_bit_of_time;

  waste_some_time();

  if (timeout - read_c0_counter() < 0)
	do_timeout_stuff();

Which now with both variables being unsigned would yield a positive value
thus the if would never be taken.  This particular construction GCC would
warn about but there are other, constructs that wouldn't trigger a warning.

I don't even want to think about what C type propagation rules say about
mixing signed and unsigned types.  Whenever such knowledge is required
to figure out what a piece of code is doing it probably should be considered
broken anyway - but the mess resulting from unwanted sign is no better!

Anyway, I've queued your patch for 4.3.  Thanks!

> I also notice that read_32bit_cp1_register has a similar issue. I
> haven't touched it at this stage but it probably makes sense to do so
> for consistency if the CP0 macros are changed. Looking at the users of
> read_32bit_cp1_register() it's probably less of an issue.

I've cooked up a patch for read_32bit_cp1_register and queued it for 4.3.

  Ralf

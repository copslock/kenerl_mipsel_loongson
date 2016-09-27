Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2016 20:52:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34740 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990517AbcI0SwqRGf2m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Sep 2016 20:52:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8RIqesc016782;
        Tue, 27 Sep 2016 20:52:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8RIqbuo016781;
        Tue, 27 Sep 2016 20:52:37 +0200
Date:   Tue, 27 Sep 2016 20:52:37 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 17/19] auxdisplay: img-ascii-lcd: driver for simple
 ASCII LCD displays
Message-ID: <20160927185237.GG12981@linux-mips.org>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
 <20160826141751.13121-18-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826141751.13121-18-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55270
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

On Fri, Aug 26, 2016 at 03:17:49PM +0100, Paul Burton wrote:

> Add a driver for simple ASCII LCD displays found on the MIPS Boston,
> Malta & SEAD3 development boards. The Boston display is an independent
> memory mapped device with a simple memory mapped 8 byte register space
> containing the 8 ASCII characters to display. The Malta display is
> exposed as part of the Malta board registers, and provides 8 registers
> each of which corresponds to one of the ASCII characters to display. The
> SEAD3 display is slightly more complex, exposing an interface to an
> S6A0069 LCD controller via registers provided by the boards CPLD.
> However although the displays differ in their register interface, we
> require similar functionality on each board so abstracting away the
> differences within a single driver allows us to share a significant
> amount of code & ensure consistent behaviour.
> 
> The driver displays the Linux kernel version as the default message, but
> allows the message to be changed via a character device. Messages longer
> then the number of characters that the display can show will scroll.
> 
> This provides different behaviour to the existing LCD display code for
> the MIPS Malta or MIPS SEAD3 platforms in the following ways:
> 
>   - The default string to display is not "LINUX ON MALTA" or "LINUX ON
>     SEAD3" but "Linux" followed by the version number of the kernel
>     (UTS_RELEASE).
> 
>   - Since that string tends to be significantly longer it scrolls twice
>     as fast, moving every 500ms rather than every 1s.
> 
>   - The LCD won't be updated until the driver is probed, so it doesn't
>     provide the early "LINUX" string.

Right now parts 15..18 of this series are stalled due to the lack of an
ack for this patch.

Miguel?

  Ralf

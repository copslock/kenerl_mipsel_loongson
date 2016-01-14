Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 13:19:13 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41814 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009857AbcANMTHuEJ8W (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Jan 2016 13:19:07 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u0ECIvX3020828;
        Thu, 14 Jan 2016 13:18:57 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u0EBCD6h019655;
        Thu, 14 Jan 2016 12:12:13 +0100
Date:   Thu, 14 Jan 2016 12:12:13 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-api@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Jean Delvare <jdelvare@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Corneliu Doban <cdoban@broadcom.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Luis de Bethencourt <luisbg@osg.samsung.com>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        yangbo lu <yangbo.lu@freescale.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v5 02/14] irqchip: irq-pic32-evic: Add support for PIC32
 interrupt controller
Message-ID: <20160114111213.GC28942@linux-mips.org>
References: <1452734299-460-1-git-send-email-joshua.henderson@microchip.com>
 <1452734299-460-3-git-send-email-joshua.henderson@microchip.com>
 <alpine.DEB.2.11.1601140901210.3575@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1601140901210.3575@nanos>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51118
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

On Thu, Jan 14, 2016 at 09:10:09AM +0100, Thomas Gleixner wrote:

> I like that approach.
> 
> So except for the nit in pic32_set_type_edge() this looks good. It's pretty
> clear now what the code does and how the hardware works.
> 
> Thanks for following up!

So I take that for an ack.  I still haven't seen any acks or comments for
the patches:

     4/14      drivers/clk
     8/14      drivers/pinctrl
    10/14      drivers/serial
    12/14      drivers/mmc

Of this series.  Ping?

  Ralf

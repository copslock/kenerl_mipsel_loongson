Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 21:05:46 +0100 (CET)
Received: from mail-qg0-f42.google.com ([209.85.192.42]:56696 "EHLO
        mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011023AbbAIUFpH8aOc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 21:05:45 +0100
Received: by mail-qg0-f42.google.com with SMTP id q108so10611081qgd.1;
        Fri, 09 Jan 2015 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8OHzoNgwGtNUscV+21ewcemY8sBDW4k2XN8tFD22oz8=;
        b=MUTyE5hEW5amWXer1I7/rQphQ2amGXjl4ChnWWiD3AHl5tRW/74M3dHK/xOv0o73co
         MAMieLZttuExVuXr2EYrlocG7YDfkDDxGcbDauQVz3iQyiJL038Bxo85ETDM8Wq4kGPW
         +a0DxkcbdohBTJFHEmHRy50ysaPH20+u1l/UyWR+1CssGWf3U4+5BZ2h2PZk/ooNjJ+4
         dU5j/w4NeNyRjhZln9pYWimTwsW7kThJwNz27t8i+G5Vmt7iHvGquK+JglgeB6Q/9YXj
         gQd4UsZtAIiAV02Zkbp42OZNGHRdyOpXIZibMqHN94UFO7bDP/jwrdp/Sx3KG+j40T9u
         jtFg==
X-Received: by 10.140.97.7 with SMTP id l7mr28973949qge.66.1420833939289;
        Fri, 09 Jan 2015 12:05:39 -0800 (PST)
Received: from ld-irv-0074 (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id f77sm7849400qgd.49.2015.01.09.12.05.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Jan 2015 12:05:38 -0800 (PST)
Date:   Fri, 9 Jan 2015 12:05:35 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: jz4740: Convert to GPIO descriptor API
Message-ID: <20150109200535.GV9759@ld-irv-0074>
References: <1417549706-28420-1-git-send-email-lars@metafoo.de>
 <20141215154408.GD9382@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141215154408.GD9382@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Mon, Dec 15, 2014 at 04:44:08PM +0100, Ralf Baechle wrote:
> On Tue, Dec 02, 2014 at 08:48:26PM +0100, Lars-Peter Clausen wrote:
> 
> > Use the GPIO descriptor API instead of the deprecated legacy GPIO API to
> > manage the busy GPIO.
> > 
> > The patch updates both the jz4740 nand driver and the only user of the driver
> > the qi-lb60 board driver.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> > This patch should preferably be merged through the MTD tree with Ralf's ack for
> > the MIPS bits.
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

For MTD stuff:

Acked-by: Brian Norris <computersforpeace@gmail.com>

> Though in my experience MIPS-specific patches to non-arch/mips code receive
> best testing in the MIPS tree.

I don't mind this going in the MIPS tree. I doubt this driver will get
much other activity in MTD soon, and you're likely quite right about
MIPS testing.

Let me know if you'd like to take it. If I don't hear back in a week or
two, I'll take it via MTD.

Brian

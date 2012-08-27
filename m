Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2012 22:46:24 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:56500 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903712Ab2H0UqT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Aug 2012 22:46:19 +0200
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.72)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1T66CM-0008ME-SS; Mon, 27 Aug 2012 22:46:14 +0200
Date:   Mon, 27 Aug 2012 22:46:13 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, sebastian@breakpoint.cc,
        stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH V4] usb: gadget: bcm63xx UDC driver
Message-ID: <20120827204613.GC6045@breakpoint.cc>
References: <2e70dcfde41aee0d733449013ac80ace@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e70dcfde41aee0d733449013ac80ace@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Aug 25, 2012 at 12:38:52PM -0700, Kevin Cernekee wrote:
> Driver for the "USB20D" / "USBD" block on BCM6328, BCM6368, BCM6816,
> BCM6362, BCM3383, and others.

I don't see anything worth to object.
Acked-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

One little question: Felipe suggested to replace the workqueue by a threaded
interrupt. You schedule the workqueue in interrupt context and once in ep0
enqueue. The enqueue should be fine by executing one round and waiting for the
interrupt. Any reason why you suggested against it?

Sebastian

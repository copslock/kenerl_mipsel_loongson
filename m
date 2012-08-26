Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2012 21:32:19 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:54470 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903203Ab2HZTcN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Aug 2012 21:32:13 +0200
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.72)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1T5iZA-00063b-PD; Sun, 26 Aug 2012 21:32:12 +0200
Date:   Sun, 26 Aug 2012 21:32:11 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH V2] usb: gadget: bcm63xx UDC driver
Message-ID: <20120826193211.GM3690@breakpoint.cc>
References: <b3bb6f2afb3ed82fd1e64563c68fb8df@localhost>
 <20120821211355.GB6307@breakpoint.cc>
 <CAJiQ=7AkGWF03wmW1FcALwE6_s5o7pDLt2wpH-W-ngG-_G+91g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7AkGWF03wmW1FcALwE6_s5o7pDLt2wpH-W-ngG-_G+91g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34361
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

On Tue, Aug 21, 2012 at 06:30:19PM -0700, Kevin Cernekee wrote:
> use_fullspeed=1 just tells the core not to negotiate USB 2.0 PHY
> rates.  It should be roughly equivalent to plugging the device into a
> full speed hub.

Okay, understood.

Sebastian

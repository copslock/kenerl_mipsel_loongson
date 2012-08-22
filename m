Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2012 09:48:28 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:41690 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903392Ab2HVHsU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2012 09:48:20 +0200
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.72)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1T45fk-000663-1T; Wed, 22 Aug 2012 09:48:16 +0200
Date:   Wed, 22 Aug 2012 09:48:15 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     balbi@ti.com, ralf@linux-mips.org, sebastian@breakpoint.cc,
        stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH V3] usb: gadget: bcm63xx UDC driver
Message-ID: <20120822074815.GB3563@breakpoint.cc>
References: <5ff8f23aae05690ba89476c4924b9387@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff8f23aae05690ba89476c4924b9387@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34340
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

On Tue, Aug 21, 2012 at 06:22:35PM -0700, Kevin Cernekee wrote:

Just one thing that bit while I was sleeping:
The HW acks SetConfig on its own. Once you notice this, you set
->ep0_req_set_cfg and set state in bcm63xx_ep0_do_idle() to
EP0_IN_FAKE_STATUS_PHASE. This is I guess the workaround for mass_storage's
hold with DELAYED_STATUS and continues with a zero packet.
Now two questions:
- If a gadget descides not NAK / stall the SetConfig requests. What happens
  here?
- What happens if the host is faster than the UDC. SetConfig returns in
  usb-storage with "DELAYED_STATUS". HW Acks this. Could the Host send another
  request before the gadget queues the ep0 request?

Sebastian

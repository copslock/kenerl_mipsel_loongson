Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 10:47:29 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:45105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823064Ab3FRIrVZMXD0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 10:47:21 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 18 Jun 2013 01:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,887,1363158000"; 
   d="scan'208";a="355365494"
Received: from unknown (HELO zurbaran) ([10.252.122.14])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2013 01:47:08 -0700
Date:   Tue, 18 Jun 2013 10:46:25 +0200
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3/7] mfd: twl4030-irq: use irq_get_trigger_type() to get
 IRQ flags
Message-ID: <20130618084625.GC7161@zurbaran>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
 <1371228049-27080-4-git-send-email-javier.martinez@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371228049-27080-4-git-send-email-javier.martinez@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sameo@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sameo@linux.intel.com
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

On Fri, Jun 14, 2013 at 06:40:45PM +0200, Javier Martinez Canillas wrote:
> Use irq_get_trigger_type() to get the IRQ trigger type flags
> instead calling irqd_get_trigger_type(irq_get_irq_data(irq))
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

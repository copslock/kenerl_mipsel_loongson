Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 14:38:07 +0200 (CEST)
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:18702 "EHLO
        mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492496Ab0HBMiB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Aug 2010 14:38:01 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEABNZVkxQycSE/2dsb2JhbACgDXLBAg2FLAQ
Received: from 132.196-201-80.adsl-dyn.isp.belgacom.be (HELO infomag) ([80.201.196.132])
  by relay.skynet.be with ESMTP; 02 Aug 2010 14:37:55 +0200
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1OfuHD-0001yH-6i; Mon, 02 Aug 2010 14:37:55 +0200
Date:   Mon, 2 Aug 2010 14:37:55 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     David Daney <ddaney@caviumnetworks.com>, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@misterjones.org>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] watchdog: Add watchdog driver for OCTEON SOCs (v2).
Message-ID: <20100802123755.GV30740@infomag.iguana.be>
References: <20100724035826.GA27516@merkur.ravnborg.org> <1279991765-23962-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1279991765-23962-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi David, Ralf,

> The OCTEON is a MIPS64 based SOC family with an on chip watchdog unit.
> 
> The driver is split into two source files one for the C code and one
> for assembly.  Assembly is needed to handle the NMI and then print the
> machine state before the reboot is triggered.
> 
> v2: Stylistic changes suggested by Sam Ravnborg.

This v2 looks good. only small remark is:
> +static struct notifier_block octeon_wdt_cpu_notifier = {
> +	.notifier_call = octeon_wdt_cpu_callback
> +};

Add a comma after octeon_wdt_cpu_callback.

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Marc Zyngier <maz@misterjones.org>
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>

Kind regards,
Wim.
